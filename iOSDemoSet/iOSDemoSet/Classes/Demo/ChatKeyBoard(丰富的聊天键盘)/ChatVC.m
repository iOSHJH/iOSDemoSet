//
//  ChatVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/11/14.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "ChatVC.h"
//#import "ChatKeyBoardVC.h"
#import "ChatKeyBoardView.h"

@interface ChatVC ()

//@property (nonatomic, strong) ChatKeyBoardVC *keyBoardVC;
@property (nonatomic, strong) ChatKeyBoardView *keyBoardView;

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

//    [self addChildViewController:self.keyBoardVC];
//    [self.view addSubview:self.keyBoardVC.view];
//
//    [self.keyBoardVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(0);
//        make.height.equalTo(@400); // 400
//    }];
    
    [self.view addSubview:self.keyBoardView];
    
    [self.keyBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(@400); // 400
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.keyBoardView outView];
}

#pragma mark - get

//- (ChatKeyBoardVC *)keyBoardVC {
//    if (!_keyBoardVC) {
//        _keyBoardVC = [ChatKeyBoardVC new];
//        // 点击发送 text：评论内容*
//        _keyBoardVC.sendBlock = ^(NSString *content){
//            
//        };
//        
//        _keyBoardVC.textViewDidBeginEditingBlock = ^(UITextView *textView) {
//            
//        };
//        
//        _keyBoardVC.emoticonBlock = ^{
//            
//        };
//    }
//    return _keyBoardVC;
//}

- (ChatKeyBoardView *)keyBoardView {
    if (!_keyBoardView) {
        _keyBoardView = [ChatKeyBoardView new];
        // 点击发送 text：评论内容*
        _keyBoardView.sendBlock = ^(NSString *content){

        };

        _keyBoardView.textViewDidBeginEditingBlock = ^(UITextView *textView) {

        };

        _keyBoardView.emoticonBlock = ^{

        };
    }
    return _keyBoardView;
}


@end
