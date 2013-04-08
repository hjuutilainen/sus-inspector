#import "SUPackageMO.h"


@interface SUPackageMO ()

// Private interface goes here.

@end


@implementation SUPackageMO

- (NSString *)packageFilename
{
    NSURL *asURL = [NSURL URLWithString:self.packageURL];
    return [asURL lastPathComponent];
}

- (NSImage *)iconImage
{
    return [[NSWorkspace sharedWorkspace] iconForFileType:[self.packageURL pathExtension]];
}

@end
