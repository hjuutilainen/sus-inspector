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

@interface SIProductInfoWindowController : NSWindowController <NSTokenFieldDelegate>

@property (retain) SUProductMO *product;
@property (retain) NSArray *catalogs;
@property (assign) IBOutlet WebView *webView;
@property (assign) IBOutlet NSArrayController *catalogsArrayController;
@property (assign) IBOutlet NSTokenField *catalogsTokenField;

@end
