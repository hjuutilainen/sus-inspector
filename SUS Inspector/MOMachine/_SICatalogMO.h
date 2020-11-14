// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SICatalogMO.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class SIProductMO;
@class SIReposadoInstanceMO;
@class SISourceListItemMO;

@interface SICatalogMOID : NSManagedObjectID {}
@end

@interface _SICatalogMO : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SICatalogMOID *objectID;

@property (nonatomic, strong, nullable) NSNumber* allowRemove;

@property (atomic) BOOL allowRemoveValue;
- (BOOL)allowRemoveValue;
- (void)setAllowRemoveValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* catalogDescription;

@property (nonatomic, strong, nullable) NSString* catalogDisplayName;

@property (nonatomic, strong, nullable) NSURL* catalogFileURL;

@property (nonatomic, strong, nullable) NSString* catalogOSVersion;

@property (nonatomic, strong, nullable) NSString* catalogTitle;

@property (nonatomic, strong, nullable) NSString* catalogURL;

@property (nonatomic, strong, nullable) NSNumber* catalogURLCheckPending;

@property (atomic) BOOL catalogURLCheckPendingValue;
- (BOOL)catalogURLCheckPendingValue;
- (void)setCatalogURLCheckPendingValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* catalogURLFromInstanceDefaultURL;

@property (nonatomic, strong, nullable) NSNumber* catalogURLIsValid;

@property (atomic) BOOL catalogURLIsValidValue;
- (BOOL)catalogURLIsValidValue;
- (void)setCatalogURLIsValidValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* catalogURLStatusCode;

@property (atomic) int32_t catalogURLStatusCodeValue;
- (int32_t)catalogURLStatusCodeValue;
- (void)setCatalogURLStatusCodeValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* isActive;

@property (atomic) BOOL isActiveValue;
- (BOOL)isActiveValue;
- (void)setIsActiveValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSSet<SIProductMO*> *products;
- (nullable NSMutableSet<SIProductMO*>*)productsSet;

@property (nonatomic, strong, nullable) SIReposadoInstanceMO *reposadoInstance;

@property (nonatomic, strong, nullable) SISourceListItemMO *sourceListItem;

@end

@interface _SICatalogMO (ProductsCoreDataGeneratedAccessors)
- (void)addProducts:(NSSet<SIProductMO*>*)value_;
- (void)removeProducts:(NSSet<SIProductMO*>*)value_;
- (void)addProductsObject:(SIProductMO*)value_;
- (void)removeProductsObject:(SIProductMO*)value_;

@end

@interface _SICatalogMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAllowRemove;
- (void)setPrimitiveAllowRemove:(nullable NSNumber*)value;

- (BOOL)primitiveAllowRemoveValue;
- (void)setPrimitiveAllowRemoveValue:(BOOL)value_;

- (nullable NSString*)primitiveCatalogDescription;
- (void)setPrimitiveCatalogDescription:(nullable NSString*)value;

- (nullable NSString*)primitiveCatalogDisplayName;
- (void)setPrimitiveCatalogDisplayName:(nullable NSString*)value;

- (nullable NSURL*)primitiveCatalogFileURL;
- (void)setPrimitiveCatalogFileURL:(nullable NSURL*)value;

- (nullable NSString*)primitiveCatalogOSVersion;
- (void)setPrimitiveCatalogOSVersion:(nullable NSString*)value;

- (nullable NSString*)primitiveCatalogTitle;
- (void)setPrimitiveCatalogTitle:(nullable NSString*)value;

- (nullable NSString*)primitiveCatalogURL;
- (void)setPrimitiveCatalogURL:(nullable NSString*)value;

- (nullable NSNumber*)primitiveCatalogURLCheckPending;
- (void)setPrimitiveCatalogURLCheckPending:(nullable NSNumber*)value;

- (BOOL)primitiveCatalogURLCheckPendingValue;
- (void)setPrimitiveCatalogURLCheckPendingValue:(BOOL)value_;

- (nullable NSString*)primitiveCatalogURLFromInstanceDefaultURL;
- (void)setPrimitiveCatalogURLFromInstanceDefaultURL:(nullable NSString*)value;

- (nullable NSNumber*)primitiveCatalogURLIsValid;
- (void)setPrimitiveCatalogURLIsValid:(nullable NSNumber*)value;

- (BOOL)primitiveCatalogURLIsValidValue;
- (void)setPrimitiveCatalogURLIsValidValue:(BOOL)value_;

- (nullable NSNumber*)primitiveCatalogURLStatusCode;
- (void)setPrimitiveCatalogURLStatusCode:(nullable NSNumber*)value;

- (int32_t)primitiveCatalogURLStatusCodeValue;
- (void)setPrimitiveCatalogURLStatusCodeValue:(int32_t)value_;

- (nullable NSNumber*)primitiveIsActive;
- (void)setPrimitiveIsActive:(nullable NSNumber*)value;

- (BOOL)primitiveIsActiveValue;
- (void)setPrimitiveIsActiveValue:(BOOL)value_;

- (NSMutableSet<SIProductMO*>*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet<SIProductMO*>*)value;

- (nullable SIReposadoInstanceMO*)primitiveReposadoInstance;
- (void)setPrimitiveReposadoInstance:(nullable SIReposadoInstanceMO*)value;

- (nullable SISourceListItemMO*)primitiveSourceListItem;
- (void)setPrimitiveSourceListItem:(nullable SISourceListItemMO*)value;

@end

@interface SICatalogMOAttributes: NSObject 
+ (NSString *)allowRemove;
+ (NSString *)catalogDescription;
+ (NSString *)catalogDisplayName;
+ (NSString *)catalogFileURL;
+ (NSString *)catalogOSVersion;
+ (NSString *)catalogTitle;
+ (NSString *)catalogURL;
+ (NSString *)catalogURLCheckPending;
+ (NSString *)catalogURLFromInstanceDefaultURL;
+ (NSString *)catalogURLIsValid;
+ (NSString *)catalogURLStatusCode;
+ (NSString *)isActive;
@end

@interface SICatalogMORelationships: NSObject
+ (NSString *)products;
+ (NSString *)reposadoInstance;
+ (NSString *)sourceListItem;
@end

NS_ASSUME_NONNULL_END
