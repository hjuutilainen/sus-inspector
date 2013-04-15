// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMO.m instead.

#import "_SIPackageMO.h"

const struct SIPackageMOAttributes SIPackageMOAttributes = {
	.packageMetadataURL = @"packageMetadataURL",
	.packageSize = @"packageSize",
};

const struct SIPackageMORelationships SIPackageMORelationships = {
	.metadata = @"metadata",
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





@dynamic metadata;

	

@dynamic product;

	






@end
