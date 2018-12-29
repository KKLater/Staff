//
//  StaffItemView.m
//  Staff
//
//  Created by 罗树新 on 2018/12/29.
//

#import "StaffItemView.h"
#import "StaffLineView.h"

@interface StaffItemView ()
@property (nonatomic, strong) StaffLineView *widthLineView;
@property (nonatomic, strong) StaffLineView *heightLineView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIColor *mainColor;
@property (nonatomic, strong) UIColor *normalColor;
@end

@implementation StaffItemView

- (instancetype)init {
    if (self = [super init]) {
        self.mainColor = [UIColor redColor];
        self.normalColor = [UIColor colorWithRed:62.f/255 green:160.f/255 blue:227.f/255 alpha:1];
        self.backgroundColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:0.3];
        self.layer.borderColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 2;
        self.layer.shadowColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1].CGColor;
        self.layer.shadowRadius = 0.5;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowOpacity = 0.3;
        [self addSubview:self.widthLineView];
        [self addSubview:self.heightLineView];
        self.scale = 1;
    }
    return self;
}

- (void)showColor:(UIColor *)color {
    self.widthLineView.themeColor = color;
    self.heightLineView.themeColor = color;
}

- (void)setMain:(BOOL)main {
    _main = main;
    if (self.isMain) {
        [self showColor:self.mainColor];
    } else {
        [self showColor:self.normalColor];
    }
}

- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    if (_contentView) {
        CGRect screenFrame = [[UIApplication sharedApplication].keyWindow convertRect:contentView.frame fromView:contentView.superview];
        self.frame = screenFrame;
        self.widthLineView.hidden = NO;
        self.heightLineView.hidden = NO;
        self.hidden = NO;
    } else {
        self.frame = CGRectZero;
        self.widthLineView.hidden = YES;
        self.heightLineView.hidden = YES;
        self.hidden = YES;
        self.widthLineView.frame = CGRectZero;
        self.heightLineView.frame = CGRectZero;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect referRect = self.frame;
    CGFloat superWidth = CGRectGetWidth(self.superview.bounds);
    CGFloat superHeight = CGRectGetHeight(self.superview.bounds);
    CGFloat width = CGRectGetWidth(referRect);
    CGFloat height = CGRectGetHeight(referRect);
    CGFloat space = 30;
    if (width > 0 && height > 0) {
        CGFloat minX = CGRectGetMinX(referRect);
        CGFloat maxX = CGRectGetMaxX(referRect);
        CGFloat minY = CGRectGetMinY(referRect);
        CGFloat maxY = CGRectGetMaxY(referRect);
        self.heightLineView.hidden = NO;
        if (minX <= space && maxX >= superWidth - space) {
            self.heightLineView.frame = CGRectMake(width - 5, 0, 1, height);
            [self.heightLineView showLength:height / self.scale atPosition:StaffLineViewDataPositionLeft];
        } else if (minX > space && maxX >= superWidth - space) {
            self.heightLineView.frame = CGRectMake(- 5, 0, 1, height);
            [self.heightLineView showLength:height / self.scale atPosition:StaffLineViewDataPositionLeft];
        } else {
            self.heightLineView.frame = CGRectMake(width + 5, 0, 1, height);
            [self.heightLineView showLength:height / self.scale atPosition:StaffLineViewDataPositionRight];
            
        }
        
        self.widthLineView.hidden = NO;
        if (minY <= space && maxY >= superHeight - space) {
            self.widthLineView.frame = CGRectMake(0, height - 5, width, 1);
            [self.widthLineView showLength:width / self.scale atPosition:StaffLineViewDataPositionTop];
            
        } else if (minY > space && maxY >= superHeight - space) {
            self.widthLineView.frame = CGRectMake(0, -5, width, 1);
            [self.widthLineView showLength:width / self.scale atPosition:StaffLineViewDataPositionTop];
            
        } else {
            self.widthLineView.frame = CGRectMake(0, height + 5, width, 1);
            [self.widthLineView showLength:width / self.scale atPosition:StaffLineViewDataPositionBottom];
        }
    } else {
        self.widthLineView.frame = CGRectZero;
        self.heightLineView.frame = CGRectZero;
        self.widthLineView.hidden = YES;
        self.heightLineView.hidden = YES;
    }
}

- (StaffLineView *)widthLineView {
    if (!_widthLineView) {
        _widthLineView = [StaffLineView lineWithType:StaffLineViewTypeSpace];
    }
    return _widthLineView;
}

- (StaffLineView *)heightLineView {
    if (!_heightLineView) {
        _heightLineView = [StaffLineView lineWithType:StaffLineViewTypeSpace];
    }
    return _heightLineView;
}

- (void)setScale:(CGFloat)scale {
    if (scale <= 0) {
        scale = 1;
    }
    _scale = scale;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
