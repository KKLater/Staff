//
//  StaffLineView.h
//  Staff
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, StaffLineViewType) {
    StaffLineViewTypeSpace,
    StaffLineViewTypeReference
};

typedef NS_ENUM(NSInteger, StaffLineViewDataPosition) {
    StaffLineViewDataPositionLeft,
    StaffLineViewDataPositionRight,
    StaffLineViewDataPositionTop,
    StaffLineViewDataPositionBottom,
    StaffLineViewDataPositionLeftTop,
    StaffLineViewDataPositionLeftBottom,
    StaffLineViewDataPositionRightTop,
    StaffLineViewDataPositionRightBottom
};
@interface StaffLineView : UIView

@property (nonatomic, strong) UIColor *themeColor;
+ (StaffLineView *)lineWithType:(StaffLineViewType)type;
- (void)showLength:(CGFloat)length atPosition:(StaffLineViewDataPosition)position;
@property (nonatomic, assign) StaffLineViewDataPosition position;

@end

NS_ASSUME_NONNULL_END
