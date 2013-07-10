//
//  SICatalogsViewController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 8.3.2013.
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


#import "SICatalogsViewController.h"
#import "DataModelHeaders.h"

@interface SICatalogsViewController ()

@end

@implementation SICatalogsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSourceList) name:@"SIDidSetupSourceListItems" object:nil];
    }
    
    return self;
}

- (void)updateSourceList
{
    // Expand all items in the source list
    [self.sourceListOutlineView expandItem:nil expandChildren:YES];
    
    // Make sure the "All Products" item is selected
    NSUInteger defaultIndexes[] = {0,0};
    [self.sourceListTreeController setSelectionIndexPath:[NSIndexPath indexPathWithIndexes:defaultIndexes length:2]];
}

- (void)awakeFromNib
{
    NSSortDescriptor *sortByIndex = [NSSortDescriptor sortDescriptorWithKey:@"sortIndex" ascending:YES selector:@selector(compare:)];
    NSSortDescriptor *sortByOSVersion = [NSSortDescriptor sortDescriptorWithKey:@"catalogReference.catalogOSVersion" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *sortByTitle = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedStandardCompare:)];
    [self.sourceListTreeController setSortDescriptors:[NSArray arrayWithObjects:sortByIndex, sortByOSVersion, sortByTitle, nil]];
    
    // The basic recipe for a sidebar. Note that the selectionHighlightStyle is set to NSTableViewSelectionHighlightStyleSourceList in the nib
    [self.sourceListOutlineView sizeLastColumnToFit];
    [self.sourceListOutlineView reloadData];
    [self.sourceListOutlineView setFloatsGroupRows:NO];
    
    // NSTableViewRowSizeStyleDefault should be used, unless the user has picked an explicit size. In that case, it should be stored out and re-used.
    [self.sourceListOutlineView setRowSizeStyle:NSTableViewRowSizeStyleDefault];
    
    // Disable animation
    //[NSAnimationContext beginGrouping];
    //[[NSAnimationContext currentContext] setDuration:0];
    
    
    
    //[NSAnimationContext endGrouping];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
    if ([[item representedObject] isGroupItemValue]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSView *)outlineView:(NSOutlineView *)ov viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    NSTableCellView *view = nil;
    
    if ([[item representedObject] isGroupItemValue]) {
        view = [ov makeViewWithIdentifier:@"HeaderCell" owner:self];
    } else {
        view = [ov makeViewWithIdentifier:@"DataCell" owner:self];
    }
    
    return view;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item
{
    if ([[item representedObject] isGroupItemValue]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
    if ([self.delegate respondsToSelector:@selector(outlineViewSelectionDidChange)]) {
        [self.delegate performSelectorOnMainThread:@selector(outlineViewSelectionDidChange)
                                        withObject:nil
                                     waitUntilDone:NO];
    }
}



@end
