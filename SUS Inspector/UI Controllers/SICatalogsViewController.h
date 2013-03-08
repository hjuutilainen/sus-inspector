//
//  SICatalogsViewController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 8.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SICatalogsViewController : NSViewController

@property (assign) IBOutlet NSArrayController *catalogsArrayController;
@property (assign) IBOutlet NSTableView *catalogsTableView;
@property (assign) IBOutlet NSOutlineView *sourceListOutlineView;

@end
