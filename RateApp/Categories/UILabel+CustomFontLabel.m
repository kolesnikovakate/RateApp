//
//  UILabel+CustomFontLabel.m
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import "UILabel+CustomFontLabel.h"

@implementation UILabel (CustomFontLabel)

- (void)awakeFromNib
{
    float size = [self.font pointSize];
    self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

@end
