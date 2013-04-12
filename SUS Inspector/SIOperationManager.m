//
//  SIReposadoManager.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIOperationManager.h"
#import "NSManagedObjectContext+HJGCDExtensions.h"
#import "SIAppDelegate.h"

@interface SIOperationManager () {
    // Private interface
}
@end

@implementation SIOperationManager

# pragma mark -
# pragma mark Singleton methods

static SIOperationManager *sharedManager = nil;
static dispatch_queue_t serialQueue;

+ (id)allocWithZone:(NSZone *)zone {
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        serialQueue = dispatch_queue_create("fi.obsolete.sus-inspector.serialqueue", NULL);
        if (sharedManager == nil) {
            sharedManager = (SIOperationManager *) [super allocWithZone:zone];
        }
    });
    
    return sharedManager;
}

+ (SIOperationManager *)sharedManager {
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        sharedManager = [[SIOperationManager alloc] init];
    });
    
    return sharedManager;
}

- (id)init {
    id __block obj;
    
    dispatch_sync(serialQueue, ^{
        obj = [super init];
        if (obj) {
            self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
            [self.operationQueue setMaxConcurrentOperationCount:4];
        }
    });
    
    self = obj;
    return self;
}

- (void)willStartOperations
{
    self.currentOperationTitle = @"Starting...";
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(willStartOperations:)]) {
            [self.delegate performSelector:@selector(willStartOperations:) withObject:self];
        }
    });
}

- (void)willEndOperations
{
    self.currentOperationTitle = @"Done";
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(willEndOperations:)]) {
            [self.delegate performSelector:@selector(willEndOperations:) withObject:self];
        }
    });
}

- (SUDistributionMO *)distributionWithURLString:(NSString *)urlString managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
    SUDistributionMO *distributionFile = nil;
    NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
    [fetchObjects setEntity:[NSEntityDescription entityForName:@"SUDistribution" inManagedObjectContext:moc]];
    [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"distributionURL == %@", urlString]];
    NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
    if (numFoundObjects == 0) {
        distributionFile = [NSEntityDescription insertNewObjectForEntityForName:@"SUDistribution" inManagedObjectContext:moc];
        distributionFile.distributionURL = urlString;
    } else {
        distributionFile = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
    }
    [fetchObjects release];
    return distributionFile;
     */
    SUDistributionMO *distributionFile = [NSEntityDescription insertNewObjectForEntityForName:@"SUDistribution" inManagedObjectContext:moc];
    distributionFile.distributionURL = urlString;
    return distributionFile;
}

- (SUPackageMO *)packageWithURLString:(NSString *)urlString managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
    SUPackageMO *thePackage = nil;
    NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
    [fetchObjects setEntity:[NSEntityDescription entityForName:@"SUPackage" inManagedObjectContext:moc]];
    [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"packageURL == %@", urlString]];
    NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
    if (numFoundObjects == 0) {
        thePackage = [NSEntityDescription insertNewObjectForEntityForName:@"SUPackage" inManagedObjectContext:moc];
        thePackage.packageURL = urlString;
    } else {
        thePackage = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
    }
    [fetchObjects release];
    return thePackage;
    */
    SUPackageMO *thePackage = [NSEntityDescription insertNewObjectForEntityForName:@"SUPackage" inManagedObjectContext:moc];
    thePackage.packageURL = urlString;
    return thePackage;
}

- (SUProductMO *)productWithID:(NSString *)productID managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
    SUProductMO *theProduct = nil;
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SUProduct" inManagedObjectContext:moc]];
    [fetchProducts setPredicate:[NSPredicate predicateWithFormat:@"productID == %@", productID]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs == 0) {
        theProduct = [NSEntityDescription insertNewObjectForEntityForName:@"SUProduct" inManagedObjectContext:moc];
        theProduct.productID = productID;
    } else {
        theProduct = [[moc executeFetchRequest:fetchProducts error:nil] objectAtIndex:0];
    }
    [fetchProducts release];
    return theProduct;
    */
    SUProductMO *theProduct = [NSEntityDescription insertNewObjectForEntityForName:@"SUProduct" inManagedObjectContext:moc];
    theProduct.productID = productID;
    return theProduct;
}

