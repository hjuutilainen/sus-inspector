// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIProductMO.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class SICatalogMO;
@class SIDistributionMO;
@class SIPackageMO;
@class SIServerMetadataMO;

@interface SIProductMOID : NSManagedObjectID {}
@end

@interface _SIProductMO : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SIProductMOID *objectID;

@property (nonatomic, strong, nullable) NSString* productDescription;

@property (nonatomic, strong, nullable) NSString* productID;

@property (nonatomic, strong, nullable) NSNumber* productIsDeprecated;

@property (atomic) BOOL productIsDeprecatedValue;
- (BOOL)productIsDeprecatedValue;
- (void)setProductIsDeprecatedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* productIsNew;

@property (atomic) BOOL productIsNewValue;
- (BOOL)productIsNewValue;
- (void)setProductIsNewValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSDate* productPostDate;

@property (nonatomic, strong, nullable) NSNumber* productSize;

@property (atomic) int64_t productSizeValue;
- (int64_t)productSizeValue;
- (void)setProductSizeValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* productTitle;

@property (nonatomic, strong, nullable) NSString* productVersion;

@property (nonatomic, strong, nullable) NSSet<SICatalogMO*> *catalogs;
- (nullable NSMutableSet<SICatalogMO*>*)catalogsSet;

@property (nonatomic, strong, nullable) NSSet<SIDistributionMO*> *distributions;
- (nullable NSMutableSet<SIDistributionMO*>*)distributionsSet;

@property (nonatomic, strong, nullable) NSSet<SIPackageMO*> *packages;
- (nullable NSMutableSet<SIPackageMO*>*)packagesSet;

@property (nonatomic, strong, nullable) NSSet<SIServerMetadataMO*> *serverMetadataFiles;
- (nullable NSMutableSet<SIServerMetadataMO*>*)serverMetadataFilesSet;

@end

@interface _SIProductMO (CatalogsCoreDataGeneratedAccessors)
- (void)addCatalogs:(NSSet<SICatalogMO*>*)value_;
- (void)removeCatalogs:(NSSet<SICatalogMO*>*)value_;
- (void)addCatalogsObject:(SICatalogMO*)value_;
- (void)removeCatalogsObject:(SICatalogMO*)value_;

@end

@interface _SIProductMO (DistributionsCoreDataGeneratedAccessors)
- (void)addDistributions:(NSSet<SIDistributionMO*>*)value_;
- (void)removeDistributions:(NSSet<SIDistributionMO*>*)value_;
- (void)addDistributionsObject:(SIDistributionMO*)value_;
- (void)removeDistributionsObject:(SIDistributionMO*)value_;

@end

@interface _SIProductMO (PackagesCoreDataGeneratedAccessors)
- (void)addPackages:(NSSet<SIPackageMO*>*)value_;
- (void)removePackages:(NSSet<SIPackageMO*>*)value_;
- (void)addPackagesObject:(SIPackageMO*)value_;
- (void)removePackagesObject:(SIPackageMO*)value_;

@end

@interface _SIProductMO (ServerMetadataFilesCoreDataGeneratedAccessors)
- (void)addServerMetadataFiles:(NSSet<SIServerMetadataMO*>*)value_;
- (void)removeServerMetadataFiles:(NSSet<SIServerMetadataMO*>*)value_;
- (void)addServerMetadataFilesObject:(SIServerMetadataMO*)value_;
- (void)removeServerMetadataFilesObject:(SIServerMetadataMO*)value_;

@end

@interface _SIProductMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveProductDescription;
- (void)setPrimitiveProductDescription:(nullable NSString*)value;

- (nullable NSString*)primitiveProductID;
- (void)setPrimitiveProductID:(nullable NSString*)value;

- (nullable NSNumber*)primitiveProductIsDeprecated;
- (void)setPrimitiveProductIsDeprecated:(nullable NSNumber*)value;

- (BOOL)primitiveProductIsDeprecatedValue;
- (void)setPrimitiveProductIsDeprecatedValue:(BOOL)value_;

- (nullable NSNumber*)primitiveProductIsNew;
- (void)setPrimitiveProductIsNew:(nullable NSNumber*)value;

- (BOOL)primitiveProductIsNewValue;
- (void)setPrimitiveProductIsNewValue:(BOOL)value_;

- (nullable NSDate*)primitiveProductPostDate;
- (void)setPrimitiveProductPostDate:(nullable NSDate*)value;

- (nullable NSNumber*)primitiveProductSize;
- (void)setPrimitiveProductSize:(nullable NSNumber*)value;

- (int64_t)primitiveProductSizeValue;
- (void)setPrimitiveProductSizeValue:(int64_t)value_;

- (nullable NSString*)primitiveProductTitle;
- (void)setPrimitiveProductTitle:(nullable NSString*)value;

- (nullable NSString*)primitiveProductVersion;
- (void)setPrimitiveProductVersion:(nullable NSString*)value;

- (NSMutableSet<SICatalogMO*>*)primitiveCatalogs;
- (void)setPrimitiveCatalogs:(NSMutableSet<SICatalogMO*>*)value;

- (NSMutableSet<SIDistributionMO*>*)primitiveDistributions;
- (void)setPrimitiveDistributions:(NSMutableSet<SIDistributionMO*>*)value;

- (NSMutableSet<SIPackageMO*>*)primitivePackages;
- (void)setPrimitivePackages:(NSMutableSet<SIPackageMO*>*)value;

- (NSMutableSet<SIServerMetadataMO*>*)primitiveServerMetadataFiles;
- (void)setPrimitiveServerMetadataFiles:(NSMutableSet<SIServerMetadataMO*>*)value;

@end

@interface SIProductMOAttributes: NSObject 
+ (NSString *)productDescription;
+ (NSString *)productID;
+ (NSString *)productIsDeprecated;
+ (NSString *)productIsNew;
+ (NSString *)productPostDate;
+ (NSString *)productSize;
+ (NSString *)productTitle;
+ (NSString *)productVersion;
@end

@interface SIProductMORelationships: NSObject
+ (NSString *)catalogs;
+ (NSString *)distributions;
+ (NSString *)packages;
+ (NSString *)serverMetadataFiles;
@end

NS_ASSUME_NONNULL_END
