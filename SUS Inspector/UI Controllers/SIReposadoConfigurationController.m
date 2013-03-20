//
//  SIReposadoSettingsController.m
//  SUS Inspector
//
//  Created by Hannes on 11.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import "SIReposadoConfigurationController.h"
#import "SIAppDelegate.h"

@interface SIReposadoConfigurationController ()

@end

@implementation SIReposadoConfigurationController

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
    
    NSSortDescriptor *sortByTitle = [NSSortDescriptor sortDescriptorWithKey:@"catalogDisplayName" ascending:YES selector:@selector(compare:)];
    NSSortDescriptor *sortByOSVersion = [NSSortDescriptor sortDescriptorWithKey:@"catalogOSVersion" ascending:NO selector:@selector(compare:)];
    [self.catalogsArrayController setSortDescriptors:[NSArray arrayWithObjects:sortByOSVersion, sortByTitle, nil]];
}

- (NSUndoManager*)windowWillReturnUndoManager:(NSWindow*)window
{
    if (!self.undoManager) {
        self.undoManager = [[NSUndoManager alloc] init];
    }
    return self.undoManager;
}

- (void)dealloc
{
    [_undoManager release];
    [super dealloc];
}

- (NSModalSession)beginEditSessionWithObject:(ReposadoInstanceMO *)instance delegate:(id)modalDelegate
{
    self.reposadoInstance = instance;
    self.delegate = modalDelegate;
    self.customBaseURL = instance.reposadoCatalogsBaseURLString;
    self.modalSession = [NSApp beginModalSessionForWindow:self.window];
    [NSApp runModalSession:self.modalSession];
    return self.modalSession;
}

# pragma mark -
# pragma mark IBActions

- (IBAction)saveAction:(id)sender
{
    [[self window] orderOut:sender];
    [NSApp endModalSession:self.modalSession];
    [NSApp stopModal];
    
    if ([self.delegate respondsToSelector:@selector(reposadoConfigurationDidFinish:returnCode:object:)]) {
        [self.delegate reposadoConfigurationDidFinish:self returnCode:NSOKButton object:self.reposadoInstance];
    }
}

- (IBAction)cancelAction:(id)sender
{
    [[self window] orderOut:sender];
    [NSApp endModalSession:self.modalSession];
    [NSApp stopModal];
    
    if ([self.delegate respondsToSelector:@selector(reposadoConfigurationDidFinish:returnCode:object:)]) {
        [self.delegate reposadoConfigurationDidFinish:self returnCode:NSCancelButton object:self.reposadoInstance];
    }
}

- (IBAction)resetCatalogsToDefaultAction:(id)sender
{
    // Delete catalogs
    NSManagedObjectContext *moc = [[NSApp delegate] managedObjectContext];
    for (SUCatalogMO *aCatalog in self.reposadoInstance.catalogs) {
        [moc deleteObject:aCatalog];
    }
    
    // Set default catalogs
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultBaseURL = [defaults stringForKey:@"reposadoCatalogsBaseURL"];
    self.reposadoInstance.reposadoCatalogsBaseURLString = defaultBaseURL;
    for (NSDictionary *defaultCatalog in [defaults arrayForKey:@"defaultCatalogs"]) {
        SUCatalogMO *newCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SUCatalog" inManagedObjectContext:moc];
        NSString *defaultCatalogURL = [defaultCatalog objectForKey:@"catalogURL"];
        NSString *newURL = [defaultCatalogURL stringByReplacingOccurrencesOfString:@"http://swscan.apple.com"
                                                                        withString:defaultBaseURL];
        newCatalog.catalogURL = newURL;
        newCatalog.catalogDisplayName = [defaultCatalog objectForKey:@"catalogDisplayName"];
        newCatalog.catalogOSVersion = [defaultCatalog objectForKey:@"catalogOSVersion"];
        newCatalog.isActiveValue = YES;
        [self.reposadoInstance addCatalogsObject:newCatalog];
    }
}


# pragma mark -
# pragma mark NSTableView delegates

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row __unused {
    NSString *identifier = [tableColumn identifier];
    id cell = [tableColumn dataCell];
    if ([identifier isEqualToString:@"isActive"]) {
        
    } else if ([identifier isEqualToString:@"catalogDisplayName"]) {
        [cell setFont:[NSFont systemFontOfSize:13]];
        [cell setLineBreakMode:NSLineBreakByTruncatingMiddle];
    } else if ([identifier isEqualToString:@"catalogURL"]) {
        [cell setFont:[NSFont systemFontOfSize:11]];
        [cell setLineBreakMode:NSLineBreakByTruncatingMiddle];
    }
    
    
    return cell;
}

@end
