#import "SUCatalogMO.h"


@interface SUCatalogMO ()

// Private interface goes here.

@end


@implementation SUCatalogMO

- (NSString *)title
{
    return self.catalogTitle;
}

- (NSString *)catalogURLAsString
{
    return [self.catalogURL path];
}

@end
