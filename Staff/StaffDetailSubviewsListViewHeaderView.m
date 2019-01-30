//
//  StaffDetailSubviewsListViewHeaderView.m
//  Staff
//
//  Created by 罗树新 on 2019/1/30.
//

#import "StaffDetailSubviewsListViewHeaderView.h"

@interface StaffDetailSubviewsListViewHeaderView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *classNameButton;
@property (nonatomic, strong) UIButton *superClassNameButton;
@property (nonatomic, strong) UIView *bottomLineView;
@end
@implementation StaffDetailSubviewsListViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.superClassNameButton];
        [self addSubview:self.classNameButton];
        [self addSubview:self.bottomLineView];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.superClassNameButton sizeToFit];
    [self.classNameButton sizeToFit];
    self.titleLabel.frame = CGRectMake(10, 5, CGRectGetWidth(self.bounds) - 20, 30);
    
    if (self.view) {
        if (self.view.superview) {
            self.superClassNameButton.frame = CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame) + 5, CGRectGetWidth(self.superClassNameButton.frame), 30);
        } else {
            self.superClassNameButton.frame = CGRectZero;
        }
        self.classNameButton.frame = CGRectMake(CGRectGetMaxX(self.superClassNameButton.frame) + 5, CGRectGetMaxY(self.titleLabel.frame) + 5, MIN(CGRectGetWidth(self.frame) - CGRectGetMaxX(self.superClassNameButton.frame) - 10, CGRectGetWidth(self.classNameButton.frame)), 30);
    } else {
        self.superClassNameButton.frame = CGRectZero;
        self.classNameButton.frame = CGRectZero;
    }
    self.bottomLineView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5);
    if (!self.isMain && self.view.subviews.count == 0) {
        self.bottomLineView.hidden = YES;
    } else {
        self.bottomLineView.hidden = NO;
    }
}

#pragma mark - Action

- (void)superClassNameButtonAction:(UIButton *)button {
    if (self.view.superview) {
        !self.headerViewChooseCallBack ?: self.headerViewChooseCallBack(self.view.superview, self.isMain);
    }
}

#pragma mark - Setter / Getter

- (void)setIsMain:(BOOL)isMain {
    _isMain = isMain;
    if (isMain) {
        self.titleLabel.text = @"主视图";
        self.titleLabel.textColor = UIColor.redColor;
    } else {
        self.titleLabel.text = @"辅视图";
        self.titleLabel.textColor = UIColor.blueColor;
    }
}

- (void)setView:(UIView *)view {
    _view = view;
    if (view) {
        if (view.superview) {
            [self.superClassNameButton setTitle:[NSString stringWithFormat:@"%@", NSStringFromClass(view.superview.class)] forState:UIControlStateNormal];
            [self.classNameButton setTitle:[NSString stringWithFormat:@"• %@", NSStringFromClass(view.class)] forState:UIControlStateNormal];
        } else {
            [self.classNameButton setTitle:[NSString stringWithFormat:@"%@", NSStringFromClass(view.class)] forState:UIControlStateNormal];
        }
    } else {
        [self.classNameButton setTitle:nil forState:UIControlStateNormal];
        [self.superClassNameButton setTitle:nil forState:UIControlStateNormal];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIButton *)classNameButton {
    if (!_classNameButton) {
        _classNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_classNameButton setTitleColor:[[UIColor alloc] initWithWhite:0 alpha:0.8] forState:UIControlStateNormal];
        _classNameButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _classNameButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _classNameButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _classNameButton;
}

- (UIButton *)superClassNameButton {
    if (!_superClassNameButton) {
        _superClassNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_superClassNameButton setTitleColor:[[UIColor alloc] initWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
        _superClassNameButton.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _superClassNameButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [_superClassNameButton addTarget:self action:@selector(superClassNameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _superClassNameButton;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [[UIColor alloc] initWithWhite:0 alpha:0.1];
    }
    return _bottomLineView;
}
@end
