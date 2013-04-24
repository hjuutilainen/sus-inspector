//
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


#import "SIPackageMO.h"
#import "SIOperationManager.h"


@interface SIPackageMO ()

// Private interface goes here.

@end


@implementation SIPackageMO

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	// Define keys that depend on
    if ([key isEqualToString:@"objectActionTitle"])
    {
        NSSet *affectingKeys = [NSSet setWithObjects:@"objectIsCached", @"objectIsDownloading", nil];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKeys];
    }
	
    return keyPaths;
}

- (NSString *)packageFilename
{
    NSURL *asURL = [NSURL URLWithString:self.objectURL];
    return [asURL lastPathComponent];
}

- (NSImage *)iconImage
{
    return [[NSWorkspace sharedWorkspace] iconForFileType:[self.objectURL pathExtension]];
}

- (void)performObjectAction
{
    if (self.objectIsCachedValue) {
        if (self.objectCachedPath) {
            [[NSWorkspace sharedWorkspace] selectFile:self.objectCachedPath inFileViewerRootedAtPath:@""];
        }
    } else if (!self.objectIsDownloadingValue) {
        NSURL *packageURL = [NSURL URLWithString:self.objectURL];
        self.objectIsDownloadingValue = YES;
        [[SIOperationManager sharedManager] cacheDownloadableObjectWithURL:packageURL];
    } else {
        NSLog(@"Package is not cached and is downloading. This action should have been disabled...");
    }
}

- (NSString *)objectActionTitle
{
    if (self.objectIsCachedValue) {
        return NSLocalizedString(@"Reveal", nil);
    } else if (self.objectIsDownloadingValue) {
        return NSLocalizedString(@"Downloading...", nil);
    } else {
        return NSLocalizedString(@"Download", nil);
    }
}

@end
