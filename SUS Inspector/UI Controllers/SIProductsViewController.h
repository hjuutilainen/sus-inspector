//
//  SIProductsViewController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
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


#import <Cocoa/Cocoa.h>
#import "DataModelHeaders.h"

@class SIProductInfoWindowController;
@class SIPkginfoWindowController;
@class SIPkginfoMultipleWindowController;

@interface SIProductsViewController : NSViewController <NSMenuDelegate> {
    
}

@property (strong) NSMutableArray *pkginfoWindowControllers;
@property (strong) NSMutableArray *productInfoWindowControllers;
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSArrayController *productsArrayController;
@property (strong) NSPredicate *productsMainFilterPredicate;
@property (readonly, strong) NSPredicate *mainCompoundPredicate;
@property (strong) NSPredicate *searchFieldPredicate;
@property (weak) IBOutlet NSTableView *productsTableView;
@property (strong) SICatalogMO *selectedCatalog;
@property (strong) SIProductInfoWindowController *productInfoWindowController;
@property (strong) SIPkginfoWindowController *pkginfoWindowController;
@property (strong) SIPkginfoMultipleWindowController *multiplePkginfoController;
@property (weak) IBOutlet NSMenu *productsListMenu;
@property (weak) IBOutlet NSMenu *distributionFilesMenu;
@property (weak) IBOutlet NSMenu *packagesMenu;
@property (weak) IBOutlet NSMenuItem *sendToMunkiAdminMenuItem;

- (IBAction)getInfoAction:(id)sender;
- (IBAction)createPkginfoAction:(id)sender;
- (IBAction)copyProductIDAction:(id)sender;
- (IBAction)copyTitleAction:(id)sender;
- (void)openGetInfoWindow;
- (void)openPkginfoWindow;
- (void)sendSelectedItemsToMunkiAdmin;
- (void)openPreferredDistributionForSelectedProducts;

@end
