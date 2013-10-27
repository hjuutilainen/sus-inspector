// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIProductMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SIProductMOAttributes {
	__unsafe_unretained NSString *productDescription;
	__unsafe_unretained NSString *productID;
	__unsafe_unretained NSString *productIsDeprecated;
	__unsafe_unretained NSString *productIsNew;
	__unsafe_unretained NSString *productPostDate;
	__unsafe_unretained NSString *productSize;
	__unsafe_unretained NSString *productTitle;
	__unsafe_unretained NSString *productVersion;
} SIProductMOAttributes;

extern const struct SIProductMORelationships {
	__unsafe_unretained NSString *catalogs;
	__unsafe_unretained NSString *distributions;
	__unsafe_unretained NSString *packages;
	__unsafe_unretained NSString *serverMetadataFiles;
} SIProductMORelationships;

extern const struct SIProductMOFetchedProperties {
} SIProductMOFetchedProperties;

@class SICatalogMO;
@class SIDistributionMO;
@class SIPackageMO;
@class SIServerMetadataMO;










@interface SIProductMOID : NSManagedObjectID {}
@end

@interface _SIProductMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIProductMOID*)objectID;





@property (nonatomic, strong) NSString* productDescription;



//- (BOOL)validateProductDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* productID;



//- (BOOL)validateProductID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* productIsDeprecated;



@property BOOL productIsDeprecatedValue;
- (BOOL)productIsDeprecatedValue;
- (void)setProductIsDeprecatedValue:(BOOL)value_;

//- (BOOL)validateProductIsDeprecated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* productIsNew;



@property BOOL productIsNewValue;
- (BOOL)productIsNewValue;
- (void)setProductIsNewValue:(BOOL)value_;

//- (BOOL)validateProductIsNew:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* productPostDate;



//- (BOOL)validateProductPostDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* productSize;



@property int64_t productSizeValue;
- (int64_t)productSizeValue;
- (void)setProductSizeValue:(int64_t)value_;

//- (BOOL)validateProductSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* productTitle;



//- (BOOL)validateProductTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* productVersion;



//- (BOOL)validateProductVersion:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *catalogs;

- (NSMutableSet*)catalogsSet;




@property (nonatomic, strong) NSSet *distributions;

- (NSMutableSet*)distributionsSet;




@property (nonatomic, strong) NSSet *packages;

- (NSMutableSet*)packagesSet;




@property (nonatomic, strong) NSSet *serverMetadataFiles;

- (NSMutableSet*)serverMetadataFilesSet;





@end

@interface _SIProductMO (CoreDataGeneratedAccessors)

- (void)addCatalogs:(NSSet*)value_;
- (void)removeCatalogs:(NSSet*)value_;
- (void)addCatalogsObject:(SICatalogMO*)value_;
- (void)removeCatalogsObject:(SICatalogMO*)value_;

- (void)addDistributions:(NSSet*)value_;
- (void)removeDistributions:(NSSet*)value_;
- (void)addDistributionsObject:(SIDistributionMO*)value_;
- (void)removeDistributionsObject:(SIDistributionMO*)value_;

- (void)addPackages:(NSSet*)value_;
- (void)removePackages:(NSSet*)value_;
- (void)addPackagesObject:(SIPackageMO*)value_;
- (void)removePackagesObject:(SIPackageMO*)value_;

- (void)addServerMetadataFiles:(NSSet*)value_;
- (void)removeServerMetadataFiles:(NSSet*)value_;
- (void)addServerMetadataFilesObject:(SIServerMetadataMO*)value_;
- (void)removeServerMetadataFilesObject:(SIServerMetadataMO*)value_;

@end

@interface _SIProductMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveProductDescription;
- (void)setPrimitiveProductDescription:(NSString*)value;




- (NSString*)primitiveProductID;
- (void)setPrimitiveProductID:(NSString*)value;




- (NSNumber*)primitiveProductIsDeprecated;
- (void)setPrimitiveProductIsDeprecated:(NSNumber*)value;

- (BOOL)primitiveProductIsDeprecatedValue;
- (void)setPrimitiveProductIsDeprecatedValue:(BOOL)value_;




- (NSNumber*)primitiveProductIsNew;
- (void)setPrimitiveProductIsNew:(NSNumber*)value;

- (BOOL)primitiveProductIsNewValue;
- (void)setPrimitiveProductIsNewValue:(BOOL)value_;




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



- (NSMutableSet*)primitiveDistributions;
- (void)setPrimitiveDistributions:(NSMutableSet*)value;



- (NSMutableSet*)primitivePackages;
- (void)setPrimitivePackages:(NSMutableSet*)value;



- (NSMutableSet*)primitiveServerMetadataFiles;
- (void)setPrimitiveServerMetadataFiles:(NSMutableSet*)value;


@end
