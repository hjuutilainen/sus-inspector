#import "SUCatalogMO.h"
#import "ReposadoInstanceMO.h"


@interface SUCatalogMO ()

// Private interface goes here.

@end


@implementation SUCatalogMO

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	// Define keys that depend on
    if ([key isEqualToString:@"catalogURLFromInstanceDefaultURL"])
    {
        NSSet *affectingKeys = [NSSet setWithObjects:@"reposadoInstance.reposadoCatalogsBaseURLString", nil];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKeys];
    }
	
    return keyPaths;
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
        parentBaseString = [[NSUserDefaults standardUserDefaults] stringForKey:@"reposadoCatalogsBaseURL"];
    }
    
    //NSURL *parentBase = [NSURL URLWithString:parentBaseString];
    //NSURL *new = [NSURL URLWithString:[currentURL relativePath] relativeToURL:parentBase];
    NSString *new = [NSString stringWithFormat:@"%@%@", parentBaseString, [currentURL relativePath]];
    return new;
}

@end
