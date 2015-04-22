//
//  RAXMLParserDelegate.m
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAXMLParserDelegate.h"
#import "NSDate+RateApp.h"

@implementation RAXMLParserDelegate

@synthesize done = isDone;
@synthesize currencyArray = currency_array;
@synthesize error = parserError;

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    isDone = NO;
    currency_array = [NSMutableArray new];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    isDone = YES;
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    isDone = YES;
    parserError = parseError;
}

-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    isDone = YES;
    parserError = validationError;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentElement = [elementName lowercaseString];
    if ([elementName isEqualToString:@"Valute"]) {
        currency = [[Currency alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Valute"]) {
        [currency_array addObject:currency];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length<1)
        return;

    if ([currentElement isEqualToString:@"numcode"])  {
        currency.numCode = string;
    } else if ([currentElement isEqualToString:@"charcode"])  {
        currency.charCode = string;
    } else if ([currentElement isEqualToString:@"nominal"])  {
        currency.nominal = string;
    } else if ([currentElement isEqualToString:@"name"])  {
        currency.name = string;
    } else if ([currentElement isEqualToString:@"value"])  {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *currencyValue = [formatter numberFromString:string];
        currency.value = currencyValue;
    }
}

@end
