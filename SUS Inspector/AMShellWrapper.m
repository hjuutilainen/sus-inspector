//
//  AMShellWrapper.m
//  CommX
//
//  Created by Andreas on 2002-04-24.
//  Based on TaskWrapper from Apple
//
//  2002-06-17 Andreas Mayer
//  - used defines for keys in AMShellWrapperProcessFinishedNotification userInfo dictionary
//  2002-08-30 Andreas Mayer
//  - removed bug in getData that sent all output to appendError:
//  - added setInputStringEncoding: and setOutputStringEncoding:
//  - reactivated code to clear output pipes when the task is finished
//  2004-06-15 Andreas Mayer
//  - renamed stopProcess to cleanup since that is what it does; stopProcess
//    is meant to just terminate the task so it's issuing a [task terminate] only now
//  - appendOutput: and appendError: do some error handling now
//  2004-08-11 Andreas Mayer
//  - removed AMShellWrapperProcessFinishedNotification notification since
//	it prevented the task from getting deallocated
//  - don't retain stdin/out/errHandle
//
//  I had some trouble to decide when the task had really stopped. The Apple example
//  did only examine the output pipe and exited when it was empty - which I found unreliable.
//
//  This, finally, seems to work: Wait until the output pipe is empty *and* we received
//  the NSTaskDidTerminateNotification. Seems obvious now ...  :)


#import "AMShellWrapper.h"


@interface AMShellWrapper (private)
- (void)taskStopped:(NSNotification *)aNotification;
- (NSFileHandle *)stdoutHandle;
- (NSFileHandle *)stderrHandle;
- (void)appendOutput:(NSData *)data;
- (void)appendError:(NSData *)data;
- (void)cleanup;
@end


@implementation AMShellWrapper

// Do basic initialization

- (id)initWithInputPipe:(id)input outputPipe:(id)output errorPipe:(id)error workingDirectory:(NSString *)directoryPath environment:(NSDictionary *)env arguments:(NSArray *)args context:(void *)pointer
{
	if ((self = [super init])) {
		context = pointer;
		arguments = [args retain];
		environment = [env retain];
		workingDirectory = [directoryPath retain];
		stdinPipe = [input retain];
		stdoutPipe = [output retain];
		stderrPipe = [error retain];
		inputStringEncoding = NSUTF8StringEncoding;
		outputStringEncoding = NSUTF8StringEncoding;
	}
	return self;
}

// tear things down
- (void)dealloc
{		
	[stderrPipe release];
	[stdoutPipe release];
	[stdinPipe release];
	[workingDirectory release];
	[environment release];
	[arguments release];
	[task release];
	[super dealloc];
}

- (id)delegate
{
	return delegate;
}

- (void)setDelegate:(id <AMShellWrapperDelegate>)newDelegate
{
	// do not retain
	if (newDelegate != delegate) {
		delegate = newDelegate;
	}
}

- (void *)context
{
	return context;
}

- (BOOL)binaryOutput
{
	return binaryOutput;
}

- (void)setBinaryOutput:(BOOL)flag
{
	if (flag != binaryOutput) {
		binaryOutput = flag;
	}
}


// If you need something else than UTF8, set the code type of the task's input here
- (void)setInputStringEncoding:(NSStringEncoding)newInputStringEncoding
{
	inputStringEncoding = newInputStringEncoding;
}

// If you need something else than UTF8, tell the task what coding to use for output here
- (void)setOutputStringEncoding:(NSStringEncoding)newOutputStringEncoding
{
	outputStringEncoding = newOutputStringEncoding;
}

