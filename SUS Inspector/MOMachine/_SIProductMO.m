// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIProductMO.m instead.

#import "_SIProductMO.h"

@implementation SIProductMOID
@end

@implementation _SIProductMO

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SIProduct" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SIProduct";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SIProduct" inManagedObjectContext:moc_];
}

- (SIProductMOID*)objectID {
	return (SIProductMOID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"productIsDeprecatedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"productIsDeprecated"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"productIsNewValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"productIsNew"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"productSizeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"productSize"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic productDescription;

@dynamic productID;

@dynamic productIsDeprecated;

- (BOOL)productIsDeprecatedValue {
	NSNumber *result = [self productIsDeprecated];
	return [result boolValue];
}

- (void)setProductIsDeprecatedValue:(BOOL)value_ {
	[self setProductIsDeprecated:@(value_)];
}

- (BOOL)primitiveProductIsDeprecatedValue {
	NSNumber *result = [self primitiveProductIsDeprecated];
	return [result boolValue];
}

- (void)setPrimitiveProductIsDeprecatedValue:(BOOL)value_ {
	[self setPrimitiveProductIsDeprecated:@(value_)];
}

@dynamic productIsNew;

- (BOOL)productIsNewValue {
	NSNumber *result = [self productIsNew];
	return [result boolValue];
}

- (void)setProductIsNewValue:(BOOL)value_ {
	[self setProductIsNew:@(value_)];
}

- (BOOL)primitiveProductIsNewValue {
	NSNumber *result = [self primitiveProductIsNew];
	return [result boolValue];
}

- (void)setPrimitiveProductIsNewValue:(BOOL)value_ {
	[self setPrimitiveProductIsNew:@(value_)];
}

@dynamic productPostDate;

@dynamic productSize;

- (int64_t)productSizeValue {
	NSNumber *result = [self productSize];
	return [result longLongValue];
}

- (void)setProductSizeValue:(int64_t)value_ {
	[self setProductSize:@(value_)];
}

- (int64_t)primitiveProductSizeValue {
	NSNumber *result = [self primitiveProductSize];
	return [result longLongValue];
}

- (void)setPrimitiveProductSizeValue:(int64_t)value_ {
	[self setPrimitiveProductSize:@(value_)];
}

@dynamic productTitle;

@dynamic productVersion;

@dynamic catalogs;

- (NSMutableSet<SICatalogMO*>*)catalogsSet {
	[self willAccessValueForKey:@"catalogs"];

	NSMutableSet<SICatalogMO*> *result = (NSMutableSet<SICatalogMO*>*)[self mutableSetValueForKey:@"catalogs"];

	[self didAccessValueForKey:@"catalogs"];
	return result;
}

@dynamic distributions;

- (NSMutableSet<SIDistributionMO*>*)distributionsSet {
	[self willAccessValueForKey:@"distributions"];

	NSMutableSet<SIDistributionMO*> *result = (NSMutableSet<SIDistributionMO*>*)[self mutableSetValueForKey:@"distributions"];

	[self didAccessValueForKey:@"distributions"];
	return result;
}

@dynamic packages;

- (NSMutableSet<SIPackageMO*>*)packagesSet {
	[self willAccessValueForKey:@"packages"];

	NSMutableSet<SIPackageMO*> *result = (NSMutableSet<SIPackageMO*>*)[self mutableSetValueForKey:@"packages"];

	[self didAccessValueForKey:@"packages"];
	return result;
}

@dynamic serverMetadataFiles;

- (NSMutableSet<SIServerMetadataMO*>*)serverMetadataFilesSet {
	[self willAccessValueForKey:@"serverMetadataFiles"];

	NSMutableSet<SIServerMetadataMO*> *result = (NSMutableSet<SIServerMetadataMO*>*)[self mutableSetValueForKey:@"serverMetadataFiles"];

	[self didAccessValueForKey:@"serverMetadataFiles"];
	return result;
}

@end

@implementation SIProductMOAttributes 
+ (NSString *)productDescription {
	return @"productDescription";
}
+ (NSString *)productID {
	return @"productID";
}
+ (NSString *)productIsDeprecated {
	return @"productIsDeprecated";
}
+ (NSString *)productIsNew {
	return @"productIsNew";
}
+ (NSString *)productPostDate {
	return @"productPostDate";
}
+ (NSString *)productSize {
	return @"productSize";
}
+ (NSString *)productTitle {
	return @"productTitle";
}
+ (NSString *)productVersion {
	return @"productVersion";
}
@end

@implementation SIProductMORelationships 
+ (NSString *)catalogs {
	return @"catalogs";
}
+ (NSString *)distributions {
	return @"distributions";
}
+ (NSString *)packages {
	return @"packages";
}
+ (NSString *)serverMetadataFiles {
	return @"serverMetadataFiles";
}
@end

