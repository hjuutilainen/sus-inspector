// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUPackageMO.h instead.

#import <CoreData/CoreData.h>


extern const struct SUPackageMOAttributes {
	 NSString *packageMetadataURL;
	 NSString *packageSize;
	 NSString *packageURL;
} SUPackageMOAttributes;

extern const struct SUPackageMORelationships {
	 NSString *product;
} SUPackageMORelationships;

extern const struct SUPackageMOFetchedProperties {
} SUPackageMOFetchedProperties;

@class SUProductMO;





@interface SUPackageMOID : NSManagedObjectID {}
@end

@interface _SUPackageMO : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SUPackageMOID*)objectID;





@property (nonatomic, retain) NSString* packageMetadataURL;



//- (BOOL)validatePackageMetadataURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* packageSize;



@property int64_t packageSizeValue;
- (int64_t)packageSizeValue;
- (void)setPackageSizeValue:(int64_t)value_;

//- (BOOL)validatePackageSize:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* packageURL;



//- (BOOL)validatePackageURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) SUProductMO *product;

//- (BOOL)validateProduct:(id*)value_ error:(NSError**)error_;





@end

@interface _SUPackageMO (CoreDataGeneratedAccessors)

@end

@interface _SUPackageMO (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePackageMetadataURL;
- (void)setPrimitivePackageMetadataURL:(NSString*)value;




- (NSNumber*)primitivePackageSize;
- (void)setPrimitivePackageSize:(NSNumber*)value;

- (int64_t)primitivePackageSizeValue;
- (void)setPrimitivePackageSizeValue:(int64_t)value_;




- (NSString*)primitivePackageURL;
- (void)setPrimitivePackageURL:(NSString*)value;





- (SUProductMO*)primitiveProduct;
- (void)setPrimitiveProduct:(SUProductMO*)value;


@end