- (NSArray *)allCatalogs
{
    NSArray *catalogs = nil;
    NSManagedObjectContext *moc = [[NSApp delegate] managedObjectContext];
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:moc]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs > 0) {
        catalogs = [moc executeFetchRequest:fetchProducts error:nil];
    }
    [fetchProducts release];
    return catalogs;
}

- (SUCatalogMO *)catalogWithURL:(NSString *)catalogURL managedObjectContext:(NSManagedObjectContext *)moc
{
    SUCatalogMO *theCatalog = nil;
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:moc]];
    [fetchProducts setPredicate:[NSPredicate predicateWithFormat:@"catalogURL == %@", catalogURL]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs == 0) {
        theCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SUCatalog" inManagedObjectContext:moc];
        theCatalog.catalogURL = catalogURL;
    } else {
        theCatalog = [[moc executeFetchRequest:fetchProducts error:nil] objectAtIndex:0];
    }
    [fetchProducts release];
    return theCatalog;
}

- (SourceListItemMO *)sourceListItemWithTitle:(NSString *)title managedObjectContext:(NSManagedObjectContext *)moc
{
    SourceListItemMO *theCatalog = nil;
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SourceListItem" inManagedObjectContext:moc]];
    [fetchProducts setPredicate:[NSPredicate predicateWithFormat:@"title == %@", title]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs == 0) {
        theCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SourceListItem" inManagedObjectContext:moc];
        theCatalog.title = title;
    } else {
        theCatalog = [[moc executeFetchRequest:fetchProducts error:nil] objectAtIndex:0];
    }
    [fetchProducts release];
    return theCatalog;
}

- (void)setupSourceListItems
{
    NSManagedObjectContext *parentMoc = [[NSApp delegate] managedObjectContext];
    [parentMoc performBlockWithPrivateQueueConcurrencyAndWait:^(NSManagedObjectContext *threadSafeMoc) {
        
        SourceListItemMO *smartItem = [self sourceListItemWithTitle:@"PRODUCTS" managedObjectContext:threadSafeMoc];
        smartItem.isGroupItemValue = YES;
        smartItem.sortIndexValue = 0;
        
        NSImage *instanceImage = [NSImage imageNamed:@"104-index-cards"];
        [instanceImage setTemplate:YES];        
        
        SourceListItemMO *allProductsItem = [self sourceListItemWithTitle:@"All Products" managedObjectContext:threadSafeMoc];
        allProductsItem.iconImage = instanceImage;
        allProductsItem.parent = smartItem;
        allProductsItem.sortIndexValue = 0;
        SUCatalogMO *allCatalog = [self catalogWithURL:@"/all" managedObjectContext:threadSafeMoc];
        allCatalog.catalogDisplayName = @"All Products";
        allProductsItem.catalogReference = allCatalog;
        
        SourceListItemMO *deprecatedProductsItem = [self sourceListItemWithTitle:@"Deprecated Products" managedObjectContext:threadSafeMoc];
        deprecatedProductsItem.iconImage = instanceImage;
        deprecatedProductsItem.parent = smartItem;
        deprecatedProductsItem.sortIndexValue = 1;
        SUCatalogMO *deprecatedCatalog = [self catalogWithURL:@"/deprecated" managedObjectContext:threadSafeMoc];
        deprecatedCatalog.catalogDisplayName = @"Deprecated Products";
        deprecatedProductsItem.catalogReference = deprecatedCatalog;
        
        
        SourceListItemMO *catalogsGroupItem = [self sourceListItemWithTitle:@"CATALOGS" managedObjectContext:threadSafeMoc];
        catalogsGroupItem.isGroupItemValue = YES;
        catalogsGroupItem.sortIndexValue = 1;
        
        // Fetch all catalogs
        NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:threadSafeMoc];
        NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
        NSPredicate *notDeprecated = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/deprecated"];
        NSPredicate *notAll = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/all"];
        NSPredicate *isActive = [NSPredicate predicateWithFormat:@"isActive == TRUE"];
        NSPredicate *instanceSetupComplete = [NSPredicate predicateWithFormat:@"reposadoInstance.reposadoSetupComplete == TRUE"];
        NSArray *subPredicates = [NSArray arrayWithObjects:notAll, notDeprecated, isActive, instanceSetupComplete, nil];
        NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
        [fetchForCatalogs setPredicate:predicate];
        [fetchForCatalogs setEntity:catalogEntityDescr];
        NSUInteger numFoundCatalogs = [threadSafeMoc countForFetchRequest:fetchForCatalogs error:nil];
        if (numFoundCatalogs != 0) {
            NSArray *allCatalogs = [threadSafeMoc executeFetchRequest:fetchForCatalogs error:nil];
            [allCatalogs enumerateObjectsUsingBlock:^(SUCatalogMO *catalog, NSUInteger idx, BOOL *stop) {
                SourceListItemMO *catalogItem = [self sourceListItemWithTitle:catalog.catalogDisplayName managedObjectContext:threadSafeMoc];
                NSImage *catalogImage = [NSImage imageNamed:@"96-book"];
                [catalogImage setTemplate:YES];
                catalogItem.iconImage = catalogImage;
                catalogItem.parent = catalogsGroupItem;
                catalogItem.catalogReference = catalog;
            }];
        }
        [fetchForCatalogs release];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SIDidSetupSourceListItems" object:nil];
    });
}

