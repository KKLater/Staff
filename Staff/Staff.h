//
//  Staff.h
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Staff : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, assign) BOOL enable;
@end

NS_ASSUME_NONNULL_END
