// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUCatalogMO.h instead.

#import <CoreData/CoreData.h>
#import "SourceListItemMO.h"

extern const struct SUCatalogMOAttributes {
	 NSString *catalogDescription;
	 NSString *catalogOSVersion;
	 NSString *catalogTitle;
	 NSString *catalogURL;
} SUCatalogMOAttributes;

extern const struct SUCatalogMORelationships {
	 NSString *reposadoInstance;
} SUCatalogMORelationships;

extern const struct SUCatalogMOFetchedProperties {
} SUCatalogMOFetchedProperties;

@class ReposadoInstanceMO;




@class NSObject;

@interface SUCatalogMOID : NSManagedObjectID {}
@end

@interface _SUCatalogMO : SourceListItemMO {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SUCatalogMOID*)objectID;





@property (nonatomic, retain) NSString* catalogDescription;



//- (BOOL)validateCatalogDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogOSVersion;



//- (BOOL)validateCatalogOSVersion:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* catalogTitle;



//- (BOOL)validateCatalogTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) id catalogURL;



//- (BOOL)validateCatalogURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) ReposadoInstanceMO *reposadoInstance;

//- (BOOL)validateReposadoInstance:(id*)value_ error:(NSError**)error_;





@end

@interface _SUCatalogMO (CoreDataGeneratedAccessors)

@end

@interface _SUCatalogMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCatalogDescription;
- (void)setPrimitiveCatalogDescription:(NSString*)value;




- (NSString*)primitiveCatalogOSVersion;
- (void)setPrimitiveCatalogOSVersion:(NSString*)value;




- (NSString*)primitiveCatalogTitle;
- (void)setPrimitiveCatalogTitle:(NSString*)value;




- (id)primitiveCatalogURL;
- (void)setPrimitiveCatalogURL:(id)value;





- (ReposadoInstanceMO*)primitiveReposadoInstance;
- (void)setPrimitiveReposadoInstance:(ReposadoInstanceMO*)value;


@end
