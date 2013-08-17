//
//  SIPkginfoWindowController.h
//  SUS Inspector
//
//  Created by Hannes Juutilainen on 19.3.2013.
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

@class SIProductMO;

@interface SIPkginfoWindowController : NSWindowController <NSWindowDelegate, NSTokenFieldDelegate, NSMenuDelegate>

+ (id)controllerWithProduct:(SIProductMO *)product;

# pragma mark -
# pragma mark Properties
@property (strong) SIProductMO *product;
@property (unsafe_unretained) id delegate;
@property (strong) NSString *munki_name;
@property (strong) NSString *munki_description;
@property (strong) NSString *munki_display_name;
@property (strong) NSString *munki_version;
@property (strong) NSString *munki_RestartAction;
@property (strong) NSArray *munki_blocking_applications;
@property (strong) NSArray *restartActionTemplates;
@property (strong) NSArray *munki_catalogs;
@property (strong) NSNumber *munki_unattended_install;
@property (strong) NSDate *munki_force_install_after_date;
@property (strong) NSNumber *munki_force_install_after_date_enabled;
@property (readonly, strong) NSString *pkginfo;
@property (readonly, strong) NSDictionary *pkginfoDict;

# pragma mark -
# pragma mark IBOutlets
@property (weak) IBOutlet NSView *leftSubView;
@property (weak) IBOutlet NSView *rightSubView;
@property (weak) IBOutlet NSSplitView *splitView;
@property (weak) IBOutlet NSPopUpButton *descriptionPopupButton;
@property (weak) IBOutlet NSTokenField *catalogsTokenField;
@property (weak) IBOutlet NSTokenField *blockingAppsTokenField;
@property (weak) IBOutlet NSPopUpButton *sharePopupButton;
@property (weak) IBOutlet NSMenuItem *sendToMunkiAdminMenuItem;
@property (weak) IBOutlet NSMenu *shareMenu;
@property (weak) IBOutlet NSMenu *descriptionMenu;
@property (weak) IBOutlet NSMenuItem *munkiimportCommandMenuItem;

# pragma mark -
# pragma mark IBActions
- (IBAction)populateDescriptionAction:(id)sender;
- (IBAction)clearDescriptionAction:(id)sender;
- (IBAction)htmlDescriptionToPlainText:(id)sender;


@end
