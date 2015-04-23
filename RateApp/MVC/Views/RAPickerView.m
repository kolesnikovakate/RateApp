//
//  RAPickerView.m
//  RateApp
//
//  Created by Екатерина Колесникова on 23.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "RAPickerView.h"
#import "UIView+Border.h"
#import "UIColor+RateApp.h"

static float const ROW_HEIGHT = 30.f;

@implementation RAPickerView {
    CAGradientLayer *_gradientLayerTop;
    CAGradientLayer *_gradientLayerBottom;
    UIView *_barSel;
    float _pickerRowY;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.pickerDateTableView = [[RAPickerTableView alloc] initWithFrame:CGRectZero pickerRowY:_pickerRowY rowHeight:ROW_HEIGHT];
        [self.pickerDateTableView setBackgroundColor:[UIColor colorRateAppBackgroundApplication]];
        [self.pickerDateTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.pickerDateTableView.dataSource = self;

        [self addSubview:self.pickerDateTableView];

        self.pickerYearTableView = [[RAPickerTableView alloc] initWithFrame:CGRectZero pickerRowY:_pickerRowY rowHeight:ROW_HEIGHT];
        [self.pickerYearTableView setBackgroundColor:[UIColor colorRateAppBackgroundApplication]];
        [self.pickerYearTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.pickerYearTableView.dataSource = self;

        [self addSubview:self.pickerYearTableView];

        _gradientLayerTop = [CAGradientLayer layer];
        _gradientLayerTop.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height/2.0);
        _gradientLayerTop.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor, (id)[UIColor colorWithWhite:1.0 alpha:0.9].CGColor, nil];
        _gradientLayerTop.startPoint = CGPointMake(0.0f, 0.7f);
        _gradientLayerTop.endPoint = CGPointMake(0.0f, 0.0f);

        _gradientLayerBottom = [CAGradientLayer layer];
        _gradientLayerBottom.frame = CGRectMake(0.0, self.bounds.size.height/2.0, self.bounds.size.width, self.bounds.size.height/2.0);
        _gradientLayerBottom.colors = _gradientLayerTop.colors;
        _gradientLayerBottom.startPoint = CGPointMake(0.0f, 0.3f);
        _gradientLayerBottom.endPoint = CGPointMake(0.0f, 1.0f);

        [self.layer addSublayer:_gradientLayerTop];
        [self.layer addSublayer:_gradientLayerBottom];

        _barSel = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_barSel];

        _selectedDateIndexPathRow = 0;
        _selectedYearIndexPathRow = 0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    CGSize size = self.bounds.size;

    _pickerRowY = self.bounds.size.height/2.0 - ROW_HEIGHT/2.0;
    self.pickerDateTableView.pickerRowY = _pickerRowY;
    self.pickerDateTableView.frame = CGRectMake(self.bounds.origin.x + size.width/3, self.bounds.origin.y,
               size.width/3 * 2, size.height);
    self.pickerDateTableView.eventDelegate = self;

    [self.pickerDateTableView setContentInset:UIEdgeInsetsMake(_pickerRowY, 0.0, _pickerRowY, 0.0)];

    self.pickerYearTableView.pickerRowY = _pickerRowY;
    self.pickerYearTableView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y,
                                                size.width/3, size.height);
    self.pickerYearTableView.eventDelegate = self;

    [self.pickerYearTableView setContentInset:UIEdgeInsetsMake(_pickerRowY, 0.0, _pickerRowY, 0.0)];

    [_barSel setFrame:CGRectMake(0.0, _pickerRowY, self.frame.size.width, ROW_HEIGHT)];
    [_barSel addBottomBorderWithColor:[UIColor colorRateAppBlue] andWidth:1.f];
    [_barSel addTopBorderWithColor:[UIColor colorRateAppBlue] andWidth:1.f];

    _gradientLayerTop.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height/2.0);
    _gradientLayerBottom.frame = CGRectMake(0.0, self.bounds.size.height/2.0, self.bounds.size.width, self.bounds.size.height/2.0);

    [self.pickerDateTableView centerCellWithIndexPathRow:_selectedDateIndexPathRow];
    [self.pickerYearTableView centerCellWithIndexPathRow:_selectedYearIndexPathRow];
}

#pragma mark - Properties

- (void)setDataSource:(id)dataSource
{
    _dataSource = dataSource;
    if (_dataSource) {
        [self.pickerDateTableView reloadData];
        [self.pickerYearTableView reloadData];
    }
}

- (void)setScrollDelegate:(id<RAPickerTableViewScrollDelegate>)scrollDelegate
{
    _scrollDelegate = scrollDelegate;
    if (_scrollDelegate) {
        self.pickerDateTableView.scrollDelegate = _scrollDelegate;
        self.pickerYearTableView.scrollDelegate = _scrollDelegate;
    }
}

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.pickerDateTableView]) {
        return [self.dataSource numberOfRowsInSection:section datePickerView:self];
    }
    return [self.dataSource numberOfRowsInSection:section yearPickerView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ([tableView isEqual:self.pickerDateTableView]) {
        cell = [self.dataSource pickerView:self dateCellAtIndexPath:indexPath];
    } else {
        cell = [self.dataSource pickerView:self yearCellAtIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - UITableView dataSource

- (void)changeSelectedIndexPathRowInPickerTableView:(RAPickerTableView *)pickerTableView
{
    if ([pickerTableView isEqual:self.pickerDateTableView]) {
        self.selectedDateIndexPathRow = self.pickerDateTableView.selectedIndexPathRow;
    } else {
        self.selectedYearIndexPathRow = self.pickerYearTableView.selectedIndexPathRow;
        [self.delegate chandedSelectedYearInDatePickerView:self];
    }
}

@end
