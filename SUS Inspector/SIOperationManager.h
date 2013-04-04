//
//  SIReposadoManager.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 7.3.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelHeaders.h"
#import "AMShellWrapper.h"

@class SIOperationManager;


@protocol SIOperationManagerDelegate <NSObject>
@optional
- (void)willStartOperations:(SIOperationManager *)operationManager;
- (void)willEndOperations:(SIOperationManager *)operationManager;
@end

@interface SIOperationManager : NSObject <AMShellWrapperDelegate>

@property (assign) id <SIOperationManagerDelegate> delegate;
@property (retain) NSOperationQueue *operationQueue;
@property (retain) NSString *currentOperationTitle;
@property (retain) NSString *currentOperationDescription;
@property (retain) AMShellWrapper *shellWrapper;
@property (retain) NSArray *currentCatalogs;


+ (SIOperationManager *)sharedManager;
- (void)setupSourceListItems;
- (void)readReposadoInstanceContentsAsync:(ReposadoInstanceMO *)instance;
- (void)runReposync:(ReposadoInstanceMO *)instance;

@end


