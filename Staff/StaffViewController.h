//
//  StaffViewController.h
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffItemView : UIView

@property (nonatomic, assign, getter=isMain) BOOL main;
@property (nonatomic, assign) CGFloat scale;

@end

@interface StaffViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
