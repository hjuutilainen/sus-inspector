// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIServerMetadataMO.m instead.

#import "_SIServerMetadataMO.h"

const struct SIServerMetadataMOAttributes SIServerMetadataMOAttributes = {
	.metadataFileContents = @"metadataFileContents",
};

const struct SIServerMetadataMORelationships SIServerMetadataMORelationships = {
	.product = @"product",
};

const struct SIServerMetadataMOFetchedProperties SIServerMetadataMOFetchedProperties = {
};

@implementation SIServerMetadataMOID
@end

@implementation _SIServerMetadataMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SIServerMetadata" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SIServerMetadata";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SIServerMetadata" inManagedObjectContext:moc_];
}

- (SIServerMetadataMOID*)objectID {
	return (SIServerMetadataMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic metadataFileContents;






@dynamic product;

	






@end
