//
//  RateViewController.m
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "RateViewController.h"
#import "RAXMLParser.h"
#import "UIColor+RateApp.h"
#import "SVProgressHUD.h"

@implementation RateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorRateAppBackgroundApplication]];

    [SVProgressHUD showWithStatus:NSLocalizedString(@"CURRENCY_LOADING", @"") maskType:SVProgressHUDMaskTypeBlack];
    [RAXMLParser getCurrencyArrayByDate:self.selectedDate withCompletion:^(NSArray *currencyArray, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            [self setUpDataFromArray:currencyArray];
        } else {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)setUpDataFromArray:(NSArray *)dataArray
{
    NSLog(@"%@", dataArray);
}

@end
