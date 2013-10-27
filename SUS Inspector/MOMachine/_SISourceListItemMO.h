// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SISourceListItemMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SISourceListItemMOAttributes {
	__unsafe_unretained NSString *iconImage;
	__unsafe_unretained NSString *iconName;
	__unsafe_unretained NSString *isGroupItem;
	__unsafe_unretained NSString *productFilterPredicate;
	__unsafe_unretained NSString *sortIndex;
	__unsafe_unretained NSString *title;
} SISourceListItemMOAttributes;

extern const struct SISourceListItemMORelationships {
	__unsafe_unretained NSString *catalogReference;
	__unsafe_unretained NSString *children;
	__unsafe_unretained NSString *parent;
} SISourceListItemMORelationships;

extern const struct SISourceListItemMOFetchedProperties {
} SISourceListItemMOFetchedProperties;

@class SICatalogMO;
@class SISourceListItemMO;
@class SISourceListItemMO;

@class NSObject;


@class NSObject;



@interface SISourceListItemMOID : NSManagedObjectID {}
@end

@interface _SISourceListItemMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SISourceListItemMOID*)objectID;





@property (nonatomic, strong) id iconImage;



//- (BOOL)validateIconImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* iconName;



//- (BOOL)validateIconName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isGroupItem;



@property BOOL isGroupItemValue;
- (BOOL)isGroupItemValue;
- (void)setIsGroupItemValue:(BOOL)value_;

//- (BOOL)validateIsGroupItem:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id productFilterPredicate;



//- (BOOL)validateProductFilterPredicate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* sortIndex;



@property int32_t sortIndexValue;
- (int32_t)sortIndexValue;
- (void)setSortIndexValue:(int32_t)value_;

//- (BOOL)validateSortIndex:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SICatalogMO *catalogReference;

//- (BOOL)validateCatalogReference:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, strong) SISourceListItemMO *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;





@end

@interface _SISourceListItemMO (CoreDataGeneratedAccessors)

- (void)addChildren:(NSSet*)value_;
- (void)removeChildren:(NSSet*)value_;
- (void)addChildrenObject:(SISourceListItemMO*)value_;
- (void)removeChildrenObject:(SISourceListItemMO*)value_;

@end

@interface _SISourceListItemMO (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveIconImage;
- (void)setPrimitiveIconImage:(id)value;




- (NSString*)primitiveIconName;
- (void)setPrimitiveIconName:(NSString*)value;




- (NSNumber*)primitiveIsGroupItem;
- (void)setPrimitiveIsGroupItem:(NSNumber*)value;

- (BOOL)primitiveIsGroupItemValue;
- (void)setPrimitiveIsGroupItemValue:(BOOL)value_;




- (id)primitiveProductFilterPredicate;
- (void)setPrimitiveProductFilterPredicate:(id)value;




- (NSNumber*)primitiveSortIndex;
- (void)setPrimitiveSortIndex:(NSNumber*)value;

- (int32_t)primitiveSortIndexValue;
- (void)setPrimitiveSortIndexValue:(int32_t)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (SICatalogMO*)primitiveCatalogReference;
- (void)setPrimitiveCatalogReference:(SICatalogMO*)value;



- (NSMutableSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet*)value;



- (SISourceListItemMO*)primitiveParent;
- (void)setPrimitiveParent:(SISourceListItemMO*)value;


@end
