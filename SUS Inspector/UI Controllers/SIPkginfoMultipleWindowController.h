//
//  SIPkginfoMultipleWindowController.h
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 24.4.2013.
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


#import <Cocoa/Cocoa.h>

@class SIProductMO;

@interface SIPkginfoMultipleWindowController : NSWindowController <NSTokenFieldDelegate, NSOpenSavePanelDelegate>

# pragma mark -
# pragma mark Properties
@property (strong) NSArray *products;
@property (strong) NSNumber *includeDisplayName;
@property (strong) NSNumber *overrideDisplayName;
@property (strong) NSString *displayName;

@property (strong) NSNumber *includeOriginalVersion;
@property (strong) NSNumber *overrideVersion;
@property (strong) NSString *version;

@property (strong) NSNumber *includeOriginalDescription;
@property (strong) NSNumber *includeOriginalDescriptionType;

@property (strong) NSNumber *includeRestartAction;
@property (strong) NSString *restartAction;
@property (strong) NSArray *restartActionTemplates;

@property (strong) NSNumber *includeCatalogs;
@property (strong) NSArray *munki_catalogs;

@property (strong) NSNumber *includeUnattendedInstall;

@property (strong) NSNumber *includeForceInstallAfterDate;
@property (strong) NSDate *forceInstallAfterDate;

@property (strong) NSNumber *includeBlockingApplications;
@property (strong) NSArray *munki_blocking_applications;

@property (readonly, strong) NSArray *pkginfos;


# pragma mark -
# pragma mark IBOutlets
@property (weak) IBOutlet NSArrayController *productsArrayController;
@property (weak) IBOutlet NSTokenField *catalogsTokenField;
@property (weak) IBOutlet NSTokenField *blockingAppsTokenField;
@property (weak) IBOutlet NSDatePicker *forceAfterDatePicker;

@end
