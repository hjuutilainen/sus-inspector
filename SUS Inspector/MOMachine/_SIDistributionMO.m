// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDistributionMO.m instead.

#import "_SIDistributionMO.h"

const struct SIDistributionMOAttributes SIDistributionMOAttributes = {
	.distributionCachedPath = @"distributionCachedPath",
	.distributionFileContents = @"distributionFileContents",
	.distributionIsCached = @"distributionIsCached",
	.distributionLanguage = @"distributionLanguage",
	.distributionURL = @"distributionURL",
};

const struct SIDistributionMORelationships SIDistributionMORelationships = {
	.product = @"product",
};

const struct SIDistributionMOFetchedProperties SIDistributionMOFetchedProperties = {
};

@implementation SIDistributionMOID
@end

@implementation _SIDistributionMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SIDistribution" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SIDistribution";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SIDistribution" inManagedObjectContext:moc_];
}

- (SIDistributionMOID*)objectID {
	return (SIDistributionMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"distributionIsCachedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"distributionIsCached"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic distributionCachedPath;






@dynamic distributionFileContents;






@dynamic distributionIsCached;



- (BOOL)distributionIsCachedValue {
	NSNumber *result = [self distributionIsCached];
	return [result boolValue];
}

- (void)setDistributionIsCachedValue:(BOOL)value_ {
	[self setDistributionIsCached:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDistributionIsCachedValue {
	NSNumber *result = [self primitiveDistributionIsCached];
	return [result boolValue];
}

- (void)setPrimitiveDistributionIsCachedValue:(BOOL)value_ {
	[self setPrimitiveDistributionIsCached:[NSNumber numberWithBool:value_]];
}





@dynamic distributionLanguage;






@dynamic distributionURL;






@dynamic product;

	






@end
