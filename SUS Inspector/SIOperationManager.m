//
//  SIReposadoManager.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
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


#import "SIOperationManager.h"
#import "NSManagedObjectContext+HJGCDExtensions.h"
#import "SIAppDelegate.h"
#import "SIPackageMetadataParser.h"

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

- (SIPackageMetadataMO *)packageMetadataFileWithURLString:(NSString *)urlString managedObjectContext:(NSManagedObjectContext *)moc
{
    SIPackageMetadataMO *metadataFile = [NSEntityDescription insertNewObjectForEntityForName:@"SIPackageMetadata" inManagedObjectContext:moc];
    metadataFile.objectURL = urlString;
    return metadataFile;
}

- (SIServerMetadataMO *)serverMetadataFileWithURLString:(NSString *)urlString managedObjectContext:(NSManagedObjectContext *)moc
{
    SIServerMetadataMO *metadataFile = [NSEntityDescription insertNewObjectForEntityForName:@"SIServerMetadata" inManagedObjectContext:moc];
    metadataFile.objectURL = urlString;
    return metadataFile;
}

- (SIDistributionMO *)distributionWithURLString:(NSString *)urlString managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
     SIDistributionMO *distributionFile = nil;
     NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
     [fetchObjects setEntity:[NSEntityDescription entityForName:@"SIDistribution" inManagedObjectContext:moc]];
     [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"distributionURL == %@", urlString]];
     NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
     if (numFoundObjects == 0) {
     distributionFile = [NSEntityDescription insertNewObjectForEntityForName:@"SIDistribution" inManagedObjectContext:moc];
     distributionFile.distributionURL = urlString;
     } else {
     distributionFile = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
     }
     [fetchObjects release];
     return distributionFile;
     */
    SIDistributionMO *distributionFile = [NSEntityDescription insertNewObjectForEntityForName:@"SIDistribution" inManagedObjectContext:moc];
    distributionFile.objectURL = urlString;
    return distributionFile;
}

- (SIPackageMO *)packageWithURLString:(NSString *)urlString managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
     SIPackageMO *thePackage = nil;
     NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
     [fetchObjects setEntity:[NSEntityDescription entityForName:@"SIPackage" inManagedObjectContext:moc]];
     [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"objectURL == %@", urlString]];
     NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
     if (numFoundObjects == 0) {
     thePackage = [NSEntityDescription insertNewObjectForEntityForName:@"SIPackage" inManagedObjectContext:moc];
     thePackage.objectURL = urlString;
     } else {
     thePackage = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
     }
     [fetchObjects release];
     return thePackage;
     */
    
    SIPackageMO *thePackage = [NSEntityDescription insertNewObjectForEntityForName:@"SIPackage" inManagedObjectContext:moc];
    thePackage.objectURL = urlString;
    return thePackage;
     
}

- (SIProductMO *)productWithID:(NSString *)productID managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
     SIProductMO *theProduct = nil;
     NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
     [fetchProducts setEntity:[NSEntityDescription entityForName:@"SIProduct" inManagedObjectContext:moc]];
     [fetchProducts setPredicate:[NSPredicate predicateWithFormat:@"productID == %@", productID]];
     NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
     if (numFoundCatalogs == 0) {
         theProduct = [NSEntityDescription insertNewObjectForEntityForName:@"SIProduct" inManagedObjectContext:moc];
         theProduct.productID = productID;
     } else if (numFoundCatalogs == NSNotFound) {
         theProduct = [NSEntityDescription insertNewObjectForEntityForName:@"SIProduct" inManagedObjectContext:moc];
         theProduct.productID = productID;
     } else {
         theProduct = [[moc executeFetchRequest:fetchProducts error:nil] objectAtIndex:0];
     }
     [fetchProducts release];
     return theProduct;
    */
    SIProductMO *theProduct = [NSEntityDescription insertNewObjectForEntityForName:@"SIProduct" inManagedObjectContext:moc];
    theProduct.productID = productID;
    return theProduct;
}

