//
//  SIPkginfoMultipleWindowController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 24.4.2013.
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


#import "SIPkginfoMultipleWindowController.h"
#import "DataModelHeaders.h"

@interface SIPkginfoMultipleWindowController ()

@end

@implementation SIPkginfoMultipleWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        NSArray *restartActions = [NSArray arrayWithObjects:@"RequireShutdown", @"RequireRestart", @"RecommendRestart", @"RequireLogout", @"None", nil];
        self.restartActionTemplates = [restartActions sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (NSButton *)addPushButtonWithTitle:(NSString *)title identifier:(NSString *)identifier superView:(NSView *)superview
{
    NSButton *pushButton = [[[NSButton alloc] init] autorelease];
    [pushButton setIdentifier:identifier];
    [pushButton setBezelStyle:NSRoundedBezelStyle];
    [pushButton setFont:[NSFont systemFontOfSize:13.0]];
    [pushButton setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [pushButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superview addSubview:pushButton];
    if (title) [pushButton setTitle:title];
    
    [pushButton setTarget:self];
    
    return pushButton;
}

- (NSTextField *)addTextFieldWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
    NSTextField *textField = [[[NSTextField alloc] init] autorelease];
    [textField setIdentifier:identifier];
    [[textField cell] setControlSize:NSRegularControlSize];
    [textField setBordered:YES];
    [textField setBezeled:YES];
    [textField setSelectable:YES];
    [textField setEditable:YES];
    [textField setFont:[NSFont systemFontOfSize:13.0]];
    [textField setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superview addSubview:textField];
    return textField;
}

- (NSComboBox *)addComboBoxWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
    NSComboBox *textField = [[[NSComboBox alloc] init] autorelease];
    [textField setIdentifier:identifier];
    [[textField cell] setControlSize:NSRegularControlSize];
    [textField setBordered:YES];
    [textField setCompletes:YES];
    [textField setBezeled:YES];
    [textField setSelectable:YES];
    [textField setEditable:YES];
    [textField setFont:[NSFont systemFontOfSize:13.0]];
    [textField setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superview addSubview:textField];
    return textField;
}

- (NSTextField *)addLabelFieldWithTitle:(NSString *)title identifier:(NSString *)identifier superView:(NSView *)superview
{
    NSTextField *textField = [[[NSTextField alloc] init] autorelease];
    [textField setIdentifier:identifier];
    [textField setStringValue:title];
    [[textField cell] setControlSize:NSRegularControlSize];
    [textField setAlignment:NSRightTextAlignment];
    [textField setBordered:NO];
    [textField setBezeled:NO];
    [textField setSelectable:NO];
    [textField setEditable:NO];
    [textField setDrawsBackground:NO];
    [textField setFont:[NSFont boldSystemFontOfSize:13.0]];
    [textField setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superview addSubview:textField];
    return textField;
}

