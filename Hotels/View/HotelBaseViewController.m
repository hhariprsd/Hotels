//
//  HotelBaseViewController.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import "HotelBaseViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface HotelBaseViewController ()

@end

@implementation HotelBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupProgressView];
}

- (void)setupProgressView {
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    [SVProgressHUD setForegroundColor:[UIColor grayColor]];
    [SVProgressHUD setRingThickness:2.f];
    [SVProgressHUD setFont:[UIFont fontWithName:@"ProximaNova-Light" size:10.0f]];
}

- (void)showActivityIndicator {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void)hideActivityIndicator {
    [SVProgressHUD dismiss];
}

@end
