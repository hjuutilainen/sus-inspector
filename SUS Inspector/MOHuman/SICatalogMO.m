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


#import "SICatalogMO.h"
#import "SIReposadoInstanceMO.h"
#import "SIOperationManager.h"


@interface SICatalogMO ()

// Private interface goes here.

@end


@implementation SICatalogMO

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	// Define keys that depend on
    if ([key isEqualToString:@"catalogURLFromInstanceDefaultURL"])
    {
        NSSet *affectingKeys = [NSSet setWithObjects:@"reposadoInstance.reposadoCatalogsBaseURLString", nil];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKeys];
    }
    else if ([key isEqualToString:@"statusImage"])
    {
        NSSet *affectingKeys = [NSSet setWithObjects:@"catalogURLIsValid", @"catalogURLCheckPending", nil];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKeys];
    }
	
    return keyPaths;
}


- (void)awakeFromInsert
{
    
}

- (void)setCatalogURL:(NSString *)catalogURL
{
    [self willChangeValueForKey:@"catalogURL"];
    [self setPrimitiveValue:catalogURL forKey:@"catalogURL"];
    [self didChangeValueForKey:@"catalogURL"];
    
    [self triggerCatalogURLCheck];
}

- (void)triggerCatalogURLCheck
{
    self.catalogURLCheckPendingValue = YES;
    [[SIOperationManager sharedManager] updateCatalogURLStatus:self];
}

- (NSImage *)statusImage
{
    if (self.catalogURLCheckPendingValue) {
        return [NSImage imageNamed:NSImageNameStatusPartiallyAvailable];
    }
    
    if (self.catalogURLIsValidValue) {
        return [NSImage imageNamed:NSImageNameStatusAvailable];
    } else {
        return [NSImage imageNamed:NSImageNameStatusUnavailable];
    }
}

- (NSString *)title
{
    return self.catalogTitle;
}

- (NSString *)catalogFilename
{
    NSURL *asURL = [NSURL URLWithString:self.catalogURL];
    return [asURL lastPathComponent];
}

- (NSString *)catalogURLAsString
{
    return self.catalogURL;
}

- (NSString *)catalogURLFromInstanceDefaultURL
{
    NSURL *currentURL = [NSURL URLWithString:self.catalogURL];
    
    NSString *parentBaseString;
    if (![self.reposadoInstance.reposadoCatalogsBaseURLString isEqualToString:@""]) {
        parentBaseString = self.reposadoInstance.reposadoCatalogsBaseURLString;
    } else {
        parentBaseString = [[NSUserDefaults standardUserDefaults] stringForKey:@"baseURL"];
    }
    
    //NSURL *parentBase = [NSURL URLWithString:parentBaseString];
    //NSURL *new = [NSURL URLWithString:[currentURL relativePath] relativeToURL:parentBase];
    NSString *new = [NSString stringWithFormat:@"%@%@", parentBaseString, [currentURL relativePath]];
    return new;
}

@end
