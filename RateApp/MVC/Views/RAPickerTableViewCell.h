//
//  RAPickerTableViewCell.h
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kRASelectedPickerCellTypeid = 1,
    kRAWeekdayPickerCellTypeid = 2,
    kRAWeekendPickerCellTypeid = 3
} kRAPickerCellTypeid;

@interface RAPickerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelDay;
@property (weak, nonatomic) IBOutlet UILabel *labelYearMonth;
@property (assign, nonatomic) kRAPickerCellTypeid cellTypeid;
@property (assign, nonatomic) BOOL isSelected;

- (void)setDate:(NSDate *)date;

@end
