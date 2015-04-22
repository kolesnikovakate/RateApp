//
//  CurrencyHelper.h
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface CurrencyHelper : NSObject

+ (Currency *)findCurrencyWithCharCode:(NSString *)charCode inArray:(NSArray *)currencyArray;

@end
