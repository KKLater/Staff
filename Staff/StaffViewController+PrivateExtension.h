//
//  StaffViewController+PrivateExtension.h
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "StaffViewController.h"
//#import "Staff.h"

NS_ASSUME_NONNULL_BEGIN

@interface StaffViewController ()

- (void)showStaffItemViewOnView:(UIView *)view;
- (void)swapMain;
- (void)cleanStaffItemViews;

@property (nonatomic, assign) NSInteger staffItemViewsCount;
@end

NS_ASSUME_NONNULL_END
