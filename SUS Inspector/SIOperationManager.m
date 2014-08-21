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
#import "SIReposadoImportOperation.h"

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


- (NSArray *)allCatalogs
{
    NSArray *catalogs = nil;
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
    NSFetchRequest *fetchProducts = [[NSFetchRequest alloc] init];
    [fetchProducts setEntity:[NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:moc]];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchProducts error:nil];
    if (numFoundCatalogs > 0) {
        catalogs = [moc executeFetchRequest:fetchProducts error:nil];
    }
    //[fetchProducts release];
    return catalogs;
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
    //[fetchProducts release];
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
    productsGroupItem.sortIndex = [NSNumber numberWithUnsignedInteger:index];
    
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
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = -30;
    NSDate *thirtyDaysAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dayComponent toDate:now options:0];
    NSPredicate *thirtyDaysAgoPredicate = [NSPredicate predicateWithFormat:@"productPostDate >= %@", thirtyDaysAgo];
    thisWeekProductsItem.productFilterPredicate = thirtyDaysAgoPredicate;
}


- (void)createProductGroupsSectionWithIndex:(NSUInteger)index managedObjectContext:(NSManagedObjectContext *)moc
{
    NSImage *iconFolderSmart = [NSImage imageNamed:NSImageNameFolderSmart];
    
    NSPredicate *includeDeprecatedPredicate;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"includeDeprecatedInProductGroups"]) {
        includeDeprecatedPredicate = [NSPredicate predicateWithFormat:@"(productIsDeprecated == TRUE) OR (productIsDeprecated == FALSE)"];
    } else {
        includeDeprecatedPredicate = [NSPredicate predicateWithFormat:@"(productIsDeprecated == FALSE)"];
    }
    
    /*
     The PRODUCT GROUPS item
     */
    SISourceListItemMO *productGroupsGroupItem = [self sourceListItemWithTitle:@"PRODUCT GROUPS" managedObjectContext:moc];
    productGroupsGroupItem.isGroupItemValue = YES;
    productGroupsGroupItem.sortIndex = [NSNumber numberWithUnsignedInteger:index];
    
    /*
     Remove all child items in this section
     */
    [productGroupsGroupItem.children enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [moc deleteObject:obj];
    }];
    
    /*
     Java Updates item
     */
    SISourceListItemMO *javaItem = [self sourceListItemWithTitle:@"Java" managedObjectContext:moc];
    javaItem.iconImage = iconFolderSmart;
    javaItem.parent = productGroupsGroupItem;
    
    NSPredicate *javaInTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Java\""];
    
    NSArray *javaPredicates = [NSArray arrayWithObjects:javaInTitlePredicate, nil];
    NSPredicate *javaCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:javaPredicates];
    NSPredicate *javaFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, javaCompoundPredicate, nil]];
    
    javaItem.productFilterPredicate = javaFinalPredicate;
    
    /*
     Firmware Updates item
     */
    SISourceListItemMO *firmwareItem = [self sourceListItemWithTitle:@"Firmware" managedObjectContext:moc];
    firmwareItem.iconImage = iconFolderSmart;
    firmwareItem.parent = productGroupsGroupItem;
    
    NSPredicate *firmwareInTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Firmware\""];
    NSArray *firmwarePredicates = [NSArray arrayWithObjects:firmwareInTitlePredicate, nil];
    NSPredicate *firmwareCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:firmwarePredicates];
    NSPredicate *firmwareFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, firmwareCompoundPredicate, nil]];
    
    firmwareItem.productFilterPredicate = firmwareFinalPredicate;
    
    /*
     OS Updates item
     */
    SISourceListItemMO *osItem = [self sourceListItemWithTitle:@"System Updates" managedObjectContext:moc];
    osItem.iconImage = iconFolderSmart;
    osItem.parent = productGroupsGroupItem;
    
    NSPredicate *osxupdateInTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"OS X Update\""];
    NSPredicate *osxserverInTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"OS X Server Update\""];
    NSArray *osPredicates = [NSArray arrayWithObjects:osxupdateInTitlePredicate, osxserverInTitlePredicate, nil];
    NSPredicate *osCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:osPredicates];
    NSPredicate *osFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, osCompoundPredicate, nil]];
    
    osItem.productFilterPredicate = osFinalPredicate;
    
    /*
     Security Updates item
     */
    SISourceListItemMO *securityItem = [self sourceListItemWithTitle:@"Security Updates" managedObjectContext:moc];
    securityItem.iconImage = iconFolderSmart;
    securityItem.parent = productGroupsGroupItem;
    
    NSPredicate *securityInTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Security Update\""];
    NSArray *securityPredicates = [NSArray arrayWithObjects:securityInTitlePredicate, nil];
    NSPredicate *securityCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:securityPredicates];
    NSPredicate *securityFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, securityCompoundPredicate, nil]];
    
    securityItem.productFilterPredicate = securityFinalPredicate;
    
    /*
     Printer Drivers item
     */
    SISourceListItemMO *printerItem = [self sourceListItemWithTitle:@"Printers" managedObjectContext:moc];
    printerItem.iconImage = iconFolderSmart;
    printerItem.parent = productGroupsGroupItem;
    
    NSPredicate *printerInTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Printer\""];
    NSArray *printerPredicates = [NSArray arrayWithObjects:printerInTitlePredicate, nil];
    NSPredicate *printerCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:printerPredicates];
    NSPredicate *printerFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, printerCompoundPredicate, nil]];
    
    printerItem.productFilterPredicate = printerFinalPredicate;
    
    /*
     Pro Apps
     */
    SISourceListItemMO *proAppsItem = [self sourceListItemWithTitle:@"Pro Applications" managedObjectContext:moc];
    proAppsItem.iconImage = iconFolderSmart;
    proAppsItem.parent = productGroupsGroupItem;
    
    NSPredicate *proAppsInTitlePredicate = [NSPredicate predicateWithFormat:
                                            @"productTitle contains[cd] \"Pro Applications\" OR \
                                            productTitle contains[cd] \"ProApps\""];
    NSPredicate *apertureInTitlePredicate = [NSPredicate predicateWithFormat:
                                             @"productTitle contains[cd] \"Aperture\""];
    NSPredicate *logicComponentsInTitlePredicate = [NSPredicate predicateWithFormat:
                                                    @"productTitle contains[cd] \"Logic\" OR \
                                                    productTitle contains[cd] \"Mainstage\" OR \
                                                    productTitle contains[cd] \"Waveburner\" OR \
                                                    productTitle contains[cd] \"Soundtrack\""];
    NSPredicate *finalCutInTitlePredicate = [NSPredicate predicateWithFormat:
                                             @"productTitle contains[cd] \"Final Cut\""];
    
    NSArray *proAppsPredicates = [NSArray arrayWithObjects:proAppsInTitlePredicate, apertureInTitlePredicate, logicComponentsInTitlePredicate, finalCutInTitlePredicate, nil];
    NSPredicate *proAppsCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:proAppsPredicates];
    NSPredicate *proAppsFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, proAppsCompoundPredicate, nil]];
    
    proAppsItem.productFilterPredicate = proAppsFinalPredicate;
    
    /*
     iLife Updates item
     */
    SISourceListItemMO *iLifeItem = [self sourceListItemWithTitle:@"iLife" managedObjectContext:moc];
    iLifeItem.iconImage = iconFolderSmart;
    iLifeItem.parent = productGroupsGroupItem;
    
    NSPredicate *iLifeInTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"iLife\""];
    NSPredicate *iMoviePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"iMovie\""];
    NSPredicate *iPhotoPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"iPhoto\""];
    NSPredicate *garageBandPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"GarageBand\""];
    NSPredicate *iDVDPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"iDVD\""];
    
    NSArray *iLifePredicates = [NSArray arrayWithObjects:iLifeInTitlePredicate, iMoviePredicate, iPhotoPredicate, garageBandPredicate, iDVDPredicate, nil];
    NSPredicate *iLifeCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:iLifePredicates];
    NSPredicate *iLifeFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, iLifeCompoundPredicate, nil]];
    
    iLifeItem.productFilterPredicate = iLifeFinalPredicate;
    
    
    /*
     iWork Updates item
     */
    SISourceListItemMO *iWorkItem = [self sourceListItemWithTitle:@"iWork" managedObjectContext:moc];
    iWorkItem.iconImage = iconFolderSmart;
    iWorkItem.parent = productGroupsGroupItem;
    
    NSPredicate *pagesPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Pages\""];
    NSPredicate *numbersPredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Numbers\""];
    NSPredicate *keynotePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Keynote\""];
    
    NSArray *iWorkPredicates = [NSArray arrayWithObjects:pagesPredicate, numbersPredicate, keynotePredicate, nil];
    NSPredicate *iWorkCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:iWorkPredicates];
    NSPredicate *iWorkFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, iWorkCompoundPredicate, nil]];
    
    iWorkItem.productFilterPredicate = iWorkFinalPredicate;
    
    /*
     Safari item
     */
    SISourceListItemMO *safariItem = [self sourceListItemWithTitle:@"Safari" managedObjectContext:moc];
    safariItem.iconImage = iconFolderSmart;
    safariItem.parent = productGroupsGroupItem;
    
    NSPredicate *safariTitlePredicate = [NSPredicate predicateWithFormat:@"productTitle contains[cd] \"Safari\""];
    
    NSArray *safariPredicates = [NSArray arrayWithObjects:safariTitlePredicate, nil];
    NSPredicate *safariCompoundPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:safariPredicates];
    NSPredicate *safariFinalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:includeDeprecatedPredicate, safariCompoundPredicate, nil]];
    
    safariItem.productFilterPredicate = safariFinalPredicate;
    
}


