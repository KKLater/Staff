//
//  StaffItemView.h
//  Staff
//
//  Created by 罗树新 on 2018/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffItemView : UIView

@property (nonatomic, assign, getter=isMain) BOOL main;
@property (nonatomic, assign) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
