//
//  UITableView+AJAnimation.m
//  iOSDemoSet
//
//  Created by Ansjer on 2021/1/26.
//  Copyright © 2021 yunshi. All rights reserved.
//

#import "UITableView+AJAnimation.h"

CGFloat const tableTotalTime = 1;
CGFloat const tableDuration = 0.25;

@implementation UITableView (AJAnimation)

- (void)moveLeftAnimation {
    NSArray *cells = self.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [self.visibleCells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        [UIView animateWithDuration:tableDuration delay:i*(tableTotalTime/cells.count) options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)moveRightAnimation {
    NSArray *cells = self.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UITableViewCell *cell = [self.visibleCells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
        [UIView animateWithDuration:tableDuration delay:i*(tableTotalTime/cells.count) options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}




@end
