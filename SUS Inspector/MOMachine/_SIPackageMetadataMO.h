// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMetadataMO.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

#import "SIDownloadableObject.h"

NS_ASSUME_NONNULL_BEGIN

@class SIPackageMO;

@interface SIPackageMetadataMOID : SIDownloadableObjectID {}
@end

@interface _SIPackageMetadataMO : SIDownloadableObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SIPackageMetadataMOID *objectID;

@property (nonatomic, strong, nullable) NSString* metadataFileContents;

@property (nonatomic, strong, nullable) SIPackageMO *package;

@end

@interface _SIPackageMetadataMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveMetadataFileContents;
- (void)setPrimitiveMetadataFileContents:(nullable NSString*)value;

- (nullable SIPackageMO*)primitivePackage;
- (void)setPrimitivePackage:(nullable SIPackageMO*)value;

@end

@interface SIPackageMetadataMOAttributes: NSObject 
+ (NSString *)metadataFileContents;
@end

@interface SIPackageMetadataMORelationships: NSObject
+ (NSString *)package;
@end

NS_ASSUME_NONNULL_END
