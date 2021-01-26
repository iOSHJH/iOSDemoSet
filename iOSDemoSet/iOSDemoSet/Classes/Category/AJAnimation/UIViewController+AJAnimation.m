//
//  UIViewController+AJAnimation.m
//  iOSDemoSet
//
//  Created by Ansjer on 2021/1/26.
//  Copyright © 2021 hjh. All rights reserved.
//  https://github.com/alanwangmodify/TableViewAnimationKit

#import "UIViewController+AJAnimation.h"

CGFloat const vcTotalTime = 1;
CGFloat const vcDuration = 0.25;

@implementation UIViewController (AJAnimation)

- (void)moveLeftAnimation {
    NSArray *views = self.view.subviews;
    for (int i = 0; i < views.count; i++) {
        UITableViewCell *cell = [views objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        [UIView animateWithDuration:vcDuration delay:i*(vcTotalTime/views.count) options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {

        }];
    }
}

- (void)moveRightAnimation {
    NSArray *views = self.view.subviews;
    for (int i = 0; i < views.count; i++) {
        UITableViewCell *cell = [views objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
        [UIView animateWithDuration:vcDuration delay:i*(vcTotalTime/views.count) options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {

        }];
    }
}

@end
