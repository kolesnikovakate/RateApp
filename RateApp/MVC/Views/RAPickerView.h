//
//  RAPickerView.h
//  RateApp
//
//  Created by Екатерина Колесникова on 23.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAPickerTableViewCell.h"
#import "RAPickerTableView.h"
#import "RAPickerTableViewYearCell.h"

@class RAPickerView;

@protocol RAPickerViewDataSource < NSObject >
- (NSUInteger)numberOfRowsInSection:(NSInteger)section datePickerView:(RAPickerView *)pickerView;
- (NSUInteger)numberOfRowsInSection:(NSInteger)section yearPickerView:(RAPickerView *)pickerView;
- (RAPickerTableViewCell *)pickerView:(RAPickerView *)pickerView dateCellAtIndexPath:(NSIndexPath *)indexPath;
- (RAPickerTableViewYearCell *)pickerView:(RAPickerView *)pickerView yearCellAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol RAPickerViewDelegate < NSObject >
- (void)chandedSelectedYearInDatePickerView:(RAPickerView *)pickerView;
@end

@interface RAPickerView : UIView < UITableViewDataSource, RAPickerTableViewDelegate >

@property (nonatomic, strong) RAPickerTableView *pickerYearTableView;
@property (nonatomic, strong) RAPickerTableView *pickerDateTableView;
@property (nonatomic, weak) id <RAPickerViewDataSource> dataSource;
@property (nonatomic, weak) id <RAPickerViewDelegate> delegate;
@property (nonatomic, weak) id <RAPickerTableViewScrollDelegate> scrollDelegate;
@property (nonatomic, assign) NSInteger selectedYearIndexPathRow;
@property (nonatomic, assign) NSInteger selectedDateIndexPathRow;

@end
