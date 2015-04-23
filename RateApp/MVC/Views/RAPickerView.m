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

@implementation RAPickerView {
    CAGradientLayer *_gradientLayerTop;
    CAGradientLayer *_gradientLayerBottom;
    UIView *_barSel;
    float _pickerRowY;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.pickerTableView = [[RAPickerTableView alloc] initWithFrame:CGRectZero pickerRowY:_pickerRowY rowHeight:30.f];
        [self.pickerTableView setBackgroundColor:[UIColor colorRateAppBackgroundApplication]];
        [self.pickerTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.pickerTableView.dataSource = self;

        [self addSubview:self.pickerTableView];

        [self.pickerTableView registerClass:[RAPickerTableViewCell class] forCellReuseIdentifier:@"RAPickerTableViewCell"];
        [self.pickerTableView registerNib:[UINib nibWithNibName:@"RAPickerTableViewCell" bundle:nil] forCellReuseIdentifier:@"RAPickerTableViewCell"];

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

        _selectedIndexPathRow = 0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _pickerRowY = self.bounds.size.height/2.0 - self.pickerTableView.rowHeight/2.0;
    self.pickerTableView.pickerRowY = _pickerRowY;
    self.pickerTableView.frame = self.bounds;
    self.pickerTableView.eventDelegate = self;

    [self.pickerTableView setContentInset:UIEdgeInsetsMake(_pickerRowY, 0.0, _pickerRowY, 0.0)];

    [_barSel setFrame:CGRectMake(0.0, _pickerRowY, self.frame.size.width, self.pickerTableView.rowHeight)];
    [_barSel addBottomBorderWithColor:[UIColor colorRateAppBlue] andWidth:1.f];
    [_barSel addTopBorderWithColor:[UIColor colorRateAppBlue] andWidth:1.f];

    _gradientLayerTop.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height/2.0);
    _gradientLayerBottom.frame = CGRectMake(0.0, self.bounds.size.height/2.0, self.bounds.size.width, self.bounds.size.height/2.0);

    [self.pickerTableView centerCellWithIndexPathRow:_selectedIndexPathRow];
}

#pragma mark - Properties

- (void)setDataSource:(id)dataSource
{
    _dataSource = dataSource;
    if (_dataSource) {
        [self.pickerTableView reloadData];
    }
}

- (void)setDelegate:(id<RAPickerTableViewScrollDelegate>)delegate
{
    _delegate = delegate;
    if (_delegate) {
        self.pickerTableView.scrollDelegate = _delegate;
    }
}

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfRowsInSection:section pickerView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RAPickerTableViewCell *cell = [self.dataSource pickerView:self cellAtIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableView dataSource

- (void)changeSelectedIndexPathRowInPickerTableView:(RAPickerTableView *)pickerTableView
{
    self.selectedIndexPathRow = self.pickerTableView.selectedIndexPathRow;
}

@end
