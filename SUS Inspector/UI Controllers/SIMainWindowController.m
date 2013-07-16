//
//  SIMainWindowController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 5.3.2013.
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


#import "SIMainWindowController.h"
#import "SIProgressWindowController.h"
#import "SIProductsViewController.h"
#import "SICatalogsViewController.h"
#import "SIReposadoConfigurationController.h"
#import "DataModelHeaders.h"
#import "SIOperationManager.h"
#import "SIAppDelegate.h"

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


- (IBAction)focusToSearchFieldAction:(id)sender
{
    [[self.productsViewController searchField] becomeFirstResponder];
}

- (IBAction)getInfoAction:(id)sender
{
    [self.productsViewController openGetInfoWindow];
}

- (IBAction)reposyncAction:(id)sender
{
    SIOperationManager *operationManager = [SIOperationManager sharedManager];
    operationManager.delegate = [NSApp delegate];
    [operationManager runReposync:[[NSApp delegate] defaultReposadoInstance]];
}

- (IBAction)createPkginfoAction:(id)sender
{
    [self.productsViewController openPkginfoWindow];
}

- (IBAction)sendToMunkiAdminAction:(id)sender
{
    [self.productsViewController sendSelectedItemsToMunkiAdmin];
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    //[self.window center];
    
    self.progressWindowController = [[[SIProgressWindowController alloc] initWithWindowNibName:@"SIProgressWindowController"] autorelease];
    self.productsViewController = [[[SIProductsViewController alloc] initWithNibName:@"SIProductsViewController" bundle:nil] autorelease];
    self.catalogsViewController = [[[SICatalogsViewController alloc] initWithNibName:@"SICatalogsViewController" bundle:nil] autorelease];
    self.catalogsViewController.delegate = self;
    self.reposadoConfigurationController = [[[SIReposadoConfigurationController alloc] initWithWindowNibName:@"SIReposadoConfigurationController"] autorelease];
    //[self.reposadoConfigurationController showWindow:self];
    
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
    [self showProgressPanelAttachedToWindow:self.window];
}

- (void)showProgressPanelAttachedToWindow:(NSWindow *)aWindow
{
    [NSApp beginSheet:self.progressWindowController.window
       modalForWindow:aWindow modalDelegate:nil
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
        
        // Resize only the right side of the split view
        
        NSView *left = [[sender subviews] objectAtIndex:0];
        NSView *right = [[sender subviews] objectAtIndex:1];
        CGFloat dividerThickness = [sender dividerThickness];
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
        SISourceListItemMO *selectedItem = [selectedSourceListItems objectAtIndex:0];
        NSPredicate *productFilter = selectedItem.productFilterPredicate;
        [self.productsViewController setProductsMainFilterPredicate:productFilter];
    }
}



@end
