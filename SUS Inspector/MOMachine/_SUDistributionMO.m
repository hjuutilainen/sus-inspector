// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUDistributionMO.m instead.

#import "_SUDistributionMO.h"

const struct SUDistributionMOAttributes SUDistributionMOAttributes = {
	.distributionCachedPath = @"distributionCachedPath",
	.distributionFileContents = @"distributionFileContents",
	.distributionIsCached = @"distributionIsCached",
	.distributionLanguage = @"distributionLanguage",
	.distributionURL = @"distributionURL",
};

const struct SUDistributionMORelationships SUDistributionMORelationships = {
	.product = @"product",
};

const struct SUDistributionMOFetchedProperties SUDistributionMOFetchedProperties = {
};

@implementation SUDistributionMOID
@end

@implementation _SUDistributionMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SUDistribution" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SUDistribution";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SUDistribution" inManagedObjectContext:moc_];
}

- (SUDistributionMOID*)objectID {
	return (SUDistributionMOID*)[super objectID];
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
