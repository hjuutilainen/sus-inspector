// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIReposadoInstanceMO.m instead.

#import "_SIReposadoInstanceMO.h"

const struct SIReposadoInstanceMOAttributes SIReposadoInstanceMOAttributes = {
	.productInfoCreationDate = @"productInfoCreationDate",
	.productInfoModificationDate = @"productInfoModificationDate",
	.reposadoCatalogsBaseURLString = @"reposadoCatalogsBaseURLString",
	.reposadoInstallURL = @"reposadoInstallURL",
	.reposadoSetupComplete = @"reposadoSetupComplete",
	.reposadoTitle = @"reposadoTitle",
	.reposadoUpdatesMetadataDir = @"reposadoUpdatesMetadataDir",
	.reposadoUpdatesRootDir = @"reposadoUpdatesRootDir",
};

const struct SIReposadoInstanceMORelationships SIReposadoInstanceMORelationships = {
	.catalogs = @"catalogs",
};

const struct SIReposadoInstanceMOFetchedProperties SIReposadoInstanceMOFetchedProperties = {
	.activeCatalogs = @"activeCatalogs",
};

@implementation SIReposadoInstanceMOID
@end

@implementation _SIReposadoInstanceMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SIReposadoInstance" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SIReposadoInstance";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SIReposadoInstance" inManagedObjectContext:moc_];
}

- (SIReposadoInstanceMOID*)objectID {
	return (SIReposadoInstanceMOID*)[super objectID];
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
