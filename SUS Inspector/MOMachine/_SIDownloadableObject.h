// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDownloadableObject.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface SIDownloadableObjectID : NSManagedObjectID {}
@end

@interface _SIDownloadableObject : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SIDownloadableObjectID *objectID;

@property (nonatomic, strong, nullable) NSString* objectCachedPath;

@property (nonatomic, strong) NSNumber* objectIsCached;

@property (atomic) BOOL objectIsCachedValue;
- (BOOL)objectIsCachedValue;
- (void)setObjectIsCachedValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* objectIsDownloading;

@property (atomic) BOOL objectIsDownloadingValue;
- (BOOL)objectIsDownloadingValue;
- (void)setObjectIsDownloadingValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* objectURL;

@property (nonatomic, strong, nullable) NSNumber* performPostDownloadAction;

@property (atomic) BOOL performPostDownloadActionValue;
- (BOOL)performPostDownloadActionValue;
- (void)setPerformPostDownloadActionValue:(BOOL)value_;

@end

@interface _SIDownloadableObject (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveObjectCachedPath;
- (void)setPrimitiveObjectCachedPath:(nullable NSString*)value;

- (NSNumber*)primitiveObjectIsCached;
- (void)setPrimitiveObjectIsCached:(NSNumber*)value;

- (BOOL)primitiveObjectIsCachedValue;
- (void)setPrimitiveObjectIsCachedValue:(BOOL)value_;

- (nullable NSNumber*)primitiveObjectIsDownloading;
- (void)setPrimitiveObjectIsDownloading:(nullable NSNumber*)value;

- (BOOL)primitiveObjectIsDownloadingValue;
- (void)setPrimitiveObjectIsDownloadingValue:(BOOL)value_;

- (nullable NSString*)primitiveObjectURL;
- (void)setPrimitiveObjectURL:(nullable NSString*)value;

- (nullable NSNumber*)primitivePerformPostDownloadAction;
- (void)setPrimitivePerformPostDownloadAction:(nullable NSNumber*)value;

- (BOOL)primitivePerformPostDownloadActionValue;
- (void)setPrimitivePerformPostDownloadActionValue:(BOOL)value_;

@end

@interface SIDownloadableObjectAttributes: NSObject 
+ (NSString *)objectCachedPath;
+ (NSString *)objectIsCached;
+ (NSString *)objectIsDownloading;
+ (NSString *)objectURL;
+ (NSString *)performPostDownloadAction;
@end

NS_ASSUME_NONNULL_END
