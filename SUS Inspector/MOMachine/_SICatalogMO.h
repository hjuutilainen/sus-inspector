// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SICatalogMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SICatalogMOAttributes {
	__unsafe_unretained NSString *allowRemove;
	__unsafe_unretained NSString *catalogDescription;
	__unsafe_unretained NSString *catalogDisplayName;
	__unsafe_unretained NSString *catalogFileURL;
	__unsafe_unretained NSString *catalogOSVersion;
	__unsafe_unretained NSString *catalogTitle;
	__unsafe_unretained NSString *catalogURL;
	__unsafe_unretained NSString *catalogURLCheckPending;
	__unsafe_unretained NSString *catalogURLFromInstanceDefaultURL;
	__unsafe_unretained NSString *catalogURLIsValid;
	__unsafe_unretained NSString *catalogURLStatusCode;
	__unsafe_unretained NSString *isActive;
} SICatalogMOAttributes;

extern const struct SICatalogMORelationships {
	__unsafe_unretained NSString *products;
	__unsafe_unretained NSString *reposadoInstance;
	__unsafe_unretained NSString *sourceListItem;
} SICatalogMORelationships;

extern const struct SICatalogMOFetchedProperties {
} SICatalogMOFetchedProperties;

@class SIProductMO;
@class SIReposadoInstanceMO;
@class SISourceListItemMO;




@class NSObject;









@interface SICatalogMOID : NSManagedObjectID {}
@end

@interface _SICatalogMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SICatalogMOID*)objectID;





@property (nonatomic, strong) NSNumber* allowRemove;



@property BOOL allowRemoveValue;
- (BOOL)allowRemoveValue;
- (void)setAllowRemoveValue:(BOOL)value_;

//- (BOOL)validateAllowRemove:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* catalogDescription;



//- (BOOL)validateCatalogDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* catalogDisplayName;



//- (BOOL)validateCatalogDisplayName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id catalogFileURL;



//- (BOOL)validateCatalogFileURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* catalogOSVersion;



//- (BOOL)validateCatalogOSVersion:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* catalogTitle;



//- (BOOL)validateCatalogTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* catalogURL;



//- (BOOL)validateCatalogURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* catalogURLCheckPending;



@property BOOL catalogURLCheckPendingValue;
- (BOOL)catalogURLCheckPendingValue;
- (void)setCatalogURLCheckPendingValue:(BOOL)value_;

//- (BOOL)validateCatalogURLCheckPending:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* catalogURLFromInstanceDefaultURL;



//- (BOOL)validateCatalogURLFromInstanceDefaultURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* catalogURLIsValid;



@property BOOL catalogURLIsValidValue;
- (BOOL)catalogURLIsValidValue;
- (void)setCatalogURLIsValidValue:(BOOL)value_;

//- (BOOL)validateCatalogURLIsValid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* catalogURLStatusCode;



@property int32_t catalogURLStatusCodeValue;
- (int32_t)catalogURLStatusCodeValue;
- (void)setCatalogURLStatusCodeValue:(int32_t)value_;

//- (BOOL)validateCatalogURLStatusCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isActive;



@property BOOL isActiveValue;
- (BOOL)isActiveValue;
- (void)setIsActiveValue:(BOOL)value_;

//- (BOOL)validateIsActive:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *products;

- (NSMutableSet*)productsSet;




@property (nonatomic, strong) SIReposadoInstanceMO *reposadoInstance;

//- (BOOL)validateReposadoInstance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) SISourceListItemMO *sourceListItem;

//- (BOOL)validateSourceListItem:(id*)value_ error:(NSError**)error_;





@end

@interface _SICatalogMO (CoreDataGeneratedAccessors)

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(SIProductMO*)value_;
- (void)removeProductsObject:(SIProductMO*)value_;

@end

@interface _SICatalogMO (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveAllowRemove;
- (void)setPrimitiveAllowRemove:(NSNumber*)value;

- (BOOL)primitiveAllowRemoveValue;
- (void)setPrimitiveAllowRemoveValue:(BOOL)value_;




- (NSString*)primitiveCatalogDescription;
- (void)setPrimitiveCatalogDescription:(NSString*)value;




- (NSString*)primitiveCatalogDisplayName;
- (void)setPrimitiveCatalogDisplayName:(NSString*)value;




- (id)primitiveCatalogFileURL;
- (void)setPrimitiveCatalogFileURL:(id)value;




- (NSString*)primitiveCatalogOSVersion;
- (void)setPrimitiveCatalogOSVersion:(NSString*)value;




- (NSString*)primitiveCatalogTitle;
- (void)setPrimitiveCatalogTitle:(NSString*)value;




- (NSString*)primitiveCatalogURL;
- (void)setPrimitiveCatalogURL:(NSString*)value;




- (NSNumber*)primitiveCatalogURLCheckPending;
- (void)setPrimitiveCatalogURLCheckPending:(NSNumber*)value;

- (BOOL)primitiveCatalogURLCheckPendingValue;
- (void)setPrimitiveCatalogURLCheckPendingValue:(BOOL)value_;




- (NSString*)primitiveCatalogURLFromInstanceDefaultURL;
- (void)setPrimitiveCatalogURLFromInstanceDefaultURL:(NSString*)value;




- (NSNumber*)primitiveCatalogURLIsValid;
- (void)setPrimitiveCatalogURLIsValid:(NSNumber*)value;

- (BOOL)primitiveCatalogURLIsValidValue;
- (void)setPrimitiveCatalogURLIsValidValue:(BOOL)value_;




- (NSNumber*)primitiveCatalogURLStatusCode;
- (void)setPrimitiveCatalogURLStatusCode:(NSNumber*)value;

- (int32_t)primitiveCatalogURLStatusCodeValue;
- (void)setPrimitiveCatalogURLStatusCodeValue:(int32_t)value_;




- (NSNumber*)primitiveIsActive;
- (void)setPrimitiveIsActive:(NSNumber*)value;

- (BOOL)primitiveIsActiveValue;
- (void)setPrimitiveIsActiveValue:(BOOL)value_;





- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;



- (SIReposadoInstanceMO*)primitiveReposadoInstance;
- (void)setPrimitiveReposadoInstance:(SIReposadoInstanceMO*)value;



- (SISourceListItemMO*)primitiveSourceListItem;
- (void)setPrimitiveSourceListItem:(SISourceListItemMO*)value;


@end
