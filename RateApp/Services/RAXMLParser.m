//
//  RAXMLParser.m
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "RAXMLParser.h"
#import "RAXMLParserDelegate.h"
#import "NSDate+RateApp.h"
#import "SVProgressHUD.h"

static NSString *const BASE_URL = @"http://www.cbr.ru/scripts/XML_daily.asp?date_req=";

@implementation RAXMLParser

+ (NSArray *)getCurrencyArrayByDate:(NSDate *)date
{
    RAXMLParserDelegate *delegate = [[RAXMLParserDelegate alloc] init];

    NSURL *parserURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, [date stringForCbrRequest]]];

    [SVProgressHUD showWithStatus:@"123" maskType:SVProgressHUDMaskTypeBlack];

    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:parserURL];
    [parser setDelegate:delegate];
    [parser parse];

    while ( !delegate.done )
        sleep(1);

    NSArray *currencyArray;
    if ( delegate.error == nil ) {
        currencyArray = delegate.currencyArray;
        [SVProgressHUD dismiss];
    } else {
        [SVProgressHUD showErrorWithStatus:[delegate.error localizedDescription]];
    }
    return currencyArray;
}

@end
