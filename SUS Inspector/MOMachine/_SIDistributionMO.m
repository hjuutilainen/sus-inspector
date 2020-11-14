// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDistributionMO.m instead.

#import "_SIDistributionMO.h"

@implementation SIDistributionMOID
@end

@implementation _SIDistributionMO

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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

@dynamic distributionLanguageDisplayName;

@dynamic product;

@end

@implementation SIDistributionMOAttributes 
+ (NSString *)distributionFileContents {
	return @"distributionFileContents";
}
+ (NSString *)distributionLanguage {
	return @"distributionLanguage";
}
+ (NSString *)distributionLanguageDisplayName {
	return @"distributionLanguageDisplayName";
}
@end

@implementation SIDistributionMORelationships 
+ (NSString *)product {
	return @"product";
}
@end

