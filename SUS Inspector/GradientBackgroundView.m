//
//  GradientBackgroundView.m
//
//  Created by Hannes Juutilainen on 21.1.2010.
//

#import "GradientBackgroundView.h"


@implementation GradientBackgroundView
@synthesize drawBottomLine;
@synthesize drawTopLine;
@synthesize drawLeftLine;
@synthesize drawRightLine;
@synthesize lineColor;
@synthesize fillGradient;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		self.drawBottomLine = NO;
        self.drawTopLine = NO;
        self.drawLeftLine = NO;
        self.drawRightLine = NO;
        self.lineColor = [NSColor grayColor];
		self.fillGradient = [[[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.714 green:0.753 blue:0.812 alpha:1.0] 
                                                           endingColor:[NSColor colorWithCalibratedRed:0.796 green:0.824 blue:0.867 alpha:1.0]] autorelease];
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	
	NSRect wholeRect = [self bounds];
	
	[self.fillGradient drawInRect:wholeRect angle:90.0];
	
	if (self.drawBottomLine) {
        NSBezierPath *bottomLine = [NSBezierPath bezierPath];
        [bottomLine moveToPoint:NSMakePoint(0, 0)];
        [bottomLine lineToPoint:NSMakePoint(wholeRect.size.width, 0)];
        [self.lineColor set];
        [bottomLine setLineWidth:1];
        [bottomLine stroke];
	}
    
    if (self.drawTopLine) {
        NSBezierPath *topLine = [NSBezierPath bezierPath];
        [topLine moveToPoint:NSMakePoint(0, wholeRect.size.height)];
        [topLine lineToPoint:NSMakePoint(wholeRect.size.width, wholeRect.size.height)];
        [self.lineColor set];
        [topLine setLineWidth:1];
        [topLine stroke];
	}
    
    if (self.drawLeftLine) {
        NSBezierPath *leftLine = [NSBezierPath bezierPath];
        [leftLine moveToPoint:NSMakePoint(0, 0)];
        [leftLine lineToPoint:NSMakePoint(0, wholeRect.size.height)];
        [self.lineColor set];
        [leftLine setLineWidth:1];
        [leftLine stroke];
	}
    
    if (self.drawRightLine) {
        NSBezierPath *rightLine = [NSBezierPath bezierPath];
        [rightLine moveToPoint:NSMakePoint(wholeRect.size.width, 0)];
        [rightLine lineToPoint:NSMakePoint(wholeRect.size.width, wholeRect.size.height)];
        [self.lineColor set];
        [rightLine setLineWidth:1];
        [rightLine stroke];
	}
}

- (void)dealloc
{
    [lineColor release];
    [fillGradient release];
    [super dealloc];
}


@end
