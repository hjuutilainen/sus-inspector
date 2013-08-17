//
//  main.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 4.3.2013.
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

int main(int argc, char *argv[])
{
    @autoreleasepool {
        NSString *userDefaultsValuesPath;
        NSDictionary *userDefaultsValuesDict;
        
        // Load the default values for the user defaults
        userDefaultsValuesPath = [[NSBundle mainBundle] pathForResource:@"UserDefaults" ofType:@"plist"];
        userDefaultsValuesDict = [NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
        
        // Set them in the standard user defaults
        [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"preferredLanguageForDistFiles": currentLanguage}];
    }
    
    return NSApplicationMain(argc, (const char **)argv);
}
