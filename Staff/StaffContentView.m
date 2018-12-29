//
//  StaffContentView.m
//  Staff
//
//  Created by 罗树新 on 2018/12/29.
//

#import "StaffContentView.h"
#import "StaffItemView.h"
#import "StaffLineView.h"
#import "StaffModel.h"

@interface StaffContentView ()
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

@end
@implementation StaffContentView

- (instancetype)init {
    if (self = [super init]) {
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
        self.mainItemView.hidden = YES;
        self.referenceItemView.hidden = YES;
    }
    return self;
}


- (void)layoutViews:(NSArray <UIView *> *)views completed:(void(^)(CGRect contentRect))completed {
    
    UIView *mainView = nil;
    UIView *refView = nil;
    
    if (views.count > 0) {
        mainView = views.firstObject;
        if (views.count > 1) {
            refView = [views objectAtIndex:1];
        }
    }
    
    if (mainView) {
        StaffModel *staffModel = [self staffModelForMainView:mainView refView:refView];
        !completed ?: completed(staffModel.contentRect);
        [self preLayoutSubviewsWithModel:staffModel];
        [self layoutSubviewsWithModel:staffModel];
    } else {
        [self hiddenViewsWithMainView:mainView refView:refView];
    }
}

- (void)hiddenViewsWithMainView:(UIView *)mainView refView:(UIView *)refView {
    if (!mainView) {
        self.mainItemView.hidden = YES;
        self.referenceItemView.hidden = YES;
    } else {
        if (!refView) {
            self.referenceItemView.hidden = YES;
        }
    }
    self.leftSpacingLine.hidden = YES;
    self.rightSpacingLine.hidden = YES;
    self.topSpacingLine.hidden = YES;
    self.bottomSpacingLine.hidden = YES;
    self.leftReferenceLine.hidden = YES;
    self.rightReferenceLine.hidden = YES;
    self.topReferenceLine.hidden = YES;
    self.bottomReferenceLine.hidden = YES;
}

- (void)layoutSubviewsWithModel:(StaffModel *)staffModel {
    if (staffModel) {
        [UIView animateWithDuration:0.2 animations:^{
            self.mainItemView.frame = staffModel.mainRect;
            self.referenceItemView.frame = staffModel.refRect;
            self.leftSpacingLine.frame = staffModel.leftRefModel.rect;
            self.leftReferenceLine.frame = staffModel.leftRefModel.referenceModel.rect;
            self.rightSpacingLine.frame = staffModel.rightRefModel.rect;
            self.rightReferenceLine.frame = staffModel.rightRefModel.referenceModel.rect;
            self.topSpacingLine.frame = staffModel.topRefModel.rect;
            self.topReferenceLine.frame = staffModel.topRefModel.referenceModel.rect;
            self.bottomSpacingLine.frame = staffModel.bottomRefModel.rect;
            self.bottomReferenceLine.frame = staffModel.bottomRefModel.referenceModel.rect;
            
            [self.leftSpacingLine showLength:staffModel.leftRefModel.showLength atPosition:staffModel.leftRefModel.position];
            [self.rightSpacingLine showLength:staffModel.rightRefModel.showLength atPosition:staffModel.rightRefModel.position];
            [self.topSpacingLine showLength:staffModel.topRefModel.showLength atPosition:staffModel.topRefModel.position];
            [self.bottomSpacingLine showLength:staffModel.bottomRefModel.showLength atPosition:staffModel.bottomRefModel.position];
            
        }];
    }
}

