//
//  StaffLineView.m
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "StaffLineView.h"

@interface StaffLineView ()

@property (strong, nonatomic) CALayer *lineLayer;
@property (nonatomic, strong) CALayer *beginLayer;
@property (nonatomic, strong) CALayer *endLayer;
@property (nonatomic, assign) StaffLineViewType type;
@property (nonatomic, strong) UILabel *lenthLabel;
@property (nonatomic, strong) CAShapeLayer *referenceLine;

@end

@implementation StaffLineView
+ (StaffLineView *)lineWithType:(StaffLineViewType)type {
    StaffLineView *view = [[StaffLineView alloc] init];
    view.type = type;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self didInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInit];
    }
    return self;
}

- (void)didInit {
    [self.layer addSublayer:self.lineLayer];
    [self.layer addSublayer:self.beginLayer];
    [self.layer addSublayer:self.endLayer];
    [self addSubview:self.lenthLabel];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        self.lenthLabel.text = nil;
    }
    switch (self.type) {
        case StaffLineViewTypeSpace:
        {
            if (CGRectGetWidth(self.bounds) >= CGRectGetHeight(self.bounds)) {
                
                
                self.lineLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds) / 2.0, CGRectGetWidth(self.bounds), 1);
                self.beginLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds) / 2.0 - 5, 1, 10);
                self.endLayer.frame = CGRectMake(CGRectGetWidth(self.bounds) - 1, CGRectGetHeight(self.bounds) / 2.0 - 5, 1, 10);
                
            } else {
                self.lineLayer.frame = CGRectMake(CGRectGetWidth(self.bounds)/2.0, 0, 1, CGRectGetHeight(self.bounds));
                self.beginLayer.frame = CGRectMake(CGRectGetWidth(self.bounds)/2.0 - 5, 0, 10, 1);
                self.endLayer.frame = CGRectMake(CGRectGetWidth(self.bounds)/2.0 - 5, CGRectGetHeight(self.bounds) - 1, 10, 1);
                
            }
        }
            break;
        case StaffLineViewTypeReference:
        {
            [self.referenceLine removeFromSuperlayer];
            _referenceLine = nil;
            if (CGRectGetWidth(self.bounds) > CGRectGetHeight(self.bounds)) {
                self.referenceLine = [self configReferenceLineVertical:NO];
                [self.layer addSublayer:self.referenceLine];
            } else {
                self.referenceLine = [self configReferenceLineVertical:YES];
                [self.layer addSublayer:self.referenceLine];
            }
            
            
        }
            break;
            
        default:
            break;
    }
}


- (void)setPosition:(StaffLineViewDataPosition)position {
    _position = position;
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.maximumFractionDigits = 2;
    
    switch (position) {
        case StaffLineViewDataPositionTop:
        {
            
            self.lenthLabel.text = [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:@(CGRectGetWidth(self.bounds))]];
            CGSize labelSize = [self sizeForLabel:self.lenthLabel size:CGSizeMake(MAXFLOAT, 12)];
            self.lenthLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) / 2.0 - labelSize.width / 2.0, -14, labelSize.width, 12);
        }
            break;
        case StaffLineViewDataPositionLeft:
        {
            self.lenthLabel.text = [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:@(CGRectGetHeight(self.bounds))]];
            CGSize labelSize = [self sizeForLabel:self.lenthLabel size:CGSizeMake(MAXFLOAT, 12)];
            self.lenthLabel.frame = CGRectMake(-labelSize.width - 2, CGRectGetHeight(self.bounds) / 2.0 - 6, labelSize.width, 12);
        }
            break;
        case StaffLineViewDataPositionRight:
        {
            self.lenthLabel.text = [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:@(CGRectGetHeight(self.bounds))]];
            CGSize labelSize = [self sizeForLabel:self.lenthLabel size:CGSizeMake(MAXFLOAT, 12)];
            self.lenthLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) + 2 , CGRectGetHeight(self.bounds) / 2.0 - 6, labelSize.width, 12);
        }
            break;
        case StaffLineViewDataPositionBottom:
        {
            self.lenthLabel.text = [NSString stringWithFormat:@"%@", [numberFormatter stringFromNumber:@(CGRectGetWidth(self.bounds))]];
            CGSize labelSize = [self sizeForLabel:self.lenthLabel size:CGSizeMake(MAXFLOAT, 12)];
            self.lenthLabel.frame = CGRectMake(CGRectGetWidth(self.bounds) /2.0 - labelSize.width / 2.0, CGRectGetHeight(self.bounds) + 2, labelSize.width, 12);
        }
            break;
        case StaffLineViewDataPositionLeftTop:
        {
            
        }
            break;
        case StaffLineViewDataPositionRightTop:
        {
            
        }
            break;
        case StaffLineViewDataPositionLeftBottom:
        {
            
        }
            break;
        case StaffLineViewDataPositionRightBottom:
        {
            
        }
            break;
        default:
            break;
    }
}
- (CGSize)sizeForLabel:(UILabel *)label size:(CGSize)size{
    // 计算大小
    CGSize labelSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : label.font } context:nil].size;
    return labelSize;
}


- (void)setThemeColor:(UIColor *)themeColor {
    _themeColor = themeColor;
    
    switch (self.type) {
        case StaffLineViewTypeReference: {
            [self setNeedsLayout];
            [self layoutIfNeeded];
            
        }
            break;
        case StaffLineViewTypeSpace:
        {
            self.lineLayer.borderColor = themeColor.CGColor;
            self.beginLayer.borderColor = themeColor.CGColor;
            self.endLayer.borderColor = themeColor.CGColor;
            self.lenthLabel.textColor = themeColor;
        }
            break;
        default:
            break;
    }
    
}

- (void)setType:(StaffLineViewType)type {
    _type = type;
    switch (type) {
        case StaffLineViewTypeSpace:
        {
            self.beginLayer.hidden = NO;
            self.endLayer.hidden = NO;
            self.lineLayer.hidden = NO;
            self.lenthLabel.hidden = NO;
        }
            break;
        case StaffLineViewTypeReference:
        {
            self.beginLayer.hidden = YES;
            self.endLayer.hidden = YES;
            self.lineLayer.hidden = YES;
            self.lenthLabel.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (CALayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.borderWidth = 1;
        
    }
    return _lineLayer;
}

- (CALayer *)beginLayer {
    if (!_beginLayer) {
        _beginLayer = [[CALayer alloc] init];
        _beginLayer.borderWidth = 1;
    }
    return _beginLayer;
}

- (CALayer *)endLayer {
    if (!_endLayer) {
        _endLayer = [[CALayer alloc] init];
        _endLayer.borderWidth = 1;
    }
    return _endLayer;
}

- (UILabel *)lenthLabel {
    if (!_lenthLabel) {
        _lenthLabel = [[UILabel alloc] init];
        _lenthLabel.font = [UIFont systemFontOfSize:10];
        _lenthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _lenthLabel;
}


- (CAShapeLayer *)configReferenceLineVertical:(BOOL)vertical {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    if (vertical) { //竖线
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame)/2 - 0.5, CGRectGetHeight(self.frame)/2)];
    }else { //横线
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2 - 0.5)];
    }
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色
    [shapeLayer setStrokeColor:self.themeColor.CGColor];
    //  设置虚线粗细大小
    [shapeLayer setLineWidth:1];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:4], [NSNumber numberWithInt:4], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (vertical) { //竖线
        
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame) / 2.0 - 0.5, CGRectGetHeight(self.frame));
    } else {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) / 2.0 - 0.5);
        
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    return shapeLayer;
}

@end
