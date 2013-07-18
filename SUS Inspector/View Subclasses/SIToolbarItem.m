//
//  SIToolbarItem.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 18.7.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIToolbarItem.h"

@implementation SIToolbarItem

- (void)validate
{
    if ([[[self toolbar] delegate] respondsToSelector:@selector(validateToolbarItem:)]) {
        BOOL enabled = [(SIMainWindowController *)[[self toolbar] delegate] validateToolbarItem:self];
        [self setEnabled:enabled];
    }
}

@end
