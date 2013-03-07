//
//  SIMainWindowController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 5.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SIProgressWindowController;
@class SIProductsViewController;

@interface SIMainWindowController : NSWindowController <NSSplitViewDelegate>

@property (retain) SIProgressWindowController *progressWindowController;
@property (retain) SIProductsViewController *productsViewController;
@property (assign) IBOutlet NSView *leftView;
@property (assign) IBOutlet NSView *rightView;
@property (assign) IBOutlet NSSplitView *mainSplitView;

- (void)showProgressPanel;
- (void)hideProgressPanel;

@end
