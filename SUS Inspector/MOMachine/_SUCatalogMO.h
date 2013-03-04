// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUCatalogMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SUCatalogMOAttributes {
	 NSString *catalogDescription;
	 NSString *catalogTitle;
	 NSString *catalogURL;
} SUCatalogMOAttributes;

extern const struct SUCatalogMORelationships {
	 NSString *products;
	 NSString *reposadoInstance;
} SUCatalogMORelationships;

extern const struct SUCatalogMOFetchedProperties {
} SUCatalogMOFetchedProperties;

@class SUProductMO;
@class ReposadoInstanceMO;



@class NSObject;

@interface SUCatalogMOID : NSManagedObjectID {}
@end

@interface _SUCatalogMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SUCatalogMOID*)objectID;





@property (nonatomic, retain) NSString* catalogDescription;



//- (BOOL)validateCatalogDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogTitle;



//- (BOOL)validateCatalogTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) id catalogURL;



//- (BOOL)validateCatalogURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet *products;

- (NSMutableSet*)productsSet;




@property (nonatomic, retain) ReposadoInstanceMO *reposadoInstance;

//- (BOOL)validateReposadoInstance:(id*)value_ error:(NSError**)error_;





@end

@interface _SUCatalogMO (CoreDataGeneratedAccessors)

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(SUProductMO*)value_;
- (void)removeProductsObject:(SUProductMO*)value_;

@end

@interface _SUCatalogMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCatalogDescription;
- (void)setPrimitiveCatalogDescription:(NSString*)value;




- (NSString*)primitiveCatalogTitle;
- (void)setPrimitiveCatalogTitle:(NSString*)value;




- (id)primitiveCatalogURL;
- (void)setPrimitiveCatalogURL:(id)value;





- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;



- (ReposadoInstanceMO*)primitiveReposadoInstance;
- (void)setPrimitiveReposadoInstance:(ReposadoInstanceMO*)value;


@end
