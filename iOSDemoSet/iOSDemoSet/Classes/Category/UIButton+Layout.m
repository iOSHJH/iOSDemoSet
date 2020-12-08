//
//  UIButton+Layout.m
//  RedChat
//
//  Created by Ansjer on 2020/12/8.
//  Copyright © 2020 ansjer. All rights reserved.
//

/*
    title image
    上下左右自由布局
 */

#import "UIButton+Layout.h"

@implementation UIButton (Layout)

- (void)leftImage_rightTitle:(CGFloat)spacing {
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0,  - spacing/2);
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing/2, 0.0, 0.0);
}

- (void)leftTitle_rightImage:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing/2);
    titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing/2, 0.0, - titleSize.width);
}

- (void)topImage_bottomTitle:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing/2), 0.0);
    titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing/2), 0.0, 0.0, - titleSize.width);
}
//{top, left, bottom, right};
- (void)topTitle_bottomImage:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing/2), - imageSize.width, 0, 0.0);
    titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, - (imageSize.height + spacing/2), - titleSize.width);
}

@end
