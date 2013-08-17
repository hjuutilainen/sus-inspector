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

@interface SIMunkiAdminBridge ()
@property (readwrite) BOOL munkiAdminIsActiveAndReady;
@property (readwrite, strong) NSArray *currentAppleUpdateMetadataNames;
@end

@implementation SIMunkiAdminBridge

#define kMunkiAdminBundleID @"fi.obsolete.MunkiAdmin"

// Notification names
#define kMunkiAdminStatusUpdateRequestName @"SUSInspectorMunkiAdminStatusUpdateRequest"
#define kMunkiAdminDidChangeStatusName @"MunkiAdminDidChangeStatus"
#define kSUSInspectorPostedSharedPkginfoName @"SUSInspectorPostedSharedPkginfo"

#define kPkginfoKeyName @"pkginfo"
#define kFilenameKeyName @"filename"

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
            NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
            [dnc addObserver:self selector:@selector(munkiAdminDidChangeStatus:) name:kMunkiAdminDidChangeStatusName object:nil];
            self.currentAppleUpdateMetadataNames = [NSArray array];
            self.munkiAdminIsActiveAndReady = NO;
        }
    });
    
    self = obj;
    return self;
}

- (void)munkiAdminDidChangeStatus:(NSNotification *)aNotification
{
    if (![aNotification userInfo]) {
        self.munkiAdminIsActiveAndReady = NO;
        self.currentAppleUpdateMetadataNames = [NSArray array];
        return;
    }
    
    id readyToReceive = [[aNotification userInfo] objectForKey:@"readyToReceive"];
    if (readyToReceive && [readyToReceive isKindOfClass:[NSNumber class]]) {
        BOOL readyToReceiveBool = [[[aNotification userInfo] objectForKey:@"readyToReceive"] boolValue];
        self.munkiAdminIsActiveAndReady = readyToReceiveBool;
    } else {
        self.munkiAdminIsActiveAndReady = NO;
    }
    
    id appleUpdateMetadataNames = [[aNotification userInfo] objectForKey:@"appleUpdateMetadataNames"];
    if (appleUpdateMetadataNames && [appleUpdateMetadataNames isKindOfClass:[NSArray class]]) {
        NSArray *newAppleUpdateMetadataNames = [NSArray arrayWithArray:(NSArray *)appleUpdateMetadataNames];
        self.currentAppleUpdateMetadataNames = [newAppleUpdateMetadataNames sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    } else {
        self.currentAppleUpdateMetadataNames = [NSArray array];
    }
}

- (BOOL)munkiAdminInstalled
{
    NSString *munkiAdminPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:kMunkiAdminBundleID];
    if (munkiAdminPath == nil) return NO;
    else return YES;
}

- (BOOL)munkiAdminRunning
{
    NSArray *runningApps = [NSRunningApplication runningApplicationsWithBundleIdentifier:kMunkiAdminBundleID];
    if ([runningApps count] == 0) return NO;
    else return YES;
}

- (void)requestMunkiAdminStatusUpdate
{
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc postNotificationName:kMunkiAdminStatusUpdateRequestName object:nil userInfo:nil deliverImmediately:YES];
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
    NSMutableArray *arrayToSend = [[NSMutableArray alloc] init];
    [pkginfoArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *infoDict = [NSMutableDictionary new];
        if ([obj objectForKey:kPkginfoKeyName])
            [infoDict setObject:[obj objectForKey:kPkginfoKeyName] forKey:kPkginfoKeyName];
        if ([obj objectForKey:kFilenameKeyName])
            [infoDict setObject:[obj objectForKey:kFilenameKeyName] forKey:kFilenameKeyName];
        
        [arrayToSend addObject:infoDict];
    }];
    
    NSArray *immutablePkginfos = [NSArray arrayWithArray:arrayToSend];
    
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc postNotificationName:kSUSInspectorPostedSharedPkginfoName object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:immutablePkginfos, @"payloadDictionaries", nil]];
}

- (void)sendProducts:(NSArray *)productArray
{
    NSMutableArray *arrayToSend = [[NSMutableArray alloc] init];
    [productArray enumerateObjectsUsingBlock:^(SIProductMO *obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *infoDict = [NSMutableDictionary new];
        [infoDict setObject:obj.pkginfoFilename forKey:kFilenameKeyName];
        [infoDict setObject:obj.pkginfoDictionary forKey:kPkginfoKeyName];
        [arrayToSend addObject:infoDict];
    }];
    
    NSArray *immutablePkginfos = [NSArray arrayWithArray:arrayToSend];
    
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc postNotificationName:kSUSInspectorPostedSharedPkginfoName object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:immutablePkginfos, @"payloadDictionaries", nil]];
}

@end