- (void)preLayoutSubviewsWithModel:(StaffModel *)staffModel {
    if (CGRectEqualToRect(staffModel.mainRect, CGRectZero)) {
        self.mainItemView.hidden = YES;
    } else {
        if (self.mainItemView.hidden) {
            self.mainItemView.hidden = NO;
            self.mainItemView.frame = staffModel.mainRect;
        }
        
    }
    if (CGRectEqualToRect(staffModel.refRect, CGRectZero)) {
        self.referenceItemView.hidden = YES;
    } else {
        if (self.referenceItemView.hidden) {
            self.referenceItemView.hidden = NO;
            self.referenceItemView.frame = staffModel.refRect;
        }
    }
    
    if (CGRectGetWidth(staffModel.leftRefModel.rect) == 0) {
        self.leftSpacingLine.hidden = YES;
    } else {
        if (self.leftSpacingLine.hidden && !CGRectEqualToRect(staffModel.leftRefModel.preRect, CGRectZero)) {
            self.leftSpacingLine.hidden = NO;
            self.leftSpacingLine.frame = staffModel.leftRefModel.preRect;
        }
    }
    if (CGRectGetHeight(staffModel.leftRefModel.referenceModel.rect) == 0) {
        self.leftReferenceLine.hidden = YES;
    } else {
        if (self.leftReferenceLine.hidden && !CGRectEqualToRect(staffModel.leftRefModel.referenceModel.preRect, CGRectZero)) {
            self.leftReferenceLine.hidden = NO;
            self.leftReferenceLine.frame = staffModel.leftRefModel.referenceModel.preRect;
        }
    }
    
    if (CGRectGetWidth(staffModel.rightRefModel.rect) == 0) {
        self.rightSpacingLine.hidden = YES;
    } else {
        if (self.rightSpacingLine.hidden && !CGRectEqualToRect(staffModel.rightRefModel.preRect, CGRectZero)) {
            self.rightSpacingLine.hidden = NO;
            self.rightSpacingLine.frame = staffModel.rightRefModel.preRect;
        }
    }
    
    if (CGRectGetHeight(staffModel.rightRefModel.referenceModel.rect) == 0) {
        self.rightReferenceLine.hidden = YES;
    } else {
        if (self.rightReferenceLine.hidden && !CGRectEqualToRect(staffModel.rightRefModel.referenceModel.preRect, CGRectZero)) {
            self.rightReferenceLine.hidden = NO;
            self.rightReferenceLine.frame = staffModel.rightRefModel.referenceModel.preRect;
        }
    }
    
    if (CGRectGetWidth(staffModel.topRefModel.rect) == 0) {
        self.topSpacingLine.hidden = YES;
    } else {
        if (self.topSpacingLine.hidden && !CGRectEqualToRect(staffModel.topRefModel.preRect, CGRectZero)) {
            self.topSpacingLine.hidden = NO;
            self.topSpacingLine.frame = staffModel.topRefModel.preRect;
        }
    }
    
    if (CGRectGetHeight(staffModel.topRefModel.referenceModel.rect) == 0) {
        self.topReferenceLine.hidden = YES;
    } else {
        if (self.topReferenceLine.hidden && !CGRectEqualToRect(staffModel.topRefModel.referenceModel.preRect, CGRectZero)) {
            self.topReferenceLine.hidden = NO;
            self.topReferenceLine.frame = staffModel.topRefModel.referenceModel.preRect;
        }
    }
    
    if (CGRectGetWidth(staffModel.bottomRefModel.rect) == 0) {
        self.bottomSpacingLine.hidden = YES;
    } else {
        if (self.bottomSpacingLine.hidden && !CGRectEqualToRect(staffModel.bottomRefModel.preRect, CGRectZero)) {
            self.bottomSpacingLine.hidden = NO;
            self.bottomSpacingLine.frame = staffModel.bottomRefModel.preRect;
        }
    }
    
    if (CGRectGetHeight(staffModel.bottomRefModel.referenceModel.rect) == 0) {
        self.bottomReferenceLine.hidden = YES;
    } else {
        if (self.bottomReferenceLine.hidden && !CGRectEqualToRect(staffModel.bottomRefModel.referenceModel.preRect, CGRectZero)) {
            self.bottomReferenceLine.hidden = NO;
            self.bottomReferenceLine.frame = staffModel.bottomRefModel.referenceModel.preRect;
        }
    }
}

