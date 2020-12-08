//
//  UIButton+Layout.h
//  RedChat
//
//  Created by Ansjer on 2020/12/8.
//  Copyright © 2020 ansjer. All rights reserved.
//

/*
    title image
    上下左右自由布局
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Layout)

- (void)leftImage_RightTitle:(CGFloat)spacing;

- (void)leftTitle_RightImage:(CGFloat)spacing;

- (void)topImage_bottomTitle:(CGFloat)spacing;

- (void)topTitle_bottomImage:(CGFloat)spacing;


@end

NS_ASSUME_NONNULL_END
