//
//  SICatalogsViewController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 8.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SICatalogsViewController : NSViewController <NSOutlineViewDelegate>

@property (assign) IBOutlet NSOutlineView *sourceListOutlineView;
@property (assign) IBOutlet NSTreeController *sourceListTreeController;
@property (assign) id delegate;

@end
