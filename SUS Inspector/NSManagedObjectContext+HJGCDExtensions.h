//
//  NSManagedObjectContext+HJGCDExtensions.h
//
//  Created by Juutilainen Hannes on 26.11.2012.
//
//

#import <CoreData/CoreData.h>

typedef void (^BasicBlock)(void);

@interface NSManagedObjectContext (HJGCDExtensions)

//- (void)performBlockThreadSafe:(void (^)())block;
- (void)performBlockWithPrivateQueueConcurrency:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform;
- (void)performBlockWithPrivateQueueConcurrencyAndWait:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform;
- (void)performBlockWithPrivateQueueConcurrency:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform completionBlock:(void (^)())completionBlock;

@end
