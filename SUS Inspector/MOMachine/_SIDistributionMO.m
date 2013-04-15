// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDistributionMO.m instead.

#import "_SIDistributionMO.h"

const struct SIDistributionMOAttributes SIDistributionMOAttributes = {
	.distributionFileContents = @"distributionFileContents",
	.distributionLanguage = @"distributionLanguage",
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
	

	return keyPaths;
}




@dynamic distributionFileContents;






@dynamic distributionLanguage;






@dynamic product;

	






@end
