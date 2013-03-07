#import "_ReposadoInstanceMO.h"

@interface ReposadoInstanceMO : _ReposadoInstanceMO {}

- (NSURL *)dataURL;
- (NSURL *)codeURL;
- (NSURL *)reposyncURL;
- (NSString *)reposyncPath;
- (NSURL *)productInfoURL;
- (NSDictionary *)productInfoDictionary;


@end
