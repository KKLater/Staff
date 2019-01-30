//
//  StaffDetailSubviewsListTableViewCell.m
//  Staff
//
//  Created by 罗树新 on 2019/1/30.
//

#import "StaffDetailSubviewsListTableViewCell.h"

@interface StaffDetailSubviewsListTableViewCell ()
@property (nonatomic, strong) UILabel *classNameLabel;
@property (nonatomic, strong) UILabel *frameInfoLabel;
@property (nonatomic, strong) UILabel *moreInfoLabel;
@end
@implementation StaffDetailSubviewsListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.classNameLabel];
        [self.contentView addSubview:self.frameInfoLabel];
        [self.contentView addSubview:self.moreInfoLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.classNameLabel sizeToFit];
    [self.frameInfoLabel sizeToFit];
    [self.moreInfoLabel sizeToFit];
    self.classNameLabel.frame = CGRectMake(10, 10, CGRectGetWidth(self.contentView.bounds) - 20, CGRectGetHeight(self.classNameLabel.frame));
    self.frameInfoLabel.frame = CGRectMake(10, 5 + CGRectGetHeight(self.classNameLabel.frame) + 5, CGRectGetWidth(self.frameInfoLabel.bounds), CGRectGetHeight(self.frameInfoLabel.bounds));
    self.moreInfoLabel.frame = CGRectMake(10, CGRectGetMaxY(self.frameInfoLabel.frame) + 3, CGRectGetWidth(self.moreInfoLabel.frame), CGRectGetHeight(self.moreInfoLabel.frame));
}

#pragma mark - Setter / Getter

- (void)setView:(UIView *)view {
    _view = view;
    if (view) {
        self.classNameLabel.text = NSStringFromClass(view.class);
        self.frameInfoLabel.text = [NSString stringWithFormat:@"Frame: (%.2f, %.2f; %.2f, %.2f)", CGRectGetMinX(view.frame), CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)];
        self.moreInfoLabel.text = [NSString stringWithFormat:@"Hidden: %@, Alpha: %.2f", view.isHidden? @"Yes" : @"No", view.alpha];
    } else {
        self.classNameLabel.text = @"";
        self.frameInfoLabel.text = @"";
        self.moreInfoLabel.text = @"";
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (UILabel *)classNameLabel {
    if (!_classNameLabel) {
        _classNameLabel = [[UILabel alloc] init];
        _classNameLabel.textColor = [[UIColor alloc] initWithWhite:0 alpha:0.8];
        _classNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _classNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _classNameLabel;
}

- (UILabel *)frameInfoLabel {
    if (!_frameInfoLabel) {
        _frameInfoLabel = [[UILabel alloc] init];
        _frameInfoLabel.textColor = [[UIColor alloc] initWithWhite:0 alpha:0.6];
        _frameInfoLabel.font = [UIFont systemFontOfSize:12];
        _frameInfoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _frameInfoLabel;
}

- (UILabel *)moreInfoLabel {
    if (!_moreInfoLabel) {
        _moreInfoLabel = [[UILabel alloc] init];
        _moreInfoLabel.textColor = [[UIColor alloc] initWithWhite:0 alpha:0.6];
        _moreInfoLabel.font = [UIFont systemFontOfSize:12];
        _moreInfoLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _moreInfoLabel;
}
@end
