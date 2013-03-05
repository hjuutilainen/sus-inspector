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

@end
