//
//  PlanDetailsCommentTCell.h
//  win
//
//  Created by 黄俊煌 on 2017/10/13.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comment;

@interface CommentTCell : UITableViewCell

@property (nonatomic, strong) Comment *comment;

@property (nonatomic, strong) Comment *reply;

@property (nonatomic, copy) void (^didSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath, Comment *reply);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 计算外层tableView cell的高度*/
- (CGFloat)rowHeightWithComment:(Comment *)comment;

/** 计算内层tableView cell的高度*/
- (CGFloat)rowHeightWithReply:(Comment *)reply;

@end
