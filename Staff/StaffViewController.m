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
@property (nonatomic, strong) UITapGestureRecognizer *thirdTapGestureRecognizer;

@property (nonatomic, strong) StaffDetailView *detailView;


@property (nonatomic, strong) StaffContentView *contentView;


@end

@implementation StaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    self.contentView.frame = UIScreen.mainScreen.bounds;
    [self.view addGestureRecognizer:self.singleTapGestureRecognizer];
    [self.view addGestureRecognizer:self.doubleTapGestureRecognizer];
    [self.view addGestureRecognizer:self.thirdTapGestureRecognizer];
    [self.view addSubview:self.detailView];
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

- (void)thirdTagGestureRecognizerAction:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        if (self.contentViews.count > 0) {
            if(self.detailView.hidden) {
                self.detailView.hidden = NO;
                self.detailView.alpha = 0;
                [UIView animateWithDuration:0.2 animations:^{
                    self.detailView.alpha = 1;
                }];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    self.detailView.alpha = 0;
                } completion:^(BOOL finished) {
                    self.detailView.hidden = YES;
                }];
            }
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
        [_singleTapGestureRecognizer requireGestureRecognizerToFail:self.thirdTapGestureRecognizer];
    }
    return _singleTapGestureRecognizer;
}

- (UITapGestureRecognizer *)doubleTapGestureRecognizer {
    if (!_doubleTapGestureRecognizer) {
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureRecognizerAction:)];
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
        [_doubleTapGestureRecognizer requireGestureRecognizerToFail:self.thirdTapGestureRecognizer];
    }
    return _doubleTapGestureRecognizer;
}

-  (UITapGestureRecognizer *)thirdTapGestureRecognizer {
    if (!_thirdTapGestureRecognizer) {
        _thirdTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdTagGestureRecognizerAction:)];
        _thirdTapGestureRecognizer.numberOfTapsRequired = 3;
    }
    return _thirdTapGestureRecognizer;
}

- (StaffDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[StaffDetailView alloc] init];
        _detailView.backgroundColor = [UIColor whiteColor];
        _detailView.layer.cornerRadius = 4;
        _detailView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
        _detailView.layer.shadowOpacity = 0.5;
        _detailView.layer.shadowRadius = 4;
        _detailView.layer.shadowOffset = CGSizeMake(0, 0);
        _detailView.clipsToBounds = false;
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
