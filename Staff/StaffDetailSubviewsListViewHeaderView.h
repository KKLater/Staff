//
//  StaffDetailSubviewsListViewHeaderView.h
//  Staff
//
//  Created by 罗树新 on 2019/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffDetailSubviewsListViewHeaderView : UIView
@property (nonatomic, assign) BOOL isMain;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, copy) void(^headerViewChooseCallBack)(UIView *view, BOOL isMain);
@end

NS_ASSUME_NONNULL_END