- (NSArray *)allCatalogs
{
    NSArray *catalogs = nil;
    NSManagedObjectContext *moc = [[NSApp delegate] managedObjectContext];
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:moc]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs > 0) {
        catalogs = [moc executeFetchRequest:fetchProducts error:nil];
    }
    [fetchProducts release];
    return catalogs;
}

- (SICatalogMO *)catalogWithURL:(NSString *)catalogURL managedObjectContext:(NSManagedObjectContext *)moc
{
    
    SICatalogMO *theCatalog = nil;
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:moc]];
    [fetchProducts setPredicate:[NSPredicate predicateWithFormat:@"catalogURL == %@", catalogURL]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs == 0) {
        theCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SICatalog" inManagedObjectContext:moc];
        theCatalog.catalogURL = catalogURL;
    } else {
        theCatalog = [[moc executeFetchRequest:fetchProducts error:nil] objectAtIndex:0];
    }
    [fetchProducts release];
    return theCatalog;
    
    /*
     SICatalogMO *theCatalog = nil;
     theCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SICatalog" inManagedObjectContext:moc];
     theCatalog.catalogURL = catalogURL;
     return theCatalog;
     */
}

- (SISourceListItemMO *)sourceListItemWithTitle:(NSString *)title managedObjectContext:(NSManagedObjectContext *)moc
{
    SISourceListItemMO *theCatalog = nil;
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SISourceListItem" inManagedObjectContext:moc]];
    [fetchProducts setPredicate:[NSPredicate predicateWithFormat:@"title == %@", title]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs == 0) {
        theCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SISourceListItem" inManagedObjectContext:moc];
        theCatalog.title = title;
    } else {
        theCatalog = [[moc executeFetchRequest:fetchProducts error:nil] objectAtIndex:0];
    }
    [fetchProducts release];
    return theCatalog;
}

- (void)createProductsSectionWithIndex:(NSUInteger)index managedObjectContext:(NSManagedObjectContext *)moc
{
    NSImage *iconFolderSmart = [NSImage imageNamed:NSImageNameFolderSmart];
    
    /*
     The PRODUCTS group item
     */
    SISourceListItemMO *productsGroupItem = [self sourceListItemWithTitle:@"PRODUCTS" managedObjectContext:moc];
    productsGroupItem.isGroupItemValue = YES;
    productsGroupItem.sortIndexValue = index;
    
    /*
     All Products item
     */
    SISourceListItemMO *allProductsItem = [self sourceListItemWithTitle:@"All Products" managedObjectContext:moc];
    allProductsItem.iconImage = iconFolderSmart;
    allProductsItem.parent = productsGroupItem;
    allProductsItem.sortIndexValue = 0;
    
    allProductsItem.productFilterPredicate = [NSPredicate predicateWithValue:TRUE];
    
    /*
     Deprecated Products item
     */
    SISourceListItemMO *deprecatedProductsItem = [self sourceListItemWithTitle:@"Deprecated Products" managedObjectContext:moc];
    deprecatedProductsItem.iconImage = iconFolderSmart;
    deprecatedProductsItem.parent = productsGroupItem;
    deprecatedProductsItem.sortIndexValue = 1;
    
    NSPredicate *deprecatedPredicate = [NSPredicate predicateWithFormat:@"productIsDeprecated == TRUE"];
    deprecatedProductsItem.productFilterPredicate = deprecatedPredicate;
    
    /*
     Last 30 Days item
     */
    SISourceListItemMO *thisWeekProductsItem = [self sourceListItemWithTitle:@"Last 30 Days" managedObjectContext:moc];
    thisWeekProductsItem.iconImage = iconFolderSmart;
    thisWeekProductsItem.parent = productsGroupItem;
    thisWeekProductsItem.sortIndexValue = 2;
    
    NSDate *now = [NSDate date];
    NSDateComponents *dayComponent = [[[NSDateComponents alloc] init] autorelease];
    dayComponent.day = -30;
    NSDate *thirtyDaysAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dayComponent toDate:now options:0];
    NSPredicate *thirtyDaysAgoPredicate = [NSPredicate predicateWithFormat:@"productPostDate >= %@", thirtyDaysAgo];
    thisWeekProductsItem.productFilterPredicate = thirtyDaysAgoPredicate;
    
}


