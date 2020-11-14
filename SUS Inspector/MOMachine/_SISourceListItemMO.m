// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SISourceListItemMO.m instead.

#import "_SISourceListItemMO.h"

@implementation SISourceListItemMOID
@end

@implementation _SISourceListItemMO

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
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
	[self setIsGroupItem:@(value_)];
}

- (BOOL)primitiveIsGroupItemValue {
	NSNumber *result = [self primitiveIsGroupItem];
	return [result boolValue];
}

- (void)setPrimitiveIsGroupItemValue:(BOOL)value_ {
	[self setPrimitiveIsGroupItem:@(value_)];
}

@dynamic productFilterPredicate;

@dynamic sortIndex;

- (int32_t)sortIndexValue {
	NSNumber *result = [self sortIndex];
	return [result intValue];
}

- (void)setSortIndexValue:(int32_t)value_ {
	[self setSortIndex:@(value_)];
}

- (int32_t)primitiveSortIndexValue {
	NSNumber *result = [self primitiveSortIndex];
	return [result intValue];
}

- (void)setPrimitiveSortIndexValue:(int32_t)value_ {
	[self setPrimitiveSortIndex:@(value_)];
}

@dynamic title;

@dynamic catalogReference;

@dynamic children;

- (NSMutableSet<SISourceListItemMO*>*)childrenSet {
	[self willAccessValueForKey:@"children"];

	NSMutableSet<SISourceListItemMO*> *result = (NSMutableSet<SISourceListItemMO*>*)[self mutableSetValueForKey:@"children"];

	[self didAccessValueForKey:@"children"];
	return result;
}

@dynamic parent;

@end

@implementation SISourceListItemMOAttributes 
+ (NSString *)iconImage {
	return @"iconImage";
}
+ (NSString *)iconName {
	return @"iconName";
}
+ (NSString *)isGroupItem {
	return @"isGroupItem";
}
+ (NSString *)productFilterPredicate {
	return @"productFilterPredicate";
}
+ (NSString *)sortIndex {
	return @"sortIndex";
}
+ (NSString *)title {
	return @"title";
}
@end

@implementation SISourceListItemMORelationships 
+ (NSString *)catalogReference {
	return @"catalogReference";
}
+ (NSString *)children {
	return @"children";
}
+ (NSString *)parent {
	return @"parent";
}
@end

