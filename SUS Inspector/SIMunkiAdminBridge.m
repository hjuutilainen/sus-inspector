//
//  SIMunkiAdminBridge.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 12.7.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
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


#import "SIMunkiAdminBridge.h"

@implementation SIMunkiAdminBridge

static SIMunkiAdminBridge *sharedBridge = nil;
static dispatch_queue_t serialQueue;

+ (id)allocWithZone:(NSZone *)zone
{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        serialQueue = dispatch_queue_create("fi.obsolete.sus-inspector.SIMunkiAdminBridge.serialqueue", NULL);
        if (sharedBridge == nil) {
            sharedBridge = (SIMunkiAdminBridge *) [super allocWithZone:zone];
        }
    });
    
    return sharedBridge;
}

+ (SIMunkiAdminBridge *)sharedBridge
{
    static dispatch_once_t onceQueue;
    
    dispatch_once(&onceQueue, ^{
        sharedBridge = [[SIMunkiAdminBridge alloc] init];
    });
    
    return sharedBridge;
}

- (id)init
{
    id __block obj;
    
    dispatch_sync(serialQueue, ^{
        obj = [super init];
        if (obj) {
            
        }
    });
    
    self = obj;
    return self;
}

# pragma mark -
# pragma mark Sending pkginfos to MunkiAdmin

/*
 Communication with MunkiAdmin is done using NSDistributedNotificationCenter.
 Pkginfo items are wrapped in the 'userInfo' object.
 This object has to be a NSDictionary so the following format is expected by MunkiAdmin:
 
 <dict>
     <key>payloadDictionaries</key>
     <array>
         <dict>
             <key>filename</key>
             <string>pkginfo1.plist</string>
             <key>pkginfo</key>
             <dict>
             <!-- The actual pkginfo -->
             </dict>
         </dict>
         <dict>
             <key>filename</key>
             <string>pkginfo2.plist</string>
             <key>pkginfo</key>
             <dict>
             <!-- The actual pkginfo -->
             </dict>
         </dict>
     </array>
 </dict>
 
 
 */

- (void)sendPkginfos:(NSArray *)pkginfoArray
{
    NSMutableArray *arrayToSend = [NSMutableArray new];
    [pkginfoArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *infoDict = [NSMutableDictionary new];
        if ([obj objectForKey:@"pkginfo"])
            [infoDict setObject:[obj objectForKey:@"pkginfo"] forKey:@"pkginfo"];
        if ([obj objectForKey:@"filename"])
            [infoDict setObject:[obj objectForKey:@"filename"] forKey:@"filename"];
        
        [arrayToSend addObject:infoDict];
    }];
    
    NSArray *immutablePkginfos = [NSArray arrayWithArray:arrayToSend];
    
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc postNotificationName:@"SUSInspectorPostedSharedPkginfo" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:immutablePkginfos, @"payloadDictionaries", nil]];
}

- (void)sendProducts:(NSArray *)productArray
{
    NSMutableArray *arrayToSend = [NSMutableArray new];
    [productArray enumerateObjectsUsingBlock:^(SIProductMO *obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *infoDict = [NSMutableDictionary new];
        [infoDict setObject:obj.pkginfoFilename forKey:@"filename"];
        [infoDict setObject:obj.pkginfoDictionary forKey:@"pkginfo"];
        [arrayToSend addObject:infoDict];
    }];
    
    NSArray *immutablePkginfos = [NSArray arrayWithArray:arrayToSend];
    
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc postNotificationName:@"SUSInspectorPostedSharedPkginfo" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:immutablePkginfos, @"payloadDictionaries", nil]];
}

@end
