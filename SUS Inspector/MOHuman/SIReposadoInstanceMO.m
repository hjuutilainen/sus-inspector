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


#import "SIReposadoInstanceMO.h"
#import "SIReposadoConstants.h"


@interface SIReposadoInstanceMO ()

// Private interface goes here.

@end


@implementation SIReposadoInstanceMO

- (NSURL *)reposadoDataURL
{
    return [(NSURL *)self.reposadoInstallURL URLByAppendingPathComponent:kReposadoDataDirectoryName];
}

- (NSURL *)reposadoHtmlURL
{
    return [self.reposadoDataURL URLByAppendingPathComponent:kReposadoHtmlDirectoryName];
}

- (NSURL *)reposadoMetadataURL
{
    return [self.reposadoDataURL URLByAppendingPathComponent:kReposadoMetadataDirectoryName];
}

- (NSURL *)reposadoBundleURL
{
    return [(NSURL *)self.reposadoInstallURL URLByAppendingPathComponent:kReposadoBundleName];
}

- (NSURL *)reposadoBundleDistributionURL
{
    NSURL *mainResourceURL = [[NSBundle mainBundle] resourceURL];
    return [mainResourceURL URLByAppendingPathComponent:kReposadoBundleName];
}

- (NSDictionary *)reposadoBundleInfoDictionary
{
    return [NSDictionary dictionaryWithContentsOfURL:self.reposadoBundleInfoDictionaryURL];
}

- (NSURL *)reposadoBundleInfoDictionaryURL
{
    return [self.reposadoBundleURL URLByAppendingPathComponent:@"Info.plist"];
}

- (NSURL *)reposadoCodeURL
{
    return [self.reposadoBundleURL URLByAppendingPathComponent:kReposadoCodeDirectoryName];
}

- (NSURL *)reposyncURL
{
    return [self.reposadoCodeURL URLByAppendingPathComponent:@"repo_sync"];
}

- (NSString *)reposyncPath
{
    return [self.reposyncURL path];
}

- (NSURL *)getLocalFileURLFromRemoteURL:(NSURL *)url
{
    NSString *requestURLRelativePath = [[url relativePath] substringFromIndex:1];
    NSURL *joined = [self.reposadoHtmlURL URLByAppendingPathComponent:requestURLRelativePath];
    return joined;
}

- (NSString *)getLocalFilePathFromRemoteURL:(NSURL *)url
{
    NSString *requestURLRelativePath = [[url relativePath] substringFromIndex:1];
    NSString *joined = [[self.reposadoHtmlURL path] stringByAppendingPathComponent:requestURLRelativePath];
    return joined;
}

- (NSURL *)productInfoURL
{
    return [self.reposadoMetadataURL URLByAppendingPathComponent:@"ProductInfo.plist" isDirectory:NO];
}

- (NSDictionary *)productInfoDictionary
{
    return [NSDictionary dictionaryWithContentsOfURL:[self productInfoURL]];
}

- (BOOL)copyReposadoBundleFilesWithForce:(BOOL)force
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Reposado components we need
    NSURL *repoutilURL = [self.reposadoCodeURL URLByAppendingPathComponent:@"repoutil"];
    NSURL *reposadolibURL = [self.reposadoCodeURL URLByAppendingPathComponent:@"reposadolib" isDirectory:YES];
    NSURL *reposadoInitURL = [reposadolibURL URLByAppendingPathComponent:@"__init__.py"];
    NSURL *reposadoCommonURL = [reposadolibURL URLByAppendingPathComponent:@"reposadocommon.py"];
    
    // Determine if everything is installed
    BOOL reposadoInstalled = YES;
    if (![fileManager fileExistsAtPath:self.reposyncPath]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[repoutilURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadolibURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadoInitURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadoCommonURL path]]) reposadoInstalled = NO;
    
    // Install if needed
    if (!reposadoInstalled || force) {
        NSLog(@"Installing local reposado to %@", [self.reposadoBundleURL path]);
        if ([fileManager fileExistsAtPath:[self.reposadoBundleURL path]]) {
            [fileManager removeItemAtURL:self.reposadoBundleURL error:nil];
        }
        NSError *error = nil;
        if ([fileManager copyItemAtURL:self.reposadoBundleDistributionURL toURL:self.reposadoBundleURL error:&error]) {
            return YES;
        } else {
            NSLog(@"%@", [error description]);
            return NO;
        }
    } else {
        // Needed files are already copied
        return YES;
    }
}

- (NSDictionary *)preferencesAsDictionary
{
    NSPredicate *active = [NSPredicate predicateWithFormat:@"isActive == TRUE"];
    NSSet *activeCatalogs = [self.catalogs filteredSetUsingPredicate:active];
    NSSortDescriptor *sortByOS = [NSSortDescriptor sortDescriptorWithKey:@"catalogOSVersion" ascending:YES];
    NSArray *sortedByOS = [activeCatalogs sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOS]];
    NSArray *catalogURLs = [sortedByOS valueForKeyPath:@"catalogURL"];
    
    NSDictionary *reposadoPrefs = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [self.reposadoMetadataURL relativePath], @"UpdatesMetadataDir",
                                   [self.reposadoHtmlURL relativePath], @"UpdatesRootDir",
                                   catalogURLs, @"AppleCatalogURLs",
                                   nil];
    return reposadoPrefs;
}

- (BOOL)writeReposadoBundleInfoDictionary
{
    NSDate *bundledReposadoCommitDate = [NSDate dateWithString:kReposadoCurrentCommitDateString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd.HHmmss"];
    NSString *versionStringFromDate = [formatter stringFromDate:bundledReposadoCommitDate];
    [formatter release];
    NSString *bundledReposadoCommitHash = kReposadoCurrentCommitHash;
    NSDictionary *newInfoDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       versionStringFromDate,       @"commitVersion",
                                       bundledReposadoCommitDate,   @"commitDate",
                                       bundledReposadoCommitHash,   @"commitHash",
                                       nil];
    return [newInfoDictionary writeToURL:self.reposadoBundleInfoDictionaryURL atomically:YES];
}

- (BOOL)writeReposadoPreferences
{
    NSDictionary *prefs = [self preferencesAsDictionary];
    NSURL *preferencesURL = [self.reposadoCodeURL URLByAppendingPathComponent:@"preferences.plist"];
    return [prefs writeToURL:preferencesURL atomically:YES];
}

- (BOOL)updateReposado
{
    if (![self copyReposadoBundleFilesWithForce:YES]) return NO;
    if (![self writeReposadoPreferences]) return NO;
    if (![self writeReposadoBundleInfoDictionary]) return NO;
    return YES;
}

- (BOOL)configureReposado
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Create the base directory for this instance
    [fileManager createDirectoryAtURL:self.reposadoInstallURL withIntermediateDirectories:YES attributes:nil error:nil];
    
    // Create the ./reposado.bundle subdirectory
    [fileManager createDirectoryAtURL:self.reposadoBundleURL withIntermediateDirectories:YES attributes:nil error:nil];
    
    // Create the ./data directory structure
    [fileManager createDirectoryAtURL:self.reposadoDataURL withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createDirectoryAtURL:self.reposadoHtmlURL withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createDirectoryAtURL:self.reposadoMetadataURL withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    self.reposadoTitle = [self.reposadoInstallURL lastPathComponent];
    
    if (![self copyReposadoBundleFilesWithForce:NO]) return NO;
    if (![self writeReposadoPreferences]) return NO;
    if (![self writeReposadoBundleInfoDictionary]) return NO;
    return YES;
}


@end
