//
//  SIProductsViewController.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIProductsViewController.h"

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

- (void)awakeFromNib
{
    NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"productPostDate" ascending:NO selector:@selector(compare:)];
    NSSortDescriptor *sortByTitle = [NSSortDescriptor sortDescriptorWithKey:@"productTitle" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSSortDescriptor *sortByID = [NSSortDescriptor sortDescriptorWithKey:@"productID" ascending:YES selector:@selector(localizedStandardCompare:)];
    [self.productsArrayController setSortDescriptors:[NSArray arrayWithObjects:sortByDate, sortByTitle, sortByID, nil]];
}

@end
