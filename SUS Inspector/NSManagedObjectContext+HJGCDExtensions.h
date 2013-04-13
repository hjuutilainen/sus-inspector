//
//  NSManagedObjectContext+HJGCDExtensions.h
//
//  Created by Juutilainen Hannes on 26.11.2012.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <CoreData/CoreData.h>

typedef void (^BasicBlock)(void);

@interface NSManagedObjectContext (HJGCDExtensions)

//- (void)performBlockThreadSafe:(void (^)())block;
- (void)performBlockWithPrivateQueueConcurrency:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform;
- (void)performBlockWithPrivateQueueConcurrencyAndWait:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform;
- (void)performBlockWithPrivateQueueConcurrency:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform completionBlock:(void (^)())completionBlock;

@end
