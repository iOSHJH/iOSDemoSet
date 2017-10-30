//
//  JHTextView.h
//  JHTextView
//
//  Created by 黄俊煌 on 2017/8/3.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 欲用此控件就不能设置代理，用block代替
 */
@interface JHTextView : UITextView

@property (nonatomic, assign) NSInteger limitLength;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UILabel *textNumLabel;

#pragma mark - UITextViewDelegate

@property (nonatomic, copy) void (^textViewDidChangeBlock)(UITextView *textView);
@property (nonatomic, copy) BOOL (^textViewShouldBeginEditingBlock)(UITextView *textView);
@property (nonatomic, copy) BOOL (^textViewShouldEndEditingBlock)(UITextView *textView);
@property (nonatomic, copy) void (^textViewDidBeginEditingBlock)(UITextView *textView);
@property (nonatomic, copy) void (^textViewDidEndEditingBlock)(UITextView *textView);
@property (nonatomic, copy) BOOL (^textViewShouldChangeTextInRangeReplacementTextBlock)(UITextView *textView, NSRange range, NSString *text);

@end