- (void)createCatalogsSectionWithIndex:(NSUInteger)index managedObjectContext:(NSManagedObjectContext *)moc
{
    /*
     The CATALOGS group item
     */
    SISourceListItemMO *catalogsGroupItem = [self sourceListItemWithTitle:@"CATALOGS" managedObjectContext:moc];
    catalogsGroupItem.isGroupItemValue = YES;
    catalogsGroupItem.sortIndex = [NSNumber numberWithUnsignedInteger:index];
    
    /*
     Fetch all catalogs and create source list items
     */
    NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:moc];
    NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
    
    NSPredicate *isActive = [NSPredicate predicateWithFormat:@"isActive == TRUE"];
    [fetchForCatalogs setPredicate:isActive];
    [fetchForCatalogs setEntity:catalogEntityDescr];
    NSUInteger numFoundCatalogs = [moc countForFetchRequest:fetchForCatalogs error:nil];
    if (numFoundCatalogs != 0) {
        NSArray *allCatalogs = [moc executeFetchRequest:fetchForCatalogs error:nil];
        [allCatalogs enumerateObjectsUsingBlock:^(SICatalogMO *catalog, NSUInteger idx, BOOL *stop) {
            SISourceListItemMO *catalogItem = [self sourceListItemWithTitle:catalog.catalogDisplayName managedObjectContext:moc];
            
            NSImage *catalogImage = [NSImage imageNamed:@"catalogTemplate"];
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
    //[fetchForCatalogs release];
}


- (void)setupSourceListGroupItems
{
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
    
    /*
     The PRODUCTS group item
     */
    SISourceListItemMO *productsGroupItem = [self sourceListItemWithTitle:@"PRODUCTS" managedObjectContext:moc];
    productsGroupItem.isGroupItemValue = YES;
    productsGroupItem.sortIndexValue = 0;
    
    /*
     The PRODUCT GROUPS item
     */
    SISourceListItemMO *productGroupsGroupItem = [self sourceListItemWithTitle:@"PRODUCT GROUPS" managedObjectContext:moc];
    productGroupsGroupItem.isGroupItemValue = YES;
    productGroupsGroupItem.sortIndexValue = 1;
    
    /*
     The CATALOGS group item
     */
    SISourceListItemMO *catalogsGroupItem = [self sourceListItemWithTitle:@"CATALOGS" managedObjectContext:moc];
    catalogsGroupItem.isGroupItemValue = YES;
    catalogsGroupItem.sortIndexValue = 2;
}

- (void)setupSourceListItems
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SIWillStartSetupSourceListItems" object:nil];
    }];
    
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
    [self createProductsSectionWithIndex:0 managedObjectContext:moc];
    [self createProductGroupsSectionWithIndex:1 managedObjectContext:moc];
    [self createCatalogsSectionWithIndex:2 managedObjectContext:moc];
    
    /*
     Notify the view controller that it should expand all items
     */
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SIDidSetupSourceListItems" object:nil];
    }];
}


