//
//  SIProductInfoWindowController.h
//  SUS Inspector
//
//  Created by Hannes on 18.3.2013.
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


#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class SUProductMO;

@interface SIProductInfoWindowController : NSWindowController <NSTokenFieldDelegate, NSTabViewDelegate>

@property (retain) SUProductMO *product;
@property (retain) NSArray *catalogs;
//@property (assign) IBOutlet NSTableView *packagesTableView;
@property (assign) IBOutlet NSScrollView *packagesScrollView;
@property (assign) IBOutlet NSArrayController *catalogsArrayController;
@property (assign) IBOutlet NSTokenField *catalogsTokenField;
@property (assign) IBOutlet NSArrayController *packagesArrayController;
@property (assign) IBOutlet NSTabView *tabView;
@property (assign) IBOutlet WebView *descriptionWebView;
@property (assign) IBOutlet NSView *tabContainerView;
@property (assign) IBOutlet NSArrayController *distributionsArrayController;
@property (assign) IBOutlet NSTableView *packagesTableView;
@property (assign) IBOutlet NSTableView *distributionsTableView;

@end
