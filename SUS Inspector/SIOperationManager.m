//
//  SIReposadoManager.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIOperationManager.h"
#import "NSManagedObjectContext+HJGCDExtensions.h"

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
            sharedManager = [super allocWithZone:zone];
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
            self.operationQueue = [[NSOperationQueue alloc] init];
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

- (SUProductMO *)newOrExistingProductWithID:(NSString *)productID managedObjectContext:(NSManagedObjectContext *)moc
{
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
}

- (SUCatalogMO *)newOrExistingCatalogWithURL:(NSString *)catalogURL managedObjectContext:(NSManagedObjectContext *)moc
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

- (SourceListItemMO *)newOrExistingSourceListItem:(NSString *)title managedObjectContext:(NSManagedObjectContext *)moc
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
    //NSManagedObjectContext *threadSafeMoc = [[NSApp delegate] managedObjectContext];
        SourceListItemMO *smartItem = [self newOrExistingSourceListItem:@"PRODUCTS" managedObjectContext:threadSafeMoc];
        smartItem.isGroupItemValue = YES;
        smartItem.sortIndexValue = 0;
        
        NSImage *instanceImage = [NSImage imageNamed:@"104-index-cards"];
        [instanceImage setTemplate:YES];        
        
        SourceListItemMO *allProductsItem = [self newOrExistingSourceListItem:@"All Products" managedObjectContext:threadSafeMoc];
        allProductsItem.iconImage = instanceImage;
        allProductsItem.parent = smartItem;
        allProductsItem.sortIndexValue = 0;
        SUCatalogMO *allCatalog = [self newOrExistingCatalogWithURL:@"/all" managedObjectContext:threadSafeMoc];
        allProductsItem.catalogReference = allCatalog;
        
        SourceListItemMO *deprecatedProductsItem = [self newOrExistingSourceListItem:@"Deprecated Products" managedObjectContext:threadSafeMoc];
        deprecatedProductsItem.iconImage = instanceImage;
        deprecatedProductsItem.parent = smartItem;
        deprecatedProductsItem.sortIndexValue = 1;
        SUCatalogMO *deprecatedCatalog = [self newOrExistingCatalogWithURL:@"/deprecated" managedObjectContext:threadSafeMoc];
        deprecatedProductsItem.catalogReference = deprecatedCatalog;
        
        
        SourceListItemMO *catalogsGroupItem = [self newOrExistingSourceListItem:@"CATALOGS" managedObjectContext:threadSafeMoc];
        catalogsGroupItem.isGroupItemValue = YES;
        catalogsGroupItem.sortIndexValue = 1;
        
        // Fetch all catalogs
        NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:threadSafeMoc];
        NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(catalogURL != %@) AND (catalogURL != %@)", @"/deprecated", @"/all"];
        [fetchForCatalogs setPredicate:predicate];
        [fetchForCatalogs setEntity:catalogEntityDescr];
        NSUInteger numFoundCatalogs = [threadSafeMoc countForFetchRequest:fetchForCatalogs error:nil];
        if (numFoundCatalogs != 0) {
            NSArray *allCatalogs = [threadSafeMoc executeFetchRequest:fetchForCatalogs error:nil];
            [allCatalogs enumerateObjectsUsingBlock:^(SUCatalogMO *catalog, NSUInteger idx, BOOL *stop) {
                SourceListItemMO *catalogItem = [self newOrExistingSourceListItem:catalog.catalogDisplayName managedObjectContext:threadSafeMoc];
                NSImage *instanceImage = [NSImage imageNamed:@"96-book"];
                [instanceImage setTemplate:YES];
                catalogItem.iconImage = instanceImage;
                catalogItem.parent = catalogsGroupItem;
                catalogItem.catalogReference = catalog;
            }];
        }
    }];
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
            
            /*
             * Check the created/modified dates
             */
            NSArray *keysToGet = [NSArray arrayWithObjects:NSURLContentModificationDateKey, NSURLCreationDateKey, nil];
            NSDictionary *urlResourceValues = [blockInstance.productInfoURL resourceValuesForKeys:keysToGet error:nil];
            NSDate *modificationDate = [urlResourceValues objectForKey:NSURLContentModificationDateKey];
            NSDate *creationDate = [urlResourceValues objectForKey:NSURLCreationDateKey];
            
            SUCatalogMO *allCatalog = [self newOrExistingCatalogWithURL:@"/all" managedObjectContext:threadSafeMoc];
            allCatalog.catalogTitle = @"All products";
            
            SUCatalogMO *deprecatedCatalog = [self newOrExistingCatalogWithURL:@"/deprecated" managedObjectContext:threadSafeMoc];
            deprecatedCatalog.catalogTitle = @"Deprecated products";
            
            BOOL readNeeded = ((![modificationDate isEqualToDate:blockInstance.productInfoModificationDate]) ||
                               (![creationDate isEqualToDate:blockInstance.productInfoCreationDate])
                               ) ? TRUE : FALSE;
            
            if (readNeeded)
            {
                NSLog(@"Reading %@", [blockInstance.productInfoURL path]);
                
                blockInstance.productInfoModificationDate = modificationDate;
                blockInstance.productInfoCreationDate = creationDate;
                
                NSDictionary *productInfo = [NSDictionary dictionaryWithContentsOfURL:blockInstance.productInfoURL];
                
                self.currentOperationTitle = [NSString stringWithFormat:@"Reading product information for %li products...", (unsigned long)[productInfo count]];
                [productInfo enumerateKeysAndObjectsWithOptions:0 usingBlock:^(id key, id obj, BOOL *stop) {
                    /*
                     * Create product objects
                     */
                    
                    // Check if the product is valid
                    BOOL hasProductID   = (![(NSString *)key isEqualToString:@""]) ? TRUE : FALSE;
                    BOOL hasTitle       = ([obj objectForKey:@"title"]) ? TRUE : FALSE;
                    BOOL hasVersion     = ([obj objectForKey:@"version"]) ? TRUE : FALSE;
                    BOOL hasPostDate    = ([obj objectForKey:@"PostDate"]) ? TRUE : FALSE;
                    BOOL hasSize        = ([obj objectForKey:@"size"]) ? TRUE : FALSE;
                    
                    BOOL validProduct   = (hasProductID && hasTitle && hasVersion &&
                                           hasPostDate && hasSize
                                           ) ? TRUE : FALSE;
                    
                    if (validProduct)
                    {
                        self.currentOperationDescription = [NSString stringWithFormat:@"%@ %@", (NSString *)key, [obj objectForKey:@"title"]];
                        
                        SUProductMO *newProduct = [self newOrExistingProductWithID:(NSString *)key managedObjectContext:threadSafeMoc];
                        newProduct.productTitle = [obj objectForKey:@"title"];
                        newProduct.productDescription = [obj objectForKey:@"description"];
                        newProduct.productPostDate = [obj objectForKey:@"PostDate"];
                        NSString *sizeAsString = [obj objectForKey:@"size"];
                        newProduct.productSize = [NSNumber numberWithInteger:[sizeAsString integerValue]];
                        newProduct.productVersion = [obj objectForKey:@"version"];
                        [newProduct addCatalogsObject:allCatalog];
                        
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
                                /*
                                if ([catalogFileNames containsObject:catalogFileName]) {
                                    SUCatalogMO *newCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SUCatalog" inManagedObjectContext:threadSafeMoc];
                                    newCatalog.catalogURL = aCatalogString;
                                    newCatalog.catalogTitle = [catalogFilenamesAndDisplayNames objectForKey:catalogFileName];
                                    newCatalog.catalogOSVersion = [catalogNamesAndOSVersions objectForKey:catalogFileName];
                                    [newCatalog addProductsObject:newProduct];
                                    [blockInstance addCatalogsObject:newCatalog];
                                }
                                 */
                            } else {
                                SUCatalogMO *existingCatalog = [[threadSafeMoc executeFetchRequest:fetchForCatalogs error:nil] objectAtIndex:0];
                                [existingCatalog addProductsObject:newProduct];
                            }
                            [fetchForCatalogs release];
                        }
                    }
                }];
            }
        }];
        [self willEndOperations];
    });
}


- (void)runReposync:(ReposadoInstanceMO *)instance
{
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

- (void)write:(NSString *)string
{
    if (![string isEqualToString:@""]) {
        self.currentOperationDescription = string;
    }
    
    /*
	NSTextStorage *text = [textOutlet textStorage];
	[text replaceCharactersInRange:NSMakeRange([text length], 0) withString:string];
	[textOutlet scrollRangeToVisible:NSMakeRange([text length], 0)];
     */
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
    [self willEndOperations];
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



@end
