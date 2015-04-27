//
//  RAXMLParserDelegate.h
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface RAXMLParserDelegate : NSObject < NSXMLParserDelegate > {
    BOOL isDone;
    NSError *parserError;
    NSMutableArray *currency_array;
    NSString *currentElement;
    BOOL isNecessaryElement;
    Currency *currency;
}

@property (readonly) BOOL done;
@property (readonly) NSError * error;
@property (readonly) NSArray * currencyArray;

@end