// Here's where we actually kick off the process via an NSTask.
- (void)startProcess
{
	BOOL error = NO;
	// We first let the controller know that we are starting
	[delegate processStarted:self];
	task = [[NSTask alloc] init];
	// The output of stdout and stderr is sent to a pipe so that we can catch it later
	// and send it along to the controller; we redirect stdin too, so that it accepts
	// input from us instead of the console
	if (stdinPipe == nil) {
		NSPipe *newPipe = [[NSPipe alloc] init];
		if (newPipe) {
			[task setStandardInput:newPipe];
			stdinHandle = [[task standardInput] fileHandleForWriting];
			// we do NOT retain stdinHandle here since it is retained (and released)
			// by the task standardInput pipe (or so I hope ...)
			[newPipe release];
		} else {
			perror("AMShellWrapper - failed to create pipe for stdIn");
			error = YES;
		}
	} else {
		[task setStandardInput:stdinPipe];
		if ([stdinPipe isKindOfClass:[NSPipe class]])
			stdinHandle = [stdinPipe fileHandleForWriting];
		else
			stdinHandle = stdinPipe;
	}
	
	if (stdoutPipe == nil) {
		NSPipe *newPipe = [[NSPipe alloc] init];
		if (newPipe) {
			[task setStandardOutput:newPipe];
			stdoutHandle = [[task standardOutput] fileHandleForReading];
			[newPipe release];
		} else {
			perror("AMShellWrapper - failed to create pipe for stdOut");
			error = YES;
		}
	} else {
		[task setStandardOutput:stdoutPipe];
		stdoutHandle = stdoutPipe;
	}
	
	if (stderrPipe == nil) {
		NSPipe *newPipe = [[NSPipe alloc] init];
		if (newPipe) {
			[task setStandardError:newPipe];
			stderrHandle = [[task standardError] fileHandleForReading];
			[newPipe release];
		} else {
			perror("AMShellWrapper - failed to create pipe for stdErr");
			error = YES;
		}
	} else {
		[task setStandardError:stderrPipe];
		stderrHandle = stderrPipe;
	}
	
	if (!error) {
		// setting the current working directory
		if (workingDirectory != nil)
			[task setCurrentDirectoryPath:workingDirectory];
		
		// Setting the environment if available
		if (environment != nil)
			[task setEnvironment:environment];
		
		// The path to the binary is the first argument that was passed in
		[task setLaunchPath:[arguments objectAtIndex:0]];
		
		// The rest of the task arguments are just grabbed from the array
		[task setArguments:[arguments subarrayWithRange:NSMakeRange(1, ([arguments count] - 1))]];
		
		// Here we register as an observer of the NSFileHandleReadCompletionNotification,
		// which lets us know when there is data waiting for us to grab it in the task's file
		// handle (the pipe to which we connected stdout and stderr above).
		// -getData: will be called when there is data waiting. The reason we need to do this
		// is because if the file handle gets filled up, the task will block waiting to send
		// data and we'll never get anywhere. So we have to keep reading data from the file
		// handle as we go.
		if (stdoutPipe == nil) // we have to handle this ourselves:
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData:) name:NSFileHandleReadCompletionNotification object:stdoutHandle];
		
		if (stderrPipe == nil) // we have to handle this ourselves:
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData:) name:NSFileHandleReadCompletionNotification object:stderrHandle];
		
		// We tell the file handle to go ahead and read in the background asynchronously,
		// and notify us via the callback registered above when we signed up as an observer.
		// The file handle will send a NSFileHandleReadCompletionNotification when it has
		// data that is available.
		[stdoutHandle readInBackgroundAndNotify];
		[stderrHandle readInBackgroundAndNotify];
		
		// since waiting for the output pipes to run dry seems unreliable in terms of
		// deciding wether the task has died, we go the 'clean' route and wait for a notification
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskStopped:) name:NSTaskDidTerminateNotification object:task];
		
		// we will wait for data in stdout; there may be nothing to receive from stderr
		stdoutEmpty = NO;
		stderrEmpty = YES;
		
		// launch the task asynchronously
		[task launch];
		
		// since the notification center does not retain the observer, make sure
		// we don't get deallocated early
		[self retain];
	} else {
		[self retain];
		[self performSelector:@selector(cleanup) withObject:nil afterDelay:0];
	}
}

// terminate the task
- (void)stopProcess
{
	[task terminate];
}