- (void)readReposadoInstanceContents:(ReposadoInstanceMO *)blockInstance managedObjectContext:(NSManagedObjectContext *)threadSafeMoc
{
    /*
     * Check the created/modified dates
     */
    NSArray *keysToGet = [NSArray arrayWithObjects:NSURLContentModificationDateKey, NSURLCreationDateKey, nil];
    NSDictionary *urlResourceValues = [blockInstance.productInfoURL resourceValuesForKeys:keysToGet error:nil];
    NSDate *modificationDate = [urlResourceValues objectForKey:NSURLContentModificationDateKey];
    NSDate *creationDate = [urlResourceValues objectForKey:NSURLCreationDateKey];
    
    __block SUCatalogMO *allCatalog = [self catalogWithURL:@"/all" managedObjectContext:threadSafeMoc];
    allCatalog.catalogTitle = @"All products";
    
    __block SUCatalogMO *deprecatedCatalog = [self catalogWithURL:@"/deprecated" managedObjectContext:threadSafeMoc];
    deprecatedCatalog.catalogTitle = @"Deprecated products";
    
    BOOL readNeeded = ((![modificationDate isEqualToDate:blockInstance.productInfoModificationDate]) ||
                       (![creationDate isEqualToDate:blockInstance.productInfoCreationDate])
                       ) ? TRUE : FALSE;
    
    if (readNeeded)
    {
        NSLog(@"Reading %@", [blockInstance.productInfoURL path]);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        blockInstance.productInfoModificationDate = modificationDate;
        blockInstance.productInfoCreationDate = creationDate;
                
        // Delete some objects that we're going to rescan anyway
        NSArray *entitiesToClear = [NSArray arrayWithObjects:@"SUProduct", @"SUPackage", @"SUDistribution", nil];
        [entitiesToClear enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:obj inManagedObjectContext:threadSafeMoc]];
            NSArray *foundObjects = [threadSafeMoc executeFetchRequest:fetchRequest error:nil];
            for (id anObject in foundObjects) {
                [threadSafeMoc deleteObject:anObject];
            }
            [fetchRequest release];
        }];
        
        
        NSDictionary *productInfo = [NSDictionary dictionaryWithContentsOfURL:blockInstance.productInfoURL];
        
        self.currentOperationTitle = [NSString stringWithFormat:@"Reading product information for %li products...", (unsigned long)[productInfo count]];
        [productInfo enumerateKeysAndObjectsWithOptions:0 usingBlock:^(NSString *key, id obj, BOOL *stop) {
            self.currentOperationDescription = [NSString stringWithFormat:@"%@ %@", key, [obj objectForKey:@"title"]];
            /*
             * Create product objects
             */
            
            // Check if the product is valid
            BOOL hasProductID   = (![key isEqualToString:@""]) ? TRUE : FALSE;
            BOOL hasTitle       = ([obj objectForKey:@"title"]) ? TRUE : FALSE;
            BOOL hasVersion     = ([obj objectForKey:@"version"]) ? TRUE : FALSE;
            BOOL hasPostDate    = ([obj objectForKey:@"PostDate"]) ? TRUE : FALSE;
            BOOL hasSize        = ([obj objectForKey:@"size"]) ? TRUE : FALSE;
            
            BOOL validProduct   = (hasProductID && hasTitle && hasVersion &&
                                   hasPostDate && hasSize
                                   ) ? TRUE : FALSE;
            
            if (validProduct)
            {
                /*
                 * Parse the basic properties
                 */
                SUProductMO *newProduct = [self productWithID:key managedObjectContext:threadSafeMoc];
                newProduct.productTitle = [obj objectForKey:@"title"];
                newProduct.productDescription = [obj objectForKey:@"description"];
                newProduct.productPostDate = [obj objectForKey:@"PostDate"];
                NSString *sizeAsString = [obj objectForKey:@"size"];
                newProduct.productSize = [NSNumber numberWithInteger:[sizeAsString integerValue]];
                newProduct.productVersion = [obj objectForKey:@"version"];
                [newProduct addCatalogsObject:allCatalog];
                
                /*
                 * Parse catalogs
                 */
                NSArray *appleCatalogs = [obj objectForKey:@"AppleCatalogs"];
                if ([appleCatalogs count] == 0) {
                    newProduct.productIsDeprecatedValue = YES;
                    [newProduct addCatalogsObject:deprecatedCatalog];
                }
                for (NSString *aCatalogString in appleCatalogs) {
                    NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:threadSafeMoc];
                    NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
                    [fetchForCatalogs setEntity:catalogEntityDescr];
                    NSPredicate *installURLPredicate = [NSPredicate predicateWithFormat:@"catalogURL == %@", aCatalogString];
                    [fetchForCatalogs setPredicate:installURLPredicate];
                    NSUInteger numFoundCatalogs = [threadSafeMoc countForFetchRequest:fetchForCatalogs error:nil];
                    if (numFoundCatalogs == 0) {
                        NSLog(@"ERROR: Did not find catalog object for URL %@", aCatalogString);
                    } else {
                        SUCatalogMO *existingCatalog = [[threadSafeMoc executeFetchRequest:fetchForCatalogs error:nil] objectAtIndex:0];
                        [existingCatalog addProductsObject:newProduct];
                    }
                    [fetchForCatalogs release];
                }
                
                /*
                 * Parse packages
                 */
                NSDictionary *catalogEntry = [obj objectForKey:@"CatalogEntry"];
                NSArray *packages = [catalogEntry objectForKey:@"Packages"];
                for (NSDictionary *aPackage in packages) {
                    NSString *packageURL = [aPackage objectForKey:@"URL"];
                    NSNumber *size = [aPackage objectForKey:@"Size"];
                    NSString *metadataURL = [aPackage objectForKey:@"MetadataURL"];
                    SUPackageMO *newPackage = [self packageWithURLString:packageURL managedObjectContext:threadSafeMoc];
                    newPackage.packageSize = size;
                    newPackage.packageMetadataURL = metadataURL;
                    newPackage.product = newProduct;
                    NSString *localPath = [blockInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:packageURL]];
                    if ([fileManager fileExistsAtPath:localPath]) {
                        newPackage.packageIsCachedValue = YES;
                        newPackage.packageCachedPath = localPath;
                    }
                }
                
                /*
                 * Parse distribution files
                 */
                NSDictionary *distributions = [catalogEntry objectForKey:@"Distributions"];
                [distributions enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    SUDistributionMO *newDistribution = [self distributionWithURLString:(NSString *)obj managedObjectContext:threadSafeMoc];
                    newDistribution.distributionLanguage = key;
                    newDistribution.product = newProduct;
                    NSString *localPath = [blockInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:obj]];
                    if ([fileManager fileExistsAtPath:localPath]) {
                        newDistribution.distributionIsCachedValue = YES;
                        newDistribution.distributionCachedPath = localPath;
                    }
                }];
                
            } else {
                NSLog(@"Invalid product %@. Skipped...", key);
            }
        }];
        self.currentOperationDescription = @"";
    }
}


