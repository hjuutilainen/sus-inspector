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

@dynamic pkginfo;

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
    self.munki_RestartAction = nil;
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

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	// Define keys that depend on
    if ([key isEqualToString:@"pkginfo"])
    {
        NSSet *affectingKeys = [NSSet setWithObjects:
                                @"munki_name",
                                @"munki_display_name",
                                @"munki_description",
                                @"munki_RestartAction",
                                @"munki_force_install_after_date_enabled",
                                @"munki_force_install_after_date",
                                @"munki_unattended_install",
                                nil];
        keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKeys];
    }
	
    return keyPaths;
}

- (NSString *)pkginfo
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (self.munki_name) [dict setObject:self.munki_name forKey:@"name"];
    if (self.munki_display_name) [dict setObject:self.munki_display_name forKey:@"display_name"];
    if (self.munki_description) [dict setObject:self.munki_description forKey:@"description"];
    if (self.munki_RestartAction) [dict setObject:self.munki_RestartAction forKey:@"RestartAction"];
    if ([self.munki_force_install_after_date_enabled boolValue]) {
        [dict setObject:self.munki_force_install_after_date forKey:@"force_install_after_date"];
    }
    if ([self.munki_unattended_install boolValue]) {
        [dict setValue:(id)kCFBooleanTrue forKey:@"unattended_install"];
    }
    
    NSError *error;
	id plist;
    plist = [NSPropertyListSerialization dataWithPropertyList:dict format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListImmutable error:&error];
    NSString *returnString = [[[NSString alloc] initWithData:plist encoding:NSUTF8StringEncoding] autorelease];
    return returnString;
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

