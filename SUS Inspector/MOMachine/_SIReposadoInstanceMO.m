// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIReposadoInstanceMO.m instead.

#import "_SIReposadoInstanceMO.h"

@implementation SIReposadoInstanceMOID
@end

@implementation _SIReposadoInstanceMO

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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
	[self setReposadoSetupComplete:@(value_)];
}

- (BOOL)primitiveReposadoSetupCompleteValue {
	NSNumber *result = [self primitiveReposadoSetupComplete];
	return [result boolValue];
}

- (void)setPrimitiveReposadoSetupCompleteValue:(BOOL)value_ {
	[self setPrimitiveReposadoSetupComplete:@(value_)];
}

@dynamic reposadoTitle;

@dynamic reposadoUpdatesMetadataDir;

@dynamic reposadoUpdatesRootDir;

@dynamic catalogs;

- (NSMutableSet<SICatalogMO*>*)catalogsSet {
	[self willAccessValueForKey:@"catalogs"];

	NSMutableSet<SICatalogMO*> *result = (NSMutableSet<SICatalogMO*>*)[self mutableSetValueForKey:@"catalogs"];

	[self didAccessValueForKey:@"catalogs"];
	return result;
}

@dynamic activeCatalogs;

@end

@implementation SIReposadoInstanceMOAttributes 
+ (NSString *)productInfoCreationDate {
	return @"productInfoCreationDate";
}
+ (NSString *)productInfoModificationDate {
	return @"productInfoModificationDate";
}
+ (NSString *)reposadoCatalogsBaseURLString {
	return @"reposadoCatalogsBaseURLString";
}
+ (NSString *)reposadoInstallURL {
	return @"reposadoInstallURL";
}
+ (NSString *)reposadoSetupComplete {
	return @"reposadoSetupComplete";
}
+ (NSString *)reposadoTitle {
	return @"reposadoTitle";
}
+ (NSString *)reposadoUpdatesMetadataDir {
	return @"reposadoUpdatesMetadataDir";
}
+ (NSString *)reposadoUpdatesRootDir {
	return @"reposadoUpdatesRootDir";
}
@end

@implementation SIReposadoInstanceMORelationships 
+ (NSString *)catalogs {
	return @"catalogs";
}
@end

@implementation SIReposadoInstanceMOFetchedProperties 
+ (NSString *)activeCatalogs {
	return @"activeCatalogs";
}
@end