- (void)readReposadoInstanceContentsAsync:(ReposadoInstanceMO *)instance
{
    __block NSManagedObjectID *instanceID = instance.objectID;
    
    self.currentOperationTitle = @"Reading product information...";
    [self willStartOperations];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSManagedObjectContext *parentMoc = [[NSApp delegate] managedObjectContext];
        
        [parentMoc performBlockWithPrivateQueueConcurrencyAndWait:^(NSManagedObjectContext *threadSafeMoc) {
            // Get the reposado instance in this managed object context
            ReposadoInstanceMO *blockInstance = (ReposadoInstanceMO *)[threadSafeMoc objectWithID:instanceID];
            [self readReposadoInstanceContents:blockInstance managedObjectContext:threadSafeMoc];
            self.currentOperationTitle = @"Saving...";
        }];
        [self willEndOperations];
        
        /*
        [parentMoc performBlockWithPrivateQueueConcurrency:^(NSManagedObjectContext *threadSafeMoc) {
            // Get the reposado instance in this managed object context
            ReposadoInstanceMO *blockInstance = (ReposadoInstanceMO *)[threadSafeMoc objectWithID:instanceID];
            [self readReposadoInstanceContents:blockInstance managedObjectContext:threadSafeMoc];
        } completionBlock:^{
            self.currentOperationTitle = @"Saving...";
            [self willEndOperations];
        }];
         */
    });
}


