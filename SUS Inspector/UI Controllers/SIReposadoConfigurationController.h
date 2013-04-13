//
//  SIReposadoSettingsController.h
//  SUS Inspector
//
//  Created by Hannes on 11.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
@property (retain) NSString *customBaseURL;
@property (assign) IBOutlet NSArrayController *catalogsArrayController;
@property (assign) IBOutlet NSObjectController *reposadoInstanceObjectController;
@property (assign) IBOutlet NSTableView *catalogsTableView;

- (NSModalSession)beginEditSessionWithObject:(ReposadoInstanceMO *)instance delegate:(id)modalDelegate;
- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)resetCatalogsToDefaultAction:(id)sender;

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row __unused;
@end
