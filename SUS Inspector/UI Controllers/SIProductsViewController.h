//
//  SIProductsViewController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataModelHeaders.h"

@interface SIProductsViewController : NSViewController

@property (assign) IBOutlet NSArrayController *productsArrayController;
@property (retain) SUCatalogMO *selectedCatalog;

@end
