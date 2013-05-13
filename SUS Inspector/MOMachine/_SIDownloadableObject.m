// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDownloadableObject.m instead.

#import "_SIDownloadableObject.h"

const struct SIDownloadableObjectAttributes SIDownloadableObjectAttributes = {
	.objectCachedPath = @"objectCachedPath",
	.objectIsCached = @"objectIsCached",
	.objectIsDownloading = @"objectIsDownloading",
	.objectURL = @"objectURL",
	.performPostDownloadAction = @"performPostDownloadAction",
};

const struct SIDownloadableObjectRelationships SIDownloadableObjectRelationships = {
};

const struct SIDownloadableObjectFetchedProperties SIDownloadableObjectFetchedProperties = {
};

@implementation SIDownloadableObjectID
@end

@implementation _SIDownloadableObject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SIDownloadableObject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SIDownloadableObject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SIDownloadableObject" inManagedObjectContext:moc_];
}

- (SIDownloadableObjectID*)objectID {
	return (SIDownloadableObjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"objectIsCachedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"objectIsCached"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"objectIsDownloadingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"objectIsDownloading"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"performPostDownloadActionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"performPostDownloadAction"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic objectCachedPath;






@dynamic objectIsCached;



- (BOOL)objectIsCachedValue {
	NSNumber *result = [self objectIsCached];
	return [result boolValue];
}

- (void)setObjectIsCachedValue:(BOOL)value_ {
	[self setObjectIsCached:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveObjectIsCachedValue {
	NSNumber *result = [self primitiveObjectIsCached];
	return [result boolValue];
}

- (void)setPrimitiveObjectIsCachedValue:(BOOL)value_ {
	[self setPrimitiveObjectIsCached:[NSNumber numberWithBool:value_]];
}





@dynamic objectIsDownloading;



- (BOOL)objectIsDownloadingValue {
	NSNumber *result = [self objectIsDownloading];
	return [result boolValue];
}

- (void)setObjectIsDownloadingValue:(BOOL)value_ {
	[self setObjectIsDownloading:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveObjectIsDownloadingValue {
	NSNumber *result = [self primitiveObjectIsDownloading];
	return [result boolValue];
}

- (void)setPrimitiveObjectIsDownloadingValue:(BOOL)value_ {
	[self setPrimitiveObjectIsDownloading:[NSNumber numberWithBool:value_]];
}





@dynamic objectURL;






@dynamic performPostDownloadAction;



- (BOOL)performPostDownloadActionValue {
	NSNumber *result = [self performPostDownloadAction];
	return [result boolValue];
}

- (void)setPerformPostDownloadActionValue:(BOOL)value_ {
	[self setPerformPostDownloadAction:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePerformPostDownloadActionValue {
	NSNumber *result = [self primitivePerformPostDownloadAction];
	return [result boolValue];
}

- (void)setPrimitivePerformPostDownloadActionValue:(BOOL)value_ {
	[self setPrimitivePerformPostDownloadAction:[NSNumber numberWithBool:value_]];
}










@end