- (void)runReposync:(ReposadoInstanceMO *)instance
{
    self.currentCatalogs = [self allCatalogs];
    NSArray *arguments = [NSArray arrayWithObjects:instance.reposyncPath, nil];
    AMShellWrapper *wrapper = [[[AMShellWrapper alloc] initWithInputPipe:nil
                                                              outputPipe:nil
                                                               errorPipe:nil
                                                        workingDirectory:@"."
                                                             environment:nil
                                                               arguments:arguments
                                                                 context:NULL] autorelease];
	[wrapper setDelegate:self];
    self.shellWrapper = wrapper;
    if (self.shellWrapper) {
		[self.shellWrapper startProcess];
	}
}


// ============================================================
// conforming to the AMShellWrapperDelegate protocol:
// ============================================================

- (NSString *)cleanReposadoMessage:(NSString *)message
{
    NSString *cleanedString = message;
    for (SUCatalogMO *aCatalog in self.currentCatalogs) {
        cleanedString = [cleanedString stringByReplacingOccurrencesOfString:aCatalog.catalogURL
                                                                 withString:[NSString stringWithFormat:@"catalog %@", aCatalog.catalogDisplayName]];
        cleanedString = [cleanedString stringByReplacingOccurrencesOfString:aCatalog.catalogFilename
                                                                 withString:[NSString stringWithFormat:@"catalog %@", aCatalog.catalogDisplayName]];
    }
    
    // If we still have long URLs in the message, replace them with the last path component
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeLink error:&error];
    NSTextCheckingResult *match = [detector firstMatchInString:cleanedString options:0 range:NSMakeRange(0, [cleanedString length])];
    if (match) {
        NSURL *url = [match URL];
        cleanedString = [cleanedString stringByReplacingOccurrencesOfString:[url relativeString]
                                                                 withString:[url lastPathComponent]];
    }
    
    NSRegularExpression *distRegex = [NSRegularExpression regularExpressionWithPattern:@"Downloading \\d+ bytes from" options:NSRegularExpressionCaseInsensitive error:nil];
    NSRange rangeOfFirstMatch = [distRegex rangeOfFirstMatchInString:cleanedString options:0 range:NSMakeRange(0, [cleanedString length])];
    if (!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0))) {
        NSString *substringForFirstMatch = [cleanedString substringWithRange:rangeOfFirstMatch];
        cleanedString = [cleanedString stringByReplacingOccurrencesOfString:substringForFirstMatch
                                                                 withString:@"Downloading"];
    }
    
    return cleanedString;
}

- (void)write:(NSString *)string
{
    if (![string isEqualToString:@""]) {
        self.currentOperationDescription = [self cleanReposadoMessage:string];
    }
}

// output from stdout
- (void)process:(AMShellWrapper *)wrapper appendOutput:(id)output
{
	[self write:output];
}

// output from stderr
- (void)process:(AMShellWrapper *)wrapper appendError:(NSString *)error
{
	//[errorOutlet setString:[[errorOutlet string] stringByAppendingString:error]];
    NSLog(@"ERROR: %@", error);
}

// This method is a callback which your controller can use to do other initialization
// when a process is launched.
- (void)processStarted:(AMShellWrapper *)wrapper
{
	[self willStartOperations];
    self.currentOperationTitle = @"Refreshing catalogs...";
}

