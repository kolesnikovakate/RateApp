//
//  RAPickerTableViewCell.m
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "RAPickerTableViewCell.h"
#import "UIColor+RateApp.h"
#import "NSDate+RateApp.h"

@implementation RAPickerTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorRateAppBackgroundApplication];

}

- (void)setCellTypeid:(kRAPickerCellTypeid)cellTypeid
{
    switch(cellTypeid) {
        case kRASelectedPickerCellTypeid: {
            [self.labelDay setTextColor:[UIColor colorRateAppBlue]];
            [self.labelYearMonth setTextColor:[UIColor colorRateAppBlue]];
            break;
        }
        case kRAWeekdayPickerCellTypeid: {
            [self.labelDay setTextColor:[UIColor colorRateAppTextGray]];
            [self.labelYearMonth setTextColor:[UIColor colorRateAppTextGray]];
            break;
        }
        case kRAWeekendPickerCellTypeid: {
            [self.labelDay setTextColor:[UIColor colorRateAppRed]];
            [self.labelYearMonth setTextColor:[UIColor colorRateAppRed]];
            break;
        }
        default: {
            NSAssert(NO, @"Unknown cell type");
            break;
        }
    }
}

- (void)setDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"EEE dd"];

    NSString *dayStringFromDate = [formatter stringFromDate:date];
    [self.labelDay setText:dayStringFromDate];

    if (self.isSelected) {
        [self setCellTypeid:kRASelectedPickerCellTypeid];
        [formatter setDateFormat:@"yyyy MMM"];
    } else {
        [date checkForFirstDayInMonth] ? [formatter setDateFormat:@"MMM"] : [formatter setDateFormat:@""];
        [date checkForWeekend] ? [self setCellTypeid:kRAWeekendPickerCellTypeid] : [self setCellTypeid:kRAWeekdayPickerCellTypeid];
    }

    NSString *yearMonthStringFromDate = [formatter stringFromDate:date];
    [self.labelYearMonth setText:yearMonthStringFromDate];

}

@end
