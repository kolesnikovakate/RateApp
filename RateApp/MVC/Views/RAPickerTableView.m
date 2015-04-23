//
//  RAPickerTableView.m
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "RAPickerTableView.h"
#import "RAPickerTableViewCell.h"
#import "RAPickerTableViewYearCell.h"

@implementation RAPickerTableView

- (id)initWithFrame:(CGRect)frame pickerRowY:(float)pickerRowY rowHeight:(float)rowHeight
{
    if(self = [super initWithFrame:frame style:UITableViewStylePlain]) {

        [self registerClass:[RAPickerTableViewCell class] forCellReuseIdentifier:@"RAPickerTableViewCell"];
        [self registerNib:[UINib nibWithNibName:@"RAPickerTableViewCell" bundle:nil] forCellReuseIdentifier:@"RAPickerTableViewCell"];

        [self registerClass:[RAPickerTableViewYearCell class] forCellReuseIdentifier:@"RAPickerTableViewYearCell"];

        [self setScrollEnabled:YES];
        self.rowHeight = rowHeight;
        [self setShowsVerticalScrollIndicator:NO];
        [self setUserInteractionEnabled:YES];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.delegate = self;

        _pickerRowY = pickerRowY;
    }
    return self;
}

- (void)reloadCellWithIndexPathRow:(NSUInteger)indexPathRow
{
    NSArray *paths = @[[NSIndexPath indexPathForRow:indexPathRow inSection:0]];
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (![scrollView isDragging]) {
        [self centerValueForScrollView:(UIScrollView *)scrollView];
    } else {
        [self.scrollDelegate scrollViewDidEndDraggingInPickerTableView:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self centerValueForScrollView:(UIScrollView *)scrollView];
    [self.scrollDelegate scrollViewDidEndDeceleratingInPickerTableView:self];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSInteger lastSelectedIndexPathRow = _selectedIndexPathRow;
    _selectedIndexPathRow = -1;
    [self.eventDelegate changeSelectedIndexPathRowInPickerTableView:self];
    [self reloadCellWithIndexPathRow:lastSelectedIndexPathRow];
}

#pragma mark - Methods

- (void)centerValueForScrollView:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.y;
    offset += scrollView.contentInset.top;
    int mod = (int)offset % (int)self.rowHeight;
    float newValue = (mod >= self.rowHeight/2.0) ? offset + (self.rowHeight-mod) : offset-mod;

    //Calculates the indexPath of the cell and set it in the object as property
    NSInteger indexPathRow = (int)(newValue/self.rowHeight);

    //Center the cell
    [self centerCellWithIndexPathRow:indexPathRow];
}

- (void)centerCellWithIndexPathRow:(NSUInteger)indexPathRow
{
    if(indexPathRow >= [self numberOfRowsInSection:0]) {
        indexPathRow = [self numberOfRowsInSection:0] - 1;
    }

    float newOffset = indexPathRow * self.rowHeight;
    newOffset -= _pickerRowY;
    [self setContentOffset:CGPointMake(0.0, newOffset) animated:YES];

    _selectedIndexPathRow = indexPathRow;
    [self.eventDelegate changeSelectedIndexPathRowInPickerTableView:self];
    [self reloadCellWithIndexPathRow:_selectedIndexPathRow];
}


@end