- (void)readPackageMetadataFiles:(SIReposadoInstanceMO *)reposadoInstance
{
    // Fetch all Packages with metadataURL
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
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
}

- (void)updateCachedStatusForProduct:(SIProductMO *)product
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSSet *packages = product.packages;
    for (SIPackageMO *aPackage in packages) {
        NSString *packageURL = aPackage.objectURL;
        
        NSString *packageLocalPath = [[(SIAppDelegate *)[NSApp delegate] defaultReposadoInstance] getLocalFilePathFromRemoteURL:[NSURL URLWithString:packageURL]];
        if ([fileManager fileExistsAtPath:packageLocalPath]) {
            NSLog(@"Exists %@", packageLocalPath);
            aPackage.objectIsCachedValue = YES;
            aPackage.objectCachedPath = packageLocalPath;
        } else {
            NSLog(@"Doesn't exist %@", packageLocalPath);
            aPackage.objectIsCachedValue = NO;
            aPackage.objectCachedPath = nil;
        }
        
        [[(SIAppDelegate *)[NSApp delegate] managedObjectContext] refreshObject:aPackage mergeChanges:YES];
        
        // Check if the package has a metadata URL
        SIPackageMetadataMO *metadataObject = aPackage.metadata;
        if (metadataObject) {
            NSString *packageMetadataLocalPath = [[(SIAppDelegate *)[NSApp delegate] defaultReposadoInstance] getLocalFilePathFromRemoteURL:[NSURL URLWithString:metadataObject.objectURL]];
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

- (void)deleteAllObjectsForEntityName:(NSString *)entity
{
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:moc]];
    NSArray *foundObjects = [moc executeFetchRequest:fetchRequest error:nil];
    [foundObjects enumerateObjectsWithOptions:0 usingBlock:^(id anObject, NSUInteger idx, BOOL *stop) {
        [moc deleteObject:anObject];
    }];
    [moc processPendingChanges];
}


