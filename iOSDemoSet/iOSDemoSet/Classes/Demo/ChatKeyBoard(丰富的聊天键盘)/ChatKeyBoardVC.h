//
//  ChatKeyBoardViewController.h
//  ehome
//
//  Created by 黄俊煌 on 2017/5/31.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatKeyBoardVC : UIViewController

/***  点击 表情block*/
@property (nonatomic,copy) void(^emoticonBlock)();
/***  点击发送 text：评论内容*/
@property (nonatomic,copy) void(^sendBlock)(NSString *content);
/** textView获得焦点*/
@property (nonatomic, copy) void (^textViewDidBeginEditingBlock)(UITextView *textView);

/***  输入框*/
@property (nonatomic,strong) UITextView *textView;

/***  键盘、表情键盘  移出到底部屏幕外*/
- (void)outView;

@end


/***  ----------------------表情键盘cell----------------------*/

@interface EmoticonCell : UICollectionViewCell

@property (nonatomic,copy) NSString *emoji;

@end
