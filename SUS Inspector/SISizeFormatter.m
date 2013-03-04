//
//  SISizeFormatter.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 4.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SISizeFormatter.h"

@implementation SISizeFormatter

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    
    long long convertedValue = [anObject longLongValue];
    return [NSByteCountFormatter stringFromByteCount:convertedValue countStyle:NSByteCountFormatterCountStyleFile];
    
}

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error {
    return [super getObjectValue:obj forString:string errorDescription:error];
}


@end
