// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SIPackageMOAttributes {
	 NSString *packageCachedPath;
	 NSString *packageIsCached;
	 NSString *packageMetadataURL;
	 NSString *packageSize;
	 NSString *packageURL;
} SIPackageMOAttributes;

extern const struct SIPackageMORelationships {
	 NSString *product;
} SIPackageMORelationships;

extern const struct SIPackageMOFetchedProperties {
} SIPackageMOFetchedProperties;

@class SIProductMO;







@interface SIPackageMOID : NSManagedObjectID {}
@end

@interface _SIPackageMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIPackageMOID*)objectID;





@property (nonatomic, retain) NSString* packageCachedPath;



//- (BOOL)validatePackageCachedPath:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* packageIsCached;



@property BOOL packageIsCachedValue;
- (BOOL)packageIsCachedValue;
- (void)setPackageIsCachedValue:(BOOL)value_;

//- (BOOL)validatePackageIsCached:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* packageMetadataURL;



//- (BOOL)validatePackageMetadataURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* packageSize;



@property int64_t packageSizeValue;
- (int64_t)packageSizeValue;
- (void)setPackageSizeValue:(int64_t)value_;

//- (BOOL)validatePackageSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* packageURL;



//- (BOOL)validatePackageURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) SIProductMO *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@end

@interface _SIPackageMO (CoreDataGeneratedAccessors)

@end

@interface _SIPackageMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePackageCachedPath;
- (void)setPrimitivePackageCachedPath:(NSString*)value;




- (NSNumber*)primitivePackageIsCached;
- (void)setPrimitivePackageIsCached:(NSNumber*)value;

- (BOOL)primitivePackageIsCachedValue;
- (void)setPrimitivePackageIsCachedValue:(BOOL)value_;




- (NSString*)primitivePackageMetadataURL;
- (void)setPrimitivePackageMetadataURL:(NSString*)value;




- (NSNumber*)primitivePackageSize;
- (void)setPrimitivePackageSize:(NSNumber*)value;

- (int64_t)primitivePackageSizeValue;
- (void)setPrimitivePackageSizeValue:(int64_t)value_;




- (NSString*)primitivePackageURL;
- (void)setPrimitivePackageURL:(NSString*)value;





- (SIProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(SIProductMO*)value;


@end
