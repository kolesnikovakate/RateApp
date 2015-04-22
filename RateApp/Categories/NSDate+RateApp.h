//
//  NSDate+RateApp.h
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RateApp)

- (BOOL)checkForWeekend;
- (BOOL)checkForFirstDayInMonth;
- (NSString *)stringForCbrRequest;
- (NSString *)stringRateScreen;

@end
