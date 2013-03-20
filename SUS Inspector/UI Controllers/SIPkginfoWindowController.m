//
//  SIPkginfoWindowController.m
//  SUS Inspector
//
//  Created by Hannes Juutilainen on 19.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIPkginfoWindowController.h"
#import "DataModelHeaders.h"

@interface SIPkginfoWindowController ()

@end

@implementation SIPkginfoWindowController

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
    [self.window setBackgroundColor:[NSColor whiteColor]];
    [self.window center];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)showWindow:(id)sender
{
    [super showWindow:sender];
    self.munki_name = self.product.productID;
    self.munki_display_name = self.product.productTitle;
    self.munki_description = self.product.productDescription;
    self.munki_RestartAction = @"";
    self.munki_description = self.product.productDescription;
    
    
    NSDate *now = [NSDate date];
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *dateComponents = [gregorian components:( NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:now];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    NSDate *normalizedDate = [gregorian dateFromComponents:dateComponents];
    
    NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init] autorelease];
    [offsetComponents setDay:7];
    NSDate *newDate = [gregorian dateByAddingComponents:offsetComponents toDate:normalizedDate options:0];
    
    self.munki_force_install_after_date = newDate;
    self.munki_force_install_after_date_enabled = [NSNumber numberWithBool:NO];
    
}

- (void)savePkginfoAction:(id)sender
{
    NSLog(@"savePkginfoAction");
}

