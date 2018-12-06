//
//  NewVesionTipsTool.h
//  IntelligentRepaymentButlerTests
//
//  Created by huangjunhuang on 2018/6/25.
//  Copyright © 2018年 lmj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewVesionTipsTool : NSObject

/// 新版本提示
+ (void)newVesionTipsUpdate:(void (^)(UIAlertController *alert))finished;

@end
