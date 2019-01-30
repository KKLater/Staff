//
//  StaffDetailView.h
//  Staff
//
//  Created by 罗树新 on 2018/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffDetailView : UIView

- (void)layoutViews:(NSArray <UIView *> *)views;
@property (nonatomic, assign, readonly) CGRect contentRect;

@property (nonatomic, copy) void(^detailViewChooseCallback)(UIView *view, BOOL isMain);

@end

NS_ASSUME_NONNULL_END
