//
//  RAPickerTableView.h
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RAPickerTableViewCell.h"

@class RAPickerTableView;

@protocol RAPickerTableViewDataSource < NSObject >
- (NSUInteger)numberOfRowsInSection:(NSInteger)section pickerTableView:(RAPickerTableView *)pickerTableView;
- (RAPickerTableViewCell *)pickerTableView:(RAPickerTableView *)pickerTableView cellAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface RAPickerTableView : UIView < UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource >

@property (nonatomic, strong) UITableView *pickerTableView;
@property (nonatomic, weak) id <RAPickerTableViewDataSource> dataSource;
@property (nonatomic, assign, readonly) NSInteger selectedIndexPathRow;

@end
