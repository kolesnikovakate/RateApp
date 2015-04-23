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
    if ([self connectedToInternet]) {
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
    } else {
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        [details setValue:NSLocalizedString(@"NO_INTERNET_ERROR_DESC", @"") forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"RateAppDomain" code:1 userInfo:details];

        completion(nil, error);
    }
}

+ (BOOL)connectedToInternet
{
    NSString *urlString = @"http://www.google.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    NSHTTPURLResponse *response;

    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];

    return ([response statusCode] == 200) ? YES : NO;
}

@end