- (void)readReposadoInstanceContentsAsync:(SIReposadoInstanceMO *)instance force:(BOOL)force
{
    self.currentOperationTitle = @"Reading product information...";
    self.currentOperationType = SIOperationTypeReadLocalFiles;
    
    /*
     Perform pre-operation tasks
     */
    [self willStartOperations];
    
    /*
     Create and run the import operation
     */
    SIReposadoImportOperation *importOp = [SIReposadoImportOperation importReposadoInstanceWithID:instance.objectID force:force];
    importOp.progressCallback = ^(float progress) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             float percentage = progress * 100.0;
             [[SIOperationManager sharedManager] setCurrentOperationDescription:[NSString stringWithFormat:@"Reading products: (%1.0f%% done)", percentage]];
         }];
    };
    importOp.finishCallback = ^() {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
             [[SIOperationManager sharedManager] willEndOperations];
         }];
    };
    
    [self.operationQueue addOperation:importOp];
}


- (void)runReposync:(SIReposadoInstanceMO *)instance
{
    [self willStartOperations];
    
    [self deleteAllObjectsForEntityName:@"SIProduct"];
    
    self.currentCatalogs = [self allCatalogs];
    NSArray *arguments = [NSArray arrayWithObjects:instance.reposyncPath, nil];
    AMShellWrapper *wrapper = [[AMShellWrapper alloc] initWithInputPipe:nil
                                                              outputPipe:nil
                                                               errorPipe:nil
                                                        workingDirectory:@"."
                                                             environment:nil
                                                               arguments:arguments
                                                                 context:NULL];
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
    
    return [cleanedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)write:(NSString *)string
{
    NSString *cleanedMessage = [self cleanReposadoMessage:string];
    if (![cleanedMessage isEqualToString:@""]) {
        self.currentOperationDescription = cleanedMessage;
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
    
    [self readReposadoInstanceContentsAsync:[(SIAppDelegate *)[NSApp delegate] defaultReposadoInstance] force:NO];
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

- (void)updateCatalogURLStatusAsync:(NSURL *)catalogURL
{
    /*
     Create the request. Setting HTTPMethod to "HEAD" causes
     the request to only download the headers
     */
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:catalogURL];
    [request setHTTPMethod:@"HEAD"];
    [request setValue:@"SUSInspector/1.0" forHTTPHeaderField:@"User-Agent"];
    [request setTimeoutInterval:5.0];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    /*
     Process the request
     */
    [NSURLConnection sendAsynchronousRequest:request queue:self.operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        /*
         Create a thread safe context
         */
        NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
        [moc performBlockWithPrivateQueueConcurrency:^(NSManagedObjectContext *threadSafeMoc) {
            
            /*
             Look up the Catalog object which this URL references
             */
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:threadSafeMoc]];
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"catalogURL == %@", [catalogURL absoluteString]]];
            NSUInteger numFoundObjects = [threadSafeMoc countForFetchRequest:fetchRequest error:nil];
            if (numFoundObjects != NSNotFound) {
                SICatalogMO *fetchedCatalog = [[threadSafeMoc executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
                if (response) {
                    
                    // Cast the response to a NSHTTPURLResponse to get a status code
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                    NSInteger status = [httpResponse statusCode];
                    fetchedCatalog.catalogURLStatusCode = [NSNumber numberWithInteger:status];
                    
                    /*
                     4xx are client errors, 5xx are server errors.
                     http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
                     
                     Treat anything below 400 as successful, we're not that picky at this point...
                     */
                    fetchedCatalog.catalogURLIsValidValue = (status >= 400) ? NO : YES;
                    
                }
                
                // Response is nil
                else {
                    fetchedCatalog.catalogURLIsValidValue = NO;
                }
                
                // We got an error
                if (error) {
                    fetchedCatalog.catalogURLIsValidValue = NO;
                }
                
                fetchedCatalog.catalogURLCheckPendingValue = NO;
            } else {
                NSLog(@"Got response for %@ but found 0 matching catalogs. Ignoring...", [catalogURL absoluteString]);
            }
            
        }];
        
    }];
}

- (void)updateCatalogURLStatus:(SICatalogMO *)catalog
{
    [self updateCatalogURLStatusAsync:[NSURL URLWithString:catalog.catalogURL]];
}

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
    SIReposadoInstanceMO *defaultRep = [(SIAppDelegate *)[NSApp delegate] defaultReposadoInstance];
    NSString *joined = [[defaultRep getLocalFileURLFromRemoteURL:requestURL] path];
    [download setDestination:joined allowOverwrite:YES];
}

- (void)download:(NSURLDownload *)download didCreateDestination:(NSString *)path
{
    NSURL *requestURL = [[download request] URL];
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
    
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
}


- (void)download:(NSURLDownload *)download didFailWithError:(NSError *)error
{
    // Inform the user.
    NSLog(@"Download failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)downloadDidFinish:(NSURLDownload *)download
{
    NSURL *requestURL = [[download request] URL];
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
    
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
}





@end