- (void)setupPkginfoPreviewView:(NSView *)parentView
{
    [parentView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [parentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    id nameLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Pkginfo Preview", nil) identifier:@"nameLabel" superView:parentView];
    
    NSTextView *pkginfoTextView = [[[NSTextView alloc] initWithFrame:[parentView bounds]] autorelease];
    [pkginfoTextView setIdentifier:@"pkginfoTextView"];
    [pkginfoTextView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [pkginfoTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pkginfoTextView setRichText:NO];
    [pkginfoTextView setDrawsBackground:YES];
    NSFont *scriptFont = [NSFont fontWithName:@"Menlo Regular" size:11];
    [pkginfoTextView setFont:scriptFont];
    NSNumber *yes = [NSNumber numberWithBool:YES];
    NSNumber *no = [NSNumber numberWithBool:NO];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:no, NSConditionallySetsEditableBindingOption, yes, NSContinuouslyUpdatesValueBindingOption, yes, NSValidatesImmediatelyBindingOption, nil];
    [pkginfoTextView bind:@"value" toObject:self withKeyPath:@"pkginfo" options:options];
    [pkginfoTextView setEditable:NO];
    [pkginfoTextView setSelectable:YES];
    NSScrollView *pkginfoScrollView = [[[NSScrollView alloc] init] autorelease];
    [pkginfoScrollView setIdentifier:@"pkginfoScrollView"];
    [pkginfoScrollView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [pkginfoScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [pkginfoScrollView setBorderType:NSNoBorder];
    [pkginfoScrollView setHasVerticalScroller:YES];
    [pkginfoScrollView setHasHorizontalScroller:YES];
    [pkginfoScrollView setAutohidesScrollers:NO];
    [pkginfoScrollView setAutoresizesSubviews:YES];
    [pkginfoScrollView setDocumentView:pkginfoTextView];
    [parentView addSubview:pkginfoScrollView];
    
    NSDictionary *buttons = NSDictionaryOfVariableBindings(nameLabel, pkginfoTextView, pkginfoScrollView);
    
    [pkginfoScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pkginfoTextView(>=20)]|" options:NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    [pkginfoScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[pkginfoTextView(>=20)]|" options:NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    
    // Horizontal layout
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[nameLabel]-(>=0)-|" options:NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[pkginfoScrollView(>=400)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:buttons]];
    
    // Vertical layout
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nameLabel]-[pkginfoScrollView]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:buttons]];
}

- (void)setupPkginfoView:(NSView *)parentView
{
    
    /*
     Binding options
     */
    NSDictionary *textFieldOptions = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSContinuouslyUpdatesValueBindingOption, nil];
    
    /*
     Name field
     */
    id nameLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Name", nil) identifier:@"nameLabel" superView:parentView];
    id nameField = [self addTextFieldWithidentifier:@"nameField" superView:parentView];
    
    [nameField bind:@"value" toObject:self withKeyPath:@"munki_name" options:textFieldOptions];
    
    /*
     Display name field
     */
    id displayNameLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Display Name", nil) identifier:@"displayNameLabel" superView:parentView];
    id displayNameField = [self addTextFieldWithidentifier:@"displayNameField" superView:parentView];
    [displayNameField bind:@"value" toObject:self withKeyPath:@"munki_display_name" options:textFieldOptions];
    
    /*
     Restart Action field
     */
    id restartActionLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Restart Action", nil) identifier:@"restartActionLabel" superView:parentView];
    id restartActionField = [self addComboBoxWithidentifier:@"restartActionField" superView:parentView];
    [restartActionField bind:@"value" toObject:self withKeyPath:@"munki_RestartAction" options:textFieldOptions];
    
    /*
     Unattended install label and check box
     */
    id unattendedLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Unattended Install", nil) identifier:@"unattendedLabel" superView:parentView];
    [unattendedLabel setHidden:YES];
    NSButton *unattendedButton = [[[NSButton alloc] init] autorelease];
    [unattendedButton setButtonType:NSSwitchButton];
    [unattendedButton setTitle:NSLocalizedString(@"Unattended Install", nil)];
    [unattendedButton setIdentifier:@"unattendedButton"];
    [unattendedButton setStringValue:NSLocalizedString(@"Unattended Install", nil)];
    [unattendedButton setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [unattendedButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [unattendedButton bind:@"value" toObject:self withKeyPath:@"munki_unattended_install" options:nil];
    [parentView addSubview:unattendedButton];
    
    /*
     Force install after date
     */
    id forceAfterLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Force After", nil) identifier:@"forceAfterLabel" superView:parentView];
    
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
    [forceAfterDatePicker bind:@"value" toObject:self withKeyPath:@"munki_force_install_after_date" options:textFieldOptions];
    [forceAfterDatePicker bind:@"enabled" toObject:self withKeyPath:@"munki_force_install_after_date_enabled" options:nil];
    [parentView addSubview:forceAfterDatePicker];
    
    NSButton *forceAfterCheckBox = [[[NSButton alloc] init] autorelease];
    [forceAfterCheckBox setButtonType:NSSwitchButton];
    [forceAfterCheckBox setImagePosition:NSImageOnly];
    [forceAfterCheckBox setIdentifier:@"forceAfterCheckBox"];
    [forceAfterCheckBox setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [forceAfterCheckBox setTranslatesAutoresizingMaskIntoConstraints:NO];
    [forceAfterCheckBox bind:@"value" toObject:self withKeyPath:@"munki_force_install_after_date_enabled" options:nil];
    [parentView addSubview:forceAfterCheckBox];
    
    /*
     Description text view
     */
    id descriptionLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Description", nil) identifier:@"descriptionLabel" superView:parentView];
    
    NSScrollView *descriptionScroll = [[[NSScrollView alloc] initWithFrame:[parentView bounds]] autorelease];
    NSSize contentSize = [descriptionScroll contentSize];
    [descriptionScroll setIdentifier:@"descriptionScroll"];
    [descriptionScroll setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [descriptionScroll setTranslatesAutoresizingMaskIntoConstraints:NO];
    [descriptionScroll setBorderType:NSBezelBorder];
    [descriptionScroll setHasVerticalScroller:YES];
    [descriptionScroll setHasHorizontalScroller:NO];
    [descriptionScroll setAutohidesScrollers:NO];
    //[descriptionScroll setAutoresizesSubviews:NO];
    
    NSTextView *descriptionTextView = [[[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, contentSize.width, contentSize.height)] autorelease];
    [descriptionTextView setIdentifier:@"descriptionTextView"];
    [descriptionTextView setAutoresizingMask:NSViewWidthSizable];
    [descriptionTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [descriptionTextView setRichText:NO];
    [descriptionTextView setDrawsBackground:YES];
    
    [descriptionTextView setMinSize:NSMakeSize(0.0, contentSize.height)];
    [descriptionTextView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [descriptionTextView setVerticallyResizable:YES];
    [descriptionTextView setHorizontallyResizable:NO];
    [descriptionTextView setAutoresizingMask:NSViewWidthSizable];
    [[descriptionTextView textContainer] setContainerSize:NSMakeSize(contentSize.width, FLT_MAX)];
    [[descriptionTextView textContainer] setWidthTracksTextView:YES];
    
    NSNumber *yes = [NSNumber numberWithBool:YES];
    NSNumber *no = [NSNumber numberWithBool:NO];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:no, NSConditionallySetsEditableBindingOption, yes, NSContinuouslyUpdatesValueBindingOption, yes, NSValidatesImmediatelyBindingOption, nil];
    [descriptionTextView bind:@"value" toObject:self withKeyPath:@"munki_description" options:options];
    
    [descriptionScroll setDocumentView:descriptionTextView];
    [parentView addSubview:descriptionScroll];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(nameLabel, nameField,
                                                         displayNameField, displayNameLabel,
                                                         restartActionField, restartActionLabel,
                                                         unattendedLabel, unattendedButton,
                                                         forceAfterLabel, forceAfterCheckBox, forceAfterDatePicker,
                                                         descriptionLabel, descriptionTextView, descriptionScroll);
    
    
    
    
    /*
     Text field layout
     */
    
    // Horizontal layout
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[nameLabel]-[nameField(>=20)]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[displayNameLabel]-[displayNameField(>=20)]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[restartActionLabel]-[restartActionField(>=20)]-|" options:NSLayoutFormatAlignAllBaseline metrics:nil views:views]];
    
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[forceAfterLabel]-[forceAfterCheckBox]-[forceAfterDatePicker(>=20)]-[unattendedButton]-|" options:0 metrics:nil views:views]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:forceAfterLabel
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:forceAfterDatePicker
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.f constant:0.f]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:forceAfterCheckBox
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:forceAfterDatePicker
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.f constant:0.f]];
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:unattendedButton
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:forceAfterDatePicker
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.f constant:0.f]];
    
    [descriptionScroll addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[descriptionTextView(>=20)]|" options:0 metrics:nil views:views]];
    [descriptionScroll addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[descriptionTextView(>=20)]|" options:0 metrics:nil views:views]];
    [descriptionScroll setContentHuggingPriority:NSLayoutPriorityDefaultLow - 1 forOrientation:NSLayoutConstraintOrientationHorizontal];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[descriptionLabel]-[descriptionScroll(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    /*
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:descriptionScroll
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:savePkginfoButton
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.f constant:-8.0]];
    */
    
    
    
    // Vertical layout
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nameField]-[displayNameField]-[restartActionField]-(16)-[forceAfterCheckBox]-(16)-[descriptionScroll(>=200)]-(>=0)-|"
                                                                        options:NSLayoutFormatAlignAllLeading
                                                                        metrics:nil
                                                                          views:views]];
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.window bind:@"title" toObject:self withKeyPath:@"product.productTitleWithVersion" options:nil];
    
    /*
     Configure the main split view
     */
    NSSplitView *splitView = self.splitView;
    [splitView setDividerStyle:NSSplitViewDividerStyleThin];
    [splitView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [splitView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSView *contentView = [[self window] contentView];
    
    /*
     Configure the 'Save Pkginfo...' and 'Cancel' buttons
     */
    NSButton *savePkginfoButton = [self addPushButtonWithTitle:NSLocalizedString(@"Save Pkginfo...", nil) identifier:@"savePkginfoButton" superView:contentView];
    [savePkginfoButton setAction:@selector(savePkginfoAction:)];
    NSButton *cancelButton = [self addPushButtonWithTitle:NSLocalizedString(@"Cancel", nil) identifier:@"cancelButton" superView:contentView];
    [cancelButton setAction:@selector(cancelSavePkginfoAction:)];
    
    /*
     Window layout
     */
    NSDictionary *topLevelComponents = NSDictionaryOfVariableBindings(splitView, savePkginfoButton, cancelButton);
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[cancelButton]-[savePkginfoButton]-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:topLevelComponents]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[splitView]-(20)-[savePkginfoButton]-|" options:0 metrics:nil views:topLevelComponents]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[splitView]|" options:NSLayoutFormatAlignAllBottom metrics:nil views:topLevelComponents]];
    
    /*
     Split view children layout
     */
    NSView *leftSubView = self.leftSubView;
    NSView *rightSubView = self.rightSubView;
    [self setupPkginfoPreviewView:rightSubView];
    [self setupPkginfoView:leftSubView];
    
}


@end