- (void)createProductGroupsSectionWithIndex:(NSUInteger)index managedObjectContext:(NSManagedObjectContext *)moc
{
    NSImage *iconFolderSmart = [NSImage imageNamed:NSImageNameFolderSmart];
    
    /*
     The PRODUCT GROUPS item
     */
    SISourceListItemMO *productGroupsGroupItem = [self sourceListItemWithTitle:@"PRODUCT GROUPS" managedObjectContext:moc];
    productGroupsGroupItem.isGroupItemValue = YES;
    productGroupsGroupItem.sortIndexValue = index;
    
    
    /*
     iLife item
     */
    SISourceListItemMO *iLifeItem = [self sourceListItemWithTitle:@"iLife" managedObjectContext:moc];
    iLifeItem.iconImage = iconFolderSmart;
    iLifeItem.parent = productGroupsGroupItem;
    iLifeItem.sortIndexValue = 0;
    
    NSPredicate *iMoviePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"iMovie\""];
    NSPredicate *iPhotoPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"iPhoto\""];
    NSPredicate *garageBandPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"GarageBand\""];
    NSPredicate *iDVDPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"iDVD\""];
    
    NSArray *iLifePredicates = [NSArray arrayWithObjects:iMoviePredicate, iPhotoPredicate, garageBandPredicate, iDVDPredicate, nil];
    NSPredicate *iLifePredicate = [NSCompoundPredicate orPredicateWithSubpredicates:iLifePredicates];
    
    iLifeItem.productFilterPredicate = iLifePredicate;
    
    
    /*
     iWork item
     */
    SISourceListItemMO *iWorkItem = [self sourceListItemWithTitle:@"iWork" managedObjectContext:moc];
    iWorkItem.iconImage = iconFolderSmart;
    iWorkItem.parent = productGroupsGroupItem;
    iWorkItem.sortIndexValue = 1;
    
    NSPredicate *pagesPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Pages\""];
    NSPredicate *numbersPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Numbers\""];
    NSPredicate *keynotePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Keynote\""];
    
    NSArray *iWorkPredicates = [NSArray arrayWithObjects:pagesPredicate, numbersPredicate, keynotePredicate, nil];
    NSPredicate *iWorkPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:iWorkPredicates];
    
    iWorkItem.productFilterPredicate = iWorkPredicate;

}


