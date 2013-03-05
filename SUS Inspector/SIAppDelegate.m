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

NSString *defaultInstanceName = @"Default Reposado Instance";
NSString *defaultReposadoDataDirectory = @"data";
NSString *defaultReposadoCodeDirectory = @"code";

- (NSDictionary *)preferencesForLocalReposadoAtURL:(NSURL *)installURL
{
    NSURL *localReposadoDataURL = [installURL URLByAppendingPathComponent:defaultReposadoDataDirectory];
    NSURL *reposadoHtmlURL = [localReposadoDataURL URLByAppendingPathComponent:@"html"];
    NSURL *reposadoMetadataURL = [localReposadoDataURL URLByAppendingPathComponent:@"metadata"];
    
    NSDictionary *reposadoPrefs = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [reposadoMetadataURL relativePath], @"UpdatesMetadataDir",
                                   [reposadoHtmlURL relativePath], @"UpdatesRootDir",
                                   nil];
    return reposadoPrefs;
}

- (void)configureReposadoInstance:(ReposadoInstanceMO *)instance
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *localReposadoDataURL = [instance.reposadoInstallURL URLByAppendingPathComponent:defaultReposadoDataDirectory];
    NSURL *reposadoHtmlURL = [localReposadoDataURL URLByAppendingPathComponent:@"html"];
    NSURL *reposadoMetadataURL = [localReposadoDataURL URLByAppendingPathComponent:@"metadata"];
    [fileManager createDirectoryAtURL:localReposadoDataURL withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createDirectoryAtURL:reposadoHtmlURL withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createDirectoryAtURL:reposadoMetadataURL withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSDictionary *prefs = [self preferencesForLocalReposadoAtURL:instance.reposadoInstallURL];
    NSURL *preferencesURL = [instance.codeURL URLByAppendingPathComponent:@"preferences.plist"];
    [prefs writeToURL:preferencesURL atomically:YES];
}