// If the task ends, there is no more data coming through the file handle even when
// the notification is sent, or the process object is released, then this method is called.
- (void)cleanup
{
	NSData *data;
	int terminationStatus = -1;
	
	if (taskDidTerminate) {
		// It is important to clean up after ourselves so that we don't leave potentially
		// deallocated objects as observers in the notification center; this can lead to
		// crashes.
		[[NSNotificationCenter defaultCenter] removeObserver:self];
		
		// Make sure the task has actually stopped!
		//[task terminate];
		
		// NSFileHandle availableData is a blocking read - what were they thinking? :-/
		// Umm - OK. It comes back when the file is closed. So here we go ...
		
		// clear stdout
		while ((data = [stdoutHandle availableData]) && [data length]) {
			[self appendOutput:data];
		}
		
		// clear stderr
		while ((data = [stderrHandle availableData]) && [data length]) {
			[self appendError:data];
		}
		terminationStatus = [task terminationStatus];
	}
	
	// we tell the controller that we finished, via the callback, and then blow away
	// our connection to the controller.  NSTasks are one-shot (not for reuse), so we
	// might as well be too.
	[delegate processFinished:self withTerminationStatus:terminationStatus];

	/*
	NSDictionary *userInfo = nil;
	// task has to go so we can't put it in a dictionary ...
	if (task) {
		userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[[task retain] autorelease], AMShellWrapperProcessFinishedNotificationTaskKey, [NSNumber numberWithInt:terminationStatus], AMShellWrapperProcessFinishedNotificationTerminationStatusKey, nil];
	} else {
		userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNull null], AMShellWrapperProcessFinishedNotificationTaskKey, [NSNumber numberWithInt:terminationStatus], AMShellWrapperProcessFinishedNotificationTerminationStatusKey, nil];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:AMShellWrapperProcessFinishedNotification object:self userInfo:userInfo];
	*/
	
	delegate = nil;

	// we are done; go ahead and kill us if you like ...
	[self release];
}

// input to stdin
- (void)appendInput:(id)input
{
	if ([input isKindOfClass:[NSString class]]) {
		[stdinHandle writeData:[input dataUsingEncoding:inputStringEncoding]];
	} else if ([input isKindOfClass:[NSData class]]) {
		[stdinHandle writeData:input];
	} else {
		NSLog(@"AMShellWrapper -appendInput expects NSString or NSData parameter (found: %@)", NSStringFromClass([input class]));
	}

}

- (void)closeInput
{
	[stdinHandle closeFile];
}

- (void)appendOutput:(NSData *)data
{
	if (binaryOutput) {
		[delegate process:self appendOutput:data];
	} else {
		NSString *outputString = [[[NSString alloc] initWithData:data encoding:outputStringEncoding] autorelease];
		if (outputString) {
			[delegate process:self appendOutput:outputString];
		} else {
			NSLog(@"AMShellWrapper - not able to encode output. Specified encoding: %u", (unsigned int)outputStringEncoding);
		}
	}
}

- (void)appendError:(NSData *)data
{
	NSString *errorString = [[[NSString alloc] initWithData:data encoding:outputStringEncoding] autorelease];
	if (errorString) {
		[delegate process:self appendError:errorString];
	} else {
		NSLog(@"AMShellWrapper - not able to encode output. Specified encoding: %u", (unsigned int)outputStringEncoding);
	}
}

// This method is called asynchronously when data is available from the task's file handle.
// We just pass the data along to the controller as an NSString.
- (void)getData:(NSNotification *)aNotification
{
	NSData *data;
	id notificationObject;
	
	notificationObject = [aNotification object];
	data = [[aNotification userInfo] objectForKey:NSFileHandleNotificationDataItem];
	
	// If the length of the data is zero, then the task is basically over - there is nothing
	// more to get from the handle so we may as well shut down.
	if ([data length]) {
		// Send the data on to the controller; we can't just use +stringWithUTF8String: here
		// because -[data bytes] is not necessarily a properly terminated string.
		// -initWithData:encoding: on the other hand checks -[data length]
		if ([notificationObject isEqualTo:stdoutHandle]) {
			[self appendOutput:data];
			stdoutEmpty = NO;
		} else if ([notificationObject isEqualTo:stderrHandle]) {
			[self appendError:data];
			stderrEmpty = NO;
		} else {
			// this should really not happen ...
		}
		
		// we need to schedule the file handle go read more data in the background again.
		[notificationObject readInBackgroundAndNotify];
	} else {
		if ([notificationObject isEqualTo:stdoutHandle]) {
			stdoutEmpty = YES;
		} else if ([notificationObject isEqualTo:stderrHandle]) {
			stderrEmpty = YES;
		} else {
			// this should really not happen ...
		}
		// if there is no more data in the pipe AND the task did terminate, we are done
		if (stdoutEmpty && stderrEmpty && taskDidTerminate) {
			[self cleanup];
		}
	}
	
	// we need to schedule the file handle go read more data in the background again.
	//[notificationObject readInBackgroundAndNotify];  
}

- (void)taskStopped:(NSNotification *)aNotification
{
	if (!taskDidTerminate) {
		taskDidTerminate = YES;
		// did we receive all data?
		if (stdoutEmpty && stderrEmpty) {
			// no data left - do the clean up
			[self cleanup];
		}
	}
}


@end
