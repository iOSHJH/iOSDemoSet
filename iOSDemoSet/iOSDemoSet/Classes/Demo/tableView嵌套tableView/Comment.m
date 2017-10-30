//
//  Comment.m
//  TableViewInTableView
//
//  Created by 黄俊煌 on 2017/10/27.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (NSMutableArray *)replys {
    if (_replys) return _replys;
    _replys = [NSMutableArray array];
    return _replys;
}

@end
