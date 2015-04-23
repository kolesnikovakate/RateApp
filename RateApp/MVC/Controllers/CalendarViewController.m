//
//  CalendarViewController.m
//  RateApp
//
//  Created by Екатерина Колесникова on 21.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "CalendarViewController.h"
#import "RAPickerTableView.h"
#import "UIColor+RateApp.h"
#import "NSDate+RateApp.h"
#import "RateViewController.h"

@interface CalendarViewController ()

@property (weak, nonatomic) IBOutlet UIButton *rateButton;

@end

@implementation CalendarViewController {
    NSArray *_arrDays;
    NSArray *_arrYears;
    NSArray *_currentArrDays;
    RAPickerView *_pickerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *calendarArray = [NSDate getCalendarArray];
    _arrYears = [calendarArray[0] copy];
    _arrDays= [calendarArray[1] copy];

    _currentArrDays = _arrDays[0];

    _pickerView = [[RAPickerView alloc] initWithFrame:CGRectZero];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.scrollDelegate = self;
    _pickerView.selectedDateIndexPathRow = 0;

    [self.view addSubview:_pickerView];

    self.rateButton.layer.cornerRadius = self.rateButton.bounds.size.height / 2;
    self.rateButton.layer.borderColor = [UIColor colorRateAppBlue].CGColor;
    self.rateButton.layer.borderWidth = 1.0f;
    [self.rateButton setTitle:NSLocalizedString(@"RATE", "") forState:UIControlStateNormal];
    [self.rateButton setTitleColor:[UIColor colorRateAppBlue] forState:UIControlStateNormal];
    [self.rateButton setTitleColor:[UIColor colorRateAppTextGray] forState:UIControlStateDisabled];
    self.rateButton.backgroundColor = [UIColor colorRateAppButtonBackground];
    [self.rateButton setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 3.f, 0.f, 3.f)];
    self.rateButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.rateButton.titleLabel.minimumScaleFactor = .5;
    [self.view bringSubviewToFront:self.rateButton];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_pickerView setFrame:self.view.frame];
    [_pickerView needsUpdateConstraints];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowRate"]) {
        RateViewController *destVC = (RateViewController *)segue.destinationViewController;
        destVC.selectedDate = _currentArrDays[_pickerView.selectedDateIndexPathRow];
    }
}

#pragma-mark RAPickerTableViewDataSource

- (NSUInteger)numberOfRowsInSection:(NSInteger)section datePickerView:(RAPickerView *)pickerView
{
    return [_currentArrDays count];
}

- (NSUInteger)numberOfRowsInSection:(NSInteger)section yearPickerView:(RAPickerView *)pickerView
{
    return _arrYears.count;
}

- (RAPickerTableViewCell *)pickerView:(RAPickerView *)pickerView dateCellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RAPickerTableViewCell";
    RAPickerTableViewCell *cell = (RAPickerTableViewCell *)[pickerView.pickerDateTableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                                                      forIndexPath:indexPath];
    NSDate *date = _currentArrDays[indexPath.row];
    cell.isSelected = (indexPath.row == _pickerView.selectedDateIndexPathRow) ?  YES : NO;
    [cell setDate:date];
    return cell;
}

- (RAPickerTableViewYearCell *)pickerView:(RAPickerView *)pickerView yearCellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RAPickerTableViewYearCell";
    RAPickerTableViewYearCell *cell = (RAPickerTableViewYearCell *)[pickerView.pickerDateTableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                                                                forIndexPath:indexPath];
    cell.isSelected = (indexPath.row == _pickerView.selectedYearIndexPathRow) ?  YES : NO;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _arrYears[indexPath.row]];
    return cell;
}

#pragma mark - RAPickerTableViewScrollDelegate

- (void)scrollViewDidEndDraggingInPickerTableView:(RAPickerTableView *)pickerTableView
{
    self.rateButton.enabled = NO;
    self.rateButton.layer.borderColor = [UIColor colorRateAppTextGray].CGColor;
}

- (void)scrollViewDidEndDeceleratingInPickerTableView:(RAPickerTableView *)pickerTableView
{
    self.rateButton.enabled = YES;
    self.rateButton.layer.borderColor = [UIColor colorRateAppBlue].CGColor;
}

#pragma mark - RAPickerTableViewScrollDelegate

-(void)chandedSelectedYearInDatePickerView:(RAPickerView *)pickerView
{
    NSInteger i = pickerView.selectedYearIndexPathRow;
    if(i < _arrDays.count && i >= 0 ) {
        _currentArrDays = _arrDays[i];
        [pickerView.pickerDateTableView reloadData];

        //если пользователь выбрал последний день в високосном году и перешел на не високосный
        if (pickerView.selectedDateIndexPathRow >= _currentArrDays.count) {
            pickerView.selectedDateIndexPathRow = _currentArrDays.count - 1;
        }
    }
}

@end
