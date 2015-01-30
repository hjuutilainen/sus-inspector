//
//  SIPkginfoMultipleWindowController.m
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


#import "SIPkginfoMultipleWindowController.h"
#import "DataModelHeaders.h"

@interface SIPkginfoMultipleWindowController ()

@end

@implementation SIPkginfoMultipleWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        NSArray *restartActions = [NSArray arrayWithObjects:@"RequireShutdown", @"RequireRestart", @"RecommendRestart", @"RequireLogout", @"None", nil];
        self.restartActionTemplates = [restartActions sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.window setBackgroundColor:[NSColor whiteColor]];
}


- (void)populateDefaultValues
{
    /*
     Set default properties for the new pkginfo
     */
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.includeDisplayName = [NSNumber numberWithBool:YES];
    self.includeOriginalVersion = [NSNumber numberWithBool:YES];
    self.restartAction = [self.restartActionTemplates objectAtIndex:0];
    
    /*
     Set the description
     */
    if ([defaults boolForKey:@"pkginfoPrefillDescription"]) {
        self.includeOriginalDescription = [NSNumber numberWithBool:YES];
        self.includeOriginalDescriptionType = [NSNumber numberWithInteger:[defaults integerForKey:@"pkginfoPrefillDescriptionType"]];
        
    } else {
        self.includeOriginalDescription = [NSNumber numberWithBool:NO];
    }
    
    /*
     Set the default munki catalogs
     */
    self.includeCatalogs = [NSNumber numberWithBool:YES];
    NSArray *catalogDictsFromDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"defaultMunkiCatalogs"];
    NSArray *catalogs = [catalogDictsFromDefaults valueForKeyPath:@"title"];
    self.munki_catalogs = catalogs;
    [self.catalogsTokenField setDelegate:self];
    
    /*
     Create a date which is about a week in the future
     */
    
    // Create a calendar object with time zone set to UTC
    NSTimeZone *timeZoneUTC = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:timeZoneUTC];
    
    // Get the current date (without hour, minute and second)
    NSDate *now = [NSDate date];
    NSDateComponents *dateComponents = [gregorian components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:now];
    
    // Set the clock to a custom value
    [dateComponents setHour:23];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
    
    NSDate *normalizedDate = [gregorian dateFromComponents:dateComponents];
    
    // Add 7 days to the normalized date
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:7];
    
    NSDate *newDate = [gregorian dateByAddingComponents:offsetComponents toDate:normalizedDate options:0];
    
    /*
     Set a default value for the force_install_after_date but don't enable it
     */
    self.forceInstallAfterDate = newDate;
    self.includeForceInstallAfterDate = [NSNumber numberWithBool:NO];
    
    [self.forceAfterDatePicker setCalendar:gregorian];
    [self.forceAfterDatePicker setTimeZone:timeZoneUTC];
    
}


- (NSString *)plainTextFromHTMLString:(NSString *)htmlString
{
    /*
     Convert the htmlString to data, parse it to a new NSAttributedString
     and return the plain text value. Rude, I know...
     */
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *html = [[NSAttributedString alloc] initWithHTML:data documentAttributes:nil];
    return [html string];
}

- (NSDictionary *)pkginfoMetadata
{
    /*
     Metadata
     */
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSDate *now = [NSDate date];
    NSOperatingSystemVersion operatingSystemVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    NSInteger majorVersion = operatingSystemVersion.majorVersion;
    NSInteger minorVersion = operatingSystemVersion.minorVersion;
    NSInteger patchVersion = operatingSystemVersion.patchVersion;
    NSString *osVersionString = [NSString stringWithFormat:@"%li.%li.%li", majorVersion, minorVersion, patchVersion];
    NSDictionary *metadata = @{@"created_by": NSUserName(),
                               @"creation_date": now,
                               @"sus_inspector_version": version,
                               @"os_version": osVersionString};
    return @{@"_metadata": metadata};
}

