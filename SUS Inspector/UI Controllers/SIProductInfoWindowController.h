//
//  SIProductInfoWindowController.h
//  SUS Inspector
//
//  Created by Hannes on 18.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
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
