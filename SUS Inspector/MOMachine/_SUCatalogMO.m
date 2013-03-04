// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUCatalogMO.m instead.

#import "_SUCatalogMO.h"

const struct SUCatalogMOAttributes SUCatalogMOAttributes = {
	.catalogDescription = @"catalogDescription",
	.catalogTitle = @"catalogTitle",
	.catalogURL = @"catalogURL",
};

const struct SUCatalogMORelationships SUCatalogMORelationships = {
	.products = @"products",
	.reposadoInstance = @"reposadoInstance",
};

const struct SUCatalogMOFetchedProperties SUCatalogMOFetchedProperties = {
};

@implementation SUCatalogMOID
@end

@implementation _SUCatalogMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SUCatalog" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SUCatalog";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SUCatalog" inManagedObjectContext:moc_];
}

- (SUCatalogMOID*)objectID {
	return (SUCatalogMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic catalogDescription;






@dynamic catalogTitle;






@dynamic catalogURL;






@dynamic products;

	
- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];
  
	[self didAccessValueForKey:@"products"];
	return result;
}
	

@dynamic reposadoInstance;

	






@end
