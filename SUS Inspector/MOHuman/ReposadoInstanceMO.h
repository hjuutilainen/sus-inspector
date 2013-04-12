#import "_ReposadoInstanceMO.h"

@interface ReposadoInstanceMO : _ReposadoInstanceMO {}

- (NSURL *)reposadoDataURL;
- (NSURL *)reposadoMetadataURL;
- (NSURL *)reposadoHtmlURL;
- (NSURL *)reposadoCodeURL;
- (NSURL *)reposadoBundleURL;
- (NSURL *)reposyncURL;
- (NSURL *)getLocalFileURLFromRemoteURL:(NSURL *)url;
- (NSString *)getLocalFilePathFromRemoteURL:(NSURL *)url;
- (NSString *)reposyncPath;
- (NSURL *)productInfoURL;
- (NSDictionary *)productInfoDictionary;
- (BOOL)configureReposado;

@end