- (ReposadoInstanceMO *)setupLocalReposadoAtURL:(NSURL *)installURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtURL:installURL withIntermediateDirectories:YES attributes:nil error:nil];
    
    ReposadoInstanceMO *newReposadoInstance = [NSEntityDescription insertNewObjectForEntityForName:@"ReposadoInstance" inManagedObjectContext:self.managedObjectContext];
    newReposadoInstance.reposadoInstallURL = installURL;
    newReposadoInstance.reposadoTitle = @"Default Reposado Instance";
    
    // Reposado components we need
    NSURL *repo_syncURL = [newReposadoInstance.codeURL URLByAppendingPathComponent:@"repo_sync"];
    NSURL *repoutilURL = [newReposadoInstance.codeURL URLByAppendingPathComponent:@"repoutil"];
    NSURL *reposadolibURL = [newReposadoInstance.codeURL URLByAppendingPathComponent:@"reposadolib" isDirectory:YES];
    NSURL *reposadoInitURL = [reposadolibURL URLByAppendingPathComponent:@"__init__.py"];
    NSURL *reposadocommonURL = [reposadolibURL URLByAppendingPathComponent:@"reposadocommon.py"];
    
    // Determine if everything is installed
    BOOL reposadoInstalled = YES;
    if (![fileManager fileExistsAtPath:[repo_syncURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[repoutilURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadolibURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadoInitURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadocommonURL path]]) reposadoInstalled = NO;
    
    // Install if needed
    if (!reposadoInstalled) {
        NSLog(@"Installing local reposado to %@", [newReposadoInstance.codeURL path]);
        if ([fileManager fileExistsAtPath:[newReposadoInstance.codeURL path]]) {
            [fileManager removeItemAtURL:newReposadoInstance.codeURL error:nil];
        }
        NSString *mainBundleURL = [[NSBundle mainBundle] bundlePath];
        NSString *bundledReposado = [mainBundleURL stringByAppendingString:@"/Contents/Resources/reposado/code"];
        NSURL *bundledReposadoURL = [NSURL fileURLWithPath:bundledReposado isDirectory:YES];
        NSError *error = nil;
        [fileManager copyItemAtURL:bundledReposadoURL toURL:newReposadoInstance.codeURL error:&error];
        if (error) {
            NSLog(@"%@", [error description]);
        }
        
        // Configure the created instance
        [self configureReposadoInstance:newReposadoInstance];
    }
    return newReposadoInstance;
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

- (void)readReposadoInstanceContents:(ReposadoInstanceMO *)instance
{
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    /*
     * Check the created/modified dates
     */
    NSArray *keysToGet = [NSArray arrayWithObjects:NSURLContentModificationDateKey, NSURLCreationDateKey, nil];
    NSDictionary *urlResourceValues = [instance.productInfoURL resourceValuesForKeys:keysToGet error:nil];
    NSDate *modificationDate = [urlResourceValues objectForKey:NSURLContentModificationDateKey];
    NSDate *creationDate = [urlResourceValues objectForKey:NSURLCreationDateKey];
    
    if (([modificationDate isEqualToDate:instance.productInfoModificationDate]) && ([creationDate isEqualToDate:instance.productInfoCreationDate])) {
        NSLog(@"No need to read ProductInfo");
    } else {
        NSLog(@"Reading %@", [instance.productInfoURL path]);
        
        instance.productInfoModificationDate = modificationDate;
        instance.productInfoCreationDate = creationDate;
        
        NSDictionary *productInfo = [NSDictionary dictionaryWithContentsOfURL:instance.productInfoURL];
        [productInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            /*
             * Create product objects
             */
            
            // Check if the product is valid
            if (([obj objectForKey:@"title"]) || ([obj objectForKey:@"version"])) {
                
                SUProductMO *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"SUProduct" inManagedObjectContext:moc];
                newProduct.productID = (NSString *)key;
                newProduct.productTitle = [obj objectForKey:@"title"];
                newProduct.productDescription = [obj objectForKey:@"description"];
                newProduct.productPostDate = [obj objectForKey:@"PostDate"];
                NSString *sizeAsString = [obj objectForKey:@"size"];
                newProduct.productSize = [NSNumber numberWithInteger:[sizeAsString integerValue]];
                newProduct.productVersion = [obj objectForKey:@"version"];
                
                NSArray *appleCatalogs = [obj objectForKey:@"AppleCatalogs"];
                if ([appleCatalogs count] == 0) {
                    newProduct.productIsDeprecatedValue = YES;
                }
                for (NSString *aCatalogString in appleCatalogs) {
                    NSURL *catalogURL = [NSURL URLWithString:aCatalogString];
                    NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:moc];
                    NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
                    [fetchForCatalogs setEntity:catalogEntityDescr];
                    NSPredicate *installURLPredicate = [NSPredicate predicateWithFormat:@"catalogURL == %@", catalogURL];
                    [fetchForCatalogs setPredicate:installURLPredicate];
                    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchForCatalogs error:nil];
                    if (numFoundCatalogs == 0) {
                        NSLog(@"Creating %@", [catalogURL absoluteString]);
                        SUCatalogMO *newCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SUCatalog" inManagedObjectContext:moc];
                        newCatalog.catalogURL = catalogURL;
                        [newCatalog addProductsObject:newProduct];
                    } else {
                        SUCatalogMO *existingCatalog = [[moc executeFetchRequest:fetchForCatalogs error:nil] objectAtIndex:0];
                        [existingCatalog addProductsObject:newProduct];
                    }
                }
            }
        }];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /*
     * Create view and window controllers
     */
    self.mainWindowController = [[SIMainWindowController alloc] initWithWindowNibName:@"SIMainWindowController"];
    [self.mainWindowController showWindow:self];
    
    
    NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"productPostDate" ascending:NO selector:@selector(compare:)];
    [self.productsArrayController setSortDescriptors:[NSArray arrayWithObjects:sortByDate, nil]];
    
    NSManagedObjectContext *moc = [self managedObjectContext];
    
    // This is the directory where default reposado instance will be installed
    NSURL *localReposadoInstallURL = [[self applicationFilesDirectory] URLByAppendingPathComponent:defaultInstanceName];
    
    NSEntityDescription *reposadoEntityDescr = [NSEntityDescription entityForName:@"ReposadoInstance" inManagedObjectContext:moc];
    NSFetchRequest *fetchForReposadoInstances = [[NSFetchRequest alloc] init];
    [fetchForReposadoInstances setEntity:reposadoEntityDescr];
    NSPredicate *installURLPredicate = [NSPredicate predicateWithFormat:@"reposadoInstallURL == %@", localReposadoInstallURL];
    [fetchForReposadoInstances setPredicate:installURLPredicate];
    NSUInteger numFoundReposados = [moc countForFetchRequest:fetchForReposadoInstances error:nil];
    if (numFoundReposados == 0) {
        ReposadoInstanceMO *existing = [self setupLocalReposadoAtURL:localReposadoInstallURL];
        [self readReposadoInstanceContents:existing];
    } else {
        ReposadoInstanceMO *defaultReposado = [[moc executeFetchRequest:fetchForReposadoInstances error:nil] objectAtIndex:0];
        [self readReposadoInstanceContents:defaultReposado];
    }
}

- (void)awakeFromNib
{
    
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "fi.obsolete.SUS_Inspector" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"fi.obsolete.SUS_Inspector"];
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
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
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