- (void)createCatalogsSectionWithIndex:(NSUInteger)index managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
     The CATALOGS group item
     */
    SISourceListItemMO *catalogsGroupItem = [self sourceListItemWithTitle:@"CATALOGS" managedObjectContext:moc];
    catalogsGroupItem.isGroupItemValue = YES;
    catalogsGroupItem.sortIndexValue = index;
    
    /*
     Fetch all catalogs and create source list items
     */
    NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:moc];
    NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
    
    // Special source list items do not have associated catalogs anymore
    //NSPredicate *notDeprecated = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/deprecated"];
    //NSPredicate *notAll = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/all"];
    
    NSPredicate *isActive = [NSPredicate predicateWithFormat:@"isActive == TRUE"];
    NSPredicate *instanceSetupComplete = [NSPredicate predicateWithFormat:@"reposadoInstance.reposadoSetupComplete == TRUE"];
    NSArray *subPredicates = [NSArray arrayWithObjects:isActive, instanceSetupComplete, nil];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    [fetchForCatalogs setPredicate:predicate];
    [fetchForCatalogs setEntity:catalogEntityDescr];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchForCatalogs error:nil];
    if (numFoundCatalogs != 0) {
        NSArray *allCatalogs = [moc executeFetchRequest:fetchForCatalogs error:nil];
        [allCatalogs enumerateObjectsUsingBlock:^(SICatalogMO *catalog, NSUInteger idx, BOOL *stop) {
            SISourceListItemMO *catalogItem = [self sourceListItemWithTitle:catalog.catalogDisplayName managedObjectContext:moc];
            
            NSImage *catalogImage = [NSImage imageNamed:@"96-book"];
            [catalogImage setTemplate:YES];
            
            catalogItem.iconImage = catalogImage;
            catalogItem.parent = catalogsGroupItem;
            catalogItem.catalogReference = catalog;
            
            /*
             Special predicate to filter the products array
             */
            NSPredicate *catalogPredicate = [NSPredicate predicateWithFormat:@"SUBQUERY(catalogs, $aCatalog, $aCatalog.catalogURL CONTAINS %@).@count != 0", catalog.catalogURL];
            // And yes, this doesn't work -> NSPredicate *catalogPredicate = [NSPredicate predicateWithFormat:@"ANY catalogs.catalogURL CONTAINS %@", catalog.catalogURL];
            catalogItem.productFilterPredicate = catalogPredicate;
            
        }];
    }
    [fetchForCatalogs release];
}

- (void)setupSourceListItems
{
    NSManagedObjectContext *parentMoc = [[NSApp delegate] managedObjectContext];
    [parentMoc performBlockWithPrivateQueueConcurrencyAndWait:^(NSManagedObjectContext *threadSafeMoc) {
        
        [self createProductsSectionWithIndex:0 managedObjectContext:threadSafeMoc];
        [self createProductGroupsSectionWithIndex:1 managedObjectContext:threadSafeMoc];
        [self createCatalogsSectionWithIndex:2 managedObjectContext:threadSafeMoc];
        
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SIDidSetupSourceListItems" object:nil];
    });
}


- (void)readPackageMetadataFiles:(SIReposadoInstanceMO *)reposadoInstance
{
    // Fetch all Packages with metadataURL
    NSManagedObjectContext *moc = [[NSApp delegate] managedObjectContext];
    NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SIPackage" inManagedObjectContext:moc];
    NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
    NSPredicate *notDeprecated = [NSPredicate predicateWithFormat:@"metadata = nil"];
    [fetchForCatalogs setPredicate:notDeprecated];
    [fetchForCatalogs setEntity:catalogEntityDescr];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchForCatalogs error:nil];
    if (numFoundCatalogs != 0) {
        NSLog(@"Found %li packages without metadataURL", (unsigned long)numFoundCatalogs);
        NSArray *allCatalogs = [moc executeFetchRequest:fetchForCatalogs error:nil];
        [allCatalogs enumerateObjectsUsingBlock:^(SIPackageMO *aPackage, NSUInteger idx, BOOL *stop) {
            NSString *metadataURLString = aPackage.objectURL;
            NSLog(@"%@", metadataURLString);
        }];
    }
    [fetchForCatalogs release];
}

- (void)updateCachedStatusForProduct:(SIProductMO *)product
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSSet *packages = product.packages;
    for (SIPackageMO *aPackage in packages) {
        NSString *packageURL = aPackage.objectURL;
        
        NSString *packageLocalPath = [[[NSApp delegate] defaultReposadoInstance] getLocalFilePathFromRemoteURL:[NSURL URLWithString:packageURL]];
        if ([fileManager fileExistsAtPath:packageLocalPath]) {
            NSLog(@"Exists %@", packageLocalPath);
            aPackage.objectIsCachedValue = YES;
            aPackage.objectCachedPath = packageLocalPath;
        } else {
            NSLog(@"Doesn't exist %@", packageLocalPath);
            aPackage.objectIsCachedValue = NO;
            aPackage.objectCachedPath = nil;
        }
        
        [[[NSApp delegate] managedObjectContext] refreshObject:aPackage mergeChanges:YES];
        
        // Check if the package has a metadata URL
        SIPackageMetadataMO *metadataObject = aPackage.metadata;
        if (metadataObject) {
            NSString *packageMetadataLocalPath = [[[NSApp delegate] defaultReposadoInstance] getLocalFilePathFromRemoteURL:[NSURL URLWithString:metadataObject.objectURL]];
            if ([fileManager fileExistsAtPath:packageMetadataLocalPath]) {
                metadataObject.objectIsCachedValue = YES;
                metadataObject.objectCachedPath = packageMetadataLocalPath;
            } else {
                metadataObject.objectIsCachedValue = NO;
                metadataObject.objectCachedPath = nil;
            }
        }
    }
}

