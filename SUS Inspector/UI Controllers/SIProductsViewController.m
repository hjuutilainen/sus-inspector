//
//  SIProductsViewController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIProductsViewController.h"
#import "SIProductInfoWindowController.h"
#import "SIPkginfoWindowController.h"

@interface SIProductsViewController ()

@end

@implementation SIProductsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)openGetInfoWindow
{
    for (SUProductMO *aProduct in [self.productsArrayController selectedObjects]) {
        SIProductInfoWindowController *newInfoWindow = [[SIProductInfoWindowController alloc] initWithWindowNibName:@"SIProductInfoWindowController"];
        [newInfoWindow setProduct:aProduct];
        [newInfoWindow showWindow:nil];
    }
}

- (IBAction)getInfoAction:(id)sender
{
    [self openGetInfoWindow];
}

- (void)openPkginfoWindow
{
    if ([[self.productsArrayController selectedObjects] count] == 1) {
        SUProductMO *selectedProduct = [[self.productsArrayController selectedObjects] objectAtIndex:0];
        SIPkginfoWindowController *newPkginfoWindow = [[SIPkginfoWindowController alloc] initWithWindowNibName:@"SIPkginfoWindowController"];
        [newPkginfoWindow setProduct:selectedProduct];
        [newPkginfoWindow showWindow:nil];
    } else {
        
    }
}

- (IBAction)createPkginfoAction:(id)sender
{
    [self openPkginfoWindow];
}

- (void)awakeFromNib
{
    NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"productPostDate" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *sortByTitle = [NSSortDescriptor sortDescriptorWithKey:@"productTitle" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSSortDescriptor *sortByID = [NSSortDescriptor sortDescriptorWithKey:@"productID" ascending:YES selector:@selector(localizedStandardCompare:)];
    [self.productsArrayController setSortDescriptors:[NSArray arrayWithObjects:sortByDate, sortByTitle, sortByID, nil]];
    
    [self.productsTableView setTarget:self];
    [self.productsTableView setDoubleAction:@selector(openGetInfoWindow)];
    
    //self.productInfoWindowController = [[[SIProductInfoWindowController alloc] initWithWindowNibName:@"SIProductInfoWindowController"] autorelease];
    //self.pkginfoWindowController = [[[SIPkginfoWindowController alloc] initWithWindowNibName:@"SIPkginfoWindowController"] autorelease];
}

@end
