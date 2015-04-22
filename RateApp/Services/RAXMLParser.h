//
//  RAXMLParser.h
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RAXMLParserCompletionBlock)(NSArray *currencyArray, NSError *error);

@interface RAXMLParser : NSObject

+ (void)getCurrencyArrayByDate:(NSDate *)date withCompletion:(RAXMLParserCompletionBlock)completion;

@end
