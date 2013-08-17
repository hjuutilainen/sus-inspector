// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMetadataMO.h instead.

#import <CoreData/CoreData.h>
#import "SIDownloadableObject.h"

extern const struct SIPackageMetadataMOAttributes {
	__unsafe_unretained NSString *metadataFileContents;
} SIPackageMetadataMOAttributes;

extern const struct SIPackageMetadataMORelationships {
	__unsafe_unretained NSString *package;
} SIPackageMetadataMORelationships;

extern const struct SIPackageMetadataMOFetchedProperties {
} SIPackageMetadataMOFetchedProperties;

@class SIPackageMO;



@interface SIPackageMetadataMOID : NSManagedObjectID {}
@end

@interface _SIPackageMetadataMO : SIDownloadableObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIPackageMetadataMOID*)objectID;





@property (nonatomic, strong) NSString* metadataFileContents;



//- (BOOL)validateMetadataFileContents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SIPackageMO *package;

//- (BOOL)validatePackage:(id*)value_ error:(NSError**)error_;





@end

@interface _SIPackageMetadataMO (CoreDataGeneratedAccessors)

@end

@interface _SIPackageMetadataMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveMetadataFileContents;
- (void)setPrimitiveMetadataFileContents:(NSString*)value;





- (SIPackageMO*)primitivePackage;
- (void)setPrimitivePackage:(SIPackageMO*)value;


@end
