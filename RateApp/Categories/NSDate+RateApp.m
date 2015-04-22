//
//  NSDate+RateApp.m
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "NSDate+RateApp.h"

@implementation NSDate (RateApp)

- (BOOL)checkForWeekend
{
    BOOL isWeekendDate = NO;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange weekdayRange = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSUInteger weekdayOfDate = [components weekday];

    if (weekdayOfDate == weekdayRange.location || weekdayOfDate == weekdayRange.length) {
        isWeekendDate = YES;
    }
    return isWeekendDate;
}

- (BOOL)checkForFirstDayInMonth
{
    BOOL isFirstDayInMonth = NO;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd"];

    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *dayNumber = [f numberFromString:[formatter stringFromDate:self]];


    if (dayNumber.intValue == 1) {
        isFirstDayInMonth = YES;
    }
    return isFirstDayInMonth;
}

- (NSString *)stringForCbrRequest
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    NSString *stringFromDate = [formatter stringFromDate:self];
    return stringFromDate;
}

@end
