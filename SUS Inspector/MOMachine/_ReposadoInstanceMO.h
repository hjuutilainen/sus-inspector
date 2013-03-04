// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ReposadoInstanceMO.h instead.

#import <CoreData/CoreData.h>


extern const struct ReposadoInstanceMOAttributes {
	 NSString *productInfoCreationDate;
	 NSString *productInfoModificationDate;
	 NSString *reposadoInstallURL;
	 NSString *reposadoTitle;
	 NSString *reposadoUpdatesMetadataDir;
	 NSString *reposadoUpdatesRootDir;
} ReposadoInstanceMOAttributes;

extern const struct ReposadoInstanceMORelationships {
	 NSString *catalogs;
} ReposadoInstanceMORelationships;

extern const struct ReposadoInstanceMOFetchedProperties {
} ReposadoInstanceMOFetchedProperties;

@class SUCatalogMO;



@class NSObject;




@interface ReposadoInstanceMOID : NSManagedObjectID {}
@end

@interface _ReposadoInstanceMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ReposadoInstanceMOID*)objectID;





@property (nonatomic, retain) NSDate* productInfoCreationDate;



//- (BOOL)validateProductInfoCreationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSDate* productInfoModificationDate;



//- (BOOL)validateProductInfoModificationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) id reposadoInstallURL;



//- (BOOL)validateReposadoInstallURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* reposadoTitle;



//- (BOOL)validateReposadoTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* reposadoUpdatesMetadataDir;



//- (BOOL)validateReposadoUpdatesMetadataDir:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* reposadoUpdatesRootDir;



//- (BOOL)validateReposadoUpdatesRootDir:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet *catalogs;

- (NSMutableSet*)catalogsSet;





@end

@interface _ReposadoInstanceMO (CoreDataGeneratedAccessors)

- (void)addCatalogs:(NSSet*)value_;
- (void)removeCatalogs:(NSSet*)value_;
- (void)addCatalogsObject:(SUCatalogMO*)value_;
- (void)removeCatalogsObject:(SUCatalogMO*)value_;

@end

@interface _ReposadoInstanceMO (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveProductInfoCreationDate;
- (void)setPrimitiveProductInfoCreationDate:(NSDate*)value;




- (NSDate*)primitiveProductInfoModificationDate;
- (void)setPrimitiveProductInfoModificationDate:(NSDate*)value;




- (id)primitiveReposadoInstallURL;
- (void)setPrimitiveReposadoInstallURL:(id)value;




- (NSString*)primitiveReposadoTitle;
- (void)setPrimitiveReposadoTitle:(NSString*)value;




- (NSString*)primitiveReposadoUpdatesMetadataDir;
- (void)setPrimitiveReposadoUpdatesMetadataDir:(NSString*)value;




- (NSString*)primitiveReposadoUpdatesRootDir;
- (void)setPrimitiveReposadoUpdatesRootDir:(NSString*)value;





- (NSMutableSet*)primitiveCatalogs;
- (void)setPrimitiveCatalogs:(NSMutableSet*)value;


@end
