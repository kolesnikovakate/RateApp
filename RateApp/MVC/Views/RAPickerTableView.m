//
//  RAPickerTableView.m
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "RAPickerTableView.h"
#import "UIView+Border.h"
#import "UIColor+RateApp.h"

@implementation RAPickerTableView {
    CAGradientLayer *_gradientLayerTop;
    CAGradientLayer *_gradientLayerBottom;
    UIView *_barSel;
    float _pickerRowY;
}

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.pickerTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];

        [self.pickerTableView registerClass:[RAPickerTableViewCell class] forCellReuseIdentifier:@"RAPickerTableViewCell"];
        [self.pickerTableView registerNib:[UINib nibWithNibName:@"RAPickerTableViewCell" bundle:nil] forCellReuseIdentifier:@"RAPickerTableViewCell"];

        [self.pickerTableView setScrollEnabled:YES];
        self.pickerTableView.rowHeight = 30.f;
        [self.pickerTableView setShowsVerticalScrollIndicator:NO];
        [self.pickerTableView setUserInteractionEnabled:YES];
        [self.pickerTableView setBackgroundColor:[UIColor colorRateAppBackgroundApplication]];
        [self.pickerTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.pickerTableView.dataSource = self;
        self.pickerTableView.delegate = self;

        [self addSubview:self.pickerTableView];

        [self.pickerTableView registerClass:[RAPickerTableViewCell class] forCellReuseIdentifier:@"RAPickerTableViewCell"];
        [self.pickerTableView registerNib:[UINib nibWithNibName:@"RAPickerTableViewCell" bundle:nil] forCellReuseIdentifier:@"RAPickerTableViewCell"];


        //Create bar selector
        _barSel = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_barSel];

        _selectedIndexPathRow = 0;
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _pickerRowY = self.bounds.size.height/2.0 - self.pickerTableView.rowHeight/2.0;
    self.pickerTableView .frame = self.bounds;

    [self.pickerTableView setContentInset:UIEdgeInsetsMake(_pickerRowY, 0.0, _pickerRowY, 0.0)];
    [self.pickerTableView setContentOffset:CGPointMake(0, -_pickerRowY)];
    [_barSel setFrame:CGRectMake(0.0, _pickerRowY, self.frame.size.width, self.pickerTableView.rowHeight)];
    [_barSel addBottomBorderWithColor:[UIColor colorRateAppBlue] andWidth:1.f];
    [_barSel addTopBorderWithColor:[UIColor colorRateAppBlue] andWidth:1.f];

    //Layer gradient
    _gradientLayerTop = [CAGradientLayer layer];
    _gradientLayerTop.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height/2.0);
    _gradientLayerTop.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor, (id)[UIColor colorWithWhite:1.0 alpha:0.3].CGColor, nil];
    _gradientLayerTop.startPoint = CGPointMake(0.0f, 0.7f);
    _gradientLayerTop.endPoint = CGPointMake(0.0f, 0.0f);

    _gradientLayerBottom = [CAGradientLayer layer];
    _gradientLayerBottom.frame = CGRectMake(0.0, self.bounds.size.height/2.0, self.bounds.size.width, self.bounds.size.height/2.0);
    _gradientLayerBottom.colors = _gradientLayerTop.colors;
    _gradientLayerBottom.startPoint = CGPointMake(0.0f, 0.3f);
    _gradientLayerBottom.endPoint = CGPointMake(0.0f, 1.0f);
    //Add gradients
    [self.layer addSublayer:_gradientLayerTop];
    [self.layer addSublayer:_gradientLayerBottom];
}

- (void)reloadCellWithIndexPathRow:(NSUInteger)indexPathRow
{
    NSArray *paths = @[[NSIndexPath indexPathForRow:indexPathRow inSection:0]];
    [self.pickerTableView beginUpdates];
    [self.pickerTableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
    [self.pickerTableView endUpdates];
}

#pragma mark - Properties

- (void)setDataSource:(id)dataSource
{
    _dataSource = dataSource;
    if (_dataSource) {
        [self.pickerTableView reloadData];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isDragging]) {
        [self.delegate scrollViewDidEndDraggingInPickerTableView:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"didEndDecelerating");
    [self centerValueForScrollView:(UIScrollView *)scrollView];
    [self.delegate scrollViewDidEndDeceleratingInPickerTableView:self];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSInteger lastSelectedIndexPathRow = _selectedIndexPathRow;
    _selectedIndexPathRow = -1;
    [self reloadCellWithIndexPathRow:lastSelectedIndexPathRow];
}

#pragma mark - Methods

- (void)centerValueForScrollView:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.y;
    offset += scrollView.contentInset.top;
    int mod = (int)offset % (int)self.pickerTableView.rowHeight;
    float newValue = (mod >= self.pickerTableView.rowHeight/2.0) ? offset + (self.pickerTableView.rowHeight-mod) : offset-mod;

    //Calculates the indexPath of the cell and set it in the object as property
    NSInteger indexPathRow = (int)(newValue/self.pickerTableView.rowHeight);

    //Center the cell
    [self centerCellWithIndexPathRow:indexPathRow forScrollView:scrollView];
}

- (void)centerCellWithIndexPathRow:(NSUInteger)indexPathRow forScrollView:(UIScrollView *)scrollView
{
    if(indexPathRow >= [self.pickerTableView numberOfRowsInSection:0]) {
        indexPathRow = [self.pickerTableView numberOfRowsInSection:0] - 1;
    }

    _selectedIndexPathRow = indexPathRow;
    NSLog(@"_selectedIndexPathRow %ld", (long)_selectedIndexPathRow);

    float newOffset = indexPathRow * self.pickerTableView.rowHeight;

    //Re-add the contentInset and set the new offset
    newOffset -= CGRectGetMinY(_barSel.frame);

    [CATransaction begin];

    [CATransaction setCompletionBlock:^{
        [self reloadCellWithIndexPathRow:_selectedIndexPathRow];

        [scrollView setUserInteractionEnabled:YES];
        [scrollView setAlpha:1.0];
    }];

    [scrollView setContentOffset:CGPointMake(0.0, newOffset) animated:YES];

    [CATransaction commit];
}

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfRowsInSection:section pickerTableView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RAPickerTableViewCell *cell = [self.dataSource pickerTableView:self cellAtIndexPath:indexPath];
    return cell;
}

@end
