#import "_ReposadoInstanceMO.h"

@interface ReposadoInstanceMO : _ReposadoInstanceMO {}

- (NSURL *)reposadoDataURL;
- (NSURL *)reposadoMetadataURL;
- (NSURL *)reposadoHtmlURL;
- (NSURL *)reposadoCodeURL;
- (NSURL *)reposadoBundleURL;
- (NSURL *)reposyncURL;
- (NSString *)reposyncPath;
- (NSURL *)productInfoURL;
- (NSDictionary *)productInfoDictionary;
- (BOOL)configureReposado;

@end
