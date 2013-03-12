// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUCatalogMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SUCatalogMOAttributes {
	 NSString *allowRemove;
	 NSString *catalogDescription;
	 NSString *catalogDisplayName;
	 NSString *catalogFileURL;
	 NSString *catalogOSVersion;
	 NSString *catalogTitle;
	 NSString *catalogURL;
	 NSString *isActive;
} SUCatalogMOAttributes;

extern const struct SUCatalogMORelationships {
	 NSString *products;
	 NSString *reposadoInstance;
	 NSString *sourceListItem;
} SUCatalogMORelationships;

extern const struct SUCatalogMOFetchedProperties {
} SUCatalogMOFetchedProperties;

@class SUProductMO;
@class ReposadoInstanceMO;
@class SourceListItemMO;




@class NSObject;





@interface SUCatalogMOID : NSManagedObjectID {}
@end

@interface _SUCatalogMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SUCatalogMOID*)objectID;





@property (nonatomic, retain) NSNumber* allowRemove;



@property BOOL allowRemoveValue;
- (BOOL)allowRemoveValue;
- (void)setAllowRemoveValue:(BOOL)value_;

//- (BOOL)validateAllowRemove:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogDescription;



//- (BOOL)validateCatalogDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogDisplayName;



//- (BOOL)validateCatalogDisplayName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) id catalogFileURL;



//- (BOOL)validateCatalogFileURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogOSVersion;



//- (BOOL)validateCatalogOSVersion:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogTitle;



//- (BOOL)validateCatalogTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogURL;



//- (BOOL)validateCatalogURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* isActive;



@property BOOL isActiveValue;
- (BOOL)isActiveValue;
- (void)setIsActiveValue:(BOOL)value_;

//- (BOOL)validateIsActive:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet *products;

- (NSMutableSet*)productsSet;




@property (nonatomic, retain) ReposadoInstanceMO *reposadoInstance;

//- (BOOL)validateReposadoInstance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) SourceListItemMO *sourceListItem;

//- (BOOL)validateSourceListItem:(id*)value_ error:(NSError**)error_;





@end

@interface _SUCatalogMO (CoreDataGeneratedAccessors)

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(SUProductMO*)value_;
- (void)removeProductsObject:(SUProductMO*)value_;

@end

@interface _SUCatalogMO (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAllowRemove;
- (void)setPrimitiveAllowRemove:(NSNumber*)value;

- (BOOL)primitiveAllowRemoveValue;
- (void)setPrimitiveAllowRemoveValue:(BOOL)value_;




- (NSString*)primitiveCatalogDescription;
- (void)setPrimitiveCatalogDescription:(NSString*)value;




- (NSString*)primitiveCatalogDisplayName;
- (void)setPrimitiveCatalogDisplayName:(NSString*)value;




- (id)primitiveCatalogFileURL;
- (void)setPrimitiveCatalogFileURL:(id)value;




- (NSString*)primitiveCatalogOSVersion;
- (void)setPrimitiveCatalogOSVersion:(NSString*)value;




- (NSString*)primitiveCatalogTitle;
- (void)setPrimitiveCatalogTitle:(NSString*)value;




- (NSString*)primitiveCatalogURL;
- (void)setPrimitiveCatalogURL:(NSString*)value;




- (NSNumber*)primitiveIsActive;
- (void)setPrimitiveIsActive:(NSNumber*)value;

- (BOOL)primitiveIsActiveValue;
- (void)setPrimitiveIsActiveValue:(BOOL)value_;





- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;



- (ReposadoInstanceMO*)primitiveReposadoInstance;
- (void)setPrimitiveReposadoInstance:(ReposadoInstanceMO*)value;



- (SourceListItemMO*)primitiveSourceListItem;
- (void)setPrimitiveSourceListItem:(SourceListItemMO*)value;


@end
