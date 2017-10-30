//
//  PlanDetailsCommentTCell.m
//  win
//
//  Created by 黄俊煌 on 2017/10/13.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import "ReplyTCell.h"
#import "Comment.h"

@interface ReplyTCell ()

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineView;

@end

static NSString * const CommentTCellIdentifer = @"CommentTCellIdentifer";

@implementation ReplyTCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    ReplyTCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTCellIdentifer];
    if (!cell) {
        cell = [[ReplyTCell alloc] initWithStyle:0 reuseIdentifier:CommentTCellIdentifer];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.iconButton];
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
        make.size.equalTo(@38);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconButton.mas_right).offset(15);
        make.centerY.equalTo(self.iconButton);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        //        make.right.equalTo(-20);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width - 80));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(13);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.right.equalTo(self);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(25);
        make.height.equalTo(@1);
    }];
}

- (CGFloat)rowHeightWithReply:(Comment *)reply {
    self.reply = reply;
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.lineView.frame);
}

- (void)iconAction {
    
}

#pragma mark - get

- (UIButton *)iconButton {
    if (_iconButton) return _iconButton;
    _iconButton = [[UIButton alloc] init];
    _iconButton.layer.cornerRadius = 19;
    _iconButton.layer.masksToBounds = YES;
    [_iconButton addTarget:self action:@selector(iconAction) forControlEvents:UIControlEventTouchUpInside];
    return _iconButton;
}

- (UILabel *)nameLabel {
    if (_nameLabel) return _nameLabel;
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = [UIColor darkGrayColor];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    return _nameLabel;
}

- (UILabel *)dateLabel {
    if (_dateLabel) return _dateLabel;
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.textColor = [UIColor lightTextColor];
    _dateLabel.font = [UIFont systemFontOfSize:13];
    return _dateLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel) return _contentLabel;
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = [UIColor lightGrayColor];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.numberOfLines = 0;
    return _contentLabel;
}

- (UIView *)lineView {
    if (_lineView) return _lineView;
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    return _lineView;
}

#pragma mark - set

- (void)setReply:(Comment *)reply {
    _reply = reply;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ 回复 %@", _reply.replyName,_reply.byReplyName];
    [self.iconButton setImage:[UIImage imageNamed:@"default_me"] forState:UIControlStateNormal];
    self.contentLabel.text = _reply.content;
    self.dateLabel.text = _reply.dateStr;
}

@end





