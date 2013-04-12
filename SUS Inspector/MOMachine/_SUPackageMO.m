// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUPackageMO.m instead.

#import "_SUPackageMO.h"

const struct SUPackageMOAttributes SUPackageMOAttributes = {
	.packageCachedPath = @"packageCachedPath",
	.packageIsCached = @"packageIsCached",
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
	
	if ([key isEqualToString:@"packageIsCachedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"packageIsCached"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"packageSizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"packageSize"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic packageCachedPath;






@dynamic packageIsCached;



- (BOOL)packageIsCachedValue {
	NSNumber *result = [self packageIsCached];
	return [result boolValue];
}

- (void)setPackageIsCachedValue:(BOOL)value_ {
	[self setPackageIsCached:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePackageIsCachedValue {
	NSNumber *result = [self primitivePackageIsCached];
	return [result boolValue];
}

- (void)setPrimitivePackageIsCachedValue:(BOOL)value_ {
	[self setPrimitivePackageIsCached:[NSNumber numberWithBool:value_]];
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
