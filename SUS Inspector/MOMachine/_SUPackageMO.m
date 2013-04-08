// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUPackageMO.m instead.

#import "_SUPackageMO.h"

const struct SUPackageMOAttributes SUPackageMOAttributes = {
	.packageMetadataURL = @"packageMetadataURL",
	.packageSize = @"packageSize",
	.packageURL = @"packageURL",
};

const struct SUPackageMORelationships SUPackageMORelationships = {
	.product = @"product",
};

const struct SUPackageMOFetchedProperties SUPackageMOFetchedProperties = {
};

@implementation SUPackageMOID
@end

@implementation _SUPackageMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SUPackage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SUPackage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SUPackage" inManagedObjectContext:moc_];
}

- (SUPackageMOID*)objectID {
	return (SUPackageMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"packageSizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"packageSize"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic packageMetadataURL;






@dynamic packageSize;



- (int64_t)packageSizeValue {
	NSNumber *result = [self packageSize];
	return [result longLongValue];
}

- (void)setPackageSizeValue:(int64_t)value_ {
	[self setPackageSize:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitivePackageSizeValue {
	NSNumber *result = [self primitivePackageSize];
	return [result longLongValue];
}

- (void)setPrimitivePackageSizeValue:(int64_t)value_ {
	[self setPrimitivePackageSize:[NSNumber numberWithLongLong:value_]];
}





@dynamic packageURL;






@dynamic product;

	






@end
