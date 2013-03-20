//
//  SIProductInfoWindowController.m
//  SUS Inspector
//
//  Created by Hannes on 18.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIProductInfoWindowController.h"
#import "DataModelHeaders.h"

@interface SIProductInfoWindowController ()

@end

@implementation SIProductInfoWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
    }
    
    return self;
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [[NSApp delegate] managedObjectContext];
}

- (void)showWindow:(id)sender
{
    [self.window center];
    [super showWindow:sender];
        
    [[self.webView mainFrame] loadHTMLString:self.product.productDescription baseURL:nil];
    
    NSPredicate *notDeprecated = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/deprecated"];
    NSPredicate *notAll = [NSPredicate predicateWithFormat:@"catalogURL != %@", @"/all"];
    NSPredicate *isActive = [NSPredicate predicateWithFormat:@"isActive == TRUE"];
    NSArray *subPredicates = [NSArray arrayWithObjects:notAll, notDeprecated, isActive, nil];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    NSArray *temp = [[self.product.catalogs allObjects] filteredArrayUsingPredicate:predicate];
    NSSortDescriptor *byOS = [NSSortDescriptor sortDescriptorWithKey:@"catalogOSVersion" ascending:NO selector:@selector(localizedStandardCompare:)];
    self.catalogs = [temp sortedArrayUsingDescriptors:[NSArray arrayWithObjects:byOS, nil]];

}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor whiteColor]];
    
    
    
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id < WebPolicyDecisionListener >)listener
{
    NSString *host = [[request URL] host];
    if (host) {
        [[NSWorkspace sharedWorkspace] openURL:[request URL]];
    } else {
        [listener use];
    }
}


// Convert the Contact entity into a displayable string for the token
- (NSString *)tokenField:(NSTokenField *)tokenField displayStringForRepresentedObject:(id)representedObject
{
    SUCatalogMO *catalog = (SUCatalogMO *)representedObject;
    return [NSString stringWithFormat:@"%@", catalog.catalogDisplayName];
}

/*
// This gets called when the NSTokenField attempts to commit the changes. Since we only allow pre-configured contacts
// it must be in our list of possible contacts, otherwise we won't add the contact.
- (NSArray *)tokenField:(NSTokenField *)tokenField shouldAddObjects:(NSArray *)tokens atIndex:(NSUInteger)idx {
    
    NSMutableArray *toAdd = [NSMutableArray array];
    // Iterate over all the tokens to be added
    for (NSString *token in tokens) {
        // Find the relevant object in our possible contacts list
        NSUInteger index = [[self possibleContacts] indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            Contact *contact = (Contact *)obj;
            NSString *contactName = [NSString stringWithFormat:@"%@ %@", contact.firstname, contact.lastname];
            if ([contactName isEqualToString:token]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        if (index != NSNotFound) {
            [toAdd addObject:[[self possibleContacts ] objectAtIndex:index]];
        } // else not a possible contact so don't add it.
    }
    return toAdd;
}

// We don't allow editing of the contact names directly, so just return the string again.
- (NSString *)tokenField:(NSTokenField *)tokenField editingStringForRepresentedObject:(id)representedObject {
    Contact *contact = (Contact *)representedObject;
    return [NSString stringWithFormat:@"%@ %@", contact.firstname, contact.lastname];
}
 */

@end
