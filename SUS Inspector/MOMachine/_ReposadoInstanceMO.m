// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ReposadoInstanceMO.m instead.

#import "_ReposadoInstanceMO.h"

const struct ReposadoInstanceMOAttributes ReposadoInstanceMOAttributes = {
	.productInfoCreationDate = @"productInfoCreationDate",
	.productInfoModificationDate = @"productInfoModificationDate",
	.reposadoInstallURL = @"reposadoInstallURL",
	.reposadoTitle = @"reposadoTitle",
	.reposadoUpdatesMetadataDir = @"reposadoUpdatesMetadataDir",
	.reposadoUpdatesRootDir = @"reposadoUpdatesRootDir",
};

const struct ReposadoInstanceMORelationships ReposadoInstanceMORelationships = {
	.catalogs = @"catalogs",
};

const struct ReposadoInstanceMOFetchedProperties ReposadoInstanceMOFetchedProperties = {
};

@implementation ReposadoInstanceMOID
@end

@implementation _ReposadoInstanceMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ReposadoInstance" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ReposadoInstance";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ReposadoInstance" inManagedObjectContext:moc_];
}

- (ReposadoInstanceMOID*)objectID {
	return (ReposadoInstanceMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic productInfoCreationDate;






@dynamic productInfoModificationDate;






@dynamic reposadoInstallURL;






@dynamic reposadoTitle;






@dynamic reposadoUpdatesMetadataDir;






@dynamic reposadoUpdatesRootDir;






@dynamic catalogs;

	
- (NSMutableSet*)catalogsSet {
	[self willAccessValueForKey:@"catalogs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"catalogs"];
  
	[self didAccessValueForKey:@"catalogs"];
	return result;
}
	






@end
