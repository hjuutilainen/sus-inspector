// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ReposadoInstanceMO.m instead.

#import "_ReposadoInstanceMO.h"

const struct ReposadoInstanceMOAttributes ReposadoInstanceMOAttributes = {
	.productInfoCreationDate = @"productInfoCreationDate",
	.productInfoModificationDate = @"productInfoModificationDate",
	.reposadoCatalogsBaseURLString = @"reposadoCatalogsBaseURLString",
	.reposadoInstallURL = @"reposadoInstallURL",
	.reposadoSetupComplete = @"reposadoSetupComplete",
	.reposadoTitle = @"reposadoTitle",
	.reposadoUpdatesMetadataDir = @"reposadoUpdatesMetadataDir",
	.reposadoUpdatesRootDir = @"reposadoUpdatesRootDir",
};

const struct ReposadoInstanceMORelationships ReposadoInstanceMORelationships = {
	.catalogs = @"catalogs",
};

const struct ReposadoInstanceMOFetchedProperties ReposadoInstanceMOFetchedProperties = {
	.activeCatalogs = @"activeCatalogs",
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
	
	if ([key isEqualToString:@"reposadoSetupCompleteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reposadoSetupComplete"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic productInfoCreationDate;






@dynamic productInfoModificationDate;






@dynamic reposadoCatalogsBaseURLString;






@dynamic reposadoInstallURL;






@dynamic reposadoSetupComplete;



- (BOOL)reposadoSetupCompleteValue {
	NSNumber *result = [self reposadoSetupComplete];
	return [result boolValue];
}

- (void)setReposadoSetupCompleteValue:(BOOL)value_ {
	[self setReposadoSetupComplete:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveReposadoSetupCompleteValue {
	NSNumber *result = [self primitiveReposadoSetupComplete];
	return [result boolValue];
}

- (void)setPrimitiveReposadoSetupCompleteValue:(BOOL)value_ {
	[self setPrimitiveReposadoSetupComplete:[NSNumber numberWithBool:value_]];
}





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
	



@dynamic activeCatalogs;




@end
