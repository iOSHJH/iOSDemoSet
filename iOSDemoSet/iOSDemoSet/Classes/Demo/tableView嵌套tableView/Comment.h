//
//  Comment.h
//  TableViewInTableView
//
//  Created by 黄俊煌 on 2017/10/27.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, copy) NSString *portrait;

@property (nonatomic, copy) NSString *replyName;

@property (nonatomic, copy) NSString *byReplyName;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, strong) NSMutableArray<Comment *> *replys;

@property (nonatomic, assign) double rowHeight;

@end
