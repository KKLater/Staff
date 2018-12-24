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
@end

@interface UIResponder (Category)
+ (BOOL)_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector;
- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIViewController (Category)
+ (BOOL)_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector;
- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface UIControl (Category)
+ (BOOL)_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector;
- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
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

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    if (enable) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [UIResponder _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:)];
            [UIViewController _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:)];
            [UIControl _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:)];
        });
    }
}

@end


@implementation UIResponder (Category)
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:)];
//
//    });
//}

- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (Staff.sharedInstance.enable) {
        
        UITouch *touch = touches.anyObject;
        UIView *view = touch.view;
        NSInteger count = [touch tapCount];
        
        if ([view isKindOfClass:StaffView.class]) {
            [self _swizzle_touchesBegan:touches withEvent:event];
        }
        if (![view isKindOfClass:UIWindow.class]) {
            
            if (count == 1) {
                [Staff.sharedInstance performSelector:@selector(_private_singleTapActionWithView:) withObject:view afterDelay:0.3];
            }
            if (count == 2) {
                //取消单击
                [NSObject cancelPreviousPerformRequestsWithTarget:Staff.sharedInstance selector:@selector(_private_singleTapActionWithView:) object:view];
                [Staff.sharedInstance performSelector:@selector(_private_doubleTapActionWithView:) withObject:view afterDelay:0.3];
            }
        }} else {
            [self.nextResponder _swizzle_touchesBegan:touches withEvent:event];
        }
}


+ (BOOL)_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, newSelector);
    BOOL didAddMethod =
    class_addMethod(self,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}
@end

@implementation UIViewController (Category)
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:)];
//    });
//}

- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (Staff.sharedInstance.enable) {
        UITouch *touch = touches.anyObject;
        UIView *view = touch.view;
        NSInteger count = [touch tapCount];
        if ([view isKindOfClass:StaffView.class]) {
            return;
        }
        if (![view isKindOfClass:UIWindow.class]) {
            
            if (count == 1) {
                [Staff.sharedInstance performSelector:@selector(_private_singleTapActionWithView:) withObject:view afterDelay:0.3];
            }
            if (count == 2) {
                //取消单击
                [NSObject cancelPreviousPerformRequestsWithTarget:Staff.sharedInstance selector:@selector(_private_singleTapActionWithView:) object:view];
                [Staff.sharedInstance _private_doubleTapActionWithView:view];
            }
        }
    }else {
        [self _swizzle_touchesBegan:touches withEvent:event];
    }
}

+ (BOOL)_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, newSelector);
    BOOL didAddMethod =
    class_addMethod(self,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}
@end

@implementation UIControl (Category)
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self _swizzleInstanceMethod:@selector(touchesBegan:withEvent:) with:@selector(_swizzle_touchesBegan:withEvent:)];
//    });
//}


- (void)_swizzle_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (Staff.sharedInstance.enable) {
        UITouch *touch = touches.anyObject;
        UIView *view = touch.view;
        NSInteger count = [touch tapCount];
        
        if ([view isKindOfClass:StaffView.class]) {
            return;
        }
        if (![view isKindOfClass:UIWindow.class]) {
            
            if (count == 1) {
                [Staff.sharedInstance performSelector:@selector(_private_singleTapActionWithView:) withObject:view afterDelay:0.3];
            }
            if (count == 2) {
                //取消单击
                [NSObject cancelPreviousPerformRequestsWithTarget:Staff.sharedInstance selector:@selector(_private_singleTapActionWithView:) object:view];
                [Staff.sharedInstance _private_doubleTapActionWithView:view];
            }
        }
    }  else {
        [self _swizzle_touchesBegan:touches withEvent:event];
    }
}

+ (BOOL)_swizzleInstanceMethod:(SEL)originalSelector with:(SEL)newSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, newSelector);
    BOOL didAddMethod =
    class_addMethod(self,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

@end
