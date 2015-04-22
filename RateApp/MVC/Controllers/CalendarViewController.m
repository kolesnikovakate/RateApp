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
    RAPickerTableView *_pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray * dateArray = [NSMutableArray array];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents *startComponents = [[NSDateComponents alloc] init];
    [startComponents setDay:1];
    [startComponents setYear:2013];

    for(NSUInteger day = 1; day <= 365; day++) {
        [startComponents setDay:day];
        [dateArray addObject:[cal dateFromComponents:startComponents]];
    }
    _arrDays = dateArray;

    _pickerView = [[RAPickerTableView alloc] initWithFrame:CGRectZero];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;

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
        destVC.selectedDate = _arrDays[_pickerView.selectedIndexPathRow];
    }
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

#pragma-mark RAPickerTableViewDelegate

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

@end
