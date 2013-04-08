//
//  SIPreferencesController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 2.4.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIPreferencesController.h"

@interface SIPreferencesController ()

@end

@implementation SIPreferencesController

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


- (IBAction)addNewCatalogAction:(id)sender
{
    //Try to end any editing that is taking place in the table view
    NSWindow *w = [self.catalogsTableView window];
    BOOL endEdit = [w makeFirstResponder:w];
    if (!endEdit)
        return;
    
    //NSDictionary *newCatalog = [NSDictionary dictionaryWithObjectsAndKeys:@"newCatalog", @"title", [NSNumber numberWithBool:YES], @"enabled", nil];
    id newCatalog = [self.catalogsArrayController newObject];
    [newCatalog setObject:@"newCatalog" forKey:@"title"];
    [newCatalog setObject:[NSNumber numberWithBool:YES] forKey:@"enabled"];
    [self.catalogsArrayController addObject:newCatalog];
    [newCatalog release];
    
    //Rearrange the objects if there is a sort on any of the columns
    [self.catalogsArrayController rearrangeObjects];
    
    //Retrieve an array of the objects in your array controller and calculate
    //which row your new object is in
    NSArray *array = [self.catalogsArrayController arrangedObjects];
    NSUInteger row = [array indexOfObjectIdenticalTo:newCatalog];
    
    //Begin editing of the cell containing the new object
    [self.catalogsTableView editColumn:0 row:row withEvent:nil select:YES];
}

- (NSToolbarItem *)toolbarItemWithIdentifier:(NSString *)identifier
{
    NSToolbarItem *toolbarItem;
    toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:identifier];
    [toolbarItem setPaletteLabel:identifier];
    [toolbarItem setLabel:identifier];
    [toolbarItem setTarget:self];
    [toolbarItem setAction:@selector(switchViews:)];
    return toolbarItem;
}

- (void)awakeFromNib
{
    self.items = [[NSMutableDictionary alloc] init];
    
	NSToolbarItem *generalItem = [self toolbarItemWithIdentifier:@"General"];
    [generalItem setToolTip:NSLocalizedString(@"General preference options.", nil)];
    [generalItem setImage:[NSImage imageNamed:@"NSPreferencesGeneral"]];
    [self.items setObject:generalItem forKey:@"General"];
    [generalItem release];
    
    NSToolbarItem *munkiItem = [self toolbarItemWithIdentifier:@"Munki"];
    [munkiItem setToolTip:NSLocalizedString(@"Munki preference options.", nil)];
    [munkiItem setImage:[NSImage imageNamed:@"NSPreferencesGeneral"]];
    [self.items setObject:munkiItem forKey:@"Munki"];
    [munkiItem release];
    
    
    NSToolbarItem *advancedItem = [self toolbarItemWithIdentifier:@"Advanced"];
    [advancedItem setToolTip:NSLocalizedString(@"Advanced options.", nil)];
    [advancedItem setImage:[NSImage imageNamed:@"NSAdvanced"]];
    [self.items setObject:advancedItem forKey:@"Advanced"];
    [advancedItem release];
	
    //any other items you want to add, do so here.
    //after you are done, just do all the toolbar stuff.
    //myWindow is an outlet pointing to the Preferences Window you made to hold all these custom views.
	
    self.toolbar = [[[NSToolbar alloc] initWithIdentifier:@"preferencePanes"] autorelease];
    [self.toolbar setDelegate:self];
    [self.toolbar setAllowsUserCustomization:NO];
    [self.toolbar setAutosavesConfiguration:NO];
    [self.window setToolbar:self.toolbar];
	[self.window setShowsResizeIndicator:NO];
	[self.window setShowsToolbarButton:NO];
    [self.window center];
	[self.window makeKeyAndOrderFront:self];
    [self switchViews:nil];
}

- (void)switchViews:(NSToolbarItem *)item
{
    NSString *sender;
    if (item == nil) {
        sender = @"General";
        [self.toolbar setSelectedItemIdentifier:sender];
    } else {
        sender = [item label];
    }
	
    NSView *prefsView;
    [self.window setTitle:sender];
	
    if ([sender isEqualToString:@"General"]) {
        prefsView = self.generalView;
    } else if ([sender isEqualToString:@"Munki"]) {
        prefsView = self.munkiView;
    } else if ([sender isEqualToString:@"Advanced"]) {
        prefsView = self.advancedView;
    } else {
        prefsView = self.generalView;
    }
	
    NSView *tempView = [[NSView alloc] initWithFrame:[[self.window contentView] frame]];
    [self.window setContentView:tempView];
    [tempView release];
    
    NSRect newFrame = [self.window frame];
    newFrame.size.height = [prefsView frame].size.height + ([self.window frame].size.height - [[self.window contentView] frame].size.height);
    newFrame.size.width = [prefsView frame].size.width;
    newFrame.origin.y += ([[self.window contentView] frame].size.height - [prefsView frame].size.height);
    
    [self.window setShowsResizeIndicator:YES];
    [self.window setFrame:newFrame display:YES animate:YES];
    [self.window setContentView:prefsView];
}

# pragma mark -
# pragma mark NSToolbar delegate methods

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
    return [self.items objectForKey:itemIdentifier];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)theToolbar
{
    return [self toolbarDefaultItemIdentifiers:theToolbar];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)theToolbar
{
    return [NSArray arrayWithObjects:@"General", @"Munki", @"Advanced", nil];
}

- (NSArray *)toolbarSelectableItemIdentifiers: (NSToolbar *)toolbar
{
    return [self.items allKeys];
}


@end