- (NSButton *)addCheckBoxWithTitle:(NSString *)title identifier:(NSString *)identifier superView:(NSView *)superView
{
    NSButton *checkBoxButton = [[[NSButton alloc] init] autorelease];
    [checkBoxButton setButtonType:NSSwitchButton];
    [checkBoxButton setTitle:title];
    [checkBoxButton setIdentifier:identifier];
    [checkBoxButton setStringValue:title];
    [checkBoxButton setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [checkBoxButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superView addSubview:checkBoxButton];
    return checkBoxButton;
}

- (void)setupPkginfoView:(NSView *)parentView
{
    
    /*
     Binding options
     */
    NSDictionary *textFieldOptions = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSContinuouslyUpdatesValueBindingOption, nil];
    NSFont *boldTitleFont = [NSFont boldSystemFontOfSize:13.0];
    
    NSMutableDictionary *views = [[[NSMutableDictionary alloc] init] autorelease];
    
    /*
     Display name field
     */
    
    NSButton *displayNameButton = [self addCheckBoxWithTitle:NSLocalizedString(@"Include Display Name", nil) identifier:@"displayNameButton" superView:parentView];
    [displayNameButton setFont:boldTitleFont];
    [displayNameButton bind:@"value" toObject:self withKeyPath:@"includeDisplayName" options:nil];
    
    NSButton *overrideDisplayNameButton = [self addCheckBoxWithTitle:NSLocalizedString(@"Override:", nil) identifier:@"overrideDisplayNameButton" superView:parentView];
    [overrideDisplayNameButton bind:@"value" toObject:self withKeyPath:@"overrideDisplayName" options:nil];
    [overrideDisplayNameButton bind:@"enabled" toObject:self withKeyPath:@"includeDisplayName" options:nil];
    
    NSTextField *displayNameField = [self addTextFieldWithidentifier:@"displayNameField" superView:parentView];
    [displayNameField bind:@"value" toObject:self withKeyPath:@"displayName" options:textFieldOptions];
    [displayNameField bind:@"enabled" toObject:self withKeyPath:@"overrideDisplayName" options:nil];
    
    NSDictionary *displayNameViews = NSDictionaryOfVariableBindings(displayNameButton, overrideDisplayNameButton, displayNameField);
    [views addEntriesFromDictionary:displayNameViews];
    
    /*
     Version field
     */
    
    NSButton *versionButton = [self addCheckBoxWithTitle:NSLocalizedString(@"Include Version", nil) identifier:@"versionButton" superView:parentView];
    [versionButton setFont:boldTitleFont];
    [versionButton bind:@"value" toObject:self withKeyPath:@"includeOriginalVersion" options:nil];
    
    NSButton *overrideVersionButton = [self addCheckBoxWithTitle:NSLocalizedString(@"Override:", nil) identifier:@"overrideVersionButton" superView:parentView];
    [overrideVersionButton bind:@"value" toObject:self withKeyPath:@"overrideVersion" options:nil];
    [overrideVersionButton bind:@"enabled" toObject:self withKeyPath:@"includeOriginalVersion" options:nil];
    
    NSTextField *versionField = [self addTextFieldWithidentifier:@"versionField" superView:parentView];
    [versionField bind:@"value" toObject:self withKeyPath:@"version" options:textFieldOptions];
    [versionField bind:@"enabled" toObject:self withKeyPath:@"overrideVersion" options:nil];
    
    NSDictionary *versionViews = NSDictionaryOfVariableBindings(versionButton, overrideVersionButton, versionField);
    [views addEntriesFromDictionary:versionViews];
    
    /*
     Catalogs token field
     */
    NSTextField *catalogsLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Catalogs", nil) identifier:@"catalogsLabel" superView:parentView];
    NSTokenField *catalogsTokenField = self.catalogsTokenField;
    [catalogsTokenField setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [catalogsTokenField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [catalogsTokenField setDelegate:self];
    [parentView addSubview:catalogsTokenField];
    [catalogsTokenField bind:@"value" toObject:self withKeyPath:@"munki_catalogs" options:textFieldOptions];
    
    NSDictionary *catalogViews = NSDictionaryOfVariableBindings(catalogsLabel, catalogsTokenField);
    [views addEntriesFromDictionary:catalogViews];
    
    /*
     Restart action
     */
    NSButton *restartActionButton = [self addCheckBoxWithTitle:NSLocalizedString(@"Restart Action", nil) identifier:@"restartActionButton" superView:parentView];
    [restartActionButton setFont:boldTitleFont];
    [restartActionButton bind:@"value" toObject:self withKeyPath:@"overrideRestartAction" options:nil];
    NSComboBox *restartActionField = [self addComboBoxWithidentifier:@"restartActionField" superView:parentView];
    [restartActionField bind:@"value" toObject:self withKeyPath:@"restartAction" options:textFieldOptions];
    [restartActionField bind:@"enabled" toObject:self withKeyPath:@"overrideRestartAction" options:nil];
    [restartActionField bind:@"contentValues" toObject:self withKeyPath:@"restartActionTemplates" options:nil];
    
    NSDictionary *restartActionViews = NSDictionaryOfVariableBindings(restartActionButton, restartActionField);
    [views addEntriesFromDictionary:restartActionViews];
    
    
    
    /*
     Unattended install label and check box
     */
    NSButton *unattendedButton = [self addCheckBoxWithTitle:NSLocalizedString(@"Unattended Install", nil) identifier:@"unattendedButton" superView:parentView];
    [unattendedButton setFont:boldTitleFont];
    [unattendedButton bind:@"value" toObject:self withKeyPath:@"includeUnattendedInstall" options:nil];
    
    NSDictionary *unattendedViews = NSDictionaryOfVariableBindings(unattendedButton);
    [views addEntriesFromDictionary:unattendedViews];
    
    /*
     Force install after date
     */
    NSButton *forceAfterButton = [self addCheckBoxWithTitle:NSLocalizedString(@"Force After", nil) identifier:@"forceAfterButton" superView:parentView];
    [forceAfterButton setFont:boldTitleFont];
    [forceAfterButton bind:@"value" toObject:self withKeyPath:@"includeForceInstallAfterDate" options:nil];
    
    NSDatePicker *forceAfterDatePicker = [[[NSDatePicker alloc] init] autorelease];
    [forceAfterDatePicker setIdentifier:@"forceAfterDatePicker"];
    [forceAfterDatePicker setDatePickerStyle:NSTextFieldAndStepperDatePickerStyle];
    [forceAfterDatePicker setDatePickerElements:( NSYearMonthDayDatePickerElementFlag | NSHourMinuteDatePickerElementFlag)];
    [[forceAfterDatePicker cell] setControlSize:NSRegularControlSize];
    [forceAfterDatePicker setBordered:YES];
    [forceAfterDatePicker setBezeled:YES];
    [forceAfterDatePicker setDrawsBackground:YES];
    [forceAfterDatePicker setFont:[NSFont systemFontOfSize:13.0]];
    [forceAfterDatePicker setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [forceAfterDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    /*
     Set the force_install_after_date date picker to use UTC
     */
    NSTimeZone *timeZoneUTC = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setTimeZone:timeZoneUTC];
    [forceAfterDatePicker setCalendar:gregorian];
    [forceAfterDatePicker setTimeZone:timeZoneUTC];
    
    [forceAfterDatePicker bind:@"value" toObject:self withKeyPath:@"forceInstallAfterDate" options:textFieldOptions];
    [forceAfterDatePicker bind:@"enabled" toObject:self withKeyPath:@"includeForceInstallAfterDate" options:nil];
    [parentView addSubview:forceAfterDatePicker];
    
    NSDictionary *forceAfterDateViews = NSDictionaryOfVariableBindings(forceAfterButton, forceAfterDatePicker);
    [views addEntriesFromDictionary:forceAfterDateViews];
    
        
    /*
     Create a correct key view loop
     */
    /*
    [self.window setInitialFirstResponder:displayNameField];
    [displayNameField setNextKeyView:versionField];
    [versionField setNextKeyView:catalogsTokenField];
    [catalogsTokenField setNextKeyView:restartActionField];
    [restartActionField setNextKeyView:descriptionTextView];
    [descriptionTextView setNextKeyView:displayNameField];
    */
    
    /*
     Text field layout
     */
    
    // Horizontal layout for display name
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[displayNameButton]-(>=20)-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[overrideDisplayNameButton]-[displayNameField]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:overrideDisplayNameButton
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:displayNameButton
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.f constant:20.0]];
    
    // Horizontal layout for version
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[versionButton]-(>=20)-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[overrideVersionButton]-[versionField]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:overrideVersionButton
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:versionButton
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.f constant:20.0]];
    
    // Horizontal layout for catalogs
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[catalogsLabel]-[catalogsTokenField(>=100)]-(>=20)-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    
    // Horizontal layout for restart action
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[restartActionButton]-[restartActionField(>=100)]-(>=20)-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    
    // Horizontal layout for unattended install
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[unattendedButton]-(>=20)-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    
    // Horizontal layout for force install after date
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[forceAfterButton]-[forceAfterDatePicker]-(>=20)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    
    // Vertical layout
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[displayNameButton]-[displayNameField]-[versionButton]-[versionField]-(20)-[catalogsTokenField]-(20)-[restartActionButton]-(20)-[unattendedButton]-(20)-[forceAfterButton]-(>=20)-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:views]];
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.window setBackgroundColor:[NSColor whiteColor]];
    [self.window center];
    
    NSView *contentView = [[self window] contentView];
    
    /*
     Configure the 'Save Pkginfo...' and 'Cancel' buttons
     */
    NSButton *savePkginfoButton = [self addPushButtonWithTitle:NSLocalizedString(@"Save Pkginfos...", nil) identifier:@"savePkginfoButton" superView:contentView];
    [savePkginfoButton setAction:@selector(savePkginfoAction:)];
    [savePkginfoButton setKeyEquivalent:@"s"];
    [savePkginfoButton setKeyEquivalentModifierMask:NSCommandKeyMask];
    NSButton *cancelButton = [self addPushButtonWithTitle:NSLocalizedString(@"Cancel", nil) identifier:@"cancelButton" superView:contentView];
    [cancelButton setAction:@selector(cancelSavePkginfoAction:)];
    [cancelButton setKeyEquivalent:@"\e"]; // escape
    
    /*
     Window layout
     */
    NSDictionary *topLevelComponents = NSDictionaryOfVariableBindings(savePkginfoButton, cancelButton);
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[cancelButton]-[savePkginfoButton]-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:topLevelComponents]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=20)-[savePkginfoButton]-|" options:0 metrics:nil views:topLevelComponents]];
    
    
    [self setupPkginfoView:contentView];
}



# pragma mark -
# pragma mark NSTokenFieldDelegate methods

- (NSArray *)tokenField:(NSTokenField *)tokenField completionsForSubstring:(NSString *)substring indexOfToken:(NSInteger)tokenIndex indexOfSelectedItem:(NSInteger *)selectedIndex
{
    NSArray *catalogDictsFromDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"defaultMunkiCatalogs"];
    NSArray *catalogs = [catalogDictsFromDefaults valueForKeyPath:@"title"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[d] %@", substring];
    NSArray *matchingCatalogs = [catalogs filteredArrayUsingPredicate:predicate];
    return matchingCatalogs;
}


@end
