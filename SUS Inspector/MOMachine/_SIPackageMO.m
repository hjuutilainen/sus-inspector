// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMO.m instead.

#import "_SIPackageMO.h"

const struct SIPackageMOAttributes SIPackageMOAttributes = {
	.packageCachedPath = @"packageCachedPath",
	.packageIsCached = @"packageIsCached",
	.packageMetadataURL = @"packageMetadataURL",
	.packageSize = @"packageSize",
	.packageURL = @"packageURL",
};

const struct SIPackageMORelationships SIPackageMORelationships = {
	.product = @"product",
};

const struct SIPackageMOFetchedProperties SIPackageMOFetchedProperties = {
};

@implementation SIPackageMOID
@end

@implementation _SIPackageMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SIPackage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SIPackage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SIPackage" inManagedObjectContext:moc_];
}

- (SIPackageMOID*)objectID {
	return (SIPackageMOID*)[super objectID];
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
