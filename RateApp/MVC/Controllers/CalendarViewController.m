//
//  CalendarViewController.m
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "CalendarViewController.h"
#import "RAPickerTableView.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController {
    NSArray *_arrDays;
    RAPickerTableView *_pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    NSMutableArray * dateArray = [NSMutableArray array];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents *startComponents = [[NSDateComponents alloc] init];
    [startComponents setDay:1];
    [startComponents setYear:2013];

    for(NSUInteger day = 1; day < 365; day++) {
        [startComponents setDay:day];
        [dateArray addObject:[cal dateFromComponents:startComponents]];
    }
    _arrDays = dateArray;

    _pickerView = [[RAPickerTableView alloc] initWithFrame:CGRectZero];
    _pickerView.dataSource = self;
    [self.view addSubview:_pickerView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_pickerView setFrame:self.view.frame];
    [_pickerView needsUpdateConstraints];
}

#pragma-mark RAPickerTableViewDataSource

- (NSUInteger)numberOfRowsInSection:(NSInteger)section pickerTableView:(RAPickerTableView *)pickerTableView
{
    return _arrDays.count;
}

- (RAPickerTableViewCell *)pickerTableView:(RAPickerTableView *)pickerTableView cellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RAPickerTableViewCell";
    RAPickerTableViewCell *cell = (RAPickerTableViewCell *)[pickerTableView.pickerTableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                                                      forIndexPath:indexPath];
    NSDate *date = _arrDays[indexPath.row];
    cell.isSelected = (indexPath.row == _pickerView.selectedIndexPathRow) ?  YES : NO;
    [cell setDate:date];
    return cell;
}


@end
