//
//  SIReposadoSettingsController.h
//  SUS Inspector
//
//  Created by Hannes on 11.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataModelHeaders.h"

@class SIReposadoConfigurationController;

@protocol SIReposadoConfigurationControllerDelegate <NSObject>
@optional
- (void)reposadoConfigurationDidFinish:(id)sender returnCode:(int)returnCode object:(ReposadoInstanceMO *)object;
@end

@interface SIReposadoConfigurationController : NSWindowController {
    
}

@property (assign) IBOutlet NSButton *okButton;

@property (retain) id<SIReposadoConfigurationControllerDelegate> delegate;
@property (retain) NSUndoManager *undoManager;
@property (assign) ReposadoInstanceMO *reposadoInstance;
@property NSModalSession modalSession;

- (NSModalSession)beginEditSessionWithObject:(ReposadoInstanceMO *)instance delegate:(id)modalDelegate;
- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
