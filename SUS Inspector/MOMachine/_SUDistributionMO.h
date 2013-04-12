// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUDistributionMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SUDistributionMOAttributes {
	 NSString *distributionCachedPath;
	 NSString *distributionFileContents;
	 NSString *distributionIsCached;
	 NSString *distributionLanguage;
	 NSString *distributionURL;
} SUDistributionMOAttributes;

extern const struct SUDistributionMORelationships {
	 NSString *product;
} SUDistributionMORelationships;

extern const struct SUDistributionMOFetchedProperties {
} SUDistributionMOFetchedProperties;

@class SUProductMO;







@interface SUDistributionMOID : NSManagedObjectID {}
@end

@interface _SUDistributionMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SUDistributionMOID*)objectID;





@property (nonatomic, retain) NSString* distributionCachedPath;



//- (BOOL)validateDistributionCachedPath:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* distributionFileContents;



//- (BOOL)validateDistributionFileContents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* distributionIsCached;



@property BOOL distributionIsCachedValue;
- (BOOL)distributionIsCachedValue;
- (void)setDistributionIsCachedValue:(BOOL)value_;

//- (BOOL)validateDistributionIsCached:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* distributionLanguage;



//- (BOOL)validateDistributionLanguage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* distributionURL;



//- (BOOL)validateDistributionURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) SUProductMO *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@end

@interface _SUDistributionMO (CoreDataGeneratedAccessors)

@end

@interface _SUDistributionMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDistributionCachedPath;
- (void)setPrimitiveDistributionCachedPath:(NSString*)value;




- (NSString*)primitiveDistributionFileContents;
- (void)setPrimitiveDistributionFileContents:(NSString*)value;




- (NSNumber*)primitiveDistributionIsCached;
- (void)setPrimitiveDistributionIsCached:(NSNumber*)value;

- (BOOL)primitiveDistributionIsCachedValue;
- (void)setPrimitiveDistributionIsCachedValue:(BOOL)value_;




- (NSString*)primitiveDistributionLanguage;
- (void)setPrimitiveDistributionLanguage:(NSString*)value;




- (NSString*)primitiveDistributionURL;
- (void)setPrimitiveDistributionURL:(NSString*)value;





- (SUProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(SUProductMO*)value;


@end
