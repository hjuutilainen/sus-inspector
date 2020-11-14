// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SICatalogMO.m instead.

#import "_SICatalogMO.h"

@implementation SICatalogMOID
@end

@implementation _SICatalogMO

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SICatalog" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SICatalog";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SICatalog" inManagedObjectContext:moc_];
}

- (SICatalogMOID*)objectID {
	return (SICatalogMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"allowRemoveValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"allowRemove"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"catalogURLCheckPendingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"catalogURLCheckPending"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"catalogURLIsValidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"catalogURLIsValid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"catalogURLStatusCodeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"catalogURLStatusCode"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isActiveValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isActive"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic allowRemove;

- (BOOL)allowRemoveValue {
	NSNumber *result = [self allowRemove];
	return [result boolValue];
}

- (void)setAllowRemoveValue:(BOOL)value_ {
	[self setAllowRemove:@(value_)];
}

- (BOOL)primitiveAllowRemoveValue {
	NSNumber *result = [self primitiveAllowRemove];
	return [result boolValue];
}

- (void)setPrimitiveAllowRemoveValue:(BOOL)value_ {
	[self setPrimitiveAllowRemove:@(value_)];
}

@dynamic catalogDescription;

@dynamic catalogDisplayName;

@dynamic catalogFileURL;

@dynamic catalogOSVersion;

@dynamic catalogTitle;

@dynamic catalogURL;

@dynamic catalogURLCheckPending;

- (BOOL)catalogURLCheckPendingValue {
	NSNumber *result = [self catalogURLCheckPending];
	return [result boolValue];
}

- (void)setCatalogURLCheckPendingValue:(BOOL)value_ {
	[self setCatalogURLCheckPending:@(value_)];
}

- (BOOL)primitiveCatalogURLCheckPendingValue {
	NSNumber *result = [self primitiveCatalogURLCheckPending];
	return [result boolValue];
}

- (void)setPrimitiveCatalogURLCheckPendingValue:(BOOL)value_ {
	[self setPrimitiveCatalogURLCheckPending:@(value_)];
}

@dynamic catalogURLFromInstanceDefaultURL;

@dynamic catalogURLIsValid;

- (BOOL)catalogURLIsValidValue {
	NSNumber *result = [self catalogURLIsValid];
	return [result boolValue];
}

- (void)setCatalogURLIsValidValue:(BOOL)value_ {
	[self setCatalogURLIsValid:@(value_)];
}

- (BOOL)primitiveCatalogURLIsValidValue {
	NSNumber *result = [self primitiveCatalogURLIsValid];
	return [result boolValue];
}

- (void)setPrimitiveCatalogURLIsValidValue:(BOOL)value_ {
	[self setPrimitiveCatalogURLIsValid:@(value_)];
}

@dynamic catalogURLStatusCode;

- (int32_t)catalogURLStatusCodeValue {
	NSNumber *result = [self catalogURLStatusCode];
	return [result intValue];
}

- (void)setCatalogURLStatusCodeValue:(int32_t)value_ {
	[self setCatalogURLStatusCode:@(value_)];
}

- (int32_t)primitiveCatalogURLStatusCodeValue {
	NSNumber *result = [self primitiveCatalogURLStatusCode];
	return [result intValue];
}

- (void)setPrimitiveCatalogURLStatusCodeValue:(int32_t)value_ {
	[self setPrimitiveCatalogURLStatusCode:@(value_)];
}

@dynamic isActive;

- (BOOL)isActiveValue {
	NSNumber *result = [self isActive];
	return [result boolValue];
}

- (void)setIsActiveValue:(BOOL)value_ {
	[self setIsActive:@(value_)];
}

- (BOOL)primitiveIsActiveValue {
	NSNumber *result = [self primitiveIsActive];
	return [result boolValue];
}

- (void)setPrimitiveIsActiveValue:(BOOL)value_ {
	[self setPrimitiveIsActive:@(value_)];
}

@dynamic products;

- (NSMutableSet<SIProductMO*>*)productsSet {
	[self willAccessValueForKey:@"products"];

	NSMutableSet<SIProductMO*> *result = (NSMutableSet<SIProductMO*>*)[self mutableSetValueForKey:@"products"];

	[self didAccessValueForKey:@"products"];
	return result;
}

@dynamic reposadoInstance;

@dynamic sourceListItem;

@end

@implementation SICatalogMOAttributes 
+ (NSString *)allowRemove {
	return @"allowRemove";
}
+ (NSString *)catalogDescription {
	return @"catalogDescription";
}
+ (NSString *)catalogDisplayName {
	return @"catalogDisplayName";
}
+ (NSString *)catalogFileURL {
	return @"catalogFileURL";
}
+ (NSString *)catalogOSVersion {
	return @"catalogOSVersion";
}
+ (NSString *)catalogTitle {
	return @"catalogTitle";
}
+ (NSString *)catalogURL {
	return @"catalogURL";
}
+ (NSString *)catalogURLCheckPending {
	return @"catalogURLCheckPending";
}
+ (NSString *)catalogURLFromInstanceDefaultURL {
	return @"catalogURLFromInstanceDefaultURL";
}
+ (NSString *)catalogURLIsValid {
	return @"catalogURLIsValid";
}
+ (NSString *)catalogURLStatusCode {
	return @"catalogURLStatusCode";
}
+ (NSString *)isActive {
	return @"isActive";
}
@end

@implementation SICatalogMORelationships 
+ (NSString *)products {
	return @"products";
}
+ (NSString *)reposadoInstance {
	return @"reposadoInstance";
}
+ (NSString *)sourceListItem {
	return @"sourceListItem";
}
@end

