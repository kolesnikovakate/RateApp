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
        NSString *valuteId = [attributeDict objectForKey:@"ID"];
       if ([valuteId isEqualToString:kRAEURValuteID] || [valuteId isEqualToString:kRAUSDValuteID]) {
            currency = [[Currency alloc] init];
            isNecessaryElement = YES;
        } else {
            isNecessaryElement = NO;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Valute"] && isNecessaryElement) {
        [currency_array addObject:currency];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length<1)
        return;

    if (isNecessaryElement) {
        if ([currentElement isEqualToString:@"charcode"])  {
            currency.charCode = string;
        } else if ([currentElement isEqualToString:@"numcode"])  {
            currency.numCode = string;
        } else if ([currentElement isEqualToString:@"nominal"])  {
            currency.nominal = string;
        } else if ([currentElement isEqualToString:@"name"])  {
            currency.name = string;
        } else if ([currentElement isEqualToString:@"value"])  {
            NSCharacterSet * charset = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
            string = [string stringByReplacingOccurrencesOfString:@"," withString:@"."];
            NSScanner * scanner = [NSScanner scannerWithString:string];
            [scanner setCharactersToBeSkipped:charset];
            float f;
            [scanner scanFloat:&f];
            currency.value = [NSNumber numberWithFloat:f];
        }
    }
}

@end
