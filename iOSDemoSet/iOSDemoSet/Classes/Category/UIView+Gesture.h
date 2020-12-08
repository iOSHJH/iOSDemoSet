//
//  UIView+Gesture.h
//  win
//
//  Created by huangjunhuang on 2019/1/25.
//  Copyright © 2019 mustget. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gesture)

/// 一句话创建单击手势
- (void)addTapGestureRecognizerActionBlock:(void (^)(UITapGestureRecognizer *tap))actionBlock;

- (void)addTapGestureRecognizer:(NSUInteger)number actionBlock:(void (^)(UITapGestureRecognizer *tap))actionBlock;

@end

NS_ASSUME_NONNULL_END
