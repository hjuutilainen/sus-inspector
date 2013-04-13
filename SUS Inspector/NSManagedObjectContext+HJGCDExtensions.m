//
//  NSManagedObjectContext+HJGCDExtensions.m
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


#import "NSManagedObjectContext+HJGCDExtensions.h"

@implementation NSManagedObjectContext (HJGCDExtensions)

- (void)performBlockWithPrivateQueueConcurrency:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSManagedObjectContext *childMoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        NSManagedObjectContext *parentMoc = self;
        [childMoc setParentContext:parentMoc];
        [childMoc setUndoManager:nil];
        
        blockToPerform(childMoc);
        
        NSError *error = nil;
        [childMoc save:&error];
        
        [parentMoc performBlock:^{
            NSError *parentError = nil;
            [parentMoc save:&parentError];
        }];
        
        [childMoc release], childMoc = nil;
    });
}

- (void)performBlockWithPrivateQueueConcurrencyAndWait:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform
{
    NSManagedObjectContext *childMoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    NSManagedObjectContext *parentMoc = self;
    [childMoc setParentContext:parentMoc];
    [childMoc setUndoManager:nil];
    
    blockToPerform(childMoc);
    
    NSError *error = nil;
    [childMoc save:&error];
    
    [parentMoc performBlock:^{
        NSError *parentError = nil;
        [parentMoc save:&parentError];
    }];
    
    [childMoc release], childMoc = nil;
}


- (void)performBlockWithPrivateQueueConcurrency:(void (^)(NSManagedObjectContext *threadSafeMoc))blockToPerform completionBlock:(void (^)())completionBlock
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSManagedObjectContext *childMoc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        NSManagedObjectContext *parentMoc = self;
        [childMoc setParentContext:parentMoc];
        [childMoc setUndoManager:nil];
        
        blockToPerform(childMoc);
        
        dispatch_queue_t main = dispatch_get_main_queue();
        dispatch_async(main, ^{
            completionBlock();
        });
        
        NSError *error = nil;
        [childMoc save:&error];
        
        [parentMoc performBlock:^{
            NSError *parentError = nil;
            [parentMoc save:&parentError];
        }];
        
        [childMoc release], childMoc = nil;
    });
}

@end
