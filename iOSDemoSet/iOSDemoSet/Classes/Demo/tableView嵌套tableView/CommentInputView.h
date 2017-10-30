//
//  CommentInputView.h
//  win
//
//  Created by 黄俊煌 on 2017/10/17.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHTextView.h"

@interface CommentInputView : UIView

@property (nonatomic, strong) JHTextView *textView;

@property (nonatomic, copy) void (^sendBlock)(void);

@end
