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

- (SUCatalogMO *)newOrExistingCatalogWithURL:(NSURL *)catalogURL managedObjectContext:(NSManagedObjectContext *)moc
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


- (void)readReposadoInstanceContentsAsync:(ReposadoInstanceMO *)instance
{
    [self willStartOperations];
    self.currentOperationTitle = @"Reading product information...";
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSManagedObjectContext *parentMoc = [[NSApp delegate] managedObjectContext];
        [parentMoc performBlockWithPrivateQueueConcurrencyAndWait:^(NSManagedObjectContext *threadSafeMoc) {
            /*
             * Check the created/modified dates
             */
            NSArray *keysToGet = [NSArray arrayWithObjects:NSURLContentModificationDateKey, NSURLCreationDateKey, nil];
            NSDictionary *urlResourceValues = [instance.productInfoURL resourceValuesForKeys:keysToGet error:nil];
            NSDate *modificationDate = [urlResourceValues objectForKey:NSURLContentModificationDateKey];
            NSDate *creationDate = [urlResourceValues objectForKey:NSURLCreationDateKey];
            
            SourceListItemMO *smartItem = [self newOrExistingSourceListItem:@"PRODUCTS" managedObjectContext:threadSafeMoc];
            smartItem.isGroupItemValue = YES;
            
            SourceListItemMO *catalogsGroupItem = [self newOrExistingSourceListItem:@"CATALOGS" managedObjectContext:threadSafeMoc];
            catalogsGroupItem.isGroupItemValue = YES;
            
            SUCatalogMO *allCatalog = [self newOrExistingCatalogWithURL:[NSURL URLWithString:@"/all"] managedObjectContext:threadSafeMoc];
            allCatalog.catalogTitle = @"All products";
            allCatalog.parent = smartItem;
            
            BOOL readNeeded = ((![modificationDate isEqualToDate:instance.productInfoModificationDate]) ||
                               (![creationDate isEqualToDate:instance.productInfoCreationDate])
                               ) ? TRUE : FALSE;
            
            if (readNeeded)
            {
                NSLog(@"Reading %@", [instance.productInfoURL path]);
                
                instance.productInfoModificationDate = modificationDate;
                instance.productInfoCreationDate = creationDate;
                
                NSDictionary *productInfo = [NSDictionary dictionaryWithContentsOfURL:instance.productInfoURL];
                
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
                            SUCatalogMO *deprecatedCatalog = [self newOrExistingCatalogWithURL:[NSURL URLWithString:@"/deprecated"] managedObjectContext:threadSafeMoc];
                            deprecatedCatalog.catalogTitle = @"Deprecated products";
                            deprecatedCatalog.parent = smartItem;
                            [newProduct addCatalogsObject:deprecatedCatalog];
                        }
                        for (NSString *aCatalogString in appleCatalogs) {
                            NSURL *catalogURL = [NSURL URLWithString:aCatalogString];
                            NSString *catalogFileName = [catalogURL lastPathComponent];
                            NSArray *catalogFileNames = [NSArray arrayWithObjects:
                                                         @"index.sucatalog",
                                                         @"index-leopard.merged-1.sucatalog",
                                                         @"index-leopard-snowleopard.merged-1.sucatalog",
                                                         @"index-lion-snowleopard-leopard.merged-1.sucatalog",
                                                         @"index-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog",
                                                         nil];
                            NSArray *osVersions = [NSArray arrayWithObjects:
                                                   @"10.4",
                                                   @"10.5",
                                                   @"10.6",
                                                   @"10.7",
                                                   @"10.8",
                                                   nil];
                            NSArray *osNames = [NSArray arrayWithObjects:
                                                   @"Tiger",
                                                   @"Leopard",
                                                   @"Snow Leopard",
                                                   @"Lion",
                                                   @"Mountain Lion",
                                                   nil];
                            NSDictionary *catalogNamesAndOSVersions = [NSDictionary dictionaryWithObjects:osVersions forKeys:catalogFileNames];
                            NSDictionary *catalogFilenamesAndDisplayNames = [NSDictionary dictionaryWithObjects:osNames forKeys:catalogFileNames];
                            NSEntityDescription *catalogEntityDescr = [NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:threadSafeMoc];
                            NSFetchRequest *fetchForCatalogs = [[NSFetchRequest alloc] init];
                            [fetchForCatalogs setEntity:catalogEntityDescr];
                            NSPredicate *installURLPredicate = [NSPredicate predicateWithFormat:@"catalogURL == %@", catalogURL];
                            [fetchForCatalogs setPredicate:installURLPredicate];
                            NSUInteger numFoundCatalogs = [threadSafeMoc countForFetchRequest:fetchForCatalogs error:nil];
                            if (numFoundCatalogs == 0) {
                                if ([catalogFileNames containsObject:catalogFileName]) {
                                    SUCatalogMO *newCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SUCatalog" inManagedObjectContext:threadSafeMoc];
                                    newCatalog.catalogURL = catalogURL;
                                    newCatalog.catalogTitle = [catalogFilenamesAndDisplayNames objectForKey:catalogFileName];
                                    newCatalog.catalogOSVersion = [catalogNamesAndOSVersions objectForKey:catalogFileName];
                                    newCatalog.parent = catalogsGroupItem;
                                    [newCatalog addProductsObject:newProduct];
                                }
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
    self.currentOperationDescription = string;
    
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
