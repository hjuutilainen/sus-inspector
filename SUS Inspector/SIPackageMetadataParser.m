//
//  SIPackageMetadataParser.m
//  SUS Inspector
//
//  Created by Juutilainen Hannes on 15.4.2013.
//  Copyright (c) 2013 Hannes Juutilainen. All rights reserved.
//
//  Heavily influenced by:
//
//  "Parsing XML in Cocoa", a blog post by Aaron Hillegass
//  http://blog.bignerdranch.com/48-parsing-xml-in-cocoa/
//  and
//  "Handling XML Elements and Attributes" from Mac Developer Library
//  https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/XMLParsing/Articles/HandlingElements.html#//apple_ref/doc/uid/20002265-BCIJFGJI


#import "SIPackageMetadataParser.h"

static NSSet *interestingKeys;

@implementation SIPackageMetadataParser

+ (void)initialize
{
    if (!interestingKeys) {
        interestingKeys = [[NSSet alloc] initWithObjects:@"Title",
                           @"DetailPageURL", nil];
    }
}

- (void)dealloc
{
    [items release];
    [super dealloc];
}

- (BOOL)parseData:(NSData *)d
{
    // Release the old itemArray
    [items release];
    
    // Create a new, empty itemArray
    items = [[NSMutableArray alloc] init];
    
    // Create a parser
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:d];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    // Do the parse
    [parser parse];
    
    [parser release];
    
    NSLog(@"items = %@", items);
    return YES;
}

- (NSArray *)items
{
    return items;
}

#pragma mark Delegate calls

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    //NSLog(@"starting Element: %@", elementName);
    
    if ([elementName isEqual:@"pkg-info"]) {
        pkgInProgress = [[NSMutableDictionary alloc] init];
        
        NSString *formatversion = [attributeDict objectForKey:@"format-version"];
        if (formatversion) [pkgInProgress setObject:formatversion forKey:@"format-version"];
        
        NSString *relocatable = [attributeDict objectForKey:@"relocatable"];
        if (relocatable) [pkgInProgress setObject:relocatable forKey:@"relocatable"];
        
        NSString *deleteObsoleteLanguages = [attributeDict objectForKey:@"deleteObsoleteLanguages"];
        if (deleteObsoleteLanguages) [pkgInProgress setObject:deleteObsoleteLanguages forKey:@"deleteObsoleteLanguages"];
        
        NSString *identifier = [attributeDict objectForKey:@"identifier"];
        if (identifier) [pkgInProgress setObject:identifier forKey:@"identifier"];
        
        NSString *overwritepermissions = [attributeDict objectForKey:@"overwrite-permissions"];
        if (overwritepermissions) [pkgInProgress setObject:overwritepermissions forKey:@"overwrite-permissions"];
        
        NSString *auth = [attributeDict objectForKey:@"auth"];
        if (auth) [pkgInProgress setObject:auth forKey:@"auth"];
        
        NSString *postinstallaction = [attributeDict objectForKey:@"postinstall-action"];
        if (postinstallaction) [pkgInProgress setObject:postinstallaction forKey:@"postinstall-action"];
        
        NSString *version = [attributeDict objectForKey:@"version"];
        if (version) [pkgInProgress setObject:version forKey:@"version"];
        
        return;
        
    }
    
    if ([elementName isEqualToString:@"payload"]) {
        NSString *installKBytes = [attributeDict objectForKey:@"installKBytes"];
        if (installKBytes) [pkgInProgress setObject:installKBytes forKey:@"installKBytes"];
        NSString *numberOfFiles = [attributeDict objectForKey:@"numberOfFiles"];
        if (numberOfFiles) [pkgInProgress setObject:numberOfFiles forKey:@"numberOfFiles"];
    }
    
    /*
    // Is it the title/url for the current item?
    if ([interestingKeys containsObject:elementName]) {
        keyInProgress = [elementName copy];
        // This is a string we will append to as the text arrives
        textInProgress = [[NSMutableString alloc] init];
    }
     */
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    //NSLog(@"ending Element: %@", elementName);
    
    if ([elementName isEqual:@"pkg-info"]) {
        [items addObject:pkgInProgress];
        
        // Clear the current item
        [pkgInProgress release];
        pkgInProgress = nil;
        return;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"%@", string);
    //[textInProgress appendString:string];
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
}

/*
 
- (void)parser:(NSXMLParser *)parser foundExternalEntityDeclarationWithName:(NSString *)entityName publicID:(NSString *)publicID systemID:(NSString *)systemID
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser didEndMappingPrefix:(NSString *)prefix
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser didStartMappingPrefix:(NSString *)prefix toURI:(NSString *)namespaceURI
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}



- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser foundNotationDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser foundProcessingInstructionWithTarget:(NSString *)target data:(NSString *)data
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser foundUnparsedEntityDeclarationWithName:(NSString *)name publicID:(NSString *)publicID systemID:(NSString *)systemID notationName:(NSString *)notationName
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", [parseError localizedDescription]);
}

- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)entityName systemID:(NSString *)systemID
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return nil;
}

- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validError
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

*/


@end
