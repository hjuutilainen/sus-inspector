#import "ReposadoInstanceMO.h"


@interface ReposadoInstanceMO ()

// Private interface goes here.

@end


@implementation ReposadoInstanceMO

- (NSURL *)reposadoDataURL
{
    return [(NSURL *)self.reposadoInstallURL URLByAppendingPathComponent:@"data"];
}

- (NSURL *)reposadoHtmlURL
{
    return [self.reposadoDataURL URLByAppendingPathComponent:@"html"];
}

- (NSURL *)reposadoMetadataURL
{
    return [self.reposadoDataURL URLByAppendingPathComponent:@"metadata"];
}

- (NSURL *)reposadoBundleURL
{
    return [(NSURL *)self.reposadoInstallURL URLByAppendingPathComponent:@"reposado.bundle"];
}

- (NSURL *)reposadoCodeURL
{
    return [self.reposadoBundleURL URLByAppendingPathComponent:@"code"];
}

- (NSURL *)reposyncURL
{
    return [(NSURL *)self.reposadoCodeURL URLByAppendingPathComponent:@"repo_sync"];
}

- (NSString *)reposyncPath
{
    return [self.reposyncURL path];
}

- (NSURL *)productInfoURL
{
    NSURL *returnURL = [[self reposadoDataURL] URLByAppendingPathComponent:@"metadata" isDirectory:YES];
    returnURL = [returnURL URLByAppendingPathComponent:@"ProductInfo.plist" isDirectory:NO];
    return returnURL;
}

- (NSDictionary *)productInfoDictionary
{
    return [NSDictionary dictionaryWithContentsOfURL:[self productInfoURL]];
}

- (BOOL)copyReposadoBundleFiles
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Reposado components we need
    NSURL *repoutilURL = [self.reposadoCodeURL URLByAppendingPathComponent:@"repoutil"];
    NSURL *reposadolibURL = [self.reposadoCodeURL URLByAppendingPathComponent:@"reposadolib" isDirectory:YES];
    NSURL *reposadoInitURL = [reposadolibURL URLByAppendingPathComponent:@"__init__.py"];
    NSURL *reposadocommonURL = [reposadolibURL URLByAppendingPathComponent:@"reposadocommon.py"];
    
    // Determine if everything is installed
    BOOL reposadoInstalled = YES;
    if (![fileManager fileExistsAtPath:self.reposyncPath]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[repoutilURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadolibURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadoInitURL path]]) reposadoInstalled = NO;
    if (![fileManager fileExistsAtPath:[reposadocommonURL path]]) reposadoInstalled = NO;
    
    // Install if needed
    if (!reposadoInstalled) {
        NSLog(@"Installing local reposado to %@", [self.reposadoBundleURL path]);
        if ([fileManager fileExistsAtPath:[self.reposadoBundleURL path]]) {
            [fileManager removeItemAtURL:self.reposadoBundleURL error:nil];
        }
        NSString *mainBundleURL = [[NSBundle mainBundle] bundlePath];
        NSString *bundledReposado = [mainBundleURL stringByAppendingString:@"/Contents/Resources/reposado.bundle"];
        NSURL *bundledReposadoURL = [NSURL fileURLWithPath:bundledReposado isDirectory:YES];
        NSError *error = nil;
        if ([fileManager copyItemAtURL:bundledReposadoURL toURL:self.reposadoBundleURL error:&error]) {
            return YES;
        } else {
            NSLog(@"%@", [error description]);
            return NO;
        }
    } else {
        // Needed files are already copied
        return YES;
    }
    return NO;
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


- (BOOL)writeReposadoPreferences
{
    NSDictionary *prefs = [self preferencesAsDictionary];
    NSURL *preferencesURL = [self.reposadoCodeURL URLByAppendingPathComponent:@"preferences.plist"];
    return [prefs writeToURL:preferencesURL atomically:YES];
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
    
    [self copyReposadoBundleFiles];
    [self writeReposadoPreferences];
    return YES;
}


@end
