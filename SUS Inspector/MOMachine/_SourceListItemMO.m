// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SourceListItemMO.m instead.

#import "_SourceListItemMO.h"

const struct SourceListItemMOAttributes SourceListItemMOAttributes = {
	.iconImage = @"iconImage",
	.iconName = @"iconName",
	.isGroupItem = @"isGroupItem",
	.sortIndex = @"sortIndex",
	.title = @"title",
};

const struct SourceListItemMORelationships SourceListItemMORelationships = {
	.catalogReference = @"catalogReference",
	.children = @"children",
	.parent = @"parent",
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
