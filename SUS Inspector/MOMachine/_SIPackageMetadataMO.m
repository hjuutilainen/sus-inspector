// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIPackageMetadataMO.m instead.

#import "_SIPackageMetadataMO.h"

@implementation SIPackageMetadataMOID
@end

@implementation _SIPackageMetadataMO

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SIPackageMetadata" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SIPackageMetadata";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SIPackageMetadata" inManagedObjectContext:moc_];
}

- (SIPackageMetadataMOID*)objectID {
	return (SIPackageMetadataMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic metadataFileContents;

@dynamic package;

@end

@implementation SIPackageMetadataMOAttributes 
+ (NSString *)metadataFileContents {
	return @"metadataFileContents";
}
@end

@implementation SIPackageMetadataMORelationships 
+ (NSString *)package {
	return @"package";
}
@end

