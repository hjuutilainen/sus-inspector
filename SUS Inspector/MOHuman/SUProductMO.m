#import "SUProductMO.h"


@interface SUProductMO ()

// Private interface goes here.

@end


@implementation SUProductMO

- (NSString *)statusDescription
{
    if (self.productIsDeprecatedValue)
        return @"Deprecated";
    else
        return @"Active";
}

- (NSString *)productTitleWithVersion
{
    return [NSString stringWithFormat:@"%@ - Version %@", self.productTitle, self.productVersion];
}

@end
