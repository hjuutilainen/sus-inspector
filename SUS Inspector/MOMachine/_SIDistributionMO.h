// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDistributionMO.h instead.

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

@interface SIDistributionMOID : SIDownloadableObjectID {}
@end

@interface _SIDistributionMO : SIDownloadableObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SIDistributionMOID *objectID;

@property (nonatomic, strong, nullable) NSString* distributionFileContents;

@property (nonatomic, strong, nullable) NSString* distributionLanguage;

@property (nonatomic, strong, nullable) NSString* distributionLanguageDisplayName;

@property (nonatomic, strong, nullable) SIProductMO *product;

@end

@interface _SIDistributionMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveDistributionFileContents;
- (void)setPrimitiveDistributionFileContents:(nullable NSString*)value;

- (nullable NSString*)primitiveDistributionLanguage;
- (void)setPrimitiveDistributionLanguage:(nullable NSString*)value;

- (nullable NSString*)primitiveDistributionLanguageDisplayName;
- (void)setPrimitiveDistributionLanguageDisplayName:(nullable NSString*)value;

- (nullable SIProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(nullable SIProductMO*)value;

@end

@interface SIDistributionMOAttributes: NSObject 
+ (NSString *)distributionFileContents;
+ (NSString *)distributionLanguage;
+ (NSString *)distributionLanguageDisplayName;
@end

@interface SIDistributionMORelationships: NSObject
+ (NSString *)product;
@end

NS_ASSUME_NONNULL_END
