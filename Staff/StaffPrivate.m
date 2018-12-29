//
//  StaffPrivate.m
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/26.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "StaffPrivate.h"
#import "Staff.h"
#import "StaffViewController+PrivateExtension.h"

@implementation StaffPrivate

+ (void)private_singleTapActionWithView:(UIView *)view {
    
    if (!view || !Staff.sharedInstance.enable) {
        return;
    }
    if ([view isKindOfClass:StaffItemView.class]) {
        
    } else {
        [Staff.sharedInstance.staffViewController showStaffItemViewOnView:view];
    }
}

+ (void)private_doubleTapAction {
    if (!Staff.sharedInstance.enable) {
        return;
    }
    [Staff.sharedInstance.staffViewController swapMain];
}

+ (UIView *)fiterViewForPoint:(CGPoint)point {
    if (Staff.sharedInstance.enable) {
         UIView *view = [self fiterView:Staff.sharedInstance.previousKeyWindow forHitTestPoint:point];
        return view;
    }
    return nil;
}
+ (UIView *)fiterView:(UIView *)view forHitTestPoint:(CGPoint)point {
  
    if (Staff.sharedInstance.enable) {
        // Select the deepest visible view at the tap point. This generally corresponds to what the user wants to select
        UIView *view = [[self recursiveSubviewsAtPoint:point  inView:Staff.sharedInstance.previousKeyWindow skipHiddenViews:YES] lastObject];
        return view;
    }
    return nil;
}

+ (NSArray *)recursiveSubviewsAtPoint:(CGPoint)pointInView inView:(UIView *)view skipHiddenViews:(BOOL)skipHidden
{
    NSMutableArray *subviewsAtPoint = [NSMutableArray array];
    for (UIView *subview in view.subviews) {
        BOOL isHidden = subview.hidden || subview.alpha < 0.01;
        if (skipHidden && isHidden) {
            continue;
        }
        
        BOOL subviewContainsPoint = CGRectContainsPoint(subview.frame, pointInView);
        if (subviewContainsPoint) {
            [subviewsAtPoint addObject:subview];
        }
        
        // If this view doesn't clip to its bounds, we need to check its subviews even if it doesn't contain the selection point.
        // They may be visible and contain the selection point.
        if (subviewContainsPoint || !subview.clipsToBounds) {
            CGPoint pointInSubview = [view convertPoint:pointInView toView:subview];
            [subviewsAtPoint addObjectsFromArray:[self recursiveSubviewsAtPoint:pointInSubview inView:subview skipHiddenViews:skipHidden]];
        }
    }
    return subviewsAtPoint;
}

@end
