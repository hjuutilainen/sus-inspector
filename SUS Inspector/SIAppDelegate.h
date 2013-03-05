//
//  SIAppDelegate.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 4.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SIMainWindowController;

@interface SIAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSArrayController *productsArrayController;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (retain) SIMainWindowController *mainWindowController;

- (IBAction)saveAction:(id)sender;


@end
