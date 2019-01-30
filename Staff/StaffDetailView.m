//
//  StaffDetailView.m
//  Staff
//
//  Created by 罗树新 on 2018/12/26.
//

#import "StaffDetailView.h"
#import "StaffContentView.h"
#import "StaffDetailSubviewsListTableViewCell.h"
#import "StaffDetailSubviewsListViewHeaderView.h"

@interface StaffDetailView () <StaffContentViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)StaffContentView *contentView;
@property (nonatomic, assign) CGRect contentRect;

@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *contentViewBackView;

@property (nonatomic, strong) UITableView *subViewsListView;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, strong) NSArray<UIView *> *views;
@end
@implementation StaffDetailView

- (instancetype)init {
    if (self = [super init]) {
        [self.tableHeaderView addSubview:self.contentViewBackView];
        [self.contentViewBackView addSubview:self.contentView];
        [self addSubview:self.subViewsListView];
    }
    return self;
}

- (void)layoutViews:(NSArray <UIView *> *)views {
    _views = views;
    self.subViewsListView.frame = CGRectMake(20, 0, CGRectGetWidth(UIScreen.mainScreen.bounds) - 40, CGRectGetHeight(UIScreen.mainScreen.bounds));
    [self.subViewsListView reloadData];
    __block typeof(self)blockSelf = self;
    [self.contentView layoutViews:views completed:^(CGRect contentRect) {
        blockSelf.contentRect = contentRect;
        [UIView animateWithDuration:0.2 animations:^{
            blockSelf.alpha = 1;
            blockSelf.contentViewBackView.frame = CGRectMake(CGRectGetWidth(UIScreen.mainScreen.bounds) - 100 - CGRectGetWidth(contentRect), CGRectGetHeight(UIScreen.mainScreen.bounds) - 160 - CGRectGetHeight(contentRect), 60 + CGRectGetWidth(contentRect), 60 + CGRectGetHeight(contentRect));
            blockSelf.contentView.frame = CGRectMake(30, 30, CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
        }];
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect tablerHeaderRect = [self.tableHeaderView convertRect:self.tableHeaderView.frame toView:self];
    CGRect contentBackViewRect = [self.tableHeaderView convertRect:self.contentViewBackView.frame toView:self];
    if (CGRectContainsPoint(tablerHeaderRect, point) && !CGRectContainsPoint(contentBackViewRect, point)) {
        return nil;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - StaffContentViewDelegate

- (CGFloat)scaleWithContentWidth:(CGFloat)contentWidth contentHeight:(CGFloat)contentHeight {
    CGFloat maxContentWidth = CGRectGetWidth(UIScreen.mainScreen.bounds) - 100;
    CGFloat maxContentHeight = CGRectGetHeight(UIScreen.mainScreen.bounds) * 2 / 3 - 100;
    return MIN(maxContentWidth / contentWidth, maxContentHeight / contentHeight);
}

#pragma mark - UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.views.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.views.count > section) {
        UIView *view = self.views[section];
        return view.subviews.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StaffDetailSubviewsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(StaffDetailSubviewsListTableViewCell.class) forIndexPath:indexPath];
    UIView *view = [self viewForIndexPath:indexPath];
    if (view) {
        cell.view = view;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    StaffDetailSubviewsListViewHeaderView *headerView = [[StaffDetailSubviewsListViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame) - 40, 75)];
    if (self.views.count > section) {
        UIView *view = self.views[section];
        headerView.view = view;
        headerView.isMain = section == 0;
    }
    __weak typeof(self)weakSelf = self;
    [headerView setHeaderViewChooseCallBack:^(UIView * _Nonnull view, BOOL isMain) {
        !weakSelf.detailViewChooseCallback ?: weakSelf.detailViewChooseCallback(view, isMain);
    }];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIView *view = [self viewForIndexPath:indexPath];
    if (view) {
        !self.detailViewChooseCallback ?: self.detailViewChooseCallback(view, indexPath.section == 0);
    }
}

- (UIView *)viewForIndexPath:(NSIndexPath *)indexPath {
    if (self.views.count > indexPath.section) {
        UIView *view = self.views[indexPath.section];
        if (view.subviews.count > indexPath.row) {
            UIView *subView = view.subviews[indexPath.row];
            return subView;
        }
    }
    return nil;
}
#pragma mark - Setter / Getter

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.backgroundColor = UIColor.clearColor;
    }
    return _tableHeaderView;
}

- (UIView *)contentViewBackView {
    if (!_contentViewBackView) {
        _contentViewBackView = [[UIView alloc] init];
        _contentViewBackView.backgroundColor = UIColor.whiteColor;
        _contentViewBackView.layer.cornerRadius = 4;
        _contentViewBackView.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
        _contentViewBackView.layer.shadowOpacity = 0.5;
        _contentViewBackView.layer.shadowRadius = 4;
        _contentViewBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _contentViewBackView.clipsToBounds = false;
    }
    return _contentViewBackView;
}

- (StaffContentView *)contentView {
    if (!_contentView) {
        _contentView = [[StaffContentView alloc] init];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (UITableView *)subViewsListView {
    if (!_subViewsListView) {
        _subViewsListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_subViewsListView registerClass:StaffDetailSubviewsListTableViewCell.class forCellReuseIdentifier:NSStringFromClass(StaffDetailSubviewsListTableViewCell.class)];
        _subViewsListView.backgroundColor = UIColor.clearColor;
        _subViewsListView.delegate = self;
        _subViewsListView.dataSource = self;
        _subViewsListView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subViewsListView.sectionHeaderHeight = 75;
        _subViewsListView.rowHeight = 80;
        _subViewsListView.layer.cornerRadius = 4;
        _subViewsListView.layer.masksToBounds = YES;
        _subViewsListView.clipsToBounds = NO;
        _subViewsListView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        self.tableHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds) - 40, CGRectGetHeight(UIScreen.mainScreen.bounds) - 80);
        _subViewsListView.tableHeaderView = self.tableHeaderView;
    }
    return _subViewsListView;
}

@end
