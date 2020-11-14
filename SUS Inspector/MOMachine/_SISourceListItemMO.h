// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SISourceListItemMO.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class SICatalogMO;
@class SISourceListItemMO;
@class SISourceListItemMO;

@class NSObject;

@class NSObject;

@interface SISourceListItemMOID : NSManagedObjectID {}
@end

@interface _SISourceListItemMO : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SISourceListItemMOID *objectID;

@property (nonatomic, strong, nullable) id iconImage;

@property (nonatomic, strong, nullable) NSString* iconName;

@property (nonatomic, strong, nullable) NSNumber* isGroupItem;

@property (atomic) BOOL isGroupItemValue;
- (BOOL)isGroupItemValue;
- (void)setIsGroupItemValue:(BOOL)value_;

@property (nonatomic, strong, nullable) id productFilterPredicate;

@property (nonatomic, strong, nullable) NSNumber* sortIndex;

@property (atomic) int32_t sortIndexValue;
- (int32_t)sortIndexValue;
- (void)setSortIndexValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* title;

@property (nonatomic, strong, nullable) SICatalogMO *catalogReference;

@property (nonatomic, strong, nullable) NSSet<SISourceListItemMO*> *children;
- (nullable NSMutableSet<SISourceListItemMO*>*)childrenSet;

@property (nonatomic, strong, nullable) SISourceListItemMO *parent;

@end

@interface _SISourceListItemMO (ChildrenCoreDataGeneratedAccessors)
- (void)addChildren:(NSSet<SISourceListItemMO*>*)value_;
- (void)removeChildren:(NSSet<SISourceListItemMO*>*)value_;
- (void)addChildrenObject:(SISourceListItemMO*)value_;
- (void)removeChildrenObject:(SISourceListItemMO*)value_;

@end

@interface _SISourceListItemMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable id)primitiveIconImage;
- (void)setPrimitiveIconImage:(nullable id)value;

- (nullable NSString*)primitiveIconName;
- (void)setPrimitiveIconName:(nullable NSString*)value;

- (nullable NSNumber*)primitiveIsGroupItem;
- (void)setPrimitiveIsGroupItem:(nullable NSNumber*)value;

- (BOOL)primitiveIsGroupItemValue;
- (void)setPrimitiveIsGroupItemValue:(BOOL)value_;

- (nullable id)primitiveProductFilterPredicate;
- (void)setPrimitiveProductFilterPredicate:(nullable id)value;

- (nullable NSNumber*)primitiveSortIndex;
- (void)setPrimitiveSortIndex:(nullable NSNumber*)value;

- (int32_t)primitiveSortIndexValue;
- (void)setPrimitiveSortIndexValue:(int32_t)value_;

- (nullable NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(nullable NSString*)value;

- (nullable SICatalogMO*)primitiveCatalogReference;
- (void)setPrimitiveCatalogReference:(nullable SICatalogMO*)value;

- (NSMutableSet<SISourceListItemMO*>*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet<SISourceListItemMO*>*)value;

- (nullable SISourceListItemMO*)primitiveParent;
- (void)setPrimitiveParent:(nullable SISourceListItemMO*)value;

@end

@interface SISourceListItemMOAttributes: NSObject 
+ (NSString *)iconImage;
+ (NSString *)iconName;
+ (NSString *)isGroupItem;
+ (NSString *)productFilterPredicate;
+ (NSString *)sortIndex;
+ (NSString *)title;
@end

@interface SISourceListItemMORelationships: NSObject
+ (NSString *)catalogReference;
+ (NSString *)children;
+ (NSString *)parent;
@end

NS_ASSUME_NONNULL_END
