//
//  Currency.h
//  RateApp
//
//  Created by Екатерина Колесникова on 22.04.15.
//  Copyright (c) 2015 Kolesnikova Ekaterina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property (nonatomic, strong) NSString *numCode;
@property (nonatomic, strong) NSString *charCode;
@property (nonatomic, strong) NSString *nominal;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *value;

@end
