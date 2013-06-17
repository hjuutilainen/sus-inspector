//
//  SISizeFormatter.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 4.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "SISizeFormatter.h"

@implementation SISizeFormatter

- (NSString *)manualStringFromBytes:(id)anObject
{
    float bytes = [anObject floatValue];
    NSArray *suffix = [NSArray arrayWithObjects:@"B", @"KB", @"MB", @"GB", @"TB", nil];
	int i = 0;
	while(bytes > 1024)
	{
		bytes = bytes/1024.0;
		i++;
	}
    
    NSNumberFormatter* formatter = [[[NSNumberFormatter alloc] init] autorelease];
    [formatter setMaximumFractionDigits:1];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // Uses localized number formats.
    [formatter setAlwaysShowsDecimalSeparator:NO];
    
    NSString *sizeInUnits = [formatter stringFromNumber:[NSNumber numberWithFloat:bytes]];
    
    return [NSString stringWithFormat:@"%@ %@", sizeInUnits, [suffix objectAtIndex:i]];
}

- (NSString *)stringForObjectValue:(id)anObject {
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    
    if (floor(NSAppKitVersionNumber) <= NSAppKitVersionNumber10_6) {
        /* On a 10.6.x or earlier system */
        return [self manualStringFromBytes:anObject];
        
    } else if (floor(NSAppKitVersionNumber) <= NSAppKitVersionNumber10_7) {
        /* On a 10.7 - 10.7.x system */
        return [self manualStringFromBytes:anObject];
        
    } else {
        /* Mountain Lion or later system */
        long long convertedValue = [anObject longLongValue];
        return [NSByteCountFormatter stringFromByteCount:convertedValue countStyle:NSByteCountFormatterCountStyleFile];
    }
}

- (BOOL)getObjectValue:(id *)obj forString:(NSString *)string errorDescription:(NSString  **)error {
    return [super getObjectValue:obj forString:string errorDescription:error];
}


@end
