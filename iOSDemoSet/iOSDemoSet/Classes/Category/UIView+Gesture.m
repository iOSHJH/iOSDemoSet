//
//  UIView+Gesture.m
//  win
//
//  Created by huangjunhuang on 2019/1/25.
//  Copyright © 2019 mustget. All rights reserved.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>

@interface UIView()

@property (nonatomic, copy) void(^addTapGestureRecognizerBlock)(UITapGestureRecognizer *tap);

@end

static char *const addTapGestureRecognizerKey = "addTapGestureRecognizerKey";

@implementation UIView (Gesture)

/// 一句话创建单击手势
- (void)addTapGestureRecognizerActionBlock:(void (^)(UITapGestureRecognizer *tap))actionBlock {
    [self addTapGestureRecognizer:1 actionBlock:actionBlock];
}

- (void)addTapGestureRecognizer:(NSUInteger)number actionBlock:(void (^)(UITapGestureRecognizer *tap))actionBlock {
    objc_setAssociatedObject(self, addTapGestureRecognizerKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (actionBlock) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTouchesRequired = number;
        [self addGestureRecognizer:tap];
    }
}

- (void (^)(UIView *))addTapGestureRecognizerBlock {
    return objc_getAssociatedObject(self, addTapGestureRecognizerKey);
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.addTapGestureRecognizerBlock) {
        self.addTapGestureRecognizerBlock(tap);
    }
}

@end
