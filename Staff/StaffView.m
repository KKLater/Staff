//
//  StaffView.m
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "StaffView.h"
#import "StaffLineView.h"

@interface StaffItemView ()
@property (nonatomic, strong) StaffLineView *widthLineView;
@property (nonatomic, strong) UILabel *widthLabel;


@property (nonatomic, strong) StaffLineView *heightLineView;
@property (nonatomic, strong) UILabel *heightLabel;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIColor *mainColor;
@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, assign, getter=isMain) BOOL main;
@end

@implementation StaffItemView

- (instancetype)init {
    if (self = [super init]) {
        self.mainColor = [UIColor redColor];
        self.normalColor = [UIColor colorWithRed:62.f/255 green:160.f/255 blue:227.f/255 alpha:1];
        self.backgroundColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:0.5];
        self.layer.borderColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 2;
        self.layer.shadowColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1].CGColor;
        self.layer.shadowRadius = 0.5;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowOpacity = 0.3;
        [self addSubview:self.widthLineView];
        [self addSubview:self.widthLabel];
        [self addSubview:self.heightLineView];
        [self addSubview:self.heightLabel];
        [self showColor:self.normalColor];
    }
    return self;
}


- (void)doubleTapAction:(UITapGestureRecognizer *)gestureRecognizer {
    if (!self.isMain) {
        self.main = YES;
    }
}

- (void)showColor:(UIColor *)color {
    self.widthLineView.themeColor = color;
    self.heightLineView.themeColor = color;
    self.widthLabel.textColor = color;
    self.heightLabel.textColor = color;
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
    CGRect screenFrame = [[UIApplication sharedApplication].keyWindow convertRect:contentView.frame fromView:contentView.superview];
    self.frame = screenFrame;
    self.widthLabel.text = [NSString stringWithFormat:@"%@",@(CGRectGetWidth(contentView.bounds))];
    self.heightLabel.text = [NSString stringWithFormat:@"%@", @(CGRectGetHeight(contentView.bounds))];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    if (width <= CGRectGetWidth(UIScreen.mainScreen.bounds) -  100) {
        self.widthLineView.frame = CGRectMake(0, height + 5, width, 1);
        self.widthLineView.position = StaffLineViewDataPositionBottom;
        
    } else {
        self.widthLineView.frame = CGRectMake(0, height  - 20, width, 1);
        self.widthLineView.position = StaffLineViewDataPositionTop;
    }
    
    if (height <= CGRectGetHeight(UIScreen.mainScreen.bounds) - 100) {
        self.heightLineView.frame = CGRectMake(width + 5, 0, 1, height);
        self.heightLineView.position = StaffLineViewDataPositionRight;
    } else {
        self.heightLineView.frame = CGRectMake(width - 20 , 0, 1, height);
        self.heightLineView.position = StaffLineViewDataPositionLeft;
    }
}



- (StaffLineView *)widthLineView {
    if (!_widthLineView) {
        _widthLineView = [StaffLineView lineWithType:StaffLineViewTypeSpace];
    }
    return _widthLineView;
}

- (UILabel *)widthLabel {
    if (!_widthLabel) {
        _widthLabel = [[UILabel alloc] init];
        _widthLabel.font = [UIFont systemFontOfSize:11];
        _widthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _widthLabel;
}

- (StaffLineView *)heightLineView {
    if (!_heightLineView) {
        _heightLineView = [StaffLineView lineWithType:StaffLineViewTypeSpace];
    }
    return _heightLineView;
}


- (UILabel *)heightLabel {
    if (!_heightLabel) {
        _heightLabel = [[UILabel alloc] init];
        _heightLabel.font = [UIFont systemFontOfSize:11];
        _heightLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _heightLabel;
}
@end

@interface StaffView ()

@property (nonatomic, strong) StaffItemView *mainItemView;
@property (nonatomic, strong) StaffItemView *referenceItemView;

@property (nonatomic, strong) StaffLineView *leftSpacingLine;
@property (nonatomic, strong) StaffLineView *rightSpacingLine;
@property (nonatomic, strong) StaffLineView *topSpacingLine;
@property (nonatomic, strong) StaffLineView *bottomSpacingLine;

@property (nonatomic, strong) StaffLineView *leftReferenceLine;
@property (nonatomic, strong) StaffLineView *rightReferenceLine;
@property (nonatomic, strong) StaffLineView *topReferenceLine;
@property (nonatomic, strong) StaffLineView *bottomReferenceLine;


@property (nonatomic, strong) NSArray *contentViews;
@end

@implementation StaffView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = UIScreen.mainScreen.bounds;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.mainItemView];
        [self addSubview:self.referenceItemView];
        
        [self addSubview:self.leftSpacingLine];
        [self addSubview:self.rightSpacingLine];
        [self addSubview:self.topSpacingLine];
        [self addSubview:self.bottomSpacingLine];
        
        [self addSubview:self.leftReferenceLine];
        [self addSubview:self.rightReferenceLine];
        [self addSubview:self.topReferenceLine];
        [self addSubview:self.bottomReferenceLine];
        
        self.clipsToBounds = NO;
        
    }
    return self;
}


