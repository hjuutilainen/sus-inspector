// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SourceListItemMO.m instead.

#import "_SourceListItemMO.h"

const struct SourceListItemMOAttributes SourceListItemMOAttributes = {
	.isGroupItem = @"isGroupItem",
	.title = @"title",
};

const struct SourceListItemMORelationships SourceListItemMORelationships = {
	.children = @"children",
	.parent = @"parent",
	.products = @"products",
};

const struct SourceListItemMOFetchedProperties SourceListItemMOFetchedProperties = {
};

@implementation SourceListItemMOID
@end

@implementation _SourceListItemMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SourceListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SourceListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SourceListItem" inManagedObjectContext:moc_];
}

- (SourceListItemMOID*)objectID {
	return (SourceListItemMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isGroupItemValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isGroupItem"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic isGroupItem;



- (BOOL)isGroupItemValue {
	NSNumber *result = [self isGroupItem];
	return [result boolValue];
}

- (void)setIsGroupItemValue:(BOOL)value_ {
	[self setIsGroupItem:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsGroupItemValue {
	NSNumber *result = [self primitiveIsGroupItem];
	return [result boolValue];
}

- (void)setPrimitiveIsGroupItemValue:(BOOL)value_ {
	[self setPrimitiveIsGroupItem:[NSNumber numberWithBool:value_]];
}





@dynamic title;






@dynamic children;

	
- (NSMutableSet*)childrenSet {
	[self willAccessValueForKey:@"children"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"children"];
  
	[self didAccessValueForKey:@"children"];
	return result;
}
	

@dynamic parent;

	

@dynamic products;

	
- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];
  
	[self didAccessValueForKey:@"products"];
	return result;
}
	






@end
