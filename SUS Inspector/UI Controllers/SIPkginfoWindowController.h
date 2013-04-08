//
//  SIPkginfoWindowController.h
//  SUS Inspector
//
//  Created by Hannes Juutilainen on 19.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SUProductMO;

@interface SIPkginfoWindowController : NSWindowController <NSTokenFieldDelegate>

# pragma mark -
# pragma mark Properties
@property (retain) SUProductMO *product;
@property (retain) NSString *munki_name;
@property (retain) NSString *munki_description;
@property (retain) NSString *munki_display_name;
@property (retain) NSString *munki_version;
@property (retain) NSString *munki_RestartAction;
@property (retain) NSArray *munki_blocking_applications;
@property (retain) NSArray *restartActionTemplates;
@property (retain) NSArray *munki_catalogs;
@property (retain) NSNumber *munki_unattended_install;
@property (retain) NSDate *munki_force_install_after_date;
@property (retain) NSNumber *munki_force_install_after_date_enabled;
@property (readonly, retain) NSString *pkginfo;

# pragma mark -
# pragma mark IBOutlets
@property (assign) IBOutlet NSView *leftSubView;
@property (assign) IBOutlet NSView *rightSubView;
@property (assign) IBOutlet NSSplitView *splitView;
@property (assign) IBOutlet NSPopUpButton *descriptionPopupButton;
@property (assign) IBOutlet NSTokenField *catalogsTokenField;

# pragma mark -
# pragma mark IBActions
- (IBAction)populateDescriptionAction:(id)sender;
- (IBAction)clearDescriptionAction:(id)sender;
- (IBAction)htmlDescriptionToPlainText:(id)sender;


@end