- (void)cancelSavePkginfoAction:(id)sender
{
    NSLog(@"cancelSavePkginfoAction");
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


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    /*
     Add views to the window.
     */
    
    [self.window bind:@"title" toObject:self withKeyPath:@"product.productTitleWithVersion" options:nil];
    
    NSView *contentView = [[self window] contentView];
    
    /*
     'Save Pkginfo...' and 'Cancel' buttons
     */
    id savePkginfoButton = [self addPushButtonWithTitle:NSLocalizedString(@"Save Pkginfo...", nil) identifier:@"savePkginfoButton" superView:contentView];
    [savePkginfoButton setAction:@selector(savePkginfoAction:)];
    id cancelButton = [self addPushButtonWithTitle:NSLocalizedString(@"Cancel", nil) identifier:@"cancelButton" superView:contentView];
    [cancelButton setAction:@selector(cancelSavePkginfoAction:)];
    
    /*
     Name field
     */
    id nameLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Name", nil) identifier:@"nameLabel" superView:contentView];
    id nameField = [self addTextFieldWithidentifier:@"nameField" superView:contentView];
    [nameField bind:@"value" toObject:self withKeyPath:@"munki_name" options:nil];
    
    /*
     Display name field
     */
    id displayNameLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Display Name", nil) identifier:@"displayNameLabel" superView:contentView];
    id displayNameField = [self addTextFieldWithidentifier:@"displayNameField" superView:contentView];
    [displayNameField bind:@"value" toObject:self withKeyPath:@"munki_display_name" options:nil];
    
    /*
     Restart Action field
     */
    id restartActionLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Restart Action", nil) identifier:@"restartActionLabel" superView:contentView];
    id restartActionField = [self addComboBoxWithidentifier:@"restartActionField" superView:contentView];
    [restartActionField bind:@"value" toObject:self withKeyPath:@"munki_RestartAction" options:nil];
    
    /*
     Unattended install label and check box
     */
    id unattendedLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Unattended Install", nil) identifier:@"unattendedLabel" superView:contentView];
    [unattendedLabel setHidden:YES];
    NSButton *unattendedButton = [[[NSButton alloc] init] autorelease];
    [unattendedButton setButtonType:NSSwitchButton];
    [unattendedButton setTitle:NSLocalizedString(@"Unattended Install", nil)];
    [unattendedButton setIdentifier:@"unattendedButton"];
    [unattendedButton setStringValue:NSLocalizedString(@"Unattended Install", nil)];
    [unattendedButton setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [unattendedButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [unattendedButton bind:@"value" toObject:self withKeyPath:@"munki_unattended_install" options:nil];
    [contentView addSubview:unattendedButton];
    
    /*
     Force install after date
     */
    id forceAfterLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Force After", nil) identifier:@"forceAfterLabel" superView:contentView];
    
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
    [forceAfterDatePicker bind:@"value" toObject:self withKeyPath:@"munki_force_install_after_date" options:nil];
    [forceAfterDatePicker bind:@"enabled" toObject:self withKeyPath:@"munki_force_install_after_date_enabled" options:nil];
    [contentView addSubview:forceAfterDatePicker];
    
    NSButton *forceAfterCheckBox = [[[NSButton alloc] init] autorelease];
    [forceAfterCheckBox setButtonType:NSSwitchButton];
    [forceAfterCheckBox setImagePosition:NSImageOnly];
    [forceAfterCheckBox setIdentifier:@"forceAfterCheckBox"];
    [forceAfterCheckBox setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [forceAfterCheckBox setTranslatesAutoresizingMaskIntoConstraints:NO];
    [forceAfterCheckBox bind:@"value" toObject:self withKeyPath:@"munki_force_install_after_date_enabled" options:nil];
    [contentView addSubview:forceAfterCheckBox];
    
    /*
     Description text view
     */
    id decsriptionLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Description", nil) identifier:@"decsriptionLabel" superView:contentView];
    NSTextView *descriptionTextView = [[[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 10, 10)] autorelease];
    [descriptionTextView setIdentifier:@"descriptionTextView"];
    [descriptionTextView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [descriptionTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [descriptionTextView setRichText:NO];
    [descriptionTextView setDrawsBackground:YES];
    [descriptionTextView bind:@"value" toObject:self withKeyPath:@"munki_description" options:nil];
    NSScrollView *descriptionScroll = [[[NSScrollView alloc] init] autorelease];
    [descriptionScroll setIdentifier:@"descriptionScroll"];
    [descriptionScroll setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [descriptionScroll setTranslatesAutoresizingMaskIntoConstraints:NO];
    [descriptionScroll setBorderType:NSBezelBorder];
    [descriptionScroll setDocumentView:descriptionTextView];
    [contentView addSubview:descriptionScroll];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(nameLabel, nameField,
                                                         displayNameField, displayNameLabel,
                                                         restartActionField, restartActionLabel,
                                                         unattendedLabel, unattendedButton,
                                                         forceAfterLabel, forceAfterCheckBox, forceAfterDatePicker,
                                                         decsriptionLabel, descriptionTextView, descriptionScroll);
    
    NSDictionary *buttons = NSDictionaryOfVariableBindings(savePkginfoButton, cancelButton);
    
    
    /*
     Button Layout
     */
    
    // Horizontal layout
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[cancelButton]-[savePkginfoButton]-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:buttons]];
    
    // Vertical layout
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=20)-[savePkginfoButton]-|" options:0 metrics:nil views:buttons]];
    
    
    /*
     Text field layout
     */
    
    // Horizontal layout
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[nameLabel]-[nameField(>=20)]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[displayNameLabel]-[displayNameField(>=20)]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[restartActionLabel]-[restartActionField(>=20)]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[forceAfterLabel]-[forceAfterCheckBox]-[forceAfterDatePicker(>=20)]-[unattendedButton]-|" options:0 metrics:nil views:views]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:forceAfterLabel
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:forceAfterDatePicker
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.f constant:0.f]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:forceAfterCheckBox
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:forceAfterDatePicker
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.f constant:0.f]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:unattendedButton
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:forceAfterDatePicker
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.f constant:0.f]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descriptionTextView(>=20)]|" options:0 metrics:nil views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[descriptionTextView(>=20)]|" options:0 metrics:nil views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[decsriptionLabel]-[descriptionScroll(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionScroll
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:savePkginfoButton
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.f constant:-8.0]];
    
    
    
    // Vertical layout
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nameField]-[displayNameField]-[restartActionField]-(16)-[forceAfterCheckBox]-(16)-[descriptionScroll(>=20)]-(>=0)-|"
                                                                        options:NSLayoutFormatAlignAllLeading
                                                                        metrics:nil
                                                                          views:views]];
    
}


@end
