// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SICatalogMO.m instead.

#import "_SICatalogMO.h"

const struct SICatalogMOAttributes SICatalogMOAttributes = {
	.allowRemove = @"allowRemove",
	.catalogDescription = @"catalogDescription",
	.catalogDisplayName = @"catalogDisplayName",
	.catalogFileURL = @"catalogFileURL",
	.catalogOSVersion = @"catalogOSVersion",
	.catalogTitle = @"catalogTitle",
	.catalogURL = @"catalogURL",
	.catalogURLCheckPending = @"catalogURLCheckPending",
	.catalogURLFromInstanceDefaultURL = @"catalogURLFromInstanceDefaultURL",
	.catalogURLIsValid = @"catalogURLIsValid",
	.catalogURLStatusCode = @"catalogURLStatusCode",
	.isActive = @"isActive",
};

const struct SICatalogMORelationships SICatalogMORelationships = {
	.products = @"products",
	.reposadoInstance = @"reposadoInstance",
	.sourceListItem = @"sourceListItem",
};

const struct SICatalogMOFetchedProperties SICatalogMOFetchedProperties = {
};

@implementation SICatalogMOID
@end

@implementation _SICatalogMO

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
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
	[self setAllowRemove:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAllowRemoveValue {
	NSNumber *result = [self primitiveAllowRemove];
	return [result boolValue];
}

- (void)setPrimitiveAllowRemoveValue:(BOOL)value_ {
	[self setPrimitiveAllowRemove:[NSNumber numberWithBool:value_]];
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
	[self setCatalogURLCheckPending:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCatalogURLCheckPendingValue {
	NSNumber *result = [self primitiveCatalogURLCheckPending];
	return [result boolValue];
}

- (void)setPrimitiveCatalogURLCheckPendingValue:(BOOL)value_ {
	[self setPrimitiveCatalogURLCheckPending:[NSNumber numberWithBool:value_]];
}





@dynamic catalogURLFromInstanceDefaultURL;






@dynamic catalogURLIsValid;



- (BOOL)catalogURLIsValidValue {
	NSNumber *result = [self catalogURLIsValid];
	return [result boolValue];
}

- (void)setCatalogURLIsValidValue:(BOOL)value_ {
	[self setCatalogURLIsValid:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCatalogURLIsValidValue {
	NSNumber *result = [self primitiveCatalogURLIsValid];
	return [result boolValue];
}

- (void)setPrimitiveCatalogURLIsValidValue:(BOOL)value_ {
	[self setPrimitiveCatalogURLIsValid:[NSNumber numberWithBool:value_]];
}





@dynamic catalogURLStatusCode;



- (int32_t)catalogURLStatusCodeValue {
	NSNumber *result = [self catalogURLStatusCode];
	return [result intValue];
}

- (void)setCatalogURLStatusCodeValue:(int32_t)value_ {
	[self setCatalogURLStatusCode:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveCatalogURLStatusCodeValue {
	NSNumber *result = [self primitiveCatalogURLStatusCode];
	return [result intValue];
}

- (void)setPrimitiveCatalogURLStatusCodeValue:(int32_t)value_ {
	[self setPrimitiveCatalogURLStatusCode:[NSNumber numberWithInt:value_]];
}





@dynamic isActive;



- (BOOL)isActiveValue {
	NSNumber *result = [self isActive];
	return [result boolValue];
}

- (void)setIsActiveValue:(BOOL)value_ {
	[self setIsActive:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsActiveValue {
	NSNumber *result = [self primitiveIsActive];
	return [result boolValue];
}

- (void)setPrimitiveIsActiveValue:(BOOL)value_ {
	[self setPrimitiveIsActive:[NSNumber numberWithBool:value_]];
}





@dynamic products;

	
- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];
  
	[self didAccessValueForKey:@"products"];
	return result;
}
	

@dynamic reposadoInstance;

	

@dynamic sourceListItem;

	






@end
