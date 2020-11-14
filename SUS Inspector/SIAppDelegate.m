//
//  SIAppDelegate.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 4.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "SIAppDelegate.h"
#import "SIMainWindowController.h"
#import "SIPreferencesController.h"
#import "SIReposadoConstants.h"
#import "SIMunkiAdminBridge.h"

@implementation SIAppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (IBAction)openPreferencesAction:sender
{
	[self.preferencesController showWindow:self];
}


- (void)reposadoConfigurationDidFinish:(id)sender returnCode:(int)returnCode object:(SIReposadoInstanceMO *)object
{
    /*
     * This is a callback from Reposado configuration
     */
    
    if (returnCode == NSModalResponseOK) {
        /*
         * User approved the Reposado settings
         * Install, configure and run the initial repo_sync
         */
        [self.managedObjectContext refreshObject:object mergeChanges:YES];
        [self.defaultReposadoInstance configureReposado];
        self.defaultReposadoInstance.reposadoSetupCompleteValue = YES;
        SIOperationManager *operationManager = [SIOperationManager sharedManager];
        //[operationManager setupSourceListItems];
        [operationManager runReposync:self.defaultReposadoInstance];
    } else if (returnCode == NSModalResponseCancel) {
        /*
         * User cancelled the configuration.
         * Undo everything and delete the instance
         */
        for (SICatalogMO *aCatalog in object.catalogs) {
            [self.managedObjectContext deleteObject:aCatalog];
        }
        [self.managedObjectContext deleteObject:object];
        //SIOperationManager *operationManager = [SIOperationManager sharedManager];
        //[operationManager setupCatalogSourceListSection];
    }
}

- (IBAction)forceReadRepoAction:(id)sender
{
    [self deleteAllObjectsForEntityName:@"SIProduct"];
    
    SIOperationManager *operationManager = [SIOperationManager sharedManager];
    operationManager.delegate = self;
    [operationManager readReposadoInstanceContentsAsync:self.defaultReposadoInstance force:YES];
}


- (void)deleteAllObjectsForEntityName:(NSString *)entity
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:moc]];
    NSArray *foundObjects = [moc executeFetchRequest:fetchRequest error:nil];
    [foundObjects enumerateObjectsWithOptions:0 usingBlock:^(id anObject, NSUInteger idx, BOOL *stop) {
        [moc deleteObject:anObject];
    }];
    [moc processPendingChanges];
}

- (IBAction)reposyncAction:(id)sender
{    
    SIOperationManager *operationManager = [SIOperationManager sharedManager];
    operationManager.delegate = self;
    [operationManager runReposync:self.defaultReposadoInstance];
}

- (void)setupReposadoInstance:(SIReposadoInstanceMO *)instance
{
    self.defaultReposadoInstance = instance;
    
    //[[[self managedObjectContext] undoManager] beginUndoGrouping];
    //[[[self managedObjectContext] undoManager] setActionName:@"Edit Reposado Configuration"];
    
    // Run the configuration GUI
    [self.mainWindowController.reposadoConfigurationController beginEditSessionWithObject:self.defaultReposadoInstance delegate:self];
}


- (BOOL)createDirectoriesForReposadoAtURL:(NSURL *)url
{
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *properties = [url resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[url path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return NO;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store Reposado data, found a file (%@).", [url path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return NO;
        }
    }
    return YES;
}

- (void)createDefaultReposadoInstance
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    // This is the directory where default reposado instance will be installed
    NSURL *localReposadoInstallURL = [[self applicationFilesDirectory] URLByAppendingPathComponent:kReposadoDefaultInstanceName];
    if (![self createDirectoriesForReposadoAtURL:localReposadoInstallURL]) {
        return;
    }
    
    SIReposadoInstanceMO *instance = nil;
    instance = [NSEntityDescription insertNewObjectForEntityForName:@"SIReposadoInstance"
                                             inManagedObjectContext:self.managedObjectContext];
    instance.reposadoInstallURL = localReposadoInstallURL;
    
    // Set some defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultBaseURL = [defaults stringForKey:@"baseURL"];
    instance.reposadoCatalogsBaseURLString = defaultBaseURL;
    for (NSDictionary *defaultCatalog in [defaults arrayForKey:@"defaultCatalogs"]) {
        SICatalogMO *newCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SICatalog" inManagedObjectContext:moc];
        NSString *defaultCatalogURL = [defaultCatalog objectForKey:@"catalogURL"];
        NSString *newURL = [defaultCatalogURL stringByReplacingOccurrencesOfString:@"https?://swscan\\.apple\\.com"
                                                                        withString:defaultBaseURL
                                                                           options:NSRegularExpressionSearch
                                                                             range:NSMakeRange(0, defaultCatalogURL.length)];
        newCatalog.catalogURL = newURL;
        newCatalog.catalogDisplayName = [defaultCatalog objectForKey:@"catalogDisplayName"];
        newCatalog.catalogOSVersion = [defaultCatalog objectForKey:@"catalogOSVersion"];
        newCatalog.isActive = [defaultCatalog objectForKey:@"enabled"];
        [instance addCatalogsObject:newCatalog];
    }
    
    [self setupReposadoInstance:instance];
}