- (UIEdgeInsets)edgeInsetsWithFirstView:(UIView *)firstView secondView:(UIView *)secondView {
    CGFloat leftSpace = fabs(CGRectGetMinX(firstView.frame) - CGRectGetMinX(secondView.frame));
    CGFloat rightSpace = fabs(CGRectGetMaxX(firstView.frame) - CGRectGetMaxX(secondView.frame));
    CGFloat topSpace = fabs(CGRectGetMinY(firstView.frame) - CGRectGetMinY(secondView.frame));
    CGFloat bottomSpace = fabs(CGRectGetMaxY(firstView.frame) - CGRectGetMaxY(secondView.frame));
    UIEdgeInsets inset = UIEdgeInsetsMake(topSpace, leftSpace, bottomSpace, rightSpace);
    return inset;
}

- (BOOL)hasSelectedView:(UIView *)view {
    if (view == nil) {
        return NO;
    }
    return [self.contentViews containsObject:view];
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
    
    if ([self.contentViews containsObject:view]) {
        return;
    }
    if (self.contentViews.count >= 2) {
        NSMutableArray *mutableContentViews = [[NSMutableArray alloc] init];
        
        [mutableContentViews addObject:self.contentViews.firstObject];
        [mutableContentViews addObject:view];
        self.contentViews = mutableContentViews.copy;
    } else {
        NSMutableArray *mutableContentViews = self.contentViews.mutableCopy;
        [mutableContentViews addObject:view];
        self.contentViews = mutableContentViews.copy;
    }
    [self refrestCoverViews];
    
}

- (void)refrestCoverViews {
    if (self.contentViews.count > 0) {
        self.mainItemView.contentView = self.contentViews.firstObject;
        
        if (self.contentViews.count > 1) {
            self.referenceItemView.contentView = self.contentViews.lastObject;
            self.leftSpacingLine.hidden = NO;
            self.rightSpacingLine.hidden = NO;
            self.topSpacingLine.hidden = NO;
            self.bottomSpacingLine.hidden = NO;
        } else {
            self.leftSpacingLine.hidden = YES;
            self.rightSpacingLine.hidden = YES;
            self.topSpacingLine.hidden = YES;
            self.bottomSpacingLine.hidden = YES;
        }
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self setNeedsLayout];
        [self layoutIfNeeded];
   
    } else {
        self.mainItemView.contentView = nil;
        self.referenceItemView.contentView = nil;
        self.leftSpacingLine.hidden = YES;
        self.rightSpacingLine.hidden = YES;
        self.topSpacingLine.hidden = YES;
        self.bottomSpacingLine.hidden = YES;
        self.leftReferenceLine.frame = CGRectZero;
        self.rightReferenceLine.frame = CGRectZero;
        self.topReferenceLine.frame = CGRectZero;
        self.bottomReferenceLine.frame = CGRectZero;
        
        [self removeFromSuperview];
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
    
    
}

