//
//  StaffView.m
//  Staff
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "StaffViewController.h"
#import "StaffPrivate.h"
#import "StaffContentView.h"
#import "StaffDetailView.h"

@interface StaffViewController ()

@property (nonatomic, strong) NSArray *contentViews;
@property (nonatomic, strong) UITapGestureRecognizer *singleTapGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGestureRecognizer;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *rightEdgePanGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *detailViewPanGestureRecognizer;
@property (nonatomic, strong) StaffDetailView *detailView;
@property (nonatomic, strong) StaffContentView *contentView;

@end

@implementation StaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.contentView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.detailView];
    [self.view addGestureRecognizer:self.singleTapGestureRecognizer];
    [self.view addGestureRecognizer:self.doubleTapGestureRecognizer];
    [self.view addGestureRecognizer:self.rightEdgePanGestureRecognizer];
    [self.detailView addGestureRecognizer:self.detailViewPanGestureRecognizer];
    self.detailView.hidden = YES;
}

- (NSInteger)staffItemViewsCount {
    return self.contentViews.count;
}

- (void)cleanStaffItemViews {
    self.contentViews = [NSArray new];
    [self refrestCoverViews];
}

- (void)showStaffItemViewOnView:(UIView *)view {
    if (view == nil) {
        return;
    }
    NSMutableArray *mutableContentViews = self.contentViews.mutableCopy;
    
    if ([self.contentViews containsObject:view]) {
        [mutableContentViews removeObject:view];
    } else {
        if (self.contentViews.count >= 2) {
            [mutableContentViews removeLastObject];
            [mutableContentViews addObject:view];
        } else {
            [mutableContentViews addObject:view];
        }
    }
    
    self.contentViews = mutableContentViews.copy;
    [self refrestCoverViews];
}

- (void)showStaffItemViewOnView:(UIView *)view isMain:(BOOL)isMain {
    if (view == nil) {
        return;
    }
    
    NSMutableArray *mutableContentViews = [[NSMutableArray alloc] init];

    if ([self.contentViews containsObject:view]) {
        // 已经包含该视图
        mutableContentViews = self.contentViews.mutableCopy;
        [mutableContentViews removeObject:view];
    } else {
        if (isMain) {
            // 替换主视图
            [mutableContentViews addObject:view];
            if (self.contentViews.count >= 2) {
                // 之前存在辅助视图
                [mutableContentViews addObject:self.contentViews.lastObject];
            }
        } else {
            // 替换辅助视图
            if (self.contentViews.count >= 2) {
                // 之前存在辅助视图
                [mutableContentViews addObject:self.contentViews.firstObject];
                [mutableContentViews addObject:view];
            } else {
                // 之前不存在辅助视图
                [mutableContentViews addObject:view];
            }
        }
    }
    self.contentViews = mutableContentViews.copy;
    [self refrestCoverViews];
}

- (void)swapMain {
    if (self.staffItemViewsCount == 2) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        [temp addObject:self.contentViews.lastObject];
        [temp addObject:self.contentViews.firstObject];
        self.contentViews = temp.copy;
        [self refrestCoverViews];
    }
}

- (void)refrestCoverViews {
    [self.contentView layoutViews:self.contentViews completed:nil];
    [self.detailView layoutViews:self.contentViews];
}

- (void)singleTapGestureRecognizerAction:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        CGPoint tapPointInView = [gestureRecognizer locationInView:self.view];
        CGPoint detailPoint = [self.view convertPoint:tapPointInView toView:self.detailView];

        if (![self.detailView hitTest:detailPoint withEvent:nil]) {
            UIView *view = [StaffPrivate fiterViewForPoint:tapPointInView];
            [StaffPrivate private_singleTapActionWithView:view];
        }
    }
}

- (void)doubleTapGestureRecognizerAction:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        [StaffPrivate private_doubleTapAction];
    }
}

- (void)rightEdgePanGestureRecognizerAction:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        if (self.contentViews.count > 0) {
            if(self.detailView.hidden) {
                CGRect toFrame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds));
                CGRect newFrame = CGRectMake(CGRectGetWidth(UIScreen.mainScreen.bounds) + 20, toFrame.origin.y, toFrame.size.width, toFrame.size.height);
                self.detailView.frame = newFrame;
                self.detailView.hidden = NO;
                [UIView animateWithDuration:0.2 animations:^{
                    self.detailView.frame = toFrame;
                }];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                } completion:^(BOOL finished) {
                    self.detailView.hidden = YES;
                }];
            }
        }
    }
}

- (void)detailViewPanGestureRecognizerAction:(UIPanGestureRecognizer *)gestureRecognizer {
    CGFloat transX = [gestureRecognizer translationInView:self.view].x;

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat x = transX;
        if (transX > 0) {
            self.detailView.frame = CGRectMake(x, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds));
        }
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        if (transX > CGRectGetWidth(self.detailView.contentRect) * 0.5) {
            [UIView animateWithDuration:0.15 animations:^{
                self.detailView.frame = CGRectMake(CGRectGetWidth(UIScreen.mainScreen.bounds) + 20, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds));
            } completion:^(BOOL finished) {
                self.detailView.hidden = YES;
            }];
        } else {
            [UIView animateWithDuration:0.15 animations:^{
                self.detailView.frame = UIScreen.mainScreen.bounds;
            }];
        }
    }
}

- (NSArray *)contentViews {
    if (!_contentViews) {
        _contentViews = [[NSArray alloc] init];
    }
    return _contentViews;
}

- (UITapGestureRecognizer *)singleTapGestureRecognizer {
    if (!_singleTapGestureRecognizer) {
        _singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizerAction:)];
        _singleTapGestureRecognizer.numberOfTapsRequired = 1;
        [_singleTapGestureRecognizer requireGestureRecognizerToFail:self.doubleTapGestureRecognizer];
    }
    return _singleTapGestureRecognizer;
}

- (UITapGestureRecognizer *)doubleTapGestureRecognizer {
    if (!_doubleTapGestureRecognizer) {
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureRecognizerAction:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    }
    return _doubleTapGestureRecognizer;
}

- (UIScreenEdgePanGestureRecognizer *)rightEdgePanGestureRecognizer {
    if (!_rightEdgePanGestureRecognizer) {
        _rightEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(rightEdgePanGestureRecognizerAction:)];
        _rightEdgePanGestureRecognizer.edges = UIRectEdgeRight;
    }
    return _rightEdgePanGestureRecognizer;
}


- (UIPanGestureRecognizer *)detailViewPanGestureRecognizer {
    if (!_detailViewPanGestureRecognizer) {
        _detailViewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(detailViewPanGestureRecognizerAction:)];
    }
    return _detailViewPanGestureRecognizer;
}

- (StaffDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[StaffDetailView alloc] init];
        _detailView.backgroundColor = [UIColor clearColor];
        __weak typeof(self)weakSelf = self;
        [_detailView setDetailViewChooseCallback:^(UIView * _Nonnull view, BOOL isMain) {
            [weakSelf showStaffItemViewOnView:view isMain:isMain];
        }];

    }
    return _detailView;
}

- (StaffContentView *)contentView {
    if (!_contentView) {
        _contentView = [[StaffContentView alloc] init];
        _contentView.isReferScreen = YES;
    }
    return _contentView;
}
@end
