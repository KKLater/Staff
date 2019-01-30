//
//  StaffPrivate.h
//  Staff
//
//  Created by 罗树新 on 2018/12/26.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffPrivate : NSObject

+ (UIView *)fiterViewForPoint:(CGPoint)point;
+ (UIView *)fiterView:(UIView *)view forHitTestPoint:(CGPoint)point;

+ (void)private_singleTapActionWithView:(UIView *)view;
+ (void)private_doubleTapAction;
+ (NSNumberFormatter *)numberFormatter;
+ (NSString *)formatedNumberString:(NSNumber *)number;
@end

NS_ASSUME_NONNULL_END
