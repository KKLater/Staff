//
//  StaffModel.h
//  Staff
//
//  Created by 罗树新 on 2018/12/28.
//

#import <Foundation/Foundation.h>
#import "StaffLineView.h"

NS_ASSUME_NONNULL_BEGIN

@class StaffSpaceLineModel, StaffReferenceLineModel;

@interface StaffModel : NSObject

@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect mainRect;
@property (nonatomic, assign) CGRect refRect;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, strong) StaffSpaceLineModel *leftRefModel;
@property (nonatomic, strong) StaffSpaceLineModel *rightRefModel;
@property (nonatomic, strong) StaffSpaceLineModel *topRefModel;
@property (nonatomic, strong) StaffSpaceLineModel *bottomRefModel;
@end

@interface StaffSpaceLineModel : NSObject
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) CGRect preRect;

@property (nonatomic, assign) CGFloat showLength;
@property (nonatomic, assign) StaffLineViewDataPosition position;

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) StaffReferenceLineModel *referenceModel;


@end

@interface StaffReferenceLineModel : NSObject
@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) CGRect preRect;

@property (nonatomic, assign) CGFloat scale;
@end

NS_ASSUME_NONNULL_END
