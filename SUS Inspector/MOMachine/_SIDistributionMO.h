// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDistributionMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SIDistributionMOAttributes {
	 NSString *distributionCachedPath;
	 NSString *distributionFileContents;
	 NSString *distributionIsCached;
	 NSString *distributionLanguage;
	 NSString *distributionURL;
} SIDistributionMOAttributes;

extern const struct SIDistributionMORelationships {
	 NSString *product;
} SIDistributionMORelationships;

extern const struct SIDistributionMOFetchedProperties {
} SIDistributionMOFetchedProperties;

@class SIProductMO;







@interface SIDistributionMOID : NSManagedObjectID {}
@end

@interface _SIDistributionMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIDistributionMOID*)objectID;





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





@property (nonatomic, retain) SIProductMO *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@end

@interface _SIDistributionMO (CoreDataGeneratedAccessors)

@end

@interface _SIDistributionMO (CoreDataGeneratedPrimitiveAccessors)


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





- (SIProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(SIProductMO*)value;


@end
