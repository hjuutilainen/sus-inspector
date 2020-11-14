// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SIReposadoInstanceMO.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class SICatalogMO;

@interface SIReposadoInstanceMOID : NSManagedObjectID {}
@end

@interface _SIReposadoInstanceMO : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SIReposadoInstanceMOID *objectID;

@property (nonatomic, strong, nullable) NSDate* productInfoCreationDate;

@property (nonatomic, strong, nullable) NSDate* productInfoModificationDate;

@property (nonatomic, strong, nullable) NSString* reposadoCatalogsBaseURLString;

@property (nonatomic, strong, nullable) NSURL* reposadoInstallURL;

@property (nonatomic, strong, nullable) NSNumber* reposadoSetupComplete;

@property (atomic) BOOL reposadoSetupCompleteValue;
- (BOOL)reposadoSetupCompleteValue;
- (void)setReposadoSetupCompleteValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* reposadoTitle;

@property (nonatomic, strong, nullable) NSString* reposadoUpdatesMetadataDir;

@property (nonatomic, strong, nullable) NSString* reposadoUpdatesRootDir;

@property (nonatomic, strong, nullable) NSSet<SICatalogMO*> *catalogs;
- (nullable NSMutableSet<SICatalogMO*>*)catalogsSet;

@property (nonatomic, readonly, nullable) NSArray *activeCatalogs;

@end

@interface _SIReposadoInstanceMO (CatalogsCoreDataGeneratedAccessors)
- (void)addCatalogs:(NSSet<SICatalogMO*>*)value_;
- (void)removeCatalogs:(NSSet<SICatalogMO*>*)value_;
- (void)addCatalogsObject:(SICatalogMO*)value_;
- (void)removeCatalogsObject:(SICatalogMO*)value_;

@end

@interface _SIReposadoInstanceMO (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSDate*)primitiveProductInfoCreationDate;
- (void)setPrimitiveProductInfoCreationDate:(nullable NSDate*)value;

- (nullable NSDate*)primitiveProductInfoModificationDate;
- (void)setPrimitiveProductInfoModificationDate:(nullable NSDate*)value;

- (nullable NSString*)primitiveReposadoCatalogsBaseURLString;
- (void)setPrimitiveReposadoCatalogsBaseURLString:(nullable NSString*)value;

- (nullable NSURL*)primitiveReposadoInstallURL;
- (void)setPrimitiveReposadoInstallURL:(nullable NSURL*)value;

- (nullable NSNumber*)primitiveReposadoSetupComplete;
- (void)setPrimitiveReposadoSetupComplete:(nullable NSNumber*)value;

- (BOOL)primitiveReposadoSetupCompleteValue;
- (void)setPrimitiveReposadoSetupCompleteValue:(BOOL)value_;

- (nullable NSString*)primitiveReposadoTitle;
- (void)setPrimitiveReposadoTitle:(nullable NSString*)value;

- (nullable NSString*)primitiveReposadoUpdatesMetadataDir;
- (void)setPrimitiveReposadoUpdatesMetadataDir:(nullable NSString*)value;

- (nullable NSString*)primitiveReposadoUpdatesRootDir;
- (void)setPrimitiveReposadoUpdatesRootDir:(nullable NSString*)value;

- (NSMutableSet<SICatalogMO*>*)primitiveCatalogs;
- (void)setPrimitiveCatalogs:(NSMutableSet<SICatalogMO*>*)value;

@end

@interface SIReposadoInstanceMOAttributes: NSObject 
+ (NSString *)productInfoCreationDate;
+ (NSString *)productInfoModificationDate;
+ (NSString *)reposadoCatalogsBaseURLString;
+ (NSString *)reposadoInstallURL;
+ (NSString *)reposadoSetupComplete;
+ (NSString *)reposadoTitle;
+ (NSString *)reposadoUpdatesMetadataDir;
+ (NSString *)reposadoUpdatesRootDir;
@end

@interface SIReposadoInstanceMORelationships: NSObject
+ (NSString *)catalogs;
@end

@interface SIReposadoInstanceMOFetchedProperties: NSObject
+ (NSString *)activeCatalogs;
@end

NS_ASSUME_NONNULL_END
