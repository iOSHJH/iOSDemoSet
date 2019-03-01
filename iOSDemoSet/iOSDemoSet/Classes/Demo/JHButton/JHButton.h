//
//  JHButton.h
//  AlarmChaser
//
//  Created by huangjunhuang on 2019/3/1.
//  Copyright © 2019 tongari. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TitleTextType){
    TopImage_BottomText = 0,  //上图,下文
    TopText_BottomImage = 1,  //上文,下图
    LeftImage_RightText = 2,  //左图,右文
    LeftText_RightImage = 3,  //左文,右图
};

@interface JHButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame imageSize:(CGSize)imageSize space:(CGFloat)space titleTextType:(TitleTextType)titleTextType;

@end

NS_ASSUME_NONNULL_END
