//
//  StaffModel.m
//  Staff
//
//  Created by 罗树新 on 2018/12/28.
//

#import "StaffModel.h"

@implementation StaffModel
- (instancetype)init {
    if (self = [super init]) {
        self.scale = 1;
    }
    return self;
}

- (CGFloat)scale {
    if (_scale <= 0) {
        _scale = 1;
    }
    return _scale;
}

- (StaffSpaceLineModel *)leftRefModel {
    if (!_leftRefModel) {
        _leftRefModel = [[StaffSpaceLineModel alloc] init];
    }
    return _leftRefModel;
}

- (StaffSpaceLineModel *)rightRefModel {
    if (!_rightRefModel) {
        _rightRefModel = [[StaffSpaceLineModel alloc] init];
    }
    return _rightRefModel;
}

- (StaffSpaceLineModel *)topRefModel {
    if (!_topRefModel) {
        _topRefModel = [[StaffSpaceLineModel alloc] init];
    }
    return _topRefModel;
}

- (StaffSpaceLineModel *)bottomRefModel {
    if (!_bottomRefModel) {
        _bottomRefModel = [[StaffSpaceLineModel alloc] init];
    }
    return _bottomRefModel;
}

@end

@implementation StaffSpaceLineModel

- (instancetype)init {
    if (self = [super init]) {
        self.scale = 1;
    }
    return self;
}

- (CGFloat)scale {
    if (_scale <= 0) {
        _scale = 1;
    }
    return _scale;
}

- (StaffReferenceLineModel *)referenceModel {
    if (!_referenceModel) {
        _referenceModel = [[StaffReferenceLineModel alloc] init];
    }
    return _referenceModel;
}

@end

@implementation StaffReferenceLineModel
- (instancetype)init {
    if (self = [super init]) {
        self.scale = 1;
    }
    return self;
}

- (CGFloat)scale {
    if (_scale <= 0) {
        _scale = 1;
    }
    return _scale;
}

@end
