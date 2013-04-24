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

@interface SIPkginfoMultipleWindowController : NSWindowController <NSTokenFieldDelegate>

# pragma mark -
# pragma mark Properties
@property (retain) NSArray *products;
@property (retain) NSNumber *includeDisplayName;
@property (retain) NSNumber *overrideDisplayName;
@property (retain) NSString *displayName;

@property (retain) NSNumber *includeOriginalVersion;
@property (retain) NSNumber *overrideVersion;
@property (retain) NSString *version;

@property (retain) NSNumber *includeOriginalDescription;
@property (retain) NSNumber *includeOriginalDescriptionType;

@property (retain) NSNumber *overrideRestartAction;
@property (retain) NSString *restartAction;
@property (retain) NSArray *restartActionTemplates;

@property (retain) NSArray *munki_catalogs;

@property (retain) NSNumber *includeUnattendedInstall;

@property (retain) NSNumber *includeForceInstallAfterDate;
@property (retain) NSDate *forceInstallAfterDate;

@property (retain) NSArray *munki_blocking_applications;

@property (readonly, retain) NSArray *pkginfos;


# pragma mark -
# pragma mark IBOutlets
@property (assign) IBOutlet NSArrayController *productsArrayController;
@property (assign) IBOutlet NSTokenField *catalogsTokenField;

@end
