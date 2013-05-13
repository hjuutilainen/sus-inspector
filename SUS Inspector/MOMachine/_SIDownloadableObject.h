// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIDownloadableObject.h instead.

#import <CoreData/CoreData.h>


extern const struct SIDownloadableObjectAttributes {
	 NSString *objectCachedPath;
	 NSString *objectIsCached;
	 NSString *objectIsDownloading;
	 NSString *objectURL;
	 NSString *performPostDownloadAction;
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





@property (nonatomic, retain) NSNumber* objectIsDownloading;



@property BOOL objectIsDownloadingValue;
- (BOOL)objectIsDownloadingValue;
- (void)setObjectIsDownloadingValue:(BOOL)value_;

//- (BOOL)validateObjectIsDownloading:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSString* objectURL;



//- (BOOL)validateObjectURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSNumber* performPostDownloadAction;



@property BOOL performPostDownloadActionValue;
- (BOOL)performPostDownloadActionValue;
- (void)setPerformPostDownloadActionValue:(BOOL)value_;

//- (BOOL)validatePerformPostDownloadAction:(id*)value_ error:(NSError**)error_;






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




- (NSNumber*)primitiveObjectIsDownloading;
- (void)setPrimitiveObjectIsDownloading:(NSNumber*)value;

- (BOOL)primitiveObjectIsDownloadingValue;
- (void)setPrimitiveObjectIsDownloadingValue:(BOOL)value_;




- (NSString*)primitiveObjectURL;
- (void)setPrimitiveObjectURL:(NSString*)value;




- (NSNumber*)primitivePerformPostDownloadAction;
- (void)setPrimitivePerformPostDownloadAction:(NSNumber*)value;

- (BOOL)primitivePerformPostDownloadActionValue;
- (void)setPrimitivePerformPostDownloadActionValue:(BOOL)value_;




@end