- (void)checkForConfiguredReposadoInstance
{
    /*
     * Fetch all reposado instances.
     * There should be also one!
     */
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"SIReposadoInstance" inManagedObjectContext:moc];
    NSFetchRequest *fetchForReposadoInstances = [[NSFetchRequest alloc] init];
    [fetchForReposadoInstances setEntity:entityDescription];
    NSUInteger instanceCount = [moc countForFetchRequest:fetchForReposadoInstances error:nil];
    if (instanceCount == 0) {
        /*
         * Setup a default reposado instance
         */
        [self createDefaultReposadoInstance];
    } else {
        NSArray *foundInstances = [moc executeFetchRequest:fetchForReposadoInstances error:nil];
        if ([foundInstances count] > 1) {
            NSLog(@"WARNING: Multiple reposado instances found. Using the first one and it might not be the right thing to do...");
        }
        SIReposadoInstanceMO *instance = [foundInstances objectAtIndex:0];
        self.defaultReposadoInstance = instance;
        if (instance.reposadoSetupCompleteValue) {
            /*
             * The instance has gone through setup
             */
            
            // Check Reposado version
            NSDictionary *infoDict = instance.reposadoBundleInfoDictionary;
            NSDate *instanceDate = [infoDict objectForKey:@"commitDate"];
            NSDate *bundledReposadoCommitDate = [NSDate dateWithString:kReposadoCurrentCommitDateString];
            if ([bundledReposadoCommitDate compare:instanceDate] == NSOrderedDescending) {
                NSLog(@"Installed Reposado should be updated...");
                [instance updateReposado];
                
            } else if ([bundledReposadoCommitDate compare:instanceDate] == NSOrderedAscending) {
                NSLog(@"Installed Reposado is newer than the bundled one. Hmm...");
            } else {
                NSLog(@"Installed Reposado is up-to-date...");
            }
            
            [[SIOperationManager sharedManager] readReposadoInstanceContentsAsync:instance force:NO];
        } else {
            /*
             * User has probably cancelled the setup so
             * run the configuration GUI again.
             */
            [self setupReposadoInstance:instance];
        }
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /*
     * Create view and window controllers
     */
    self.mainWindowController = [[SIMainWindowController alloc] initWithWindowNibName:@"SIMainWindowController"];
    [self.mainWindowController showWindow:self];
    
    self.preferencesController = [[SIPreferencesController alloc] initWithWindowNibName:@"SIPreferencesController"];
    
    SIOperationManager *operationManager = [SIOperationManager sharedManager];
    operationManager.delegate = self;
    
    /*
     * Setup the initial source list items
     */
    [operationManager setupSourceListGroupItems];
    
    /*
     * We need one configured Reposado instance
     */
    [self checkForConfiguredReposadoInstance];
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:NSManagedObjectContextDidSaveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
         [self.managedObjectContext mergeChangesFromContextDidSaveNotification:note];
     }];
    
    [[SIMunkiAdminBridge sharedBridge] requestMunkiAdminStatusUpdate];
}


# pragma mark -
# pragma mark SIOperationManager delegate

- (void)willStartOperations:(id)sender
{
    SIOperationManager *om = [SIOperationManager sharedManager];
    
    /*
     If we're currently running a package operation, attach the progress
     sheet to the current key window
     */
    if (om.currentOperationType == SIOperationTypePackageOperation) {
        NSWindow *keyWindow = [NSApp keyWindow];
        [self.mainWindowController showProgressPanelAttachedToWindow:keyWindow];
    }
    
    /*
     If we're running a repo_sync, attach the progress sheet to main window
     */
    else if (om.currentOperationType == SIOperationTypeRepoSync) {
        [self.mainWindowController showProgressPanel];
    }
    
    /*
     Default is to attach to the main window
     */
    else {
        [self.mainWindowController showProgressPanel];
    }
}


- (void)willEndOperations:(id)sender
{
    [self.mainWindowController hideProgressPanel];
    [[SIOperationManager sharedManager] setupSourceListItems];
    /*
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SIDidSetupSourceListItems" object:nil];
    }];
     */
    
    //[[SIOperationManager sharedManager] readPackageMetadataFiles:self.defaultReposadoInstance];
}


# pragma mark -
# pragma mark Core data defaults

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.hjuutilainen.SUS_Inspector" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"SUS Inspector"];
}


// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SUS_Inspector" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"SUS_Inspector.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
        
        // Try to remove the store file
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:[url path]]) {
            NSLog(@"Removing persistent store %@", [url path]);
            [fm removeItemAtURL:url error:nil];
            if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
                [[NSApplication sharedApplication] presentError:error];
                return nil;
            }
        } else {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
        
    }
    
    _persistentStoreCoordinator = coordinator;
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) 
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    //_managedObjectContext = [[NSManagedObjectContext alloc] init];
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];

    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSModalResponseCancel) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

@end
