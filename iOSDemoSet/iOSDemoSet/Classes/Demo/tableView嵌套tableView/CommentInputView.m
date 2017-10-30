//
//  CommentInputView.m
//  win
//
//  Created by 黄俊煌 on 2017/10/17.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import "CommentInputView.h"
#import "JHTextView.h"
#import "Masonry.h"

@interface CommentInputView ()

@property (nonatomic, strong) UIView *bgTextView;
@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation CommentInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-8));
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.bgTextView];
    [self.bgTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.centerY.equalTo(self);
        make.right.equalTo(self.sendButton.mas_left).offset(-10);
        make.height.equalTo(@40);
    }];
    
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgTextView).offset(20);
        make.right.equalTo(self.bgTextView).offset(-20);
        make.height.top.equalTo(self.bgTextView);
    }];
}

- (void)sendAction {
    if (self.sendBlock) {
        self.sendBlock();
    }
}

#pragma mark - get

- (UIView *)bgTextView {
    if (_bgTextView) return _bgTextView;
    _bgTextView = [[UIView alloc] init];
    _bgTextView.backgroundColor = [UIColor colorWithRed:0.949  green:0.949  blue:0.949 alpha:1];
    _bgTextView.layer.cornerRadius = 20;
    return _bgTextView;
}

- (JHTextView *)textView {
    if (_textView) return _textView;
    _textView = [[JHTextView alloc] init];
    _textView.placeholder = @"想说些什么...";
    _textView.limitLength = 100;
    _textView.backgroundColor = [UIColor colorWithRed:0.949  green:0.949  blue:0.949 alpha:1];
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.textColor = [UIColor darkGrayColor];
    _textView.textNumLabel.hidden = YES;
    return _textView;
}

- (UIButton *)sendButton {
    if (_sendButton) return _sendButton;
    _sendButton = [[UIButton alloc] init];
    [_sendButton setImage:[UIImage imageNamed:@"btn_send"] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    return _sendButton;
}

@end
