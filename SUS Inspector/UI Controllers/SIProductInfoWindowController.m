//
//  SIProductInfoWindowController.m
//  SUS Inspector
//
//  Created by Hannes on 18.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIProductInfoWindowController.h"
#import "DataModelHeaders.h"

@interface SIProductInfoWindowController ()

@end

@implementation SIProductInfoWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
    }
    
    return self;
}

- (void)showWindow:(id)sender
{
    [super showWindow:sender];
    [[self.webView mainFrame] loadHTMLString:self.product.productDescription baseURL:nil];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor whiteColor]];
    
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
