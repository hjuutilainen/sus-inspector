//
//  SIGradientBackgroundView.m
//
//  Created by Hannes Juutilainen on 21.1.2010.
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


#import "SIGradientBackgroundView.h"


@implementation SIGradientBackgroundView
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
		self.fillGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.714 green:0.753 blue:0.812 alpha:1.0]
                                                           endingColor:[NSColor colorWithCalibratedRed:0.796 green:0.824 blue:0.867 alpha:1.0]];
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


@end
