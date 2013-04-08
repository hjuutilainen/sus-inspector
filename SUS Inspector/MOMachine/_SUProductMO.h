// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUProductMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SUProductMOAttributes {
	 NSString *productDescription;
	 NSString *productID;
	 NSString *productIsDeprecated;
	 NSString *productPostDate;
	 NSString *productSize;
	 NSString *productTitle;
	 NSString *productVersion;
} SUProductMOAttributes;

extern const struct SUProductMORelationships {
	 NSString *catalogs;
	 NSString *packages;
} SUProductMORelationships;

extern const struct SUProductMOFetchedProperties {
} SUProductMOFetchedProperties;

@class SUCatalogMO;
@class SUPackageMO;









@interface SUProductMOID : NSManagedObjectID {}
@end

@interface _SUProductMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SUProductMOID*)objectID;





@property (nonatomic, retain) NSString* productDescription;



//- (BOOL)validateProductDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* productID;



//- (BOOL)validateProductID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* productIsDeprecated;



@property BOOL productIsDeprecatedValue;
- (BOOL)productIsDeprecatedValue;
- (void)setProductIsDeprecatedValue:(BOOL)value_;

//- (BOOL)validateProductIsDeprecated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSDate* productPostDate;



//- (BOOL)validateProductPostDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* productSize;



@property int64_t productSizeValue;
- (int64_t)productSizeValue;
- (void)setProductSizeValue:(int64_t)value_;

//- (BOOL)validateProductSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* productTitle;



//- (BOOL)validateProductTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* productVersion;



//- (BOOL)validateProductVersion:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet *catalogs;

- (NSMutableSet*)catalogsSet;




@property (nonatomic, retain) NSSet *packages;

- (NSMutableSet*)packagesSet;





@end

@interface _SUProductMO (CoreDataGeneratedAccessors)

- (void)addCatalogs:(NSSet*)value_;
- (void)removeCatalogs:(NSSet*)value_;
- (void)addCatalogsObject:(SUCatalogMO*)value_;
- (void)removeCatalogsObject:(SUCatalogMO*)value_;

- (void)addPackages:(NSSet*)value_;
- (void)removePackages:(NSSet*)value_;
- (void)addPackagesObject:(SUPackageMO*)value_;
- (void)removePackagesObject:(SUPackageMO*)value_;

@end

@interface _SUProductMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveProductDescription;
- (void)setPrimitiveProductDescription:(NSString*)value;




- (NSString*)primitiveProductID;
- (void)setPrimitiveProductID:(NSString*)value;




- (NSNumber*)primitiveProductIsDeprecated;
- (void)setPrimitiveProductIsDeprecated:(NSNumber*)value;

- (BOOL)primitiveProductIsDeprecatedValue;
- (void)setPrimitiveProductIsDeprecatedValue:(BOOL)value_;




- (NSDate*)primitiveProductPostDate;
- (void)setPrimitiveProductPostDate:(NSDate*)value;




- (NSNumber*)primitiveProductSize;
- (void)setPrimitiveProductSize:(NSNumber*)value;

- (int64_t)primitiveProductSizeValue;
- (void)setPrimitiveProductSizeValue:(int64_t)value_;




- (NSString*)primitiveProductTitle;
- (void)setPrimitiveProductTitle:(NSString*)value;




- (NSString*)primitiveProductVersion;
- (void)setPrimitiveProductVersion:(NSString*)value;





- (NSMutableSet*)primitiveCatalogs;
- (void)setPrimitiveCatalogs:(NSMutableSet*)value;



- (NSMutableSet*)primitivePackages;
- (void)setPrimitivePackages:(NSMutableSet*)value;


@end
