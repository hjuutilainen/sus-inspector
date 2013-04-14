//
//  SIGradientBackgroundView.h
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


#import <Cocoa/Cocoa.h>


@interface SIGradientBackgroundView : NSView {

	NSGradient *fillGradient;
    NSColor *lineColor;
	BOOL drawBottomLine;
    BOOL drawTopLine;
    BOOL drawLeftLine;
    BOOL drawRightLine;
}

@property BOOL drawBottomLine;
@property BOOL drawTopLine;
@property BOOL drawLeftLine;
@property BOOL drawRightLine;
@property (nonatomic, copy) NSGradient *fillGradient;
@property (nonatomic, copy) NSColor *lineColor;

@end