- (StaffModel *)staffModelForMainView:(UIView *)mainView refView:(UIView *)refView {
    if (!mainView) {
        return nil;
    }
    StaffModel *staffModel = [[StaffModel alloc] init];
    staffModel.scale = 1;
    
    CGFloat mainOriginMinX = 0;
    CGFloat mainOriginMinY = 0;
    CGFloat mainOriginMaxX = 0;
    CGFloat mainOriginMaxY = 0;
    CGFloat mainOriginWidth = 0;
    CGFloat mainOriginHeight = 0;
    CGFloat refOriginMinX = 0;
    CGFloat refOriginMinY = 0;
    CGFloat refOriginMaxX = 0;
    CGFloat refOriginMaxY = 0;
    CGFloat refOriginWidth = 0;
    CGFloat refOriginHeight = 0;
    
    CGFloat minOriginX = 0;
    CGFloat minOriginY = 0;
    CGFloat originWidth = 0;
    CGFloat originHeight = 0;
    
    CGRect mainRect = CGRectZero;
    CGRect referenceRect = CGRectZero;
    CGRect newMainFrame = CGRectZero;
    CGRect newReferenceFrame = CGRectZero;
    CGFloat scale = 1;
    
    if (self.isReferScreen) {
        if (mainView) {
            newMainFrame = [[UIApplication sharedApplication].keyWindow convertRect:mainView.frame fromView:mainView.superview];
        }
        if (refView) {
            newReferenceFrame = [[UIApplication sharedApplication].keyWindow convertRect:refView.frame fromView:refView.superview];
        }
    } else {
        if (mainView) {
            mainRect = [[UIApplication sharedApplication].keyWindow convertRect:mainView.frame fromView:mainView.superview];
            
            mainOriginMinX = CGRectGetMinX(mainRect);
            mainOriginMinY = CGRectGetMinY(mainRect);
            mainOriginMaxX = CGRectGetMaxX(mainRect);
            mainOriginMaxY = CGRectGetMaxY(mainRect);
            mainOriginWidth = CGRectGetWidth(mainRect);
            mainOriginHeight = CGRectGetHeight(mainRect);
        }
        
        if (refView) {
            referenceRect = [[UIApplication sharedApplication].keyWindow convertRect:refView.frame fromView:refView.superview];
            
            refOriginMinX = CGRectGetMinX(referenceRect);
            refOriginMinY = CGRectGetMinY(referenceRect);
            refOriginMaxX = CGRectGetMaxX(referenceRect);
            refOriginMaxY = CGRectGetMaxY(referenceRect);
            refOriginWidth = CGRectGetWidth(referenceRect);
            refOriginHeight = CGRectGetHeight(referenceRect);
        }
        minOriginX = MIN(mainOriginMinX, (CGRectEqualToRect(referenceRect, CGRectZero) ? CGRectGetWidth(UIScreen.mainScreen.bounds) : refOriginMinX));
        minOriginY = MIN(mainOriginMinY, (CGRectEqualToRect(referenceRect, CGRectZero) ?  CGRectGetHeight(UIScreen.mainScreen.bounds) : refOriginMinY));
        originWidth = MAX(mainOriginMaxX, refOriginMaxX) - minOriginX;
        originHeight = MAX(mainOriginMaxY, refOriginMaxY) - minOriginY;
        
        if (originHeight == 0 && originWidth == 0) {
            return nil;
        }
        
        if ([self.delegate respondsToSelector:@selector(scaleWithContentWidth:contentHeight:)]) {
            scale = [self.delegate scaleWithContentWidth:originWidth contentHeight:originHeight];
            originWidth = originWidth * scale;
            originHeight = originHeight * scale;
        }
        
        if (mainView) {
            // 计算main的新布局
            self.mainItemView.hidden = NO;
            CGFloat newMainX = (mainOriginMinX - minOriginX) * scale;
            CGFloat newMainY = (mainOriginMinY - minOriginY) * scale;
            CGFloat newMainWidth = mainOriginWidth * scale;
            CGFloat newMainHeight = mainOriginHeight * scale;
            
            newMainFrame = CGRectMake(newMainX, newMainY, newMainWidth, newMainHeight);
            self.mainItemView.scale = scale;
        }
        
        if (refView) {
            self.referenceItemView.hidden = NO;
            CGFloat newRefX = (refOriginMinX - minOriginX) * scale;
            CGFloat newRefY = (refOriginMinY - minOriginY) * scale;
            CGFloat newRefWidth = refOriginWidth * scale;
            CGFloat newRefHeight = refOriginHeight * scale;
            self.referenceItemView.scale = scale;
            newReferenceFrame = CGRectMake(newRefX, newRefY, newRefWidth, newRefHeight);
        }
    }
    staffModel.contentRect = CGRectMake(minOriginX, minOriginY, originWidth, originHeight);
    staffModel.mainRect = newMainFrame;
    
    CGFloat minFirstX = CGRectGetMinX(newMainFrame);
    CGFloat maxFirstX = CGRectGetMaxX(newMainFrame);
    CGFloat minFirstY = CGRectGetMinY(newMainFrame);
    CGFloat maxFirstY = CGRectGetMaxY(newMainFrame);
    CGFloat centerFirstX = minFirstX + CGRectGetWidth(newMainFrame) / 2.0;
    CGFloat centerFirstY = minFirstY + CGRectGetHeight(newMainFrame) / 2.0;
    
    if (!refView) {
        return staffModel;
    }
    
    staffModel.refRect = newReferenceFrame;
    CGFloat minSecondX = CGRectGetMinX(newReferenceFrame);
    CGFloat maxSecondX = CGRectGetMaxX(newReferenceFrame);
    CGFloat minSecondY = CGRectGetMinY(newReferenceFrame);
    CGFloat maxSecondY = CGRectGetMaxY(newReferenceFrame);
    
    CGFloat centerSecondX = minSecondX + CGRectGetWidth(newReferenceFrame) / 2.0;
    CGFloat centerSecondY = minSecondY + CGRectGetHeight(newReferenceFrame) / 2.0;
    
    staffModel.leftRefModel.referenceModel.rect = CGRectMake(minFirstX, centerFirstY, 0, 0);
    staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxFirstX, centerFirstY, 0, 0);
    
    if (minSecondX > maxFirstX) {
        // 主在左
        
        staffModel.leftRefModel.preRect = CGRectMake(minFirstX, centerFirstY, 0, 1);;
        staffModel.leftRefModel.rect = CGRectMake(minFirstX, centerFirstY, 0, 1);
        staffModel.leftRefModel.showLength = 0;
        staffModel.leftRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.rightRefModel.preRect = CGRectMake(maxFirstX, centerFirstY, 0, 1);
        staffModel.rightRefModel.rect = CGRectMake(maxFirstX, centerFirstY, minSecondX - maxFirstX, 1);
        staffModel.rightRefModel.showLength = (minSecondX - maxFirstX) / scale;
        staffModel.rightRefModel.position = StaffLineViewDataPositionTop;
        
        if (maxSecondY < centerFirstY || minSecondY > centerFirstY) {
            if (maxSecondY < centerFirstY) {
                staffModel.rightRefModel.referenceModel.preRect =  CGRectMake(minSecondX, minSecondY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(minSecondX, minSecondY - 10, 1, centerFirstY -  minSecondY + 24);
            }
            if (minSecondY > centerFirstY) {
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(minSecondX, centerFirstY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect =  CGRectMake(minSecondX, centerFirstY - 10, 1, maxSecondY - centerFirstY + 24);
            }
        }
        
    } else if (minFirstX > maxSecondX){
        // 主在右
        staffModel.rightRefModel.preRect = CGRectMake(maxFirstX, centerFirstY, 0, 1);
        staffModel.rightRefModel.rect = CGRectMake(maxFirstX, centerFirstY, 0, 1);
        staffModel.rightRefModel.showLength = 0;
        staffModel.rightRefModel.position = StaffLineViewDataPositionRight;
        
        staffModel.leftRefModel.preRect = CGRectMake(maxSecondX, centerFirstY, 0, 1);
        staffModel.leftRefModel.rect = CGRectMake(maxSecondX, centerFirstY, minFirstX - maxSecondX, 1);
        staffModel.leftRefModel.showLength = (minFirstX - maxSecondX) / scale;
        staffModel.leftRefModel.position = StaffLineViewDataPositionTop;
        
        if (maxSecondY < centerFirstY || minSecondY > centerFirstY) {
            if (maxSecondY < centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(maxSecondX + 1, minSecondY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(maxSecondX + 1, minSecondY - 10, 1, centerFirstY -  minSecondY + 24);
            }
            if (minSecondY > centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(maxSecondX + 1, centerFirstY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(maxSecondX + 1, centerFirstY - 10, 1, maxSecondY - centerFirstY + 24);
            }
        }
        
    } else if (minSecondX <= minFirstX && maxSecondX >= maxFirstX) {
        // 主 小于 参照
        staffModel.leftRefModel.preRect = CGRectMake(minSecondX, centerFirstY, 0, 1);
        staffModel.leftRefModel.rect = CGRectMake(minSecondX, centerFirstY, minFirstX - minSecondX, 1);
        staffModel.leftRefModel.showLength = (minFirstX - minSecondX) / scale;
        staffModel.leftRefModel.position = StaffLineViewDataPositionTop;
        
        staffModel.rightRefModel.preRect = CGRectMake(maxFirstX, centerFirstY, 0, 1);
        staffModel.rightRefModel.rect = CGRectMake(maxFirstX, centerFirstY, maxSecondX - maxFirstX, 1);
        staffModel.rightRefModel.showLength = (maxSecondX - maxFirstX) / scale;
        staffModel.rightRefModel.position = StaffLineViewDataPositionTop;
        
        if (maxSecondY < centerFirstY || minSecondY > centerFirstY) {
            if (maxSecondY < centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(minSecondX + 1, minSecondY - 10, 1, 0);;
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minSecondX + 1, minSecondY - 10, 1, centerFirstY -  minSecondY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxSecondX, minSecondY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxSecondX, minSecondY - 10, 1, centerFirstY -  minSecondY + 24);
            }
            if (minSecondY > centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(minSecondX + 1, centerFirstY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minSecondX + 1, centerFirstY - 10, 1, maxSecondY - centerFirstY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxSecondX, centerFirstY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxSecondX, centerFirstY - 10, 1, maxSecondY - centerFirstY + 24);
            }
        }
        
    } else if (minSecondX > minFirstX && maxSecondX < maxFirstX) {
        // 主 大于 参照
        // minf < mins < maxs < maxf
        staffModel.leftRefModel.preRect = CGRectMake(minFirstX, centerSecondY, 0, 1);
        staffModel.leftRefModel.rect = CGRectMake(minFirstX, centerSecondY, minSecondX - minFirstX, 1);
        staffModel.leftRefModel.showLength = (minSecondX - minFirstX) / scale;
        staffModel.leftRefModel.position = StaffLineViewDataPositionTop;
        
        staffModel.rightRefModel.preRect = CGRectMake(maxSecondX, centerSecondY, 0, 1);
        staffModel.rightRefModel.rect = CGRectMake(maxSecondX, centerSecondY, maxFirstX - maxSecondX, 1);
        staffModel.rightRefModel.showLength = (maxFirstX - maxSecondX) / scale;
        staffModel.rightRefModel.position = StaffLineViewDataPositionTop;
        
        if (maxSecondY < centerFirstY || minSecondY > centerFirstY) {
            if (maxSecondY < centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect =  CGRectMake(minFirstX + 1, centerSecondY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minFirstX + 1, centerSecondY - 10, 1, maxFirstY - centerSecondY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxFirstX, centerSecondY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxFirstX, centerSecondY - 10, 1, maxFirstY - centerSecondY + 24);
            }
            if (minSecondY > centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(minFirstX + 1, minFirstY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minFirstX + 1, minFirstY - 10, 1, centerSecondY -  minFirstY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxFirstX, minFirstY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxFirstX, minFirstY - 10, 1, centerSecondY -  minFirstY + 24);
            }
        }
        
    } else if(minSecondX < minFirstX && maxSecondX < maxFirstX){
        // mins < minf < maxs < maxf
        staffModel.leftRefModel.preRect = CGRectMake(minSecondX, centerFirstY, 0, 1);
        staffModel.leftRefModel.rect = CGRectMake(minSecondX, centerFirstY, minFirstX - minSecondX, 1);
        staffModel.leftRefModel.showLength = (minFirstX - minSecondX) / scale;
        staffModel.leftRefModel.position = StaffLineViewDataPositionTop;
        
        staffModel.rightRefModel.preRect = CGRectMake(maxSecondX, centerSecondY, 0, 1);
        staffModel.rightRefModel.rect = CGRectMake(maxSecondX, centerSecondY, maxFirstX - maxSecondX, 1);
        staffModel.rightRefModel.showLength = (maxFirstX - maxSecondX) / scale;
        staffModel.rightRefModel.position = StaffLineViewDataPositionTop;
        
        if (maxSecondY < centerFirstY || minSecondY > centerFirstY) {
            
            if (maxSecondY < centerFirstY) {
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(minSecondX + 1, minSecondY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minSecondX + 1, minSecondY - 10, 1, centerFirstY -  minSecondY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxFirstX, centerSecondY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxFirstX, centerSecondY - 10, 1, maxFirstY -  centerSecondY + 24);
            }
            if (minSecondY > centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(minSecondX + 1, centerFirstY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minSecondX + 1, centerFirstY - 10, 1, maxSecondY -  centerFirstY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxFirstX, minFirstY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxFirstX, minFirstY - 10, 1, centerSecondY -  minFirstY + 24);
            }
        }
        
    } else if (minSecondX >= minFirstX && maxSecondX >= maxFirstX) {
        // minf < mins < maxf < maxs
        staffModel.leftRefModel.preRect = CGRectMake(minFirstX, centerSecondY, 0, 1);
        staffModel.leftRefModel.rect = CGRectMake(minFirstX, centerSecondY, minSecondX - minFirstX, 1);
        staffModel.leftRefModel.showLength = (minSecondX - minFirstX) / scale;
        staffModel.leftRefModel.position = StaffLineViewDataPositionTop;
        
        staffModel.rightRefModel.preRect = CGRectMake(maxFirstX, centerFirstY, 0, 1);
        staffModel.rightRefModel.rect = CGRectMake(maxFirstX, centerFirstY, maxSecondX - maxFirstX, 1);
        staffModel.rightRefModel.showLength = (maxSecondX - maxFirstX) / scale;
        staffModel.rightRefModel.position = StaffLineViewDataPositionTop;
        
        if (maxSecondY < centerFirstY || minSecondY > centerFirstY) {
            if (maxSecondY < centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(minFirstX + 1, centerSecondY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minFirstX + 1, centerSecondY - 10, 1, maxFirstY -  centerSecondY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxSecondX, minSecondY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxSecondX, minSecondY - 10, 1, centerFirstY -  minSecondY + 24);
                
            }
            if (minSecondY > centerFirstY) {
                
                staffModel.leftRefModel.referenceModel.preRect = CGRectMake(minFirstX + 1, minFirstY - 10, 1, 0);
                staffModel.leftRefModel.referenceModel.rect = CGRectMake(minFirstX + 1, minFirstY - 10, 1, centerSecondY -  minFirstY + 24);
                
                staffModel.rightRefModel.referenceModel.preRect = CGRectMake(maxSecondX, centerFirstY - 10, 1, 0);
                staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxSecondX, centerFirstY - 10, 1, maxSecondY -  centerFirstY + 24);
            }
        }
    } else {
        staffModel.leftRefModel.preRect = CGRectMake(minFirstX, centerFirstY, 0, 1);
        staffModel.leftRefModel.rect = CGRectMake(minFirstX, centerFirstY, minSecondX - minFirstX, 1);
        staffModel.leftRefModel.showLength = (minSecondX - minFirstX) / scale;
        staffModel.leftRefModel.position = StaffLineViewDataPositionTop;
        
        staffModel.rightRefModel.preRect = CGRectMake(maxSecondX, centerFirstY, 0, 1);
        staffModel.rightRefModel.rect = CGRectMake(maxSecondX, centerFirstY, maxFirstX - maxSecondX, 1);
        staffModel.rightRefModel.showLength = (maxFirstX - maxSecondX) / scale;
        staffModel.rightRefModel.position = StaffLineViewDataPositionTop;
        
        staffModel.leftRefModel.referenceModel.rect = CGRectMake(minFirstX, centerFirstY, 0, 0);
        staffModel.rightRefModel.referenceModel.rect = CGRectMake(maxSecondX, centerFirstY, 0, 0);
    }
    
    staffModel.topRefModel.rect = CGRectMake(centerFirstX, maxSecondY, 0, 0);
    staffModel.bottomRefModel.rect = CGRectMake(centerFirstX, minSecondY, 0, 0);
    
    if (minSecondY > maxFirstY) {
        // 主上
        staffModel.topRefModel.preRect =  CGRectMake(centerFirstX, minFirstY, 0, 1);
        staffModel.topRefModel.rect = CGRectMake(centerFirstX, minFirstY, 1, 0);
        staffModel.topRefModel.showLength = 0;
        staffModel.topRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.bottomRefModel.preRect = CGRectMake(centerFirstX, maxFirstY, 0, 1);
        staffModel.bottomRefModel.rect = CGRectMake(centerFirstX, maxFirstY, 1, minSecondY - maxFirstY);
        staffModel.bottomRefModel.showLength = (minSecondY - maxFirstY) / scale;
        staffModel.bottomRefModel.position = StaffLineViewDataPositionRight;
        
        if (minSecondX > centerFirstX || maxSecondX < centerFirstX) {
            if (minSecondX > centerFirstX) {
                
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(centerFirstX - 12, minSecondY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(centerFirstX - 12, minSecondY, maxSecondX -  centerFirstX + 24, 1);
            }
            
            if (maxSecondX < centerFirstX) {
                
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(minSecondX - 12, minSecondY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(minSecondX - 12, minSecondY, centerFirstX - minSecondX + 24, 1);
            }
        }
        
    } else if (minFirstY > maxSecondY) {
        // 主下
        staffModel.topRefModel.preRect = CGRectMake(centerFirstX, maxSecondY, 0, 1);
        staffModel.topRefModel.rect = CGRectMake(centerFirstX,  maxSecondY, 1, minFirstY - maxSecondY);
        staffModel.topRefModel.showLength = (minFirstY - maxSecondY) / scale;
        staffModel.topRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.bottomRefModel.preRect = CGRectMake(centerFirstX, maxFirstY, 0, 1);
        staffModel.bottomRefModel.rect = CGRectMake(centerFirstX, maxFirstY, 1, 0);
        staffModel.bottomRefModel.showLength = 0;
        staffModel.bottomRefModel.position = StaffLineViewDataPositionRight;
        
        if (minSecondX > centerFirstX || maxSecondX < centerFirstX) {
            if (minSecondX > centerFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(centerFirstX - 12, maxSecondY, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(centerFirstX - 12, maxSecondY + 1, maxSecondX -  centerFirstX + 24, 1);
            }
            
            if (maxSecondX < centerFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(minSecondX - 12, maxSecondY, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(minSecondX - 12, maxSecondY + 1, centerFirstX - minSecondX + 24, 1);
            }
        }
    } else if (minSecondY >= minFirstY && maxSecondY <= maxFirstY) {
        // 主 大于 参考
        // minf < mins < maxs < maxf
        staffModel.topRefModel.preRect = CGRectMake(centerSecondX, minFirstY, 0, 1);
        staffModel.topRefModel.rect = CGRectMake(centerSecondX,  minFirstY, 1, minSecondY - minFirstY);
        staffModel.topRefModel.showLength = (minSecondY - minFirstY) / scale;
        staffModel.topRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.bottomRefModel.preRect = CGRectMake(centerSecondX, maxSecondY, 0, 1);
        staffModel.bottomRefModel.rect = CGRectMake(centerSecondX, maxSecondY, 1, maxFirstY - maxSecondY);
        staffModel.bottomRefModel.showLength = (maxFirstY - maxSecondY) / scale;
        staffModel.bottomRefModel.position = StaffLineViewDataPositionRight;
        
        if (maxSecondX < minFirstX || minSecondX > maxFirstX) {
            if (maxSecondX < minFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(centerSecondX - 12, minFirstY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(centerSecondX - 12, minFirstY + 1, maxFirstX - centerSecondX + 24, 1);
                
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(centerSecondX - 12, maxFirstY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(centerSecondX - 12, maxFirstY, maxFirstX - centerSecondX + 24, 1);
            }
            
            if (minSecondX > maxFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(minFirstX - 12, minFirstY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(minFirstX - 12, minFirstY + 1, centerSecondX - minFirstX + 24, 1);
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(minFirstX - 12, maxFirstY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(minFirstX - 12, maxFirstY, centerSecondX - minFirstX + 24, 1);
            }
        }
        
    } else if (minSecondY < minFirstY && maxSecondY > maxFirstY) {
        // 主 小于 参考
        staffModel.topRefModel.preRect = CGRectMake(centerFirstX, minSecondY, 0, 1);
        staffModel.topRefModel.rect = CGRectMake(centerFirstX,  minSecondY, 1, minFirstY - minSecondY);
        staffModel.topRefModel.showLength = (minFirstY - minSecondY) / scale;
        staffModel.topRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.bottomRefModel.preRect = CGRectMake(centerFirstX, maxFirstY, 0, 1);
        staffModel.bottomRefModel.rect = CGRectMake(centerFirstX, maxFirstY, 1, maxSecondY - maxFirstY);
        staffModel.bottomRefModel.showLength = (maxSecondY - maxFirstY) / scale
        ;
        staffModel.bottomRefModel.position = StaffLineViewDataPositionRight;
        
        if (maxSecondX < minFirstX || minSecondX > maxFirstX) {
            if (maxSecondX < minFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(minSecondX - 12, minSecondY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(minSecondX - 12, minSecondY + 1, centerFirstX - minSecondX + 24, 1);
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(minSecondX - 12, maxSecondY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(minSecondX - 12, maxSecondY, centerFirstX - minSecondX + 24, 1);
            }
            
            if (minSecondX > maxFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(centerFirstX - 12, minSecondY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(centerFirstX - 12, minSecondY + 1, maxSecondX - centerFirstX + 24, 1);
                
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(centerFirstX - 12, maxSecondY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(centerFirstX - 12, maxSecondY, maxSecondX - centerFirstX + 24, 1);
            }
        }
    } else if(minFirstY <= minSecondY && maxFirstY <= maxSecondY) {
        // minf < mins < maxf < maxs
        staffModel.topRefModel.preRect = CGRectMake(centerSecondX, minFirstY, 0, 1);
        staffModel.topRefModel.rect = CGRectMake(centerSecondX,  minFirstY, 1, minSecondY - minFirstY);
        staffModel.topRefModel.showLength = (minSecondY - minFirstY) / scale;
        staffModel.topRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.bottomRefModel.preRect = CGRectMake(centerFirstX, maxFirstY, 0, 1);
        staffModel.bottomRefModel.rect = CGRectMake(centerFirstX, maxFirstY, 1, maxSecondY - maxFirstY);
        staffModel.bottomRefModel.showLength = (maxSecondY - maxFirstY) / scale;
        staffModel.bottomRefModel.position = StaffLineViewDataPositionRight;
        
        if (minSecondX > centerFirstX || maxSecondX < centerFirstX) {
            if (minSecondX > centerFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(minFirstX - 12, minFirstY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(minFirstX - 12, minFirstY + 1, centerSecondX - minFirstX + 24, 1);
                
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(centerFirstX - 12, maxSecondY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(centerFirstX - 12, maxSecondY, maxSecondX - centerFirstX + 24, 1);
            }
            
            if (maxSecondX < centerFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(centerSecondX - 12, minFirstY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(centerSecondX - 12, minFirstY + 1, centerFirstX - minSecondX + 24, 1);
                
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(minSecondX - 12, maxSecondY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(minSecondX - 12, maxSecondY, centerFirstX - minSecondX + 24, 1);
            }
        }
    } else if (minSecondY < minFirstY && maxSecondY < maxFirstY) {
        // mins < minf < maxs < maxf
        staffModel.topRefModel.preRect = CGRectMake(centerFirstX, minSecondY, 0, 1);
        staffModel.topRefModel.rect = CGRectMake(centerFirstX,  minSecondY, 1, minFirstY - minSecondY);
        staffModel.topRefModel.showLength = (minFirstY - minSecondY) / scale;
        staffModel.topRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.bottomRefModel.preRect = CGRectMake(centerSecondX, maxSecondY, 0, 1);
        staffModel.bottomRefModel.rect = CGRectMake(centerSecondX, maxSecondY, 1, maxFirstY - maxSecondY);
        staffModel.bottomRefModel.showLength = (maxFirstY - maxSecondY) / scale;
        staffModel.bottomRefModel.position = StaffLineViewDataPositionRight;
        
        if (minSecondX > centerFirstX || maxSecondX < centerFirstX) {
            if (minSecondX > centerFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(centerFirstX - 12, minSecondY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(centerFirstX - 12, minSecondY + 1, maxSecondX - centerFirstX + 24, 1);
                
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(minFirstX - 12, maxFirstY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(minFirstX - 12, maxFirstY, centerSecondX - minFirstX + 24, 1);
            }
            
            if (maxSecondX < centerFirstX) {
                
                staffModel.topRefModel.referenceModel.preRect = CGRectMake(minSecondX - 12, minSecondY + 1, 0, 1);
                staffModel.topRefModel.referenceModel.rect = CGRectMake(minSecondX - 12, minSecondY + 1, centerFirstX - minSecondX + 24, 1);
                staffModel.bottomRefModel.referenceModel.preRect = CGRectMake(centerSecondX - 12, maxFirstY, 0, 1);
                staffModel.bottomRefModel.referenceModel.rect = CGRectMake(centerSecondX - 12, maxFirstY, maxFirstX - centerSecondX + 24, 1);
            }
        }
    } else {
        staffModel.topRefModel.preRect = CGRectMake(centerFirstX, maxFirstY, 0, 1);
        staffModel.topRefModel.rect = CGRectMake(centerFirstX,  maxFirstY, 1, maxSecondY - maxFirstY);
        staffModel.topRefModel.showLength = (maxSecondY - maxFirstY) / scale;
        staffModel.topRefModel.position = StaffLineViewDataPositionLeft;
        
        staffModel.bottomRefModel.preRect = CGRectMake(centerFirstX, minSecondY, 0, 1);
        staffModel.bottomRefModel.rect = CGRectMake(centerFirstX, minSecondY, 1, minFirstY - minSecondY);
        staffModel.bottomRefModel.showLength = (minFirstY - minSecondY) / scale;
        staffModel.bottomRefModel.position = StaffLineViewDataPositionRight;
    }
    return staffModel;
}

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

- (void)setFrame:(CGRect)frame {
    if (self.isReferScreen && !CGRectEqualToRect(frame, UIScreen.mainScreen.bounds)) {
        frame = UIScreen.mainScreen.bounds;
    }
    [super setFrame:frame];
}

@end
