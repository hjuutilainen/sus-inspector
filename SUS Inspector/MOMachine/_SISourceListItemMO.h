// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SISourceListItemMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SISourceListItemMOAttributes {
	 NSString *iconImage;
	 NSString *iconName;
	 NSString *isGroupItem;
	 NSString *sortIndex;
	 NSString *title;
} SISourceListItemMOAttributes;

extern const struct SISourceListItemMORelationships {
	 NSString *catalogReference;
	 NSString *children;
	 NSString *parent;
} SISourceListItemMORelationships;

extern const struct SISourceListItemMOFetchedProperties {
} SISourceListItemMOFetchedProperties;

@class SICatalogMO;
@class SISourceListItemMO;
@class SISourceListItemMO;

@class NSObject;





@interface SISourceListItemMOID : NSManagedObjectID {}
@end

@interface _SISourceListItemMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SISourceListItemMOID*)objectID;





@property (nonatomic, retain) id iconImage;



//- (BOOL)validateIconImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* iconName;



//- (BOOL)validateIconName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* isGroupItem;



@property BOOL isGroupItemValue;
- (BOOL)isGroupItemValue;
- (void)setIsGroupItemValue:(BOOL)value_;

//- (BOOL)validateIsGroupItem:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* sortIndex;



@property int32_t sortIndexValue;
- (int32_t)sortIndexValue;
- (void)setSortIndexValue:(int32_t)value_;

//- (BOOL)validateSortIndex:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) SICatalogMO *catalogReference;

//- (BOOL)validateCatalogReference:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet *children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, retain) SISourceListItemMO *parent;

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
