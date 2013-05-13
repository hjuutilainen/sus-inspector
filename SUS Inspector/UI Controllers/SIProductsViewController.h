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

@property (assign) IBOutlet NSArrayController *productsArrayController;
@property (assign) IBOutlet NSTableView *productsTableView;
@property (retain) SICatalogMO *selectedCatalog;
@property (retain) SIProductInfoWindowController *productInfoWindowController;
@property (retain) SIPkginfoWindowController *pkginfoWindowController;
@property (assign) IBOutlet NSMenu *productsListMenu;
@property (assign) IBOutlet NSMenu *distributionFilesMenu;
@property (assign) IBOutlet NSMenu *packagesMenu;

- (IBAction)getInfoAction:(id)sender;
- (IBAction)createPkginfoAction:(id)sender;
- (IBAction)copyProductIDAction:(id)sender;
- (IBAction)copyTitleAction:(id)sender;

@end
