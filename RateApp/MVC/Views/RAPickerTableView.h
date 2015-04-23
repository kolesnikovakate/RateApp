//
//  RAPickerTableView.h
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RAPickerTableView;

@protocol RAPickerTableViewScrollDelegate < NSObject >
- (void)scrollViewDidEndDraggingInPickerTableView:(RAPickerTableView *)pickerTableView;
- (void)scrollViewDidEndDeceleratingInPickerTableView:(RAPickerTableView *)pickerTableView;
@end

@protocol RAPickerTableViewDelegate < NSObject >
- (void)changeSelectedIndexPathRowInPickerTableView:(RAPickerTableView *)pickerTableView;
@end

@interface RAPickerTableView : UITableView < UITableViewDelegate >

- (void)centerCellWithIndexPathRow:(NSUInteger)indexPathRow;
- (id)initWithFrame:(CGRect)frame pickerRowY:(float)pickerRowY rowHeight:(float)rowHeight;

@property (nonatomic, weak) id <RAPickerTableViewScrollDelegate> scrollDelegate;
@property (nonatomic, weak) id <RAPickerTableViewDelegate> eventDelegate;
@property (nonatomic, assign) NSInteger selectedIndexPathRow;
@property (nonatomic, assign) float pickerRowY;

@end
