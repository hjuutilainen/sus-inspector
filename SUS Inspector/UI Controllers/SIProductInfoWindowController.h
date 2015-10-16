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

@class SIProductMO;

@interface SIProductInfoWindowController : NSWindowController <NSWindowDelegate, NSTokenFieldDelegate, NSTabViewDelegate, WebPolicyDelegate> {
    
}

@property (strong) SIProductMO *product;
@property (unsafe_unretained) id delegate;
@property (strong) NSArray *catalogs;
//@property (assign) IBOutlet NSTableView *packagesTableView;
@property (weak) IBOutlet NSScrollView *packagesScrollView;
@property (weak) IBOutlet NSArrayController *catalogsArrayController;
@property (weak) IBOutlet NSTokenField *catalogsTokenField;
@property (weak) IBOutlet NSArrayController *packagesArrayController;
@property (weak) IBOutlet NSTabView *tabView;
@property (weak) IBOutlet WebView *descriptionWebView;
@property (weak) IBOutlet NSView *tabContainerView;
@property (weak) IBOutlet NSArrayController *distributionsArrayController;
@property (weak) IBOutlet NSTableView *packagesTableView;
@property (weak) IBOutlet NSTableView *distributionsTableView;

- (IBAction)expandSelectedPackagesAction:(id)sender;
- (IBAction)extractOriginalsFromSelectedPackagesAction:(id)sender;
- (IBAction)extractPayloadFromSelectedPackagesAction:(id)sender;

@end
