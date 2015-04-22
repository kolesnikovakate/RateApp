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
#import "CurrencyHelper.h"
#import "NSDate+RateApp.h"

@interface RateViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eurLabel;
@property (weak, nonatomic) IBOutlet UILabel *usdLabel;

@end

@implementation RateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorRateAppBackgroundApplication]];

    self.dateLabel.textColor = [UIColor colorRateAppBlue];
    self.eurLabel.textColor = [UIColor colorRateAppBlue];
    self.usdLabel.textColor = [UIColor colorRateAppBlue];

    self.dateLabel.text = [self.selectedDate stringRateScreen];

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
    Currency *usd = [CurrencyHelper findCurrencyWithCharCode:kRAUSDCharCode inArray:dataArray];
    Currency *eur = [CurrencyHelper findCurrencyWithCharCode:kRAEURCharCode inArray:dataArray];
    NSLog(@"%@ %@", usd.nominal, usd.value);
    NSLog(@"%@ %@", eur.nominal, eur.value);
    self.eurLabel.text = [NSString stringWithFormat:@"%@ Eur = %.2f Rub", eur.nominal, eur.value.floatValue];
    self.usdLabel.text = [NSString stringWithFormat:@"%@ $ = %.2f Rub", usd.nominal, usd.value.floatValue];
    self.eurLabel.hidden = NO;
    self.usdLabel.hidden = NO;
}

@end
