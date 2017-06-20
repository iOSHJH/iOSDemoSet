//
//  VisualEffectVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/21.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "VisualEffectVC.h"

@interface VisualEffectVC ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIVisualEffectView *visualEfView;

@end

@implementation VisualEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [self.imageView addSubview:self.visualEfView];
    [self.visualEfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imageView);
    }];
    
}


- (UIImageView *)imageView {
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aa"]];
    
    return _imageView;
}

- (UIVisualEffectView *)visualEfView {
    if (_visualEfView) {
        return _visualEfView;
    }
    _visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    _visualEfView.alpha = 0.7;
    
    return _visualEfView;
}


@end
