// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIReposadoInstanceMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SIReposadoInstanceMOAttributes {
	 NSString *productInfoCreationDate;
	 NSString *productInfoModificationDate;
	 NSString *reposadoCatalogsBaseURLString;
	 NSString *reposadoInstallURL;
	 NSString *reposadoSetupComplete;
	 NSString *reposadoTitle;
	 NSString *reposadoUpdatesMetadataDir;
	 NSString *reposadoUpdatesRootDir;
} SIReposadoInstanceMOAttributes;

extern const struct SIReposadoInstanceMORelationships {
	 NSString *catalogs;
} SIReposadoInstanceMORelationships;

extern const struct SIReposadoInstanceMOFetchedProperties {
	 NSString *activeCatalogs;
} SIReposadoInstanceMOFetchedProperties;

@class SICatalogMO;




@class NSObject;





@interface SIReposadoInstanceMOID : NSManagedObjectID {}
@end

@interface _SIReposadoInstanceMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIReposadoInstanceMOID*)objectID;





@property (nonatomic, retain) NSDate* productInfoCreationDate;



//- (BOOL)validateProductInfoCreationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSDate* productInfoModificationDate;



//- (BOOL)validateProductInfoModificationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* reposadoCatalogsBaseURLString;



//- (BOOL)validateReposadoCatalogsBaseURLString:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) id reposadoInstallURL;



//- (BOOL)validateReposadoInstallURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* reposadoSetupComplete;



@property BOOL reposadoSetupCompleteValue;
- (BOOL)reposadoSetupCompleteValue;
- (void)setReposadoSetupCompleteValue:(BOOL)value_;

//- (BOOL)validateReposadoSetupComplete:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* reposadoTitle;



//- (BOOL)validateReposadoTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* reposadoUpdatesMetadataDir;



//- (BOOL)validateReposadoUpdatesMetadataDir:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* reposadoUpdatesRootDir;



//- (BOOL)validateReposadoUpdatesRootDir:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet *catalogs;

- (NSMutableSet*)catalogsSet;




@property (nonatomic, readonly) NSArray *activeCatalogs;


@end

@interface _SIReposadoInstanceMO (CoreDataGeneratedAccessors)

- (void)addCatalogs:(NSSet*)value_;
- (void)removeCatalogs:(NSSet*)value_;
- (void)addCatalogsObject:(SICatalogMO*)value_;
- (void)removeCatalogsObject:(SICatalogMO*)value_;

@end

@interface _SIReposadoInstanceMO (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveProductInfoCreationDate;
- (void)setPrimitiveProductInfoCreationDate:(NSDate*)value;




- (NSDate*)primitiveProductInfoModificationDate;
- (void)setPrimitiveProductInfoModificationDate:(NSDate*)value;




- (NSString*)primitiveReposadoCatalogsBaseURLString;
- (void)setPrimitiveReposadoCatalogsBaseURLString:(NSString*)value;




- (id)primitiveReposadoInstallURL;
- (void)setPrimitiveReposadoInstallURL:(id)value;




- (NSNumber*)primitiveReposadoSetupComplete;
- (void)setPrimitiveReposadoSetupComplete:(NSNumber*)value;

- (BOOL)primitiveReposadoSetupCompleteValue;
- (void)setPrimitiveReposadoSetupCompleteValue:(BOOL)value_;




- (NSString*)primitiveReposadoTitle;
- (void)setPrimitiveReposadoTitle:(NSString*)value;




- (NSString*)primitiveReposadoUpdatesMetadataDir;
- (void)setPrimitiveReposadoUpdatesMetadataDir:(NSString*)value;




- (NSString*)primitiveReposadoUpdatesRootDir;
- (void)setPrimitiveReposadoUpdatesRootDir:(NSString*)value;





- (NSMutableSet*)primitiveCatalogs;
- (void)setPrimitiveCatalogs:(NSMutableSet*)value;


@end
