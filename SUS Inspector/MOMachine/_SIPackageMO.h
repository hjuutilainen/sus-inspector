// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMO.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

#import "SIDownloadableObject.h"

NS_ASSUME_NONNULL_BEGIN

@class SIPackageMetadataMO;
@class SIProductMO;

@interface SIPackageMOID : SIDownloadableObjectID {}
@end

@interface _SIPackageMO : SIDownloadableObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SIPackageMOID *objectID;

@property (nonatomic, strong, nullable) NSString* packageMetadataURL;

@property (nonatomic, strong, nullable) NSNumber* packageSize;

@property (atomic) int64_t packageSizeValue;
- (int64_t)packageSizeValue;
- (void)setPackageSizeValue:(int64_t)value_;

@property (nonatomic, strong, nullable) SIPackageMetadataMO *metadata;

@property (nonatomic, strong, nullable) SIProductMO *product;

@end

@interface _SIPackageMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitivePackageMetadataURL;
- (void)setPrimitivePackageMetadataURL:(nullable NSString*)value;

- (nullable NSNumber*)primitivePackageSize;
- (void)setPrimitivePackageSize:(nullable NSNumber*)value;

- (int64_t)primitivePackageSizeValue;
- (void)setPrimitivePackageSizeValue:(int64_t)value_;

- (nullable SIPackageMetadataMO*)primitiveMetadata;
- (void)setPrimitiveMetadata:(nullable SIPackageMetadataMO*)value;

- (nullable SIProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(nullable SIProductMO*)value;

@end

@interface SIPackageMOAttributes: NSObject 
+ (NSString *)packageMetadataURL;
+ (NSString *)packageSize;
@end

@interface SIPackageMORelationships: NSObject
+ (NSString *)metadata;
+ (NSString *)product;
@end

NS_ASSUME_NONNULL_END
