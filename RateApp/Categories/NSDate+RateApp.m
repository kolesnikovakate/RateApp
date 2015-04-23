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

- (NSString *)stringRateScreen
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"dd MMMM YYYY"];
    NSString *stringFromDate = [formatter stringFromDate:self];
    return stringFromDate;
}

+ (NSArray *)getCalendarArray
{
    NSMutableArray *arrDays = [NSMutableArray array];
    NSMutableArray *arrYears = [NSMutableArray array];

    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents *startComponents = [[NSDateComponents alloc] init];

    for (NSUInteger year = 2004; year <= 2014; year++) {
        [arrYears addObject:@(year)];
        NSMutableArray * dateArray = [NSMutableArray array];

        [startComponents setDay:1];
        [startComponents setYear:year];

        NSInteger numbersOfDay = [self isYearLeapYear:year] ? 366 : 365;
        for(NSUInteger day = 1; day <= numbersOfDay; day++) {
            [startComponents setDay:day];
            [dateArray addObject:[cal dateFromComponents:startComponents]];
        }
        [arrDays addObject:dateArray];
    }
    NSMutableArray *calendarArray = [[NSMutableArray alloc] init];
    [calendarArray addObject:arrYears];
    [calendarArray addObject:arrDays];
    return calendarArray;
}

+ (BOOL)isYearLeapYear:(NSInteger)year
{
    return (( year%100 != 0) && (year%4 == 0)) || year%400 == 0;
}

@end
