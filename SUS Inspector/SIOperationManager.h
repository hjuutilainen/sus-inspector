//
//  SIReposadoManager.h
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


#import <Foundation/Foundation.h>
#import "DataModelHeaders.h"
#import "AMShellWrapper.h"

@class SIOperationManager;
@class SIPackageMetadataParser;

@protocol SIOperationManagerDelegate <NSObject>
@optional
- (void)willStartOperations:(SIOperationManager *)operationManager;
- (void)willEndOperations:(SIOperationManager *)operationManager;
@end

@interface SIOperationManager : NSObject <AMShellWrapperDelegate, NSURLDownloadDelegate>

typedef enum {
    SIOperationTypeGeneric,
    SIOperationTypeRepoSync,
    SIOperationTypeReadLocalFiles,
    SIOperationTypePackageOperation,
} SIOperationType;

@property (assign) id <SIOperationManagerDelegate> delegate;
@property SIOperationType currentOperationType;
@property (retain) NSOperationQueue *operationQueue;
@property (retain) NSString *currentOperationTitle;
@property (retain) NSString *currentOperationDescription;
@property (retain) AMShellWrapper *shellWrapper;
@property (retain) NSArray *currentCatalogs;


+ (SIOperationManager *)sharedManager;
- (void)setupSourceListGroupItems;
- (void)setupSourceListItems;
- (void)readReposadoInstanceContentsAsync:(SIReposadoInstanceMO *)instance force:(BOOL)force;
- (void)runReposync:(SIReposadoInstanceMO *)instance;
- (void)updateCachedStatusForProduct:(SIProductMO *)product;
- (void)updateCatalogURLStatusAsync:(NSURL *)catalogURL;
- (void)updateCatalogURLStatus:(SICatalogMO *)catalog;
- (void)cacheDownloadableObjectWithURL:(NSURL *)url;
//- (void)cacheDistributionFileWithURL:(NSURL *)url;
//- (void)cachePackageWithURL:(NSURL *)url;
- (void)readXMLFromPackageMetadataFile:(SIPackageMetadataMO *)obj;
- (void)readXMLFromDistributionFile:(SIDistributionMO *)obj;
- (void)readPackageMetadataFiles:(SIReposadoInstanceMO *)reposadoInstance;

- (void)willStartOperations;
- (void)willEndOperations;

@end


