// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDistributionMO.h instead.

#import <CoreData/CoreData.h>
#import "SIDownloadableObject.h"

extern const struct SIDistributionMOAttributes {
	__unsafe_unretained NSString *distributionFileContents;
	__unsafe_unretained NSString *distributionLanguage;
	__unsafe_unretained NSString *distributionLanguageDisplayName;
} SIDistributionMOAttributes;

extern const struct SIDistributionMORelationships {
	__unsafe_unretained NSString *product;
} SIDistributionMORelationships;

extern const struct SIDistributionMOFetchedProperties {
} SIDistributionMOFetchedProperties;

@class SIProductMO;





@interface SIDistributionMOID : NSManagedObjectID {}
@end

@interface _SIDistributionMO : SIDownloadableObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIDistributionMOID*)objectID;





@property (nonatomic, strong) NSString* distributionFileContents;



//- (BOOL)validateDistributionFileContents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* distributionLanguage;



//- (BOOL)validateDistributionLanguage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* distributionLanguageDisplayName;



//- (BOOL)validateDistributionLanguageDisplayName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SIProductMO *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@end

@interface _SIDistributionMO (CoreDataGeneratedAccessors)

@end

@interface _SIDistributionMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDistributionFileContents;
- (void)setPrimitiveDistributionFileContents:(NSString*)value;




- (NSString*)primitiveDistributionLanguage;
- (void)setPrimitiveDistributionLanguage:(NSString*)value;




- (NSString*)primitiveDistributionLanguageDisplayName;
- (void)setPrimitiveDistributionLanguageDisplayName:(NSString*)value;





- (SIProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(SIProductMO*)value;


@end
