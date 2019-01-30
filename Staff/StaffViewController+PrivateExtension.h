//
//  StaffViewController+PrivateExtension.h
//  Staff
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "StaffViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface StaffViewController ()

- (void)showStaffItemViewOnView:(UIView *)view;
- (void)swapMain;
- (void)cleanStaffItemViews;
- (void)showStaffItemViewOnView:(UIView *)view isMain:(BOOL)isMain;

@property (nonatomic, assign) NSInteger staffItemViewsCount;
@end

NS_ASSUME_NONNULL_END