- (void)readReposadoInstanceContents:(SIReposadoInstanceMO *)blockInstance force:(BOOL)force managedObjectContext:(NSManagedObjectContext *)threadSafeMoc
{
    /*
     * Check the created/modified dates
     */
    NSArray *keysToGet = [NSArray arrayWithObjects:NSURLContentModificationDateKey, NSURLCreationDateKey, nil];
    NSDictionary *urlResourceValues = [blockInstance.productInfoURL resourceValuesForKeys:keysToGet error:nil];
    NSDate *modificationDate = [urlResourceValues objectForKey:NSURLContentModificationDateKey];
    NSDate *creationDate = [urlResourceValues objectForKey:NSURLCreationDateKey];
    
    /*
    __block SICatalogMO *allCatalog = [self catalogWithURL:@"/all" managedObjectContext:threadSafeMoc];
    allCatalog.catalogTitle = @"All products";
    
    __block SICatalogMO *deprecatedCatalog = [self catalogWithURL:@"/deprecated" managedObjectContext:threadSafeMoc];
    deprecatedCatalog.catalogTitle = @"Deprecated products";
    */
     
    BOOL readNeeded = ((![modificationDate isEqualToDate:blockInstance.productInfoModificationDate]) ||
                       (![creationDate isEqualToDate:blockInstance.productInfoCreationDate])
                       ) ? TRUE : FALSE;
    
    if (readNeeded || force)
    {
        NSLog(@"Reading %@", [blockInstance.productInfoURL path]);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        blockInstance.productInfoModificationDate = modificationDate;
        blockInstance.productInfoCreationDate = creationDate;
        
        
        NSDictionary *productInfo = [NSDictionary dictionaryWithContentsOfURL:blockInstance.productInfoURL];
        __block NSInteger num = 0;
        __block NSUInteger productCount = [productInfo count];
        self.currentOperationTitle = [NSString stringWithFormat:@"Reading product information for %li products...", (unsigned long)[productInfo count]];
        [productInfo enumerateKeysAndObjectsWithOptions:0 usingBlock:^(NSString *key, id obj, BOOL *stop) {
            /*
             if ((num % 5) == 0) {
             //NSLog(@"%ld", (long)num);
             self.currentOperationDescription = [NSString stringWithFormat:@"Product %li/%li: %@ %@", (unsigned long)num, (unsigned long)productCount, key, [obj objectForKey:@"title"]];
             }
             */
            num++;
            //self.currentOperationDescription = [NSString stringWithFormat:@"Product %li/%li: %@ %@", (unsigned long)num, (unsigned long)productCount, key, [obj objectForKey:@"title"]];
            //self.currentOperationDescription = [NSString stringWithFormat:@"Reading product %li/%li (%@)", (unsigned long)num, (unsigned long)productCount, key];
            float percentage = ((float)num / (float)productCount) * 100.0;
            
            self.currentOperationDescription = [NSString stringWithFormat:@"Reading products: (%1.0f%% done)", percentage];
            
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
                SIProductMO *newProduct = [self productWithID:key managedObjectContext:threadSafeMoc];
                newProduct.productTitle = [obj objectForKey:@"title"];
                newProduct.productDescription = [obj objectForKey:@"description"];
                newProduct.productPostDate = [obj objectForKey:@"PostDate"];
                NSString *sizeAsString = [obj objectForKey:@"size"];
                newProduct.productSize = [NSNumber numberWithInteger:[sizeAsString integerValue]];
                newProduct.productVersion = [obj objectForKey:@"version"];
                //[newProduct addCatalogsObject:allCatalog];
                
                
                /*
                 * Parse catalogs
                 */
                
                NSArray *appleCatalogs = [obj objectForKey:@"AppleCatalogs"];
                if ([appleCatalogs count] == 0) {
                    newProduct.productIsDeprecatedValue = YES;
                    //[newProduct addCatalogsObject:deprecatedCatalog];
                }
                for (NSString *aCatalogString in appleCatalogs) {
                    NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:threadSafeMoc];
                    NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
                    [fetchForCatalogs setEntity:catalogEntityDescr];
                    NSPredicate *installURLPredicate = [NSPredicate predicateWithFormat:@"catalogURL == %@", aCatalogString];
                    [fetchForCatalogs setPredicate:installURLPredicate];
                    NSUInteger numFoundCatalogs = [threadSafeMoc countForFetchRequest:fetchForCatalogs error:nil];
                    if (numFoundCatalogs == 0) {
                        NSLog(@"ERROR: Did not find catalog object for URL %@", aCatalogString);
                    } else {
                        SICatalogMO *existingCatalog = [[threadSafeMoc executeFetchRequest:fetchForCatalogs error:nil] objectAtIndex:0];
                        [existingCatalog addProductsObject:newProduct];
                    }
                    [fetchForCatalogs release];
                }
                
                /*
                 * Parse the original CatalogEntry
                 */
                NSDictionary *catalogEntry = [obj objectForKey:@"CatalogEntry"];
                
                // Packages
                NSArray *packages = [catalogEntry objectForKey:@"Packages"];
                for (NSDictionary *aPackage in packages) {
                    NSString *packageURL = [aPackage objectForKey:@"URL"];
                    NSNumber *size = [aPackage objectForKey:@"Size"];
                    SIPackageMO *newPackage = [self packageWithURLString:packageURL managedObjectContext:threadSafeMoc];
                    newPackage.packageSize = size;
                    newPackage.product = newProduct;
                    
                    NSString *packageLocalPath = [blockInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:packageURL]];
                    if ([fileManager fileExistsAtPath:packageLocalPath]) {
                        newPackage.objectIsCachedValue = YES;
                        newPackage.objectCachedPath = packageLocalPath;
                    }
                    
                    
                    // Check if the package has a metadata URL
                    NSString *metadataURL = [aPackage objectForKey:@"MetadataURL"];
                    if (metadataURL) {
                        SIPackageMetadataMO *newMetadataObject = [self packageMetadataFileWithURLString:metadataURL managedObjectContext:threadSafeMoc];
                        newMetadataObject.package = newPackage;
                        
                        NSString *packageMetadataLocalPath = [blockInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:metadataURL]];
                        if ([fileManager fileExistsAtPath:packageMetadataLocalPath]) {
                            newMetadataObject.objectIsCachedValue = YES;
                            newMetadataObject.objectCachedPath = packageMetadataLocalPath;
                        }
                        
                    }
                    
                }
                // ServerMetadata
                NSString *serverMetadataURL = [catalogEntry objectForKey:@"ServerMetadataURL"];
                if (serverMetadataURL) {
                    SIServerMetadataMO *newMetadataObject = [self serverMetadataFileWithURLString:serverMetadataURL managedObjectContext:threadSafeMoc];
                    newMetadataObject.product = newProduct;
                }
                
                /*
                 * Parse distribution files
                 */
                NSDictionary *distributions = [catalogEntry objectForKey:@"Distributions"];
                [distributions enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    SIDistributionMO *newDistribution = [self distributionWithURLString:(NSString *)obj managedObjectContext:threadSafeMoc];
                    newDistribution.product = newProduct;
                    
                    // Determine the distribution language
                    newDistribution.distributionLanguage = key;
                    NSString *displayName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:key];
                    if (displayName) {
                        newDistribution.distributionLanguageDisplayName = displayName;
                    } else {
                        newDistribution.distributionLanguageDisplayName = key;
                    }
                    
                    // Check if this file has been cached
                    
                    NSString *localPath = [blockInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:obj]];
                    if ([fileManager fileExistsAtPath:localPath]) {
                        newDistribution.objectIsCachedValue = YES;
                        newDistribution.objectCachedPath = localPath;
                    }
                    
                }];
                
                
            } else {
                NSLog(@"Invalid product %@. Skipped...", key);
            }
        }];
        self.currentOperationDescription = @"";
    }
}