// This method is a callback which your controller can use to do other cleanup
// when a process is halted.
- (void)processFinished:(AMShellWrapper *)wrapper withTerminationStatus:(int)resultCode
{
    /*
	[self write:[NSString stringWithFormat:@"\rcommand finished. Result code: %i\r", resultCode]];
	[self setShellWrapper:nil];
	[textOutlet scrollRangeToVisible:NSMakeRange([[textOutlet string] length], 0)];
	[errorOutlet scrollRangeToVisible:NSMakeRange([[errorOutlet string] length], 0)];
	[runButton setEnabled:YES];
	[progressIndicator stopAnimation:self];
	[runButton setTitle:@"Execute"];
	[runButton setAction:@selector(printBanner:)];
     */
    
    [self readReposadoInstanceContentsAsync:[[NSApp delegate] defaultReposadoInstance]];
    //[self willEndOperations];
}

- (void)processLaunchException:(NSException *)exception
{
    /*
	[self write:[NSString stringWithFormat:@"\rcaught %@ while executing command\r", [exception name]]];
	[textOutlet scrollRangeToVisible:NSMakeRange([[textOutlet string] length], 0)];
	[errorOutlet scrollRangeToVisible:NSMakeRange([[errorOutlet string] length], 0)];
	[runButton setEnabled:YES];
	[progressIndicator stopAnimation:self];
	[runButton setTitle:@"Execute"];
	[runButton setAction:@selector(printBanner:)];
	[self setShellWrapper:nil];
     */
    [self willEndOperations];
}



# pragma mark -
# pragma mark NSURLDownload methods

- (void)cacheDistributionFileWithURL:(NSURL *)url
{
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:5.0];
    
    NSURLDownload  *theDownload = [[NSURLDownload alloc] initWithRequest:theRequest delegate:self];
    if (!theDownload) {
        NSLog(@"Error: Failed to initialize cacheDistributionFileWithURL %@", [url absoluteString]);
    }
}

- (void)cachePackageWithURL:(NSURL *)url
{
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:5.0];
    
    NSURLDownload  *theDownload = [[NSURLDownload alloc] initWithRequest:theRequest delegate:self];
    if (!theDownload) {
        NSLog(@"Error: Failed to initialize cachePackageWithURL %@", [url absoluteString]);
    }
}


- (void)download:(NSURLDownload *)download decideDestinationWithSuggestedFilename:(NSString *)filename
{
    NSURL *requestURL = [[download request] URL];
    ReposadoInstanceMO *defaultRep = [[NSApp delegate] defaultReposadoInstance];
    NSString *joined = [[defaultRep getLocalFileURLFromRemoteURL:requestURL] path];
    [download setDestination:joined allowOverwrite:YES];
}

- (void)download:(NSURLDownload *)download didCreateDestination:(NSString *)path
{
    NSURL *requestURL = [[download request] URL];
    NSManagedObjectContext *moc = [[NSApp delegate] managedObjectContext];
    
    // Determine what kind of file we just downloaded
    if ([[requestURL pathExtension] isEqualToString:@"dist"]) {
        //NSLog(@"Linking downloaded distribution file");
        NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
        [fetchObjects setEntity:[NSEntityDescription entityForName:@"SUDistribution" inManagedObjectContext:moc]];
        [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"distributionURL == %@", [requestURL absoluteString]]];
        NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
        if (numFoundObjects != 0) {
            SUDistributionMO *dist = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
            dist.distributionIsCachedValue = YES;
            dist.distributionCachedPath = path;
            [[NSWorkspace sharedWorkspace] openFile:path];
        } else {
            NSLog(@"Error: Could not find distribution file with URL %@", [requestURL absoluteString]);
        }
        [fetchObjects release];
    } else {
        NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
        [fetchObjects setEntity:[NSEntityDescription entityForName:@"SUPackage" inManagedObjectContext:moc]];
        [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"packageURL == %@", [requestURL absoluteString]]];
        NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
        if (numFoundObjects != 0) {
            SUPackageMO *package = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
            package.packageIsCachedValue = YES;
            package.packageCachedPath = path;
            [[NSWorkspace sharedWorkspace] openFile:path];
        } else {
            NSLog(@"Error: Could not find package with URL %@", [requestURL absoluteString]);
        }
        [fetchObjects release];
    }
}


- (void)download:(NSURLDownload *)download didFailWithError:(NSError *)error
{
    // Release the download.
    [download release];
    
    // Inform the user.
    NSLog(@"Download failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)downloadDidFinish:(NSURLDownload *)download
{
    // Release the download.
    [download release];
    
    // Do something with the data.
    //NSLog(@"%@",@"downloadDidFinish");
}





@end
