//
//  SITableView.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 13.5.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SITableView.h"

@implementation SITableView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

/*
 Overridden to change selection when user right-clicks the table
 */
- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{
	NSIndexSet *selectedRowIndexes = [self selectedRowIndexes];
	NSPoint mousePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	NSInteger row = [self rowAtPoint:mousePoint];
	if ([selectedRowIndexes containsIndex:row] == NO)
	{
		[self selectRowIndexes:[NSIndexSet indexSetWithIndex:row] byExtendingSelection:NO];
	}
	return [super menuForEvent:theEvent];
}

@end
