// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SourceListItemMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SourceListItemMOAttributes {
	 NSString *iconImage;
	 NSString *iconName;
	 NSString *isGroupItem;
	 NSString *sortIndex;
	 NSString *title;
} SourceListItemMOAttributes;

extern const struct SourceListItemMORelationships {
	 NSString *catalogReference;
	 NSString *children;
	 NSString *parent;
} SourceListItemMORelationships;

extern const struct SourceListItemMOFetchedProperties {
} SourceListItemMOFetchedProperties;

@class SUCatalogMO;
@class SourceListItemMO;
@class SourceListItemMO;

@class NSObject;





@interface SourceListItemMOID : NSManagedObjectID {}
@end

@interface _SourceListItemMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SourceListItemMOID*)objectID;





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





@property (nonatomic, retain) SUCatalogMO *catalogReference;

//- (BOOL)validateCatalogReference:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet *children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, retain) SourceListItemMO *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;





@end

@interface _SourceListItemMO (CoreDataGeneratedAccessors)

- (void)addChildren:(NSSet*)value_;
- (void)removeChildren:(NSSet*)value_;
- (void)addChildrenObject:(SourceListItemMO*)value_;
- (void)removeChildrenObject:(SourceListItemMO*)value_;

@end

@interface _SourceListItemMO (CoreDataGeneratedPrimitiveAccessors)


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





- (SUCatalogMO*)primitiveCatalogReference;
- (void)setPrimitiveCatalogReference:(SUCatalogMO*)value;



- (NSMutableSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet*)value;



- (SourceListItemMO*)primitiveParent;
- (void)setPrimitiveParent:(SourceListItemMO*)value;


@end
