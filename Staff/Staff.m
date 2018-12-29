//
//  Staff.m
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "Staff.h"
#import "StaffViewController+PrivateExtension.h"

@interface Staff ()
@property (nonatomic, strong) StaffViewController *staffViewController;
@property (nonatomic, strong) UIWindow *staffWindow;
@property (nonatomic, strong) UIWindow *previousKeyWindow;

@end

@implementation Staff

+ (instancetype)sharedInstance {
    static Staff *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Staff alloc] init];
    });
    return manager;
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    if (_enable) {
        if ([UIApplication.sharedApplication.keyWindow isEqual:self.staffWindow]) {
            return;
        }
        self.previousKeyWindow = UIApplication.sharedApplication.keyWindow;
        [self.staffWindow makeKeyAndVisible];
    } else {
        
        [self.staffViewController cleanStaffItemViews];
        [self.previousKeyWindow makeKeyAndVisible];
    }
    
}

- (UIWindow *)staffWindow {
    if (!_staffWindow) {
        _staffWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _staffWindow.rootViewController = self.staffViewController;
    }
    return _staffWindow;
}

- (StaffViewController *)staffViewController {
    if (!_staffViewController) {
        _staffViewController = [[StaffViewController alloc] init];
    }
    return _staffViewController;
}

@end
