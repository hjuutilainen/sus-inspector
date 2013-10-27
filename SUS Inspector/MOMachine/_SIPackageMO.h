// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMO.h instead.

#import <CoreData/CoreData.h>
#import "SIDownloadableObject.h"

extern const struct SIPackageMOAttributes {
	__unsafe_unretained NSString *packageMetadataURL;
	__unsafe_unretained NSString *packageSize;
} SIPackageMOAttributes;

extern const struct SIPackageMORelationships {
	__unsafe_unretained NSString *metadata;
	__unsafe_unretained NSString *product;
} SIPackageMORelationships;

extern const struct SIPackageMOFetchedProperties {
} SIPackageMOFetchedProperties;

@class SIPackageMetadataMO;
@class SIProductMO;




@interface SIPackageMOID : NSManagedObjectID {}
@end

@interface _SIPackageMO : SIDownloadableObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIPackageMOID*)objectID;





@property (nonatomic, strong) NSString* packageMetadataURL;



//- (BOOL)validatePackageMetadataURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* packageSize;



@property int64_t packageSizeValue;
- (int64_t)packageSizeValue;
- (void)setPackageSizeValue:(int64_t)value_;

//- (BOOL)validatePackageSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SIPackageMetadataMO *metadata;

//- (BOOL)validateMetadata:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) SIProductMO *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@end

@interface _SIPackageMO (CoreDataGeneratedAccessors)

@end

@interface _SIPackageMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePackageMetadataURL;
- (void)setPrimitivePackageMetadataURL:(NSString*)value;




- (NSNumber*)primitivePackageSize;
- (void)setPrimitivePackageSize:(NSNumber*)value;

- (int64_t)primitivePackageSizeValue;
- (void)setPrimitivePackageSizeValue:(int64_t)value_;





- (SIPackageMetadataMO*)primitiveMetadata;
- (void)setPrimitiveMetadata:(SIPackageMetadataMO*)value;



- (SIProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(SIProductMO*)value;


@end
