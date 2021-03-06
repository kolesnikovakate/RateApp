//
//  CurrencyHelper.m
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "CurrencyHelper.h"

@implementation CurrencyHelper

+ (Currency *)findCurrencyWithCharCode:(NSString *)charCode inArray:(NSArray *)currencyArray
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"charCode == %@", charCode];
    NSArray *filteredArray = [currencyArray filteredArrayUsingPredicate:predicate];
    return filteredArray.count > 0 ? filteredArray.firstObject : nil;
}

@end
