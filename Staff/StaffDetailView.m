//
//  StaffDetailView.m
//  Staff
//
//  Created by 罗树新 on 2018/12/26.
//

#import "StaffDetailView.h"
#import "StaffContentView.h"

@interface StaffDetailView () <StaffContentViewDelegate>
@property (nonatomic, strong)StaffContentView *contentView;
@end
@implementation StaffDetailView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)layoutViews:(NSArray <UIView *> *)views {
    [self.contentView layoutViews:views completed:^(CGRect contentRect) {
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.alpha = 1;
            self.frame = CGRectMake(CGRectGetWidth(UIScreen.mainScreen.bounds) - 80 - CGRectGetWidth(contentRect), CGRectGetHeight(UIScreen.mainScreen.bounds) - 80 - CGRectGetHeight(contentRect), 60 + CGRectGetWidth(contentRect), 60 + CGRectGetHeight(contentRect));
            self.contentView.frame = CGRectMake(30, 30, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
        }];
    }];
}

- (CGFloat)scaleWithContentWidth:(CGFloat)contentWidth contentHeight:(CGFloat)contentHeight {
    CGFloat maxContentWidth = CGRectGetWidth(UIScreen.mainScreen.bounds) - 100;
    CGFloat maxContentHeight = CGRectGetHeight(UIScreen.mainScreen.bounds) * 2 / 3 - 100;
    return MIN(maxContentWidth / contentWidth, maxContentHeight / contentHeight);
}

- (StaffContentView *)contentView {
    if (!_contentView) {
        _contentView = [[StaffContentView alloc] init];
        _contentView.delegate = self;
    }
    return _contentView;
}
@end
