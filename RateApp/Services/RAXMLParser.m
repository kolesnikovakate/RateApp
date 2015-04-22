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

+ (void)getCurrencyArrayByDate:(NSDate *)date withCompletion:(RAXMLParserCompletionBlock)completion
{
    NSOperationQueue *current_queue = [NSOperationQueue currentQueue];

    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [q addOperationWithBlock:^{
        RAXMLParserDelegate *delegate = [[RAXMLParserDelegate alloc] init];

        NSURL *parserURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL, [date stringForCbrRequest]]];

        NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:parserURL];
        [parser setDelegate:delegate];
        [parser parse];

        while ( !delegate.done )
            sleep(1);

        [current_queue addOperationWithBlock:^{
            if ( delegate.error == nil ) {
                completion(delegate.currencyArray, nil);
            } else {
                completion(nil, delegate.error);
            }
        }];
    }];
}

@end