- (void)readReposadoInstanceContentsAsync:(SIReposadoInstanceMO *)instance force:(BOOL)force
{
    __block NSManagedObjectID *instanceID = instance.objectID;
    
    self.currentOperationTitle = @"Reading product information...";
    self.currentOperationType = SIOperationTypeReadLocalFiles;
    [self willStartOperations];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSManagedObjectContext *parentMoc = [[NSApp delegate] managedObjectContext];
        
        NSDate *startTime = [NSDate date];
        
        
        NSLog(@"Context has %li objects registered (before read)", (unsigned long)[[parentMoc registeredObjects] count]);
        [parentMoc performBlockWithPrivateQueueConcurrencyAndWait:^(NSManagedObjectContext *threadSafeMoc) {
            // Get the reposado instance in this managed object context
            SIReposadoInstanceMO *blockInstance = (SIReposadoInstanceMO *)[threadSafeMoc objectWithID:instanceID];
            [self readReposadoInstanceContents:blockInstance force:force managedObjectContext:threadSafeMoc];
            self.currentOperationTitle = @"Saving...";
        }];
        NSLog(@"Context has %li objects registered (after read)", (unsigned long)[[parentMoc registeredObjects] count]);
        NSDate *now = [NSDate date];
        NSLog(@"readReposadoInstanceContents took %lf (ms)", [now timeIntervalSinceDate:startTime] * 1000.0);
        
        [self willEndOperations];
        
        
        /*
         [parentMoc performBlockWithPrivateQueueConcurrency:^(NSManagedObjectContext *threadSafeMoc) {
         // Get the reposado instance in this managed object context
         SIReposadoInstanceMO *blockInstance = (SIReposadoInstanceMO *)[threadSafeMoc objectWithID:instanceID];
         [self readReposadoInstanceContents:blockInstance managedObjectContext:threadSafeMoc];
         } completionBlock:^{
         self.currentOperationTitle = @"Saving...";
         [self willEndOperations];
         }];
         */
    });
}


