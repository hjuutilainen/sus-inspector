//
//  SIReposadoImportOperation.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 10.7.2013.
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


#import "SIReposadoImportOperation.h"
#import "DataModelHeaders.h"
#import "SIAppDelegate.h"

static const int ImportBatchSize = 50;

@interface SIReposadoImportOperation ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (retain) SIReposadoInstanceMO *reposadoInstance;
@property BOOL force;
@end

@implementation SIReposadoImportOperation

+ (id)importReposadoInstanceWithID:(SIReposadoInstanceMOID *)instanceID force:(BOOL)force
{
	return [[[self alloc] initWithReposadoInstanceID:instanceID force:force] autorelease];
}

- (id)initWithReposadoInstanceID:(SIReposadoInstanceMOID *)instanceID force:(BOOL)force
{
	if ((self = [super init])) {
		self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        self.context.persistentStoreCoordinator = [[NSApp delegate] persistentStoreCoordinator];
        self.context.undoManager = nil;
        self.reposadoInstance = (SIReposadoInstanceMO *)[self.context objectWithID:instanceID];
        self.force = force;
	}
	return self;
}

- (void)dealloc {
    [_reposadoInstance release];
	[_context release];
	[super dealloc];
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

- (void)import
{
    /*
     * Check the created/modified dates
     */
    NSArray *keysToGet = [NSArray arrayWithObjects:NSURLContentModificationDateKey, NSURLCreationDateKey, nil];
    NSDictionary *urlResourceValues = [self.reposadoInstance.productInfoURL resourceValuesForKeys:keysToGet error:nil];
    NSDate *modificationDate = [urlResourceValues objectForKey:NSURLContentModificationDateKey];
    NSDate *creationDate = [urlResourceValues objectForKey:NSURLCreationDateKey];
    
    BOOL readNeeded = ((![modificationDate isEqualToDate:self.reposadoInstance.productInfoModificationDate]) ||
                       (![creationDate isEqualToDate:self.reposadoInstance.productInfoCreationDate])
                       ) ? TRUE : FALSE;
    
    if (readNeeded || self.force)
    {
        NSLog(@"Reading %@", [self.reposadoInstance.productInfoURL path]);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        self.reposadoInstance.productInfoModificationDate = modificationDate;
        self.reposadoInstance.productInfoCreationDate = creationDate;
        
        
        NSDictionary *productInfo = [NSDictionary dictionaryWithContentsOfURL:self.reposadoInstance.productInfoURL];
        //__block NSInteger num = 0;
        //__block NSUInteger productCount = [productInfo count];
        //self.currentOperationTitle = [NSString stringWithFormat:@"Reading product information for %li products...", (unsigned long)[productInfo count]];
        
        NSInteger count = [productInfo count];
        NSInteger progressGranularity = count / 100;
        __block NSInteger idx = -1;
        
        [productInfo enumerateKeysAndObjectsWithOptions:0 usingBlock:^(NSString *key, id obj, BOOL *stop) {
            idx++;
            
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
                SIProductMO *newProduct = [self productWithID:key managedObjectContext:self.context];
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
                    NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:self.context];
                    NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
                    [fetchForCatalogs setEntity:catalogEntityDescr];
                    NSPredicate *installURLPredicate = [NSPredicate predicateWithFormat:@"catalogURL == %@", aCatalogString];
                    [fetchForCatalogs setPredicate:installURLPredicate];
                    NSUInteger numFoundCatalogs = [self.context countForFetchRequest:fetchForCatalogs error:nil];
                    if (numFoundCatalogs == 0) {
                        NSLog(@"ERROR: Did not find catalog object for URL %@", aCatalogString);
                    } else {
                        SICatalogMO *existingCatalog = [[self.context executeFetchRequest:fetchForCatalogs error:nil] objectAtIndex:0];
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
                    SIPackageMO *newPackage = [self packageWithURLString:packageURL managedObjectContext:self.context];
                    newPackage.packageSize = size;
                    newPackage.product = newProduct;
                    
                    NSString *packageLocalPath = [self.reposadoInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:packageURL]];
                    if ([fileManager fileExistsAtPath:packageLocalPath]) {
                        newPackage.objectIsCachedValue = YES;
                        newPackage.objectCachedPath = packageLocalPath;
                    }
                    
                    
                    // Check if the package has a metadata URL
                    NSString *metadataURL = [aPackage objectForKey:@"MetadataURL"];
                    if (metadataURL) {
                        SIPackageMetadataMO *newMetadataObject = [self packageMetadataFileWithURLString:metadataURL managedObjectContext:self.context];
                        newMetadataObject.package = newPackage;
                        
                        NSString *packageMetadataLocalPath = [self.reposadoInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:metadataURL]];
                        if ([fileManager fileExistsAtPath:packageMetadataLocalPath]) {
                            newMetadataObject.objectIsCachedValue = YES;
                            newMetadataObject.objectCachedPath = packageMetadataLocalPath;
                        }
                        
                    }
                    
                }
                // ServerMetadata
                NSString *serverMetadataURL = [catalogEntry objectForKey:@"ServerMetadataURL"];
                if (serverMetadataURL) {
                    SIServerMetadataMO *newMetadataObject = [self serverMetadataFileWithURLString:serverMetadataURL managedObjectContext:self.context];
                    newMetadataObject.product = newProduct;
                }
                
                /*
                 * Parse distribution files
                 */
                NSDictionary *distributions = [catalogEntry objectForKey:@"Distributions"];
                [distributions enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    SIDistributionMO *newDistribution = [self distributionWithURLString:(NSString *)obj managedObjectContext:self.context];
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
                    
                    NSString *localPath = [self.reposadoInstance getLocalFilePathFromRemoteURL:[NSURL URLWithString:obj]];
                    if ([fileManager fileExistsAtPath:localPath]) {
                        newDistribution.objectIsCachedValue = YES;
                        newDistribution.objectCachedPath = localPath;
                    }
                    
                }];
                
                
            } else {
                NSLog(@"Invalid product %@. Skipped...", key);
            }
            
            if (idx % progressGranularity == 0) {
                self.progressCallback(idx / (float) count);
            }
            if (idx % ImportBatchSize == 0) {
                [self.context save:nil];
            }
            
        }];
        
        
    }
    [self.context save:nil];
    self.progressCallback(1);
    self.finishCallback();
}

- (void)main
{
    [self.context performBlockAndWait:^{
        [self import];
    }];
}

@end
