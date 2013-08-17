//
//  SIPreferencesController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 2.4.2013.
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
    // Try to end any editing that is taking place in the table view
    NSWindow *window = [self.catalogsTableView window];
    BOOL endEdit = [window makeFirstResponder:window];
    if (!endEdit)
        return;
    
    // Create a new catalog
    id newCatalog = [self.catalogsArrayController newObject];
    [newCatalog setObject:@"newCatalog" forKey:@"title"];
    [newCatalog setObject:[NSNumber numberWithBool:YES] forKey:@"enabled"];
    [self.catalogsArrayController addObject:newCatalog];
    
    // Rearrange the objects if there is a sort on any of the columns
    [self.catalogsArrayController rearrangeObjects];
    
    // Get the index of the object we just created
    NSArray *array = [self.catalogsArrayController arrangedObjects];
    NSUInteger row = [array indexOfObject:newCatalog];
    
    // Edit the cell containing the new object
    [self.catalogsTableView editColumn:1 row:row withEvent:nil select:YES];
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

- (void)setupTextEditor
{
    /*
     NSString *utiValue;
     NSURL *url = [NSURL fileURLWithPath:myFilePath];
     [url getResourceValue:&utiValue forKey:NSURLTypeIdentifierKey error:nil];
     if (utiValue)
     {
     NSLog(@"UTI: %@", utiValue);
     }
     
     NSString *fileUTIByExt = [(NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
     (CFStringRef)[myFilePath pathExtension],
     NULL) autorelease];
     //NSLog(@"Filetype UTI: %@", fileUTIByExt);
     NSArray *allUTIsForExt = [(NSArray *)UTTypeCreateAllIdentifiersForTag(kUTTagClassFilenameExtension,
     (CFStringRef)[myFilePath pathExtension], NULL) autorelease];
     for (NSString *subUTI in allUTIsForExt) {
     NSLog(@"Filetype UTI: %@", subUTI);
     }
     */
    
    CFStringRef distUTI = CFSTR("public.text");
    [self.distApplicationsPopUpButton removeAllItems];
    
    NSArray *roleHandlers = (__bridge_transfer NSArray *)LSCopyAllRoleHandlersForContentType(distUTI, kLSRolesAll);
    NSMutableArray *appDicts = [[NSMutableArray alloc] init];
    for (NSString *bundleIdentifier in roleHandlers) {
        NSString *path = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:bundleIdentifier];
        NSString *name = [[NSFileManager defaultManager] displayNameAtPath:path];
        NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:path];
        [icon setSize:NSMakeSize(16, 16)];
        NSDictionary *appDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 path, @"path",
                                 name, @"name",
                                 icon, @"icon", nil];
        [appDicts addObject:appDict];
    }
    NSSortDescriptor *byTitle = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
    for (NSDictionary *appDict in [appDicts sortedArrayUsingDescriptors:[NSArray arrayWithObject:byTitle]]) {
        NSMenuItem *menuItem = [[NSMenuItem alloc] init];
        menuItem.title = [appDict objectForKey:@"name"];
        menuItem.image = [appDict objectForKey:@"icon"];
        menuItem.representedObject = [appDict objectForKey:@"path"];
        [[self.distApplicationsPopUpButton menu] addItem:menuItem];
    }
    
    // Determine the default
    NSString *defaultHandler = (__bridge_transfer NSString *)LSCopyDefaultRoleHandlerForContentType(distUTI, kLSRolesAll);
    NSString *defaultHandlerPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:defaultHandler];
    NSString *appPath = [[NSUserDefaults standardUserDefaults] stringForKey:@"distFileViewerPath"];
    if (appPath == nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:defaultHandlerPath forKey:@"distFileViewerPath"];
        [defaults synchronize];
    }
}

- (void)setupLocales
{
    [self.languagesPopupButton removeAllItems];
    
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    //NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSMutableArray *langDicts = [[NSMutableArray alloc] init];
    NSMutableArray *mutableLanguageIDs = [[NSMutableArray alloc] init];
    for (NSString *aLanguage in languages) {
        NSString *displayName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:aLanguage];
        NSDictionary *langDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 aLanguage, @"languageID",
                                 displayName, @"displayName",
                                 nil];
        [mutableLanguageIDs addObject:aLanguage];
        [langDicts addObject:langDict];
    }
    [self.languageComboBox setCompletes:YES];
    self.languageIDs = [NSArray arrayWithArray:mutableLanguageIDs];
}

- (void)awakeFromNib
{
    self.items = [[NSMutableDictionary alloc] init];
    
	NSToolbarItem *generalItem = [self toolbarItemWithIdentifier:@"General"];
    [generalItem setToolTip:NSLocalizedString(@"General preference options.", nil)];
    [generalItem setImage:[NSImage imageNamed:@"NSPreferencesGeneral"]];
    [self.items setObject:generalItem forKey:@"General"];
    
    NSToolbarItem *munkiItem = [self toolbarItemWithIdentifier:@"Munki"];
    [munkiItem setToolTip:NSLocalizedString(@"Munki preference options.", nil)];
    [munkiItem setImage:[NSImage imageNamed:@"NSPreferencesGeneral"]];
    [self.items setObject:munkiItem forKey:@"Munki"];
    
    
    NSToolbarItem *advancedItem = [self toolbarItemWithIdentifier:@"Advanced"];
    [advancedItem setToolTip:NSLocalizedString(@"Advanced options.", nil)];
    [advancedItem setImage:[NSImage imageNamed:@"NSAdvanced"]];
    [self.items setObject:advancedItem forKey:@"Advanced"];
	
    //any other items you want to add, do so here.
    //after you are done, just do all the toolbar stuff.
    //myWindow is an outlet pointing to the Preferences Window you made to hold all these custom views.
	
    self.toolbar = [[NSToolbar alloc] initWithIdentifier:@"preferencePanes"];
    [self.toolbar setDelegate:self];
    [self.toolbar setAllowsUserCustomization:NO];
    [self.toolbar setAutosavesConfiguration:NO];
    [self.window setToolbar:self.toolbar];
	[self.window setShowsResizeIndicator:NO];
	[self.window setShowsToolbarButton:NO];
    [self.window center];
	[self.window makeKeyAndOrderFront:self];
    [self switchViews:nil];
    
    [self setupTextEditor];
    [self setupLocales];
    
    NSSortDescriptor *sortByTitle = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedStandardCompare:)];
    [self.catalogsArrayController setSortDescriptors:@[sortByTitle]];
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
