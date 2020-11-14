// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIServerMetadataMO.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

#import "SIDownloadableObject.h"

NS_ASSUME_NONNULL_BEGIN

@class SIProductMO;

@interface SIServerMetadataMOID : SIDownloadableObjectID {}
@end

@interface _SIServerMetadataMO : SIDownloadableObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SIServerMetadataMOID *objectID;

@property (nonatomic, strong, nullable) NSString* metadataFileContents;

@property (nonatomic, strong, nullable) SIProductMO *product;

@end

@interface _SIServerMetadataMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveMetadataFileContents;
- (void)setPrimitiveMetadataFileContents:(nullable NSString*)value;

- (nullable SIProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(nullable SIProductMO*)value;

@end

@interface SIServerMetadataMOAttributes: NSObject 
+ (NSString *)metadataFileContents;
@end

@interface SIServerMetadataMORelationships: NSObject
+ (NSString *)product;
@end

NS_ASSUME_NONNULL_END