- (CGSize)sizeForLabel:(UILabel *)label size:(CGSize)size{
    // 计算大小
    CGSize labelSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : label.font } context:nil].size;
    return labelSize;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = self.superview.bounds;
    CGFloat main  = CGRectGetWidth(self.mainItemView.frame) * CGRectGetHeight(self.mainItemView.frame);
    CGFloat refrence = CGRectGetWidth(self.referenceItemView.frame) * CGRectGetHeight(self.referenceItemView.frame);
    if (main < refrence) {
        [self sendSubviewToBack:self.referenceItemView];
    } else {
        [self sendSubviewToBack:self.mainItemView];
    }
    if (self.staffItemViewsCount > 0) {
        CGFloat minFirstX = CGRectGetMinX(self.mainItemView.frame);
        CGFloat maxFirstX = CGRectGetMaxX(self.mainItemView.frame);
        CGFloat minFirstY = CGRectGetMinY(self.mainItemView.frame);
        CGFloat maxFirstY = CGRectGetMaxY(self.mainItemView.frame);
        CGFloat centerFirstX = self.mainItemView.center.x;
        CGFloat centerFirstY = self.mainItemView.center.y;
        
        if (self.staffItemViewsCount > 1) {
            CGFloat minSecondX = CGRectGetMinX(self.referenceItemView.frame);
            CGFloat maxSecondX = CGRectGetMaxX(self.referenceItemView.frame);
            CGFloat minSecondY = CGRectGetMinY(self.referenceItemView.frame);
            CGFloat maxSecondY = CGRectGetMaxY(self.referenceItemView.frame);
            
            CGFloat centerSecondX = self.referenceItemView.center.x;
            CGFloat centerSecondY = self.referenceItemView.center.y;
            
            self.rightSpacingLine.frame = CGRectZero;
            self.leftSpacingLine.frame = CGRectZero;
            self.topSpacingLine.frame = CGRectZero;
            self.bottomSpacingLine.frame = CGRectZero;
            
            self.leftReferenceLine.frame = CGRectZero;
            self.rightReferenceLine.frame = CGRectZero;
            self.topReferenceLine.frame = CGRectZero;
            self.bottomReferenceLine.frame = CGRectZero;
            // 无重复
            
            if (minSecondX > maxFirstX) {
                NSLog(@"right 1");
                // 主在左
                self.rightSpacingLine.frame = CGRectMake(maxFirstX, centerFirstY, minSecondX - maxFirstX, 1);
                self.rightSpacingLine.position = StaffLineViewDataPositionTop;
                
                if (maxSecondY < centerFirstY) {
                    CGFloat rightReferenceLineLength = centerFirstY -  minSecondY + 24;
                    self.rightReferenceLine.frame = CGRectMake(minSecondX, minSecondY - 10, 1, rightReferenceLineLength);
                    
                } else if (minSecondY > centerFirstY) {
                    CGFloat rightReferenceLineLength =   maxSecondY - centerFirstY + 24;
                    self.rightReferenceLine.frame = CGRectMake(minSecondX, centerFirstY - 10, 1, rightReferenceLineLength);
                    
                } else {
                    self.rightReferenceLine.frame = CGRectZero;
                }
                
            } else if (minFirstX > maxSecondX){
                // 主在右
                self.leftSpacingLine.frame = CGRectMake(maxSecondX, centerFirstY, minFirstX - maxSecondX, 1);
                self.leftSpacingLine.position = StaffLineViewDataPositionTop;
                
                if (maxSecondY < centerFirstY) {
                    CGFloat leftReferenceLineLength = centerFirstY -  minSecondY + 24;
                    self.leftReferenceLine.frame = CGRectMake(maxSecondX + 1, minSecondY - 10, 1, leftReferenceLineLength);
                    
                } else if (minSecondY > centerFirstY) {
                    CGFloat leftReferenceLineLength = maxSecondY - centerFirstY + 24;
                    self.leftReferenceLine.frame = CGRectMake(maxSecondX + 1, centerFirstY - 10, 1, leftReferenceLineLength);
                    
                } else {
                    self.leftReferenceLine.frame = CGRectZero;
                }
                
            } else if (minSecondX < minFirstX && maxSecondX > maxFirstX) {
                // 主 小于 参照
                self.rightSpacingLine.frame = CGRectMake(maxFirstX, centerFirstY, maxSecondX - maxFirstX, 1);
                self.rightSpacingLine.position = StaffLineViewDataPositionTop;
                
                self.leftSpacingLine.frame = CGRectMake(minSecondX, centerFirstY, minFirstX - minSecondX, 1);
                self.leftSpacingLine.position = StaffLineViewDataPositionTop;
                
                if (maxSecondY < centerFirstY) {
                    CGFloat leftReferenceLineLength = centerFirstY -  minSecondY + 24;
                    CGFloat rightReferenceLineLength = centerFirstY -  minSecondY + 24;
                    
                    self.leftReferenceLine.frame = CGRectMake(minSecondX + 1, minSecondY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxSecondX, minSecondY - 10, 1, rightReferenceLineLength);
                    
                } else if (minSecondY > centerFirstY) {
                    CGFloat leftReferenceLineLength = maxSecondY - centerFirstY + 24;
                    CGFloat rightReferenceLineLength =   maxSecondY - centerFirstY + 24;
                    
                    self.leftReferenceLine.frame = CGRectMake(minSecondX + 1, centerFirstY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxSecondX, centerFirstY - 10, 1, rightReferenceLineLength);
                    
                } else {
                    self.leftReferenceLine.frame = CGRectZero;
                    self.rightReferenceLine.frame = CGRectZero;
                }
            } else if (minSecondX > minFirstX && maxSecondX < maxFirstX) {
                // 主 大于 参照
                // minf < mins < maxs < maxf
                self.rightSpacingLine.frame = CGRectMake(maxSecondX, centerSecondY, maxFirstX - maxSecondX, 1);
                self.rightSpacingLine.position = StaffLineViewDataPositionTop;
                
                self.leftSpacingLine.frame = CGRectMake(minFirstX, centerSecondY, minSecondX - minFirstX, 1);
                self.leftSpacingLine.position = StaffLineViewDataPositionTop;
                
                if (maxSecondY < centerFirstY) {
                    
                    CGFloat leftReferenceLineLength = maxFirstY - centerSecondY + 24;
                    CGFloat rightReferenceLineLength =   maxFirstY - centerSecondY + 24;
                    
                    self.leftReferenceLine.frame = CGRectMake(minFirstX + 1, centerSecondY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxFirstX, centerSecondY - 10, 1, rightReferenceLineLength);
                    
                } else if (minSecondY > centerFirstY) {
                    CGFloat leftReferenceLineLength = centerSecondY -  minFirstY + 24;
                    CGFloat rightReferenceLineLength = centerSecondY -  minFirstY + 24;
                    
                    
                    self.leftReferenceLine.frame = CGRectMake(minFirstX + 1, minFirstY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxFirstX, minFirstY - 10, 1, rightReferenceLineLength);
                    
                } else {
                    self.leftReferenceLine.frame = CGRectZero;
                    self.rightReferenceLine.frame = CGRectZero;
                }
                
            } else if(minSecondX < minFirstX && maxSecondX < maxFirstX){
                // mins < minf < maxs < maxf
                self.leftSpacingLine.frame = CGRectMake(minFirstX, centerFirstY, minSecondX - minFirstX, 1);
                self.leftSpacingLine.position = StaffLineViewDataPositionTop;
                
                self.rightSpacingLine.frame = CGRectMake(maxSecondX, centerSecondY, maxFirstX - maxSecondX, 1);
                self.rightSpacingLine.position = StaffLineViewDataPositionTop;
                
                if (maxSecondY < centerFirstY) {
                    CGFloat leftReferenceLineLength = centerFirstY -  minSecondY + 24;
                    CGFloat rightReferenceLineLength = maxFirstY -  centerSecondY + 24;
                    
                    self.leftReferenceLine.frame = CGRectMake(minSecondX + 1, minSecondY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxFirstX, centerSecondY - 10, 1, rightReferenceLineLength);
                    
                } else if (minSecondY > centerFirstY) {
                    
                    CGFloat leftReferenceLineLength = maxSecondY -  centerFirstY + 24;
                    CGFloat rightReferenceLineLength = centerSecondY -  minFirstY + 24;
                    
                    self.leftReferenceLine.frame = CGRectMake(minSecondX + 1, centerFirstY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxFirstX, minFirstY - 10, 1, rightReferenceLineLength);
                    
                } else {
                    self.leftReferenceLine.frame = CGRectZero;
                    self.rightReferenceLine.frame = CGRectZero;
                }
                
            } else if (minSecondX > minFirstX && maxSecondX > maxFirstX) {
                // minf < mins < maxf < maxs
                self.rightSpacingLine.frame = CGRectMake(maxFirstX, centerFirstY, maxSecondX - maxFirstX, 1);
                self.rightSpacingLine.position = StaffLineViewDataPositionTop;
                
                self.leftSpacingLine.frame = CGRectMake(minFirstX, centerSecondY, minSecondX - minFirstX, 1);
                self.leftSpacingLine.position = StaffLineViewDataPositionTop;
                
                if (maxSecondY < centerFirstY) {
                    CGFloat leftReferenceLineLength = maxFirstY -  centerSecondY + 24;
                    CGFloat rightReferenceLineLength = centerFirstY -  minSecondY + 24;
                    
                    self.leftReferenceLine.frame = CGRectMake(minFirstX + 1, centerSecondY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxSecondX, minSecondY - 10, 1, rightReferenceLineLength);
                    
                } else if (minSecondY > centerFirstY) {
                    
                    CGFloat leftReferenceLineLength = centerSecondY -  minFirstY + 24;
                    CGFloat rightReferenceLineLength = maxSecondY -  centerFirstY + 24;
                    
                    self.leftReferenceLine.frame = CGRectMake(minFirstX + 1, minFirstY - 10, 1, leftReferenceLineLength);
                    self.rightReferenceLine.frame = CGRectMake(maxSecondX, centerFirstY - 10, 1, rightReferenceLineLength);
                    
                } else {
                    self.leftReferenceLine.frame = CGRectZero;
                    self.rightReferenceLine.frame = CGRectZero;
                }
                
            } else {
                self.rightSpacingLine.frame = CGRectMake(maxSecondX, centerFirstY, maxFirstX - maxSecondX, 1);
                self.rightSpacingLine.position = StaffLineViewDataPositionTop;
                
                self.leftSpacingLine.frame = CGRectMake(minFirstX, centerFirstY, minSecondX - minFirstX, 1);
                self.leftSpacingLine.position = StaffLineViewDataPositionTop;
                
            }
            
            if (minSecondY > maxFirstY) {
                // 主上
                
                self.bottomSpacingLine.frame = CGRectMake(centerFirstX, maxFirstY, 1, minSecondY - maxFirstY);
                self.bottomSpacingLine.position = StaffLineViewDataPositionRight;
                
                self.topSpacingLine.frame = CGRectZero;
                if (minSecondX > centerFirstX) {
                    CGFloat bottomReferenceLineLength = maxSecondX -  centerFirstX + 24;
                    self.bottomReferenceLine.frame = CGRectMake(centerFirstX - 12, minSecondY, bottomReferenceLineLength, 1);
                    
                } else if (maxSecondX < centerFirstX) {
                    CGFloat bottomReferenceLineLength = centerFirstX - minSecondX + 24;
                    self.bottomReferenceLine.frame = CGRectMake(minSecondX - 12, minSecondY, bottomReferenceLineLength, 1);
                    
                } else {
                    self.bottomReferenceLine.frame = CGRectZero;
                }
                
            } else if (minFirstY > maxSecondY) {
                // 主下
                self.topSpacingLine.frame = CGRectMake(centerFirstX,  maxSecondY, 1, minFirstY - maxSecondY);
                self.topSpacingLine.position = StaffLineViewDataPositionRight;
                
                self.bottomSpacingLine.frame = CGRectZero;
                if (minSecondX > centerFirstX) {
                    CGFloat topReferenceLineLength = maxSecondX -  centerFirstX + 24;
                    self.topReferenceLine.frame = CGRectMake(centerFirstX - 12, maxSecondY + 1, topReferenceLineLength, 1);
                    
                } else if (maxSecondX < centerFirstX) {
                    CGFloat topReferenceLineLength = centerFirstX - minSecondX + 24;
                    self.topReferenceLine.frame = CGRectMake(minSecondX - 12, maxSecondY + 1, topReferenceLineLength, 1);
                    
                } else {
                    self.topReferenceLine.frame = CGRectZero;
                }
                
            } else if (minSecondY > minFirstY && maxSecondY < maxFirstY) {
                // 主 大于 参考
                // minf < mins < maxs < maxf
                NSLog(@"top 3");
                self.topSpacingLine.frame = CGRectMake(centerSecondX,  minFirstY, 1, minSecondY - minFirstY);
                self.topSpacingLine.position = StaffLineViewDataPositionRight;
                
                self.bottomSpacingLine.frame = CGRectMake(centerSecondX, maxSecondY, 1, maxFirstY - maxSecondY);
                self.bottomSpacingLine.position = StaffLineViewDataPositionRight;
                
                if (maxSecondX < minFirstX) {
                    CGFloat topReferenceLineLength = maxFirstX - centerSecondX + 24;
                    CGFloat bottomReferenceLineLength = maxFirstX - centerSecondX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(centerSecondX - 12, minFirstY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(centerSecondX - 12, maxFirstY, bottomReferenceLineLength, 1);
                    
                } else if (minSecondX > maxFirstX) {
                    CGFloat topReferenceLineLength = centerSecondX -  minFirstX + 24;
                    CGFloat bottomReferenceLineLength = centerSecondX -  minFirstX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(minFirstX - 12, minFirstY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(minFirstX - 12, maxFirstY, bottomReferenceLineLength, 1);
                    
                } else {
                    self.topReferenceLine.frame = CGRectZero;
                    self.bottomReferenceLine.frame = CGRectZero;
                }
                
            } else if (minSecondY < minFirstY && maxSecondY > maxFirstY) {
                // 主 小于 参考
                self.bottomSpacingLine.frame = CGRectMake(centerFirstX, maxFirstY, 1, maxSecondY - maxFirstY);
                self.bottomSpacingLine.position = StaffLineViewDataPositionRight;
                
                self.topSpacingLine.frame = CGRectMake(centerFirstX,  minSecondY, 1, minFirstY - minSecondY);
                self.topSpacingLine.position = StaffLineViewDataPositionRight;
                
                if (maxSecondX < minFirstX) {
                    CGFloat topReferenceLineLength = centerFirstX - minSecondX + 24;
                    CGFloat bottomReferenceLineLength = centerFirstX - minSecondX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(minSecondX - 12, minSecondY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(minSecondX - 12, maxSecondY, bottomReferenceLineLength, 1);
                    
                } else if (minSecondX > maxFirstX) {
                    CGFloat topReferenceLineLength = maxSecondX -  centerFirstX + 24;
                    CGFloat bottomReferenceLineLength = maxSecondX -  centerFirstX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(centerFirstX - 12, minSecondY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(centerFirstX - 12, maxSecondY, bottomReferenceLineLength, 1);
                    
                } else {
                    self.topReferenceLine.frame = CGRectZero;
                    self.bottomReferenceLine.frame = CGRectZero;
                }
                
            } else if(minFirstY < minSecondY && maxFirstY < maxSecondY) {
                // minf < mins < maxf < maxs
                self.topSpacingLine.frame = CGRectMake(centerSecondX,  minFirstY, 1, minSecondY - minFirstY);
                self.topSpacingLine.position = StaffLineViewDataPositionRight;
                
                
                self.bottomSpacingLine.frame = CGRectMake(centerFirstX, maxFirstY, 1, maxSecondY - maxFirstY);
                self.bottomSpacingLine.position = StaffLineViewDataPositionRight;
                
                if (minSecondX > centerFirstX) {
                    CGFloat topReferenceLineLength = centerSecondX -  minFirstX + 24;
                    CGFloat bottomReferenceLineLength = maxSecondX -  centerFirstX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(minFirstX - 12, minFirstY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(centerFirstX - 12, maxSecondY, bottomReferenceLineLength, 1);
                    
                } else if (maxSecondX < centerFirstX) {
                    CGFloat topReferenceLineLength = centerFirstX - minSecondX + 24;
                    CGFloat bottomReferenceLineLength = centerFirstX - minSecondX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(centerSecondX - 12, minFirstY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(minSecondX - 12, maxSecondY, bottomReferenceLineLength, 1);
                    
                } else {
                    self.topReferenceLine.frame = CGRectZero;
                    self.bottomReferenceLine.frame = CGRectZero;
                }
            } else if (minSecondY < minFirstY && maxSecondY < maxFirstY) {
                // mins < minf < maxs < maxf
                self.topSpacingLine.frame = CGRectMake(centerFirstX,  minSecondY, 1, minFirstY - minSecondY);
                self.topSpacingLine.position = StaffLineViewDataPositionRight;
                
                self.bottomSpacingLine.frame = CGRectMake(centerSecondX, maxSecondY, 1, maxFirstY - maxSecondY);
                self.bottomSpacingLine.position = StaffLineViewDataPositionRight;
                
                if (minSecondX > centerFirstX) {
                    CGFloat topReferenceLineLength = maxSecondX -  centerFirstX + 24;
                    CGFloat bottomReferenceLineLength =  centerSecondX -  minFirstX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(centerFirstX - 12, minSecondY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(minFirstX - 12, maxFirstY, bottomReferenceLineLength, 1);
                    
                } else if (maxSecondX < centerFirstX) {
                    CGFloat topReferenceLineLength = centerFirstX - minSecondX + 24;
                    CGFloat bottomReferenceLineLength = maxFirstX - centerSecondX + 24;
                    
                    self.topReferenceLine.frame = CGRectMake(minSecondX - 12, minSecondY + 1, topReferenceLineLength, 1);
                    self.bottomReferenceLine.frame = CGRectMake(centerSecondX - 12, maxFirstY, bottomReferenceLineLength, 1);
                    
                } else {
                    self.topReferenceLine.frame = CGRectZero;
                    self.bottomReferenceLine.frame = CGRectZero;
                }
            } else {
                self.bottomSpacingLine.frame = CGRectMake(centerFirstX, maxFirstY, 1, maxSecondY - maxFirstY);
                self.bottomSpacingLine.position = StaffLineViewDataPositionRight;
                
                self.topSpacingLine.frame = CGRectMake(centerFirstX ,  minSecondY + 1, 1, minFirstY - minSecondY);
                self.topSpacingLine.position = StaffLineViewDataPositionRight;
            }
        }
    }
    
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

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return nil;
}

#pragma mark - Setter/Getter


- (StaffItemView *)mainItemView {
    if (!_mainItemView) {
        _mainItemView = [[StaffItemView alloc] init];
        _mainItemView.main = YES;
    }
    return _mainItemView;
}

- (StaffItemView *)referenceItemView {
    if (!_referenceItemView) {
        _referenceItemView = [[StaffItemView alloc] init];
    }
    return _referenceItemView;
}

- (StaffLineView *)leftSpacingLine {
    if (!_leftSpacingLine) {
        _leftSpacingLine = [StaffLineView lineWithType:StaffLineViewTypeSpace];
        _leftSpacingLine.themeColor = [UIColor brownColor];
    }
    return _leftSpacingLine;
}


- (StaffLineView *)rightSpacingLine {
    if (!_rightSpacingLine) {
        _rightSpacingLine = [StaffLineView lineWithType:StaffLineViewTypeSpace];
        _rightSpacingLine.themeColor = [UIColor darkGrayColor];
    }
    return _rightSpacingLine;
}
- (StaffLineView *)topSpacingLine {
    if (!_topSpacingLine) {
        _topSpacingLine = [StaffLineView lineWithType:StaffLineViewTypeSpace];
        _topSpacingLine.themeColor = [UIColor orangeColor];
    }
    return _topSpacingLine;
}
- (StaffLineView *)bottomSpacingLine {
    if (!_bottomSpacingLine) {
        _bottomSpacingLine = [StaffLineView lineWithType:StaffLineViewTypeSpace];
        _bottomSpacingLine.themeColor = [UIColor purpleColor];
    }
    return _bottomSpacingLine;
}

- (StaffLineView *)leftReferenceLine {
    if (!_leftReferenceLine) {
        _leftReferenceLine = [StaffLineView lineWithType:StaffLineViewTypeReference];
        _leftReferenceLine.themeColor = [UIColor brownColor];
    }
    return _leftReferenceLine;
}

- (StaffLineView *)rightReferenceLine {
    if (!_rightReferenceLine) {
        _rightReferenceLine = [StaffLineView lineWithType:StaffLineViewTypeReference];
        _rightReferenceLine.themeColor = [UIColor darkGrayColor];
    }
    return _rightReferenceLine;
}

- (StaffLineView *)topReferenceLine {
    if (!_topReferenceLine) {
        _topReferenceLine = [StaffLineView lineWithType:StaffLineViewTypeReference];
        _topReferenceLine.themeColor = [UIColor orangeColor];
    }
    return _topReferenceLine;
}

- (StaffLineView *)bottomReferenceLine {
    if (!_bottomReferenceLine) {
        _bottomReferenceLine = [StaffLineView lineWithType:StaffLineViewTypeReference];
        _bottomReferenceLine.themeColor = [UIColor purpleColor];
    }
    return _bottomReferenceLine;
}

- (NSArray *)contentViews {
    if (!_contentViews) {
        _contentViews = [[NSArray alloc] init];
    }
    return _contentViews;
}
@end
