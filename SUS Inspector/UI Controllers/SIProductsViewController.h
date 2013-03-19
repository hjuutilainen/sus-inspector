//
//  SIProductsViewController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataModelHeaders.h"

@class SIProductInfoWindowController;

@interface SIProductsViewController : NSViewController

@property (assign) IBOutlet NSArrayController *productsArrayController;
@property (assign) IBOutlet NSTableView *productsTableView;
@property (retain) SUCatalogMO *selectedCatalog;
@property (retain) SIProductInfoWindowController *productInfoWindowController;

- (IBAction)getInfoAction:(id)sender;

@end
