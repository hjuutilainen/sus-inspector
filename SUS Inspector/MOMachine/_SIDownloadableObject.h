// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDownloadableObject.h instead.

#import <CoreData/CoreData.h>


extern const struct SIDownloadableObjectAttributes {
	 NSString *objectCachedPath;
	 NSString *objectIsCached;
	 NSString *objectURL;
} SIDownloadableObjectAttributes;

extern const struct SIDownloadableObjectRelationships {
} SIDownloadableObjectRelationships;

extern const struct SIDownloadableObjectFetchedProperties {
} SIDownloadableObjectFetchedProperties;






@interface SIDownloadableObjectID : NSManagedObjectID {}
@end

@interface _SIDownloadableObject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SIDownloadableObjectID*)objectID;





@property (nonatomic, retain) NSString* objectCachedPath;



//- (BOOL)validateObjectCachedPath:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* objectIsCached;



@property BOOL objectIsCachedValue;
- (BOOL)objectIsCachedValue;
- (void)setObjectIsCachedValue:(BOOL)value_;

//- (BOOL)validateObjectIsCached:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* objectURL;



//- (BOOL)validateObjectURL:(id*)value_ error:(NSError**)error_;






@end

@interface _SIDownloadableObject (CoreDataGeneratedAccessors)

@end

@interface _SIDownloadableObject (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveObjectCachedPath;
- (void)setPrimitiveObjectCachedPath:(NSString*)value;




- (NSNumber*)primitiveObjectIsCached;
- (void)setPrimitiveObjectIsCached:(NSNumber*)value;

- (BOOL)primitiveObjectIsCachedValue;
- (void)setPrimitiveObjectIsCachedValue:(BOOL)value_;




- (NSString*)primitiveObjectURL;
- (void)setPrimitiveObjectURL:(NSString*)value;




@end
