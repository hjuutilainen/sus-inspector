//
//  SIPreferencesController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 2.4.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SIPreferencesController : NSWindowController <NSToolbarDelegate> {
    
}

@property (assign) IBOutlet NSView *generalView;
@property (assign) IBOutlet NSView *munkiView;
@property (assign) IBOutlet NSView *advancedView;
@property (assign) IBOutlet NSArrayController *catalogsArrayController;
@property (assign) IBOutlet NSTableView *catalogsTableView;

@property (retain) NSToolbar *toolbar;
@property (retain) NSMutableDictionary *items;

- (void)switchViews:(NSToolbarItem *)item;

- (IBAction)addNewCatalogAction:(id)sender;

@end