- (void)runReposync:(SIReposadoInstanceMO *)instance
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



# pragma mark -
# pragma mark AMShellWrapperDelegate methods

- (NSString *)cleanReposadoMessage:(NSString *)message
{
    NSString *cleanedString = message;
    for (SICatalogMO *aCatalog in self.currentCatalogs) {
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
    self.currentOperationType = SIOperationTypeRepoSync;
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
    
    [self readReposadoInstanceContentsAsync:[[NSApp delegate] defaultReposadoInstance] force:NO];
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

- (void)cacheDownloadableObjectWithURL:(NSURL *)url
{
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:5.0];
    
    NSURLDownload  *theDownload = [[NSURLDownload alloc] initWithRequest:theRequest delegate:self];
    if (!theDownload) {
        NSLog(@"Error: Failed to initialize cacheDownloadableObjectWithURL %@", [url absoluteString]);
    }
}


- (void)readXMLFromPackageMetadataFile:(SIPackageMetadataMO *)obj
{
    NSData *xmlData = [NSData dataWithContentsOfFile:obj.objectCachedPath];
    SIPackageMetadataParser *parser = [[SIPackageMetadataParser alloc] init];
    [parser parseData:xmlData];
    
}

- (void)readXMLFromDistributionFile:(SIDistributionMO *)obj
{
    NSData *xmlData = [NSData dataWithContentsOfFile:obj.objectCachedPath];
    SIPackageMetadataParser *parser = [[SIPackageMetadataParser alloc] init];
    [parser parseData:xmlData];
}


- (void)download:(NSURLDownload *)download decideDestinationWithSuggestedFilename:(NSString *)filename
{
    NSURL *requestURL = [[download request] URL];
    SIReposadoInstanceMO *defaultRep = [[NSApp delegate] defaultReposadoInstance];
    NSString *joined = [[defaultRep getLocalFileURLFromRemoteURL:requestURL] path];
    [download setDestination:joined allowOverwrite:YES];
}

- (void)download:(NSURLDownload *)download didCreateDestination:(NSString *)path
{
    NSURL *requestURL = [[download request] URL];
    NSManagedObjectContext *moc = [[NSApp delegate] managedObjectContext];
    
    // Determine what kind of file we just downloaded
    NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
    [fetchObjects setEntity:[NSEntityDescription entityForName:@"SIDownloadableObject" inManagedObjectContext:moc]];
    [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"objectURL == %@", [requestURL absoluteString]]];
    NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
    if (numFoundObjects != 0) {
        id cachedObject = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
        [cachedObject setObjectCachedPath:path];
        
    } else {
        NSLog(@"Error: Could not find SIDownloadableObject with URL %@", [requestURL absoluteString]);
    }
    [fetchObjects release];
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
    NSURL *requestURL = [[download request] URL];
    NSManagedObjectContext *moc = [[NSApp delegate] managedObjectContext];
    
    // Determine what kind of file we just downloaded
    NSFetchRequest *fetchObjects = [[NSFetchRequest alloc] init];
    [fetchObjects setEntity:[NSEntityDescription entityForName:@"SIDownloadableObject" inManagedObjectContext:moc]];
    [fetchObjects setPredicate:[NSPredicate predicateWithFormat:@"objectURL == %@", [requestURL absoluteString]]];
    NSUInteger numFoundObjects = [moc countForFetchRequest:fetchObjects error:nil];
    if (numFoundObjects != 0) {
        id cachedObject = [[moc executeFetchRequest:fetchObjects error:nil] objectAtIndex:0];
        [cachedObject setObjectIsCachedValue:YES];
        [cachedObject setObjectIsDownloadingValue:NO];
        
        BOOL shouldPostProcess = [cachedObject performPostDownloadActionValue];
        
        if ([cachedObject isKindOfClass:[SIDistributionMO class]]) {
            // We downloaded a distribution file
            if (shouldPostProcess) {
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSString *appPath = [[NSUserDefaults standardUserDefaults] stringForKey:@"distFileViewerPath"];
                [[NSWorkspace sharedWorkspace] openFile:[cachedObject objectCachedPath] withApplication:appPath];
            }
        } else if ([cachedObject isKindOfClass:[SIPackageMO class]]) {
            // We downloaded a package
            if (shouldPostProcess) {
                [[NSWorkspace sharedWorkspace] selectFile:[cachedObject objectCachedPath] inFileViewerRootedAtPath:@""];
            }
            
        } else if ([cachedObject isKindOfClass:[SIPackageMetadataMO class]]) {
            // We downloaded a package metadata file
            NSLog(@"Finished downloading package metadata %@", [cachedObject objectCachedPath]);
            [self readXMLFromPackageMetadataFile:cachedObject];
        }
    } else {
        NSLog(@"Error: Could not find SIDownloadableObject with URL %@", [requestURL absoluteString]);
    }
    [fetchObjects release];
    
    // Release the download.
    [download release];
}





@end
