//
//  GradientButtonBarView.m
//  MunkiAdmin
//
//  Created by Juutilainen Hannes on 28.4.2011.
//

#import "GradientButtonBarView.h"


@implementation GradientButtonBarView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.drawBottomLine = YES;
        self.drawTopLine = YES;
        self.drawLeftLine = YES;
        self.drawRightLine = YES;
        self.fillGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.95 alpha:1.0] 
                                                           endingColor:[NSColor colorWithCalibratedWhite:1.0 alpha:1.0]] autorelease];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
