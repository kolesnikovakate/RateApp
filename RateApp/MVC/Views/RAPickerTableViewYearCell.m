//
//  RAPickerTableViewYearCell.m
//  RateApp
//
//  Created by Екатерина Колесникова on 23.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "RAPickerTableViewYearCell.h"
#import "UIColor+RateApp.h"

@implementation RAPickerTableViewYearCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorRateAppBackgroundApplication];
    self.textLabel.textAlignment = NSTextAlignmentRight;
    self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected) {
        [self.textLabel setTextColor:[UIColor colorRateAppBlue]];
    } else {
        [self.textLabel setTextColor:[UIColor colorRateAppTextGray]];
    }
}

@end
