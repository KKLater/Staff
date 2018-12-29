//
//  StaffContentView.h
//  Staff
//
//  Created by 罗树新 on 2018/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol StaffContentViewDelegate;
@interface StaffContentView : UIView
@property (nonatomic, assign) id<StaffContentViewDelegate> delegate;
- (void)layoutViews:(NSArray <UIView *> *)views completed:(void(^ _Nullable)(CGRect contentRect))completed;
@property (nonatomic, assign) BOOL isReferScreen;
@end

@protocol StaffContentViewDelegate <NSObject>
- (CGFloat)scaleWithContentWidth:(CGFloat)contentWidth contentHeight:(CGFloat)contentHeight;
@end
NS_ASSUME_NONNULL_END
