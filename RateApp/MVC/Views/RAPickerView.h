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

@class RAPickerView;

@protocol RAPickerViewDataSource < NSObject >
- (NSUInteger)numberOfRowsInSection:(NSInteger)section pickerView:(RAPickerView *)pickerView;
- (RAPickerTableViewCell *)pickerView:(RAPickerView *)pickerView cellAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface RAPickerView : UIView < UITableViewDataSource, RAPickerTableViewScrollDelegate, RAPickerTableViewDelegate >

@property (nonatomic, strong) RAPickerTableView *pickerTableView;
@property (nonatomic, weak) id <RAPickerViewDataSource> dataSource;
@property (nonatomic, weak) id <RAPickerTableViewScrollDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndexPathRow;

@end
