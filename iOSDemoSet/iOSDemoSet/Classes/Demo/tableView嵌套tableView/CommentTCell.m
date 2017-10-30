//
//  PlanDetailsCommentTCell.m
//  win
//
//  Created by 黄俊煌 on 2017/10/13.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import "CommentTCell.h"
#import "ReplyTCell.h"
#import "Comment.h"

@interface CommentTCell ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineView;
/** 回复 tableView*/
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString * const PlanDetailsCommentTCellIdentifier = @"PlanDetailsCommentTCellIdentifier";

@implementation CommentTCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    CommentTCell *cell = [tableView dequeueReusableCellWithIdentifier:PlanDetailsCommentTCellIdentifier];
    if (!cell) {
        cell = [[CommentTCell alloc] initWithStyle:0 reuseIdentifier:PlanDetailsCommentTCellIdentifier];
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
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.dateLabel);
        make.top.equalTo(self.lineView.mas_bottom);
        make.height.equalTo(@0);
    }];
}

- (CGFloat)rowHeightWithComment:(Comment *)comment {
    self.comment = comment;
    [self layoutIfNeeded];
    
    // 计算tableview的高度
    CGFloat tableViewHeight = 0;
    for (Comment *reply in comment.replys) {
        tableViewHeight = tableViewHeight+[self rowHeightWithReply:reply];
    }
    return CGRectGetMaxY(self.lineView.frame) + tableViewHeight;
}

- (CGFloat)rowHeightWithReply:(Comment *)reply {
    self.reply = reply;
    [self layoutIfNeeded];
    return CGRectGetMaxY(self.lineView.frame);
}

- (void)iconAction {
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comment.replys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReplyTCell *cell = [ReplyTCell cellWithTableView:tableView];
    Comment *reply = self.comment.replys[indexPath.row];
    cell.reply = reply;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReplyTCell *cell = [ReplyTCell cellWithTableView:tableView];
    Comment *reply = self.comment.replys[indexPath.row];
    if (reply.rowHeight > 0) {
        return reply.rowHeight;
    }
    CGFloat height = [cell rowHeightWithReply:reply];
    reply.rowHeight = height;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(tableView, indexPath, self.comment.replys[indexPath.row]);
    }
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

- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor brownColor];
    return _tableView;
}

#pragma mark - set

- (void)setComment:(Comment *)comment {
    _comment = comment;
    
    [self.iconButton setImage:[UIImage imageNamed:@"default_me"] forState:UIControlStateNormal];
    self.nameLabel.text = _comment.replyName;
    self.contentLabel.text = _comment.content;
    self.dateLabel.text = _comment.dateStr;
    
    [self.tableView reloadData];

    // 计算tableview的高度
    CGFloat tableViewHeight = 0;
    for (Comment *reply in comment.replys) {
        tableViewHeight = tableViewHeight+[self rowHeightWithReply:reply];
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(tableViewHeight));
    }];
}


@end




