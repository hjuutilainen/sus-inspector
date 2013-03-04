// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUProductMO.m instead.

#import "_SUProductMO.h"

const struct SUProductMOAttributes SUProductMOAttributes = {
	.productDescription = @"productDescription",
	.productID = @"productID",
	.productPostDate = @"productPostDate",
	.productSize = @"productSize",
	.productTitle = @"productTitle",
	.productVersion = @"productVersion",
};

const struct SUProductMORelationships SUProductMORelationships = {
	.catalogs = @"catalogs",
};

const struct SUProductMOFetchedProperties SUProductMOFetchedProperties = {
};

@implementation SUProductMOID
@end

@implementation _SUProductMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SUProduct" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SUProduct";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SUProduct" inManagedObjectContext:moc_];
}

- (SUProductMOID*)objectID {
	return (SUProductMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"productSizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"productSize"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic productDescription;






@dynamic productID;






@dynamic productPostDate;






@dynamic productSize;



- (int64_t)productSizeValue {
	NSNumber *result = [self productSize];
	return [result longLongValue];
}

- (void)setProductSizeValue:(int64_t)value_ {
	[self setProductSize:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveProductSizeValue {
	NSNumber *result = [self primitiveProductSize];
	return [result longLongValue];
}

- (void)setPrimitiveProductSizeValue:(int64_t)value_ {
	[self setPrimitiveProductSize:[NSNumber numberWithLongLong:value_]];
}





@dynamic productTitle;






@dynamic productVersion;






@dynamic catalogs;

	
- (NSMutableSet*)catalogsSet {
	[self willAccessValueForKey:@"catalogs"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"catalogs"];
  
	[self didAccessValueForKey:@"catalogs"];
	return result;
}
	






@end
