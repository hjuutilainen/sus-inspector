//
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


#import "SIProductMO.h"


@interface SIProductMO ()

// Private interface goes here.

@end


@implementation SIProductMO

- (NSString *)statusDescription
{
    if (self.productIsDeprecatedValue)
        return @"Deprecated";
    else
        return @"Active";
}

- (NSString *)pkginfoFilename
{
    /*
     Suggest a sensible filename based on:
     - Display Name
     - Product ID
     - Version
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *whiteSpaceReplacement = @"-";
    NSString *joinWithString = @"-";
    
    NSArray *nameComponents = @[self.productTitle, self.productVersion, self.productID];
    NSMutableArray *processedComponents = [NSMutableArray new];
    for (NSString *component in nameComponents) {
        NSString *newValue = [component stringByReplacingOccurrencesOfString:@" " withString:whiteSpaceReplacement];
        [processedComponents addObject:newValue];
    }
    NSString *newName = [processedComponents componentsJoinedByString:joinWithString];
    NSString *fileExtension = [defaults stringForKey:@"pkginfoDefaultFileExtension"];
    NSString *filenameWithExtension = [NSString stringWithFormat:@"%@%@", newName, fileExtension];
    
    return filenameWithExtension;
}

- (NSString *)plainTextFromHTMLString:(NSString *)htmlString
{
    /*
     Convert the htmlString to data, parse it to a new NSAttributedString
     and return the plain text value. Rude, I know...
     */
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *html = [[[NSAttributedString alloc] initWithHTML:data documentAttributes:nil] autorelease];
    return [html string];
}

- (NSDictionary *)pkginfoDictionary
{
    /*
     Create a pkginfo representation of current values.
     If some field is empty, we don't want it at all in the resulting string.
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"apple_update_metadata" forKey:@"installer_type"];
    if (self.productID) [dict setObject:self.productID forKey:@"name"];
    if (self.productTitle) [dict setObject:self.productTitle forKey:@"display_name"];
    if (self.productVersion) [dict setObject:self.productVersion forKey:@"version"];
    
    /*
     Set the description
     */
    NSString *preferredDescription = @"";
    if ([defaults boolForKey:@"pkginfoPrefillDescription"]) {
        if ([defaults integerForKey:@"pkginfoPrefillDescriptionType"] == 0) {
            preferredDescription = [self plainTextFromHTMLString:self.productDescription];
            
        } else if ([defaults integerForKey:@"pkginfoPrefillDescriptionType"] == 1) {
            preferredDescription = self.productDescription;
        }
    }
    [dict setObject:preferredDescription forKey:@"description"];
    
    /*
     Set the default munki catalogs
     */
    NSArray *catalogDictsFromDefaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"defaultMunkiCatalogs"];
    NSArray *catalogs = [catalogDictsFromDefaults valueForKeyPath:@"title"];
    if ([catalogs count] > 0) {
        [dict setObject:catalogs forKey:@"catalogs"];
    }
    
    /*
     Only add the unattended boolean if it's enabled.
     Munki defaults to false if it is missing.
     */
    BOOL unattendedInstall = ([defaults boolForKey:@"pkginfoUnattendedInstall"]) ? YES : NO;
    if (unattendedInstall) {
        [dict setValue:(id)kCFBooleanTrue forKey:@"unattended_install"];
    } else {
        [dict setValue:(id)kCFBooleanFalse forKey:@"unattended_install"];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)pkginfo
{
    /*
     Create a string representation of the dictionary
     */
    NSError *error;
	id plist = [NSPropertyListSerialization dataWithPropertyList:self.pkginfoDictionary
                                                          format:NSPropertyListXMLFormat_v1_0
                                                         options:NSPropertyListImmutable
                                                           error:&error];
    NSString *returnString = [[[NSString alloc] initWithData:plist encoding:NSUTF8StringEncoding] autorelease];
    return returnString;
}


- (NSString *)productTitleWithVersion
{
    return [NSString stringWithFormat:@"%@ - Version %@", self.productTitle, self.productVersion];
}

@end
