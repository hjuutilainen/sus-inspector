//
//  SIProductInfoWindowController.m
//  SUS Inspector
//
//  Created by Hannes on 18.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIProductInfoWindowController.h"
#import "DataModelHeaders.h"
#import "SISizeFormatter.h"

@interface SIProductInfoWindowController ()

@end

@implementation SIProductInfoWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [[NSApp delegate] managedObjectContext];
}

- (void)showWindow:(id)sender
{
    [self.window center];
    [super showWindow:sender];
        
    [[self.descriptionWebView mainFrame] loadHTMLString:self.product.productDescription baseURL:nil];
    
    NSPredicate *notDeprecated = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/deprecated"];
    NSPredicate *notAll = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/all"];
    NSPredicate *isActive = [NSPredicate predicateWithFormat:@"isActive == TRUE"];
    NSArray *subPredicates = [NSArray arrayWithObjects:notAll, notDeprecated, isActive, nil];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    NSArray *temp = [[self.product.catalogs allObjects] filteredArrayUsingPredicate:predicate];
    NSSortDescriptor *byOS = [NSSortDescriptor sortDescriptorWithKey:@"catalogOSVersion" ascending:NO selector:@selector(localizedStandardCompare:)];
    self.catalogs = [temp sortedArrayUsingDescriptors:[NSArray arrayWithObjects:byOS, nil]];

}


