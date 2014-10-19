//
//  SIReposadoSettingsController.m
//  SUS Inspector
//
//  Created by Hannes on 11.3.2013.
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


#import "SIReposadoConfigurationController.h"
#import "SIAppDelegate.h"
#import "SIReposadoConstants.h"

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
    NSSortDescriptor *sortByOSVersion = [NSSortDescriptor sortDescriptorWithKey:@"catalogOSVersion" ascending:NO selector:@selector(localizedStandardCompare:)];
    [self.catalogsArrayController setSortDescriptors:[NSArray arrayWithObjects:sortByOSVersion, sortByTitle, nil]];
}

- (NSUndoManager*)windowWillReturnUndoManager:(NSWindow*)window
{
    if (!self.undoManager) {
        self.undoManager = [[NSUndoManager alloc] init];
    }
    return self.undoManager;
}

- (NSModalSession)beginEditSessionWithObject:(SIReposadoInstanceMO *)instance delegate:(id)modalDelegate
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
    NSManagedObjectContext *moc = [(SIAppDelegate *)[NSApp delegate] managedObjectContext];
    for (SICatalogMO *aCatalog in self.reposadoInstance.catalogs) {
        [moc deleteObject:aCatalog];
    }
    
    // Set default catalogs
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultBaseURL = [defaults stringForKey:@"baseURL"];
    self.reposadoInstance.reposadoCatalogsBaseURLString = defaultBaseURL;
    for (NSDictionary *defaultCatalog in [defaults arrayForKey:@"defaultCatalogs"]) {
        SICatalogMO *newCatalog = [NSEntityDescription insertNewObjectForEntityForName:@"SICatalog" inManagedObjectContext:moc];
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

- (NSURL *)showSavePanel:(NSString *)fileName
{
	NSSavePanel *savePanel = [NSSavePanel savePanel];
	savePanel.nameFieldStringValue = fileName;
    savePanel.title = @"Change Reposado Location";
	if ([savePanel runModal] == NSFileHandlingPanelOKButton)
	{
		return [savePanel URL];
	} else {
		return nil;
	}
}

- (IBAction)chooseLocationAction:(id)sender
{
    NSURL *newLocation = [self showSavePanel:kReposadoDefaultInstanceName];
    if (newLocation) {
        NSURL *oldLocation = self.reposadoInstance.reposadoInstallURL;
        NSArray *oldContents = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:oldLocation includingPropertiesForKeys:nil options:0 error:nil];
        if ([oldContents count] == 0) {
            // Remove the old directory because it's empty
            [[NSFileManager defaultManager] removeItemAtURL:oldLocation error:nil];
        }
        
        [(SIAppDelegate *)[NSApp delegate] createDirectoriesForReposadoAtURL:newLocation];
        
        self.reposadoInstance.reposadoInstallURL = newLocation;
        
        [[(SIAppDelegate *)[NSApp delegate] managedObjectContext] save:nil];
    }
}


# pragma mark -
# pragma mark NSTableView delegates

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
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
