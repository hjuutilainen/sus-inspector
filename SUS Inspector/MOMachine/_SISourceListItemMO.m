// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SISourceListItemMO.m instead.

#import "_SISourceListItemMO.h"

const struct SISourceListItemMOAttributes SISourceListItemMOAttributes = {
	.iconImage = @"iconImage",
	.iconName = @"iconName",
	.isGroupItem = @"isGroupItem",
	.sortIndex = @"sortIndex",
	.title = @"title",
};

const struct SISourceListItemMORelationships SISourceListItemMORelationships = {
	.catalogReference = @"catalogReference",
	.children = @"children",
	.parent = @"parent",
};

const struct SISourceListItemMOFetchedProperties SISourceListItemMOFetchedProperties = {
};

@implementation SISourceListItemMOID
@end

@implementation _SISourceListItemMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SISourceListItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SISourceListItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SISourceListItem" inManagedObjectContext:moc_];
}

- (SISourceListItemMOID*)objectID {
	return (SISourceListItemMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"isGroupItemValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isGroupItem"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"sortIndexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sortIndex"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic iconImage;






@dynamic iconName;






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





@dynamic sortIndex;



- (int32_t)sortIndexValue {
	NSNumber *result = [self sortIndex];
	return [result intValue];
}

- (void)setSortIndexValue:(int32_t)value_ {
	[self setSortIndex:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveSortIndexValue {
	NSNumber *result = [self primitiveSortIndex];
	return [result intValue];
}

- (void)setPrimitiveSortIndexValue:(int32_t)value_ {
	[self setPrimitiveSortIndex:[NSNumber numberWithInt:value_]];
}





@dynamic title;






@dynamic catalogReference;

	

@dynamic children;

	
- (NSMutableSet*)childrenSet {
	[self willAccessValueForKey:@"children"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"children"];
  
	[self didAccessValueForKey:@"children"];
	return result;
}
	

@dynamic parent;

	






@end
