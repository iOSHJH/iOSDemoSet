//
//  TestJhButtonVC.m
//  iOSDemoSet
//
//  Created by huangjunhuang on 2019/3/1.
//  Copyright © 2019 yunshi. All rights reserved.
//

#import "TestJhButtonVC.h"
#import "JHButton.h"

@interface TestJhButtonVC ()

@property (nonatomic, strong) UIView *toolView;
@property (nonatomic, strong) JHButton *homeButton;
@property (nonatomic, strong) JHButton *backButton;
@property (nonatomic, strong) JHButton *forwardButton;
@property (nonatomic, strong) JHButton *refreshButton;

@end

@implementation TestJhButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.toolView];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(64);
    }];
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width/4.0;
    CGFloat h = 50;
    [self.toolView addSubview:self.homeButton];
    [self.homeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(6);
        make.width.equalTo(w);
        make.height.equalTo(h);
    }];
    
    [self.toolView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.homeButton.mas_right);
        make.top.equalTo(self.homeButton);
        make.width.equalTo(w);
        make.height.equalTo(h);
    }];
    
    [self.toolView addSubview:self.forwardButton];
    [self.forwardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backButton.mas_right);
        make.top.equalTo(self.homeButton);
        make.width.equalTo(w);
        make.height.equalTo(h);
    }];
    
    [self.toolView addSubview:self.refreshButton];
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.forwardButton.mas_right);
        make.top.equalTo(self.homeButton);
        make.width.equalTo(w);
        make.height.equalTo(h);
    }];
}

#pragma mark - action

- (void)homeAction {
    
}

- (void)backAction {
    
}

- (void)forwardAction {
    
}

- (void)refreshAction {
    
}

- (UIView *)toolView {
    if (_toolView) return _toolView;
    _toolView = [[UIView alloc] init];
    _toolView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return _toolView;
}

- (JHButton *)homeButton {
    if (_homeButton) return _homeButton;
    _homeButton = [[JHButton alloc] initWithFrame:CGRectZero imageSize:CGSizeMake(20, 20) space:6 titleTextType:TopImage_BottomText];
    _homeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_homeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_homeButton setTitle:@"首页" forState:UIControlStateNormal];
    [_homeButton setImage:[UIImage imageNamed:@"faceicon"] forState:UIControlStateNormal];
    [_homeButton addTarget:self action:@selector(homeAction) forControlEvents:UIControlEventTouchUpInside];
    return _homeButton;
}

- (JHButton *)backButton {
    if (_backButton) return _backButton;
    _backButton = [[JHButton alloc] initWithFrame:CGRectZero imageSize:CGSizeMake(20, 20) space:6 titleTextType:TopImage_BottomText];
    _backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_backButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_backButton setTitle:@"后退" forState:UIControlStateNormal];
    [_backButton setImage:[UIImage imageNamed:@"faceicon"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return _backButton;
}

- (JHButton *)forwardButton {
    if (_forwardButton) return _forwardButton;
    _forwardButton = [[JHButton alloc] initWithFrame:CGRectZero imageSize:CGSizeMake(20, 20) space:6 titleTextType:TopImage_BottomText];
    _forwardButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_forwardButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_forwardButton setTitle:@"前进" forState:UIControlStateNormal];
    [_forwardButton setImage:[UIImage imageNamed:@"faceicon"] forState:UIControlStateNormal];
    [_forwardButton addTarget:self action:@selector(forwardAction) forControlEvents:UIControlEventTouchUpInside];
    return _forwardButton;
}

- (JHButton *)refreshButton {
    if (_refreshButton) return _refreshButton;
    _refreshButton = [[JHButton alloc] initWithFrame:CGRectZero imageSize:CGSizeMake(20, 20) space:6 titleTextType:TopImage_BottomText];
    _refreshButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_refreshButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_refreshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [_refreshButton setImage:[UIImage imageNamed:@"faceicon"] forState:UIControlStateNormal];
    [_refreshButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
    return _refreshButton;
}

@end
