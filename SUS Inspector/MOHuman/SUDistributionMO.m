#import "SUDistributionMO.h"


@interface SUDistributionMO ()

// Private interface goes here.

@end


@implementation SUDistributionMO


- (NSString *)distributionFilename
{
    NSURL *asURL = [NSURL URLWithString:self.distributionURL];
    return [asURL lastPathComponent];
}

- (NSImage *)iconImage
{
    return [[NSWorkspace sharedWorkspace] iconForFileType:[self.distributionURL pathExtension]];
}

@end
