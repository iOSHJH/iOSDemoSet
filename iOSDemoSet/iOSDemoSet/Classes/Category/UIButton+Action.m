//
//  UIButton+Extension.m
//  win
//
//  Created by huangjunhuang on 2019/1/8.
//  Copyright © 2019 mustget. All rights reserved.
//

#import "UIButton+Action.h"
#import <objc/runtime.h>

@interface UIButton()

@property (nonatomic, copy) void(^addButtonActionBlock)(UIButton *button);

@end

static char *const addButtonActionBlockKey = "addButtonActionBlockKey";

@implementation UIButton (Action)

/// 一句话添加Button点击事件
- (void)addActionWithBlock:(void (^)(UIButton *button))actionBlock {
    objc_setAssociatedObject(self, addButtonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (actionBlock) {
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addActionForEvent:(UIControlEvents)event actionBlock:(void (^)(UIButton *button))actionBlock {
    objc_setAssociatedObject(self, addButtonActionBlockKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (actionBlock) {
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:event];
    }
}

- (void (^)(UIButton *))addButtonActionBlock {
    return objc_getAssociatedObject(self, addButtonActionBlockKey);
}

- (void)buttonAction:(UIButton *)button {
    if (self.addButtonActionBlock) {
        self.addButtonActionBlock(button);
    }
}

@end
