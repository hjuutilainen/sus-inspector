//
//  SIAppDelegate.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 4.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIAppDelegate.h"
#import "DataModelHeaders.h"
#import "SIMainWindowController.h"
#import "SIOperationManager.h"
#import "SIReposadoConfigurationController.h"

@implementation SIAppDelegate

- (void)dealloc
{
    [_persistentStoreCoordinator release];
    [_managedObjectModel release];
    [_managedObjectContext release];
    [super dealloc];
}

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

NSString *defaultInstanceName = @"Default";
NSString *defaultReposadoDataDirectory = @"data";
NSString *defaultReposadoCodeDirectory = @"code";


- (void)reposadoConfigurationDidFinish:(id)sender returnCode:(int)returnCode object:(ReposadoInstanceMO *)object
{
    [self.managedObjectContext refreshObject:object mergeChanges:YES];
    [[[self managedObjectContext] undoManager] endUndoGrouping];
    
    if (returnCode == NSOKButton) {
        [self.defaultReposadoInstance configureReposado];
    } else if (returnCode == NSOKButton) {
        [[[self managedObjectContext] undoManager] undo];
    }
}


- (SUProductMO *)newOrExistingProductForID:(NSString *)productID
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    NSFetchRequest *fetchForProduct = [[NSFetchRequest alloc] init];
    [fetchForProduct setEntity:[NSEntityDescription entityForName:@"SUProduct" inManagedObjectContext:moc]];
    NSPredicate *productIDPredicate = [NSPredicate predicateWithFormat:@"productID == %@", productID];
    [fetchForProduct setPredicate:productIDPredicate];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchForProduct error:nil];
    if (numFoundCatalogs == 0) {
        SUProductMO *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"SUProduct" inManagedObjectContext:moc];
        newProduct.productID = productID;
        return newProduct;
    } else {
        SUProductMO *existingProduct = [[moc executeFetchRequest:fetchForProduct error:nil] objectAtIndex:0];
        return existingProduct;
    }
}


- (IBAction)reposyncAction:(id)sender
{
    SIOperationManager *operationManager = [SIOperationManager sharedManager];
    operationManager.delegate = self;
    [operationManager runReposync:self.defaultReposadoInstance];
}

- (void)setupDefaultReposado
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    SIOperationManager *operationManager = [SIOperationManager sharedManager];
    operationManager.delegate = self;
    
    // This is the directory where default reposado instance will be installed
    NSURL *localReposadoInstallURL = [[self applicationFilesDirectory] URLByAppendingPathComponent:defaultInstanceName];
    
    NSEntityDescription *reposadoEntityDescr = [NSEntityDescription entityForName:@"ReposadoInstance" inManagedObjectContext:moc];
    NSFetchRequest *fetchForReposadoInstances = [[NSFetchRequest alloc] init];
    [fetchForReposadoInstances setEntity:reposadoEntityDescr];
    NSPredicate *installURLPredicate = [NSPredicate predicateWithFormat:@"reposadoInstallURL == %@", localReposadoInstallURL];
    [fetchForReposadoInstances setPredicate:installURLPredicate];
    NSUInteger numFoundReposados = [moc countForFetchRequest:fetchForReposadoInstances error:nil];
    ReposadoInstanceMO *instance = nil;
    if (numFoundReposados == 0) {
        instance = [NSEntityDescription insertNewObjectForEntityForName:@"ReposadoInstance" inManagedObjectContext:self.managedObjectContext];
        instance.reposadoInstallURL = localReposadoInstallURL;
        
        for (NSDictionary *defaultCatalog in [[NSUserDefaults standardUserDefaults] arrayForKey:@"defaultCatalogs"]) {
            SUCatalogMO *newCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SUCatalog" inManagedObjectContext:moc];
            newCatalog.catalogURL = [defaultCatalog objectForKey:@"catalogURL"];
            newCatalog.catalogDisplayName = [defaultCatalog objectForKey:@"catalogDisplayName"];
            newCatalog.catalogOSVersion = [defaultCatalog objectForKey:@"catalogOSVersion"];
            newCatalog.isActiveValue = YES;
            [instance addCatalogsObject:newCatalog];
        }
        
        self.defaultReposadoInstance = instance;
        
        [[[self managedObjectContext] undoManager] beginUndoGrouping];
        [[[self managedObjectContext] undoManager] setActionName:@"Edit Reposado Configuration"];
        
        [self.mainWindowController.reposadoConfigurationController beginEditSessionWithObject:self.defaultReposadoInstance delegate:self];
        
        /*
        BOOL installedAndConfigured = [instance runInitialSetup];
        if (!installedAndConfigured) {
            NSLog(@"Error: Failed to setup local reposado instance");
        }
         */
    } else {
        instance = [[moc executeFetchRequest:fetchForReposadoInstances error:nil] objectAtIndex:0];
        self.defaultReposadoInstance = instance;
        [operationManager readReposadoInstanceContentsAsync:instance];
    }
    [fetchForReposadoInstances release];
    
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /*
     * Create view and window controllers
     */
    self.mainWindowController = [[SIMainWindowController alloc] initWithWindowNibName:@"SIMainWindowController"];
    [self.mainWindowController showWindow:self];
    
    /*
     * Setup a default reposado instance
     */
    [self setupDefaultReposado];
}

- (void)awakeFromNib
{
    
}


# pragma mark -
# pragma mark SIOprationManager delegate

- (void)willStartOperations:(id)sender
{
    [self.mainWindowController showProgressPanel];
}


- (void)willEndOperations:(id)sender
{
    [[SIOperationManager sharedManager] setupSourceListItems];
    [self.mainWindowController hideProgressPanel];
}


# pragma mark -
# pragma mark Core data defaults

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "fi.obsolete.SUS_Inspector" in the user's Application Support directory.
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
    NSPersistentStoreCoordinator *coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom] autorelease];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = [coordinator retain];
    
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
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

@end
