//
//  Staff.m
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "Staff.h"
#import <UIKit/UIKit.h>
#import "StaffView+PrivateExtension.h"
#import <objc/runtime.h>

@interface Staff ()
@property (nonatomic, strong) StaffView *staffView;
@property (nonatomic, strong) NSArray <NSString *> *hookKey;

@end

@interface UIWindow (Category)
- (UIView *)_swizzle_hitTest:(CGPoint)point withEvent:(UIEvent *)event;
- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (UIView *)_swizzle_origin_hook_hitTest:(CGPoint)point withEvent:(UIEvent *)event;
- (void)_swizzle_origin_hook_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface UIControl (Category)
- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)_swizzle_origin_hook_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@implementation Staff

+ (instancetype)sharedInstance {
    static Staff *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[Staff alloc] init];
        manager.hookKey = [NSArray new];
    });
    return manager;
}

- (StaffView *)staffView {
    if (!_staffView) {
        _staffView = [[StaffView alloc] init];
    }
    return _staffView;
}

- (void)_private_singleTapActionWithView:(UIView *)view {
    
    if (!view || !Staff.sharedInstance.enable) {
        return;
    }
    if ([view isKindOfClass:StaffItemView.class]) {
        
    } else {
        
        if ([Staff.sharedInstance.staffView hasSelectedView:view]) {
        } else {
            [Staff.sharedInstance.staffView showStaffItemViewOnView:view];
        }
        
    }
}

- (void)_private_doubleTapActionWithView:(UIView *)view {
    if (!view || !Staff.sharedInstance.enable) {
        return;
    }
    [Staff.sharedInstance.staffView swapMain];
}

- (void)_private_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    UIView *view = touch.view;
    NSInteger count = [touch tapCount];
    if ([view.window isEqual:UIApplication.sharedApplication.keyWindow]) {
        if (![view isKindOfClass:UIWindow.class]) {
            if (count == 1) {
                [Staff.sharedInstance performSelector:@selector(_private_singleTapActionWithView:) withObject:view afterDelay:0.3];
            }
            if (count == 2) {
                //取消单击
                [NSObject cancelPreviousPerformRequestsWithTarget:Staff.sharedInstance selector:@selector(_private_singleTapActionWithView:) object:view];
                [Staff.sharedInstance performSelector:@selector(_private_doubleTapActionWithView:) withObject:view afterDelay:0.3];
            }
        }
    }
}

- (void)setEnable:(BOOL)enable {
    _enable  =enable;
    if (_enable) {

        
        [Staff _swizzleInstanceMethod:@selector(hitTest:withEvent:) with:@selector(_swizzle_hitTest:withEvent:) saveSelector:@selector(_swizzle_origin_hook_hitTest:withEvent:) forClass:UIWindow.class];
        [Staff _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:) saveSelector:@selector(_swizzle_origin_hook_touchesBegan:withEvent:) forClass:UIWindow.class];
        [Staff _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:) saveSelector:@selector(_swizzle_origin_hook_touchesBegan:withEvent:) forClass:UIControl.class];


    } else {
        [Staff _swizzle_resetInstanceMethod:@selector(hitTest:withEvent:) with:@selector(_swizzle_hitTest:withEvent:) saveSelector:@selector(_swizzle_origin_hook_hitTest:withEvent:) forClass:UIWindow.class];
        [Staff _swizzle_resetInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:) saveSelector:@selector(_swizzle_origin_hook_touchesBegan:withEvent:) forClass:UIWindow.class];
        [Staff _swizzle_resetInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:) saveSelector:@selector(_swizzle_origin_hook_touchesBegan:withEvent:) forClass:UIControl.class];
        [self.staffView cleanStaffItemViews];
    }
    
}

+ (void)_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector saveSelector:(SEL)saveSelector forClass:(Class)class {
    NSString *key = [NSString stringWithFormat:@"%@-%@", NSStringFromClass(class), NSStringFromSelector(originalSelector)];
    if ([Staff.sharedInstance.hookKey containsObject:key]) {
        return;
    }
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    Method saveMethod = class_getInstanceMethod(class, saveSelector);
    if (!originalMethod || !swizzledMethod || !saveMethod) {
        return;
    }
    method_exchangeImplementations(originalMethod, saveMethod);
    method_exchangeImplementations(originalMethod, swizzledMethod);
    NSMutableArray *keys = Staff.sharedInstance.hookKey.mutableCopy;
    [keys addObject:key];
    Staff.sharedInstance.hookKey = keys.copy;
}

+ (void)_swizzle_resetInstanceMethod:(SEL)originalSelector with:(SEL)newSelector saveSelector:(SEL)saveSelector forClass:(Class)class  {
    NSString *key = [NSString stringWithFormat:@"%@-%@", NSStringFromClass(class), NSStringFromSelector(originalSelector)];
    if (![Staff.sharedInstance.hookKey containsObject:key]) {
        return;
    }
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    Method saveMethod = class_getInstanceMethod(class, saveSelector);
    if (!originalMethod || !swizzledMethod || !saveMethod) {
        return;
    }
    method_exchangeImplementations(originalMethod, saveMethod);
    method_exchangeImplementations(swizzledMethod, saveMethod);
    NSMutableArray *keys = Staff.sharedInstance.hookKey.mutableCopy;
    [keys removeObject:key];
    Staff.sharedInstance.hookKey = keys.copy;
}
@end

@implementation UIApplication (Category)

@end

@implementation UIWindow (Category)

- (UIView *)_swizzle_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (Staff.sharedInstance.enable) {
        
        if ([self isEqual:UIApplication.sharedApplication.keyWindow]) {
            if ([self.layer hitTest:point]) {
                UIView *view = [self fiterView:self forHitTestPoint:point];
                if (view) {
                    if ([view isKindOfClass:StaffView.class]) {
                        return nil;
                    }
                    if ([view isKindOfClass:UIWindow.class]) {
                        
                        
                        return nil;
                        
                    }

                    return view;
                }
            }
        }
        return nil;
        
    }
    return [self _swizzle_hitTest:point withEvent:event];
}

- (UIView *)fiterView:(UIView *)view forHitTestPoint:(CGPoint)point {
    if (Staff.sharedInstance.enable) {
        
        CGPoint locationPoint = [[UIApplication sharedApplication].keyWindow convertPoint:point toView:view.superview];
        
        if ([view.layer hitTest:locationPoint]) {
            for (UIView *aview in view.subviews) {
                UIView *tempView = [self fiterView:aview forHitTestPoint:point];
                if (tempView) {
                    return tempView;
                }
            }
            return view;
        }
    }
    return nil;
}
//
- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (Staff.sharedInstance.enable) {

        [Staff.sharedInstance _private_touchesBegan:touches withEvent:event];

    }
}

- (UIView *)_swizzle_origin_hook_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return nil;
}
- (void)_swizzle_origin_hook_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}




@end

@implementation UIControl (Category)

- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (Staff.sharedInstance.enable) {
        
        [Staff.sharedInstance _private_touchesBegan:touches withEvent:event];
        
    }
}


- (void)_swizzle_origin_hook_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
