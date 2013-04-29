// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIProductMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SIProductMOAttributes {
	 NSString *productDescription;
	 NSString *productID;
	 NSString *productIsDeprecated;
	 NSString *productIsNew;
	 NSString *productPostDate;
	 NSString *productSize;
	 NSString *productTitle;
	 NSString *productVersion;
} SIProductMOAttributes;

extern const struct SIProductMORelationships {
	 NSString *catalogs;
	 NSString *distributions;
	 NSString *packages;
	 NSString *serverMetadataFiles;
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





@property (nonatomic, retain) NSString* productDescription;



//- (BOOL)validateProductDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* productID;



//- (BOOL)validateProductID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* productIsDeprecated;



@property BOOL productIsDeprecatedValue;
- (BOOL)productIsDeprecatedValue;
- (void)setProductIsDeprecatedValue:(BOOL)value_;

//- (BOOL)validateProductIsDeprecated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* productIsNew;



@property BOOL productIsNewValue;
- (BOOL)productIsNewValue;
- (void)setProductIsNewValue:(BOOL)value_;

//- (BOOL)validateProductIsNew:(id*)value_ error:(NSError**)error_;





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




@property (nonatomic, retain) NSSet *distributions;

- (NSMutableSet*)distributionsSet;




@property (nonatomic, retain) NSSet *packages;

- (NSMutableSet*)packagesSet;




@property (nonatomic, retain) NSSet *serverMetadataFiles;

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
