//
//  SIGradientButtonBarView.m
//
//  Created by Juutilainen Hannes on 28.4.2011.
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


#import "SIGradientButtonBarView.h"


@implementation SIGradientButtonBarView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        self.drawBottomLine = YES;
        self.drawTopLine = YES;
        self.drawLeftLine = YES;
        self.drawRightLine = YES;
        self.fillGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.95 alpha:1.0] 
                                                           endingColor:[NSColor colorWithCalibratedWhite:1.0 alpha:1.0]];
    }
    
    return self;
}



- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

@end
