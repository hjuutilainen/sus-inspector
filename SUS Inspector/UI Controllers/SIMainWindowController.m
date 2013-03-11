//
//  SIMainWindowController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 5.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIMainWindowController.h"
#import "SIProgressWindowController.h"
#import "SIProductsViewController.h"
#import "SICatalogsViewController.h"
#import "SIReposadoSettingsController.h"
#import "DataModelHeaders.h"

@interface SIMainWindowController ()

@end

@implementation SIMainWindowController

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
    
    [self.window center];
    
    self.progressWindowController = [[SIProgressWindowController alloc] initWithWindowNibName:@"SIProgressWindowController"];
    self.productsViewController = [[SIProductsViewController alloc] initWithNibName:@"SIProductsViewController" bundle:nil];
    self.catalogsViewController = [[SICatalogsViewController alloc] initWithNibName:@"SICatalogsViewController" bundle:nil];
    self.catalogsViewController.delegate = self;
    self.reposadoSettingsController = [[SIReposadoSettingsController alloc] initWithWindowNibName:@"SIReposadoSettingsController"];
    //[self.reposadoSettingsController showWindow:self];
    
    [self.mainSplitView setDelegate:self];
    
    [self.rightView addSubview:self.productsViewController.view];
    [[self.productsViewController view] setFrame:[self.rightView frame]];
    [[self.productsViewController view] setFrameOrigin:NSMakePoint(0,0)];
    [[self.productsViewController view] setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    [self.leftView addSubview:self.catalogsViewController.view];
    [[self.catalogsViewController view] setFrame:[self.leftView frame]];
    [[self.catalogsViewController view] setFrameOrigin:NSMakePoint(0,0)];
    [[self.catalogsViewController view] setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
}

- (void)showProgressPanel
{
    [NSApp beginSheet:self.progressWindowController.window
       modalForWindow:self.window modalDelegate:nil
       didEndSelector:nil contextInfo:nil];
    [self.progressWindowController.progressIndicator setIndeterminate:YES];
    [self.progressWindowController.progressIndicator startAnimation:self];
}


- (void)hideProgressPanel
{
    [NSApp endSheet:self.progressWindowController.window];
    [self.progressWindowController.window close];
    [self.progressWindowController.progressIndicator stopAnimation:self];
}


#pragma mark -
#pragma mark NSSplitView delegates

- (void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize:(NSSize)oldSize
{
    if (sender == self.mainSplitView) {
        
        // Resize only the right side of the splitview
        
        NSView *left = [[sender subviews] objectAtIndex:0];
        NSView *right = [[sender subviews] objectAtIndex:1];
        float dividerThickness = [sender dividerThickness];
        NSRect newFrame = [sender frame];
        NSRect leftFrame = [left frame];
        NSRect rightFrame = [right frame];
        
        rightFrame.size.height = newFrame.size.height;
        rightFrame.size.width = newFrame.size.width - leftFrame.size.width - dividerThickness;
        rightFrame.origin = NSMakePoint(leftFrame.size.width + dividerThickness, 0);
        
        leftFrame.size.height = newFrame.size.height;
        leftFrame.origin.x = 0;
        
        [left setFrame:leftFrame];
        [right setFrame:rightFrame];
    }
}


- (void)outlineViewSelectionDidChange
{
    //NSLog(@"outlineViewSelectionDidChange");
    NSArray *selectedSourceListItems = [self.catalogsViewController.sourceListTreeController selectedObjects];
    if ([selectedSourceListItems count] > 0) {
        SourceListItemMO *selectedItem = [selectedSourceListItems objectAtIndex:0];
        [self.productsViewController setSelectedCatalog:selectedItem.catalogReference];
    }
}



@end
