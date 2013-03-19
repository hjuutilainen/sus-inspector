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

@interface SIProductInfoWindowController : NSWindowController

@property (retain) SUProductMO *product;
@property (assign) IBOutlet WebView *webView;

@end
