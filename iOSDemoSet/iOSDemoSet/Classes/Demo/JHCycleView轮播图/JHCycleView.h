//
//  JHCycleView.h
//  iOSDemoSet
//
//  Created by huangjunhuang on 2018/12/8.
//  Copyright © 2018 yunshi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHCycleView : UIView

/// isForbiddenCycleScroll：是否禁用循环滚动
- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames imageUrls:(NSArray *)imageUrls isForbiddenCycleScroll:(BOOL)isForbidden;

@end

NS_ASSUME_NONNULL_END
