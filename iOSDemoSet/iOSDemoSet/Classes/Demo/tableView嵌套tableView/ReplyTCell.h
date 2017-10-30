//
//  ReplyTCell.h
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/10/30.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Comment;

@interface ReplyTCell : UITableViewCell

@property (nonatomic, strong) Comment *reply;

- (CGFloat)rowHeightWithReply:(Comment *)reply;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
