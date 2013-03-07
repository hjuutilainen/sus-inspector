#import "ReposadoInstanceMO.h"


@interface ReposadoInstanceMO ()

// Private interface goes here.

@end


@implementation ReposadoInstanceMO

- (NSURL *)dataURL
{
    return [(NSURL *)self.reposadoInstallURL URLByAppendingPathComponent:@"data"];
}

- (NSURL *)codeURL
{
    return [(NSURL *)self.reposadoInstallURL URLByAppendingPathComponent:@"code"];
}

- (NSURL *)reposyncURL
{
    return [(NSURL *)self.codeURL URLByAppendingPathComponent:@"repo_sync"];
}

- (NSString *)reposyncPath
{
    return [self.reposyncURL path];
}

- (NSURL *)productInfoURL
{
    NSURL *returnURL = [[self dataURL] URLByAppendingPathComponent:@"metadata" isDirectory:YES];
    returnURL = [returnURL URLByAppendingPathComponent:@"ProductInfo.plist" isDirectory:NO];
    return returnURL;
}

- (NSDictionary *)productInfoDictionary
{
    return [NSDictionary dictionaryWithContentsOfURL:[self productInfoURL]];
}

@end
