// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SourceListItemMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SourceListItemMOAttributes {
	 NSString *isGroupItem;
	 NSString *title;
} SourceListItemMOAttributes;

extern const struct SourceListItemMORelationships {
	 NSString *children;
	 NSString *parent;
	 NSString *products;
} SourceListItemMORelationships;

extern const struct SourceListItemMOFetchedProperties {
} SourceListItemMOFetchedProperties;

@class SourceListItemMO;
@class SourceListItemMO;
@class SUProductMO;




@interface SourceListItemMOID : NSManagedObjectID {}
@end

@interface _SourceListItemMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SourceListItemMOID*)objectID;





@property (nonatomic, retain) NSNumber* isGroupItem;



@property BOOL isGroupItemValue;
- (BOOL)isGroupItemValue;
- (void)setIsGroupItemValue:(BOOL)value_;

//- (BOOL)validateIsGroupItem:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet *children;

- (NSMutableSet*)childrenSet;




@property (nonatomic, retain) SourceListItemMO *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet *products;

- (NSMutableSet*)productsSet;





@end

@interface _SourceListItemMO (CoreDataGeneratedAccessors)

- (void)addChildren:(NSSet*)value_;
- (void)removeChildren:(NSSet*)value_;
- (void)addChildrenObject:(SourceListItemMO*)value_;
- (void)removeChildrenObject:(SourceListItemMO*)value_;

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(SUProductMO*)value_;
- (void)removeProductsObject:(SUProductMO*)value_;

@end

@interface _SourceListItemMO (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsGroupItem;
- (void)setPrimitiveIsGroupItem:(NSNumber*)value;

- (BOOL)primitiveIsGroupItemValue;
- (void)setPrimitiveIsGroupItemValue:(BOOL)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableSet*)value;



- (SourceListItemMO*)primitiveParent;
- (void)setPrimitiveParent:(SourceListItemMO*)value;



- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;


@end
