//
//  SIReposadoSettingsController.m
//  SUS Inspector
//
//  Created by Hannes on 11.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIReposadoConfigurationController.h"

@interface SIReposadoConfigurationController ()

@end

@implementation SIReposadoConfigurationController

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
    
    [self.window center];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (NSUndoManager*)windowWillReturnUndoManager:(NSWindow*)window
{
    if (!self.undoManager) {
        self.undoManager = [[NSUndoManager alloc] init];
    }
    return self.undoManager;
}

- (void)dealloc
{
    [_undoManager release];
    [super dealloc];
}

- (NSModalSession)beginEditSessionWithObject:(ReposadoInstanceMO *)instance delegate:(id)modalDelegate
{
    self.reposadoInstance = instance;
    self.delegate = modalDelegate;
    self.modalSession = [NSApp beginModalSessionForWindow:self.window];
    [NSApp runModalSession:self.modalSession];
    return self.modalSession;
}


- (IBAction)saveAction:(id)sender
{
    //[self commitChangesToCurrentPackage];
    
    [[self window] orderOut:sender];
    [NSApp endModalSession:self.modalSession];
    [NSApp stopModal];
    
    if ([self.delegate respondsToSelector:@selector(reposadoConfigurationDidFinish:returnCode:object:)]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.delegate reposadoConfigurationDidFinish:self returnCode:NSOKButton object:self.reposadoInstance];
        });
    }
}

- (IBAction)cancelAction:(id)sender
{
    [[self window] orderOut:sender];
    [NSApp endModalSession:self.modalSession];
    [NSApp stopModal];
    
    if ([self.delegate respondsToSelector:@selector(reposadoConfigurationDidFinish:returnCode:object:)]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.delegate reposadoConfigurationDidFinish:self returnCode:NSCancelButton object:self.reposadoInstance];
        });
    }
}

@end