- (NSDictionary *)pkginfoDictForProduct:(SIProductMO *)product
{
    /*
     Create a pkginfo representation of current values.
     If some field is empty, we don't want it at all in the resulting string.
     */
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"apple_update_metadata" forKey:@"installer_type"];
    [dict setObject:product.productID forKey:@"name"];
    if ([self.includeDisplayName boolValue]) [dict setObject:product.productTitle forKey:@"display_name"];
    if ([self.includeOriginalVersion boolValue]) [dict setObject:product.productVersion forKey:@"version"];
    if ([self.includeOriginalDescription boolValue]) {
        if ([self.includeOriginalDescriptionType integerValue] == 0) {
            // Plain text
            [dict setObject:[self plainTextFromHTMLString:product.productDescription] forKey:@"description"];
        } else {
            [dict setObject:product.productDescription forKey:@"description"];
        }
        
    }
    if ([self.munki_catalogs count] > 0 && [self.includeCatalogs boolValue]) {
        [dict setObject:self.munki_catalogs forKey:@"catalogs"];
    }
    if ([self.munki_blocking_applications count] > 0 && [self.includeBlockingApplications boolValue]) {
        [dict setObject:self.munki_blocking_applications forKey:@"blocking_applications"];
    }
    if ([self.includeRestartAction boolValue]) [dict setObject:self.restartAction forKey:@"RestartAction"];
    if ([self.includeForceInstallAfterDate boolValue]) {
        [dict setObject:self.forceInstallAfterDate forKey:@"force_install_after_date"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"pkginfoAddMetadata"]) {
        [dict addEntriesFromDictionary:[self pkginfoMetadata]];
    }
    
    /*
     Only add the unattended boolean if it's enabled.
     Munki defaults to false if it is missing.
     */
    if ([self.includeUnattendedInstall boolValue]) {
        [dict setValue:(id)kCFBooleanTrue forKey:@"unattended_install"];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)pkginfoStringForProduct:(SIProductMO *)aProduct
{
    /*
     Create a string representation of the dictionary
     */
    NSError *error;
	id plist = [NSPropertyListSerialization dataWithPropertyList:[self pkginfoDictForProduct:aProduct]
                                                          format:NSPropertyListXMLFormat_v1_0
                                                         options:NSPropertyListImmutable
                                                           error:&error];
    NSString *returnString = [[NSString alloc] initWithData:plist encoding:NSUTF8StringEncoding];
    return returnString;
}


- (IBAction)savePkginfoAction:(id)sender
{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    
    openPanel.delegate = self;
	openPanel.title = @"Save pkginfo files";
	openPanel.allowsMultipleSelection = NO;
	openPanel.canChooseDirectories = YES;
	openPanel.canChooseFiles = NO;
	openPanel.resolvesAliases = YES;
    openPanel.prompt = @"Choose";
    
	if ([openPanel runModal] == NSFileHandlingPanelOKButton)
	{
        NSURL *selectedDir = [[openPanel URLs] objectAtIndex:0];
		for (SIProductMO *aProduct in self.products) {
            NSURL *saveURL = [selectedDir URLByAppendingPathComponent:aProduct.pkginfoFilename];
            if (!saveURL) {
                break;
            }
            NSError *writeError = nil;
            if (![[self pkginfoStringForProduct:aProduct] writeToURL:saveURL
                                                          atomically:YES
                                                            encoding:NSUTF8StringEncoding
                                                               error:&writeError]) {
                NSLog(@"Failed to write %@: %@", [saveURL path], writeError);
            }
            
        }
	} else {
        
    }
}

- (IBAction)cancelSavePkginfoAction:(id)sender
{
    [self.window close];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.window center];
    
    [self populateDefaultValues];
}



# pragma mark -
# pragma mark NSTokenFieldDelegate methods

- (NSArray *)tokenField:(NSTokenField *)tokenField completionsForSubstring:(NSString *)substring indexOfToken:(NSInteger)tokenIndex indexOfSelectedItem:(NSInteger *)selectedIndex
{
    if (tokenField == self.catalogsTokenField) {
        NSArray *catalogDictsFromDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"defaultMunkiCatalogs"];
        NSArray *catalogs = [catalogDictsFromDefaults valueForKeyPath:@"title"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[d] %@", substring];
        NSArray *matchingCatalogs = [catalogs filteredArrayUsingPredicate:predicate];
        return matchingCatalogs;
    } else if (tokenField == self.blockingAppsTokenField) {
        
    }
    return nil;
}


@end