- (NSTextField *)addTextFieldWithidentifier:(NSString *)identifier superView:(NSView *)superview
{
    NSTextField *textField = [[[NSTextField alloc] init] autorelease];
    [textField setIdentifier:identifier];
    [[textField cell] setControlSize:NSRegularControlSize];
    [textField setBordered:NO];
    [textField setBezeled:NO];
    [textField setSelectable:YES];
    [textField setEditable:NO];
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



- (void)setupProductInfoView:(NSView *)parentView
{
    
    /*
     Binding options
     */
    NSDictionary *bindOptions = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSContinuouslyUpdatesValueBindingOption, nil];
    
    /*
     Window
     */
    [self.window bind:@"title" toObject:self withKeyPath:@"product.productTitleWithVersion" options:nil];
    
    /*
     Name field
     */
    NSTextField *nameLabel = [self addTextFieldWithidentifier:@"nameLabel" superView:parentView];
    [nameLabel setFont:[NSFont boldSystemFontOfSize:16.0]];
    [nameLabel bind:@"value" toObject:self withKeyPath:@"product.productTitle" options:bindOptions];
    
    
    /*
     Product ID
     */
    NSTextField *productIDLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Product ID", nil) identifier:@"productIDLabel" superView:parentView];
    NSTextField *productIDTextField = [self addTextFieldWithidentifier:@"productIDTextField" superView:parentView];
    [productIDTextField bind:@"value" toObject:self withKeyPath:@"product.productID" options:bindOptions];
    
    /*
     Version
     */
    NSTextField *productVersionLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Version", nil) identifier:@"productVersionLabel" superView:parentView];
    NSTextField *productVersionTextField = [self addTextFieldWithidentifier:@"productVersionTextField" superView:parentView];
    [productVersionTextField bind:@"value" toObject:self withKeyPath:@"product.productVersion" options:bindOptions];
    
    /*
     Released date
     */
    NSTextField *productReleasedLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Released", nil) identifier:@"productReleasedLabel" superView:parentView];
    NSTextField *productReleasedTextField = [self addTextFieldWithidentifier:@"productReleasedTextField" superView:parentView];
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [productReleasedTextField setFormatter:dateFormatter];
    [productReleasedTextField bind:@"value" toObject:self withKeyPath:@"product.productPostDate" options:bindOptions];
    
    
    /*
     Size
     */
    NSTextField *productSizeLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Size", nil) identifier:@"productSizeLabel" superView:parentView];
    NSTextField *productSizeTextField = [self addTextFieldWithidentifier:@"productSizeTextField" superView:parentView];
    SISizeFormatter *fileSizeFormatter = [[[SISizeFormatter alloc] init] autorelease];
    [productSizeTextField setFormatter:fileSizeFormatter];
    [productSizeTextField bind:@"value" toObject:self withKeyPath:@"product.productSize" options:bindOptions];
    
    
    /*
     Catalogs token field
     */
    NSTextField *productCatalogsLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Catalogs", nil) identifier:@"productCatalogsLabel" superView:parentView];
    NSTokenField *productCatalogsTokenField = [[[NSTokenField alloc] init] autorelease];
    [productCatalogsTokenField setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [productCatalogsTokenField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [productCatalogsTokenField setDelegate:self];
    [productCatalogsTokenField setBordered:NO];
    [productCatalogsTokenField setBezeled:NO];
    [productCatalogsTokenField setSelectable:YES];
    [productCatalogsTokenField setEditable:NO];
    [parentView addSubview:productCatalogsTokenField];
    [productCatalogsTokenField bind:@"value" toObject:self withKeyPath:@"catalogs" options:bindOptions];
    
    /*
     Separator 1
     */
    /*
    NSBox *separatorLine1 = [[[NSBox alloc] init] autorelease];
    [separatorLine1 setBoxType:NSBoxSeparator];
    [separatorLine1 setAutoresizingMask:NSViewWidthSizable];
    [separatorLine1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addSubview:separatorLine1];
    */
    
    /*
     Tab view
     */
    NSView *tabContainerView = self.tabContainerView;
    [tabContainerView setIdentifier:@"tabContainerView"];
    [tabContainerView setAutoresizingMask:(NSViewWidthSizable|NSViewHeightSizable)];
    [tabContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [tabContainerView setAutoresizesSubviews:YES];
    [parentView addSubview:tabContainerView];
    
    
    
    
    /*
     Packages table view
     */
    /*
    NSTextField *packagesLabel = [self addLabelFieldWithTitle:NSLocalizedString(@"Packages", nil) identifier:@"packagesLabel" superView:parentView];
    //NSTableView *packagesTableView = self.packagesTableView;
    //[packagesTableView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    //[packagesTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSScrollView *packagesScrollView = self.packagesScrollView;
    [packagesScrollView setIdentifier:@"packagesScrollView"];
    [packagesScrollView setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
    [packagesScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [packagesScrollView setBorderType:NSBezelBorder];
    [packagesScrollView setHasVerticalScroller:YES];
    [packagesScrollView setHasHorizontalScroller:YES];
    [packagesScrollView setAutohidesScrollers:NO];
    [packagesScrollView setAutoresizesSubviews:YES];
    //[packagesScrollView setDocumentView:packagesTableView];
    [parentView addSubview:packagesScrollView];
    */
    
    /*
     Separator 2
     */
    /*
    NSBox *separatorLine2 = [[[NSBox alloc] init] autorelease];
    [separatorLine2 setBoxType:NSBoxSeparator];
    [separatorLine2 setAutoresizingMask:NSViewWidthSizable];
    [separatorLine2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [parentView addSubview:separatorLine2];
    */
    
    /*
     Description web view
     */
    
    WebView *webView = self.descriptionWebView;
    [webView setPolicyDelegate:self];
    [webView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    //[webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [webView setShouldCloseWithWindow:NO];
    [webView setShouldUpdateWhileOffscreen:YES];
    [webView setDrawsBackground:YES];
    //NSDictionary *tabViewChildren = NSDictionaryOfVariableBindings(webView);
    
    //[tabView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[webView(>=300)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:tabViewChildren]];
    //[tabView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[webView(>=300)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:tabViewChildren]];
     
    NSDictionary *views = NSDictionaryOfVariableBindings(nameLabel,
                                                         productIDLabel, productIDTextField,
                                                         productVersionLabel, productVersionTextField,
                                                         productReleasedLabel, productReleasedTextField,
                                                         productSizeLabel, productSizeTextField,
                                                         productCatalogsLabel, productCatalogsTokenField,
                                                         //separatorLine1,
                                                         tabContainerView
                                                         //packagesLabel, packagesScrollView,
                                                         //separatorLine2,
                                                         //webView
                                                         );
    
    
    
    /*
     Create a correct key view loop
     */
    /*
    [self.window setInitialFirstResponder:displayNameField];
    [displayNameField setNextKeyView:catalogsTokenField];
    [catalogsTokenField setNextKeyView:restartActionField];
    [restartActionField setNextKeyView:descriptionTextView];
    [descriptionTextView setNextKeyView:displayNameField];
    */
    
    /*
     Text field layout
     */
    
    // Horizontal layout
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[nameLabel(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[productIDLabel]-[productIDTextField(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[productVersionLabel]-[productVersionTextField(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[productReleasedLabel]-[productReleasedTextField(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[productSizeLabel]-[productSizeTextField(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[productCatalogsLabel]-[productCatalogsTokenField(>=20)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    //[parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[separatorLine1]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tabContainerView(>=100)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    //[parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[packagesLabel]-[packagesScrollView(>=300)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    //[parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[separatorLine2]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    //[parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[webView(>=300)]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:views]];
    
    NSArray *textFields = [NSArray arrayWithObjects:productIDTextField, productVersionTextField, productReleasedTextField, productSizeTextField, productCatalogsTokenField, nil];
    for (NSView *view in textFields) {
        [view setContentHuggingPriority:NSLayoutPriorityDefaultLow - 1 forOrientation:NSLayoutConstraintOrientationHorizontal];
    }
    
    
    // Vertical layout
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(12)-[nameLabel]-(12)-[productIDLabel]-[productVersionLabel]-[productReleasedLabel]-[productSizeLabel]-[productCatalogsLabel]-(12)-[tabContainerView(>=100)]-|"//-[packagesLabel]-[separatorLine2]-[webView(>=200)]-|"
                                                                       options:NSLayoutFormatAlignAllLeading
                                                                       metrics:nil
                                                                         views:views]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[productIDTextField]-[productVersionTextField]-[productReleasedTextField]-[productSizeTextField]-[productCatalogsTokenField]-(>=20)-|"
                                                                       options:NSLayoutFormatAlignAllLeading
                                                                       metrics:nil
                                                                         views:views]];
    /*
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorLine1]-[packagesScrollView(>=100)]-[separatorLine2]"
                                                                       options:NSLayoutFormatAlignAllTrailing
                                                                       metrics:nil
                                                                         views:views]];
    */
    
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.window center];
    
    [self setupProductInfoView:[self.window contentView]];
    
    NSSortDescriptor *sortByFileName = [NSSortDescriptor sortDescriptorWithKey:@"packageFilename" ascending:YES selector:@selector(localizedStandardCompare:)];
    [self.packagesArrayController setSortDescriptors:[NSArray arrayWithObjects:sortByFileName, nil]];
    
    [self.tabView setTabViewType:NSNoTabsNoBorder];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor whiteColor]];
    
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
    //[[self.descriptionWebView mainFrame] loadHTMLString:self.product.productDescription baseURL:nil];
    /*
    [[tabViewItem view] setNeedsDisplay:YES];
    NSLog([self.descriptionWebView isHidden] ? @"Hidden: Yes" : @"Hidden: No");
    NSLog(@"%@", NSStringFromRect([self.descriptionWebView bounds]));
    [self.descriptionWebView setFrame:[[tabViewItem view] bounds]];
    [self.descriptionWebView setNeedsUpdateConstraints:YES];
    [self.descriptionWebView setNeedsDisplay:YES];
    [self.descriptionWebView reload:self];
    */
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id < WebPolicyDecisionListener >)listener
{
    NSString *host = [[request URL] host];
    if (host) {
        [[NSWorkspace sharedWorkspace] openURL:[request URL]];
    } else {
        [listener use];
    }
}


// Convert the Contact entity into a displayable string for the token
- (NSString *)tokenField:(NSTokenField *)tokenField displayStringForRepresentedObject:(id)representedObject
{
    SUCatalogMO *catalog = (SUCatalogMO *)representedObject;
    return [NSString stringWithFormat:@"%@", catalog.catalogDisplayName];
}


@end
