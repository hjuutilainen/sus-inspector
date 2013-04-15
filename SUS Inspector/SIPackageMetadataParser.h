//
//  SIPackageMetadataParser.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 15.4.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIPackageMetadataParser : NSObject <NSXMLParserDelegate> {
    NSMutableArray *items;
    NSMutableDictionary *pkgInProgress;
    NSString *keyInProgress;
    NSMutableString *textInProgress;
}

- (BOOL)parseData:(NSData *)d;
- (NSArray *)items;

@end
