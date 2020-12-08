//
//  UIButton+Extension.h
//  win
//
//  Created by huangjunhuang on 2019/1/8.
//  Copyright © 2019 mustget. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Action)

/// 一句话添加Button点击事件
- (void)addActionWithBlock:(void (^)(UIButton *button))actionBlock;

- (void)addActionForEvent:(UIControlEvents)event actionBlock:(void (^)(UIButton *button))actionBlock;

@end

NS_ASSUME_NONNULL_END
