//
//  ChatKeyBoardViewController.m
//  ehome
//
//  Created by 黄俊煌 on 2017/5/31.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import "ChatKeyBoardVC.h"

@interface ChatKeyBoardVC ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UIView *toolView;

/***  表情图标*/
@property (nonatomic,strong) UIButton *emoticonButton;
/***  发送按钮*/
@property (nonatomic,strong) UIButton *sendButton;

/***  表情键盘*/
@property (nonatomic,strong) UIView *emoticonView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) UIPageControl *pageControl;


/***  emoji表情数组*/
@property (nonatomic,strong) NSArray *emojis;


@end

static NSString * const EmoticonCellIdentifer = @"EmoticonCellIdentifer";

@implementation ChatKeyBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareSetup];
    [self prepareUI];
}

- (void)prepareSetup {
    self.view.backgroundColor = [UIColor clearColor];
    
    // 注册cell
    [self.collectionView registerClass:[EmoticonCell class] forCellWithReuseIdentifier:EmoticonCellIdentifer];
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)prepareUI {
    [self.view addSubview:self.toolView];

    [self.toolView addSubview:self.sendButton];
    [self.toolView addSubview:self.emoticonButton];
    [self.toolView addSubview:self.textView];
    
    [self.view addSubview:self.emoticonView];
    [self.emoticonView addSubview:self.collectionView];
    [self.emoticonView addSubview:self.pageControl];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(50);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-7);
        make.centerY.equalTo(self.toolView);
    }];
    [self.emoticonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sendButton.mas_left).offset(-12);
        make.centerY.equalTo(self.toolView);
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.emoticonButton.mas_left).offset(-12);
        make.top.equalTo(@5);
        make.bottom.mas_equalTo(-5);
    }];
    
    [self.emoticonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(215);
        make.height.equalTo(215);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.emoticonView).offset(10);
        make.height.equalTo(180);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.emoticonView);
        make.bottom.equalTo(self.emoticonView).offset(0);
    }];
}

- (void)KeyboardWillChangeFrameNotification:(NSNotification *)notification {
    // 动画时间
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的最终位置
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    NSLog(@"ScreenHeight - endFrame.origin.y) = %f",ScreenHeight - endFrame.origin.y);
    if (ScreenHeight - endFrame.origin.y == 0) {
            [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.bottom.equalTo(self.view).offset(0);
                make.height.equalTo(@50);
            }];
            [self.emoticonView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(215);
            }];
    }else {
        [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-(ScreenHeight - endFrame.origin.y));
            make.height.equalTo(@50);
        }];
    }
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

// 键盘、表情键盘  移出到底部屏幕外
- (void)outView {
    [self.textView resignFirstResponder];
    
    [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(@50);
    }];
    [self.emoticonView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(215);
        make.height.equalTo(215);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.emojis.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EmoticonCellIdentifer forIndexPath:indexPath];
    cell.emoji = self.emojis[indexPath.item];
    //    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EmoticonCell *cell = (EmoticonCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.emoji isEqualToString:@"icon_delete"]) {
        [self.textView deleteBackward];
    }else {
        self.textView.text = [self.textView.text stringByAppendingString:cell.emoji];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = (int)scrollView.contentOffset.x / (int)ScreenWidth;
    
    self.pageControl.currentPage = page;
}



#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {

}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.textViewDidBeginEditingBlock) {
        self.textViewDidBeginEditingBlock(textView);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    DLog(@"text = %@",text);
    if ([text isEqualToString:@"\n"]) {
        if (self.sendBlock) {
            self.sendBlock(textView.text);
        }
        return NO;
    }
    return YES;
}



#pragma mark action


- (void)emoticonAction {
    if (self.emoticonBlock) {
        self.emoticonBlock();
    }
    [self.textView resignFirstResponder];

    [self.emoticonView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
        make.height.equalTo(215);
    }];
    [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-215);
        make.height.equalTo(@50);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)sendClick:(UIButton *)button {
    if (self.sendBlock) {
        self.sendBlock(self.textView.text);
    }
}

#pragma mark - lazy load

- (UIView *)toolView {
    if (!_toolView) {
        _toolView = [UIView new];
        _toolView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    }
    return _toolView;
}

- (UIButton *)emoticonButton {
    if (!_emoticonButton) {
        _emoticonButton = [UIButton new];
        [_emoticonButton setImage:[UIImage imageNamed:@"faceicon"] forState:UIControlStateNormal];
        [_emoticonButton addTarget:self action:@selector(emoticonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emoticonButton;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor grayColor];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.cornerRadius = 5;
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeySend;
    }
    return _textView;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton new];
        [_sendButton setImage:[UIImage imageNamed:@"button_send_nor"] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UIView *)emoticonView {
    if (!_emoticonView) {
        _emoticonView = [UIView new];
        _emoticonView.backgroundColor = [UIColor whiteColor];
    }
    return _emoticonView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 400, ScreenWidth, 180) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat width = self.collectionView.frame.size.width / 7;
        CGFloat height = self.collectionView.frame.size.height / 3;
        
        _layout.itemSize = CGSizeMake(width, height);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumInteritemSpacing = 0;
        _layout.minimumLineSpacing = 0;
    }
    return _layout;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.numberOfPages = self.emojis.count / 21;
        _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

- (NSArray *)emojis {
    if (!_emojis) {
        NSMutableArray *array = [NSMutableArray new];
        int index = 1;
        for (int i=0x1F600; i<=0x1F64F; i++) {
            if (i < 0x1F641 || i > 0x1F644) {
                int sym = EMOJI_CODE_TO_SYMBOL(i);
                NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
                [array addObject:emoT];
                
                if (index % 20 == 0) {
                    [array addObject:@"icon_delete"];
                }
                index++;
            }
        }
        
        int num = array.count % 21;
        
        for (int i = 0; i < (21 - num -1); ++i) {
            [array addObject:@"1"];
        }
        [array addObject:@"icon_delete"];
        _emojis = array;
    }
    return _emojis;
}

#pragma mark - setter

@end

#pragma mark -----------------------表情键盘cell----------------------

@interface EmoticonCell ()

@property (nonatomic,strong) UIButton *emoticonButton;

@end

@implementation EmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self.contentView addSubview:self.emoticonButton];
        
        [self.emoticonButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setEmoji:(NSString *)emoji {
    _emoji = emoji;
    
    if ([_emoji isEqualToString:@"icon_delete"]) {
        [self.emoticonButton setTitle:@"" forState:UIControlStateNormal];
        [self.emoticonButton setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    }else {
        [self.emoticonButton setTitle:emoji forState:UIControlStateNormal];
        [self.emoticonButton setImage:nil forState:UIControlStateNormal];
    }
}

- (UIButton *)emoticonButton {
    if (!_emoticonButton) {
        _emoticonButton = [UIButton new];
        _emoticonButton.titleLabel.font = [UIFont systemFontOfSize:30];
        _emoticonButton.userInteractionEnabled = NO;
    }
    return _emoticonButton;
}




@end
