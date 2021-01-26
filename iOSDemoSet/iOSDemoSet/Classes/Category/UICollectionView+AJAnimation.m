//
//  UICollectionView+AJAnimation.m
//  iOSDemoSet
//
//  Created by Ansjer on 2021/1/26.
//  Copyright © 2021 yunshi. All rights reserved.
//

#import "UICollectionView+AJAnimation.h"

CGFloat const collectionTotalTime = 1;
CGFloat const collectionDuration = 0.25;

@implementation UICollectionView (AJAnimation)

- (void)moveLeftAnimation {
    NSArray *cells = [self descendingCells];
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        [UIView animateWithDuration:collectionDuration delay:i*(collectionTotalTime/cells.count) options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)moveRightAnimation {
    NSArray *cells = [self ascendingCells];
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
        [UIView animateWithDuration:collectionDuration delay:i*(collectionTotalTime/cells.count) options:0 animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

/// 升序
-(NSArray *)descendingCells {
    NSArray *visibleCellIndex = [self visibleCells];
    NSArray *sortedIndexPaths = [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)[self indexPathForCell:obj1];
        NSIndexPath *path2 = (NSIndexPath *)[self indexPathForCell:obj2];
        return [path1 compare:path2] == NSOrderedDescending;
    }];
    return sortedIndexPaths;
}

/// 降序
- (NSArray *)ascendingCells {
    NSArray *visibleCellIndex = [self visibleCells];
    NSArray *sortedIndexPaths = [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *path1 = (NSIndexPath *)[self indexPathForCell:obj1];
        NSIndexPath *path2 = (NSIndexPath *)[self indexPathForCell:obj2];
        return [path1 compare:path2] == NSOrderedAscending;
    }];
    return sortedIndexPaths;
}



@end
