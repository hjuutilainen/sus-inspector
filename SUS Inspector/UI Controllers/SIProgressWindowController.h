//
//  SIProgressWindowController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SIProgressWindowController : NSWindowController

@property (assign) IBOutlet NSProgressIndicator *progressIndicator;
@property (assign) IBOutlet NSTextField *statusText;
@property (assign) IBOutlet NSTextField *statusTextSmall;

@end
