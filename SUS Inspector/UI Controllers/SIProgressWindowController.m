//
//  SIProgressWindowController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIProgressWindowController.h"
#import "SIOperationManager.h"

@interface SIProgressWindowController ()

@end

@implementation SIProgressWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)cancelAllOperationsAction:(id)sender
{
    //[[SIOperationManager sharedManager] cancelAllOperations];
}

@end
