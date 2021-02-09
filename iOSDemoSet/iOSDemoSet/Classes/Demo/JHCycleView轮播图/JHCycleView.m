//
//  JHCycleView.m
//  iOSDemoSet
//
//  Created by huangjunhuang on 2018/12/8.
//  Copyright © 2018 yunshi. All rights reserved.
//

#import "JHCycleView.h"

@interface JHCycleView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *imageUrls;
/// 表示中间显示第几张图片
@property (nonatomic, assign) NSInteger currentIndex;
/// 计时器
@property (nonatomic, strong) NSTimer *autoScrollTimer;
/// 指示器
@property (nonatomic, strong) NSMutableArray<UIView *> *tipViews;
@property (nonatomic, strong) UIView *currentTipView;
/// 是否禁用循环滚动
@property (nonatomic, assign) BOOL isForbiddenCycleScroll;
/// 点击轮播图 回调
@property (nonatomic, copy) void (^didSelectItemAtBlock)(NSInteger currentIndex);

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation JHCycleView

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames imageUrls:(NSArray *)imageUrls isForbiddenCycleScroll:(BOOL)isForbidden
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageNames = imageNames;
        self.imageUrls = imageUrls;
        self.currentIndex = 0;
        self.isForbiddenCycleScroll = isForbidden;
        
        NSInteger imageNamesCount = self.imageNames.count > 0 ? self.imageNames.count : 0;
        NSInteger imageUrlsCount = self.imageUrls.count > 0 ? self.imageUrls.count : 0;
        if (imageNamesCount > 1 || imageUrlsCount > 1) {
            if (isForbidden == NO) {
                [self configureAutoScrollTimer];
            }
            [self resetImageViewSource];
        }
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.middleImageView];
    [self.scrollView addSubview:self.rightImageView];
    
    NSInteger count = self.imageNames.count > 0 ? self.imageNames.count : self.imageUrls.count;
    
    CGFloat width = 18;
    CGFloat height = 1.4;
    CGFloat space = 8;
    CGFloat y = self.scrollView.bounds.size.height - 5;
    CGFloat sunWidth = count * width + space*(count-1);// 指示器总范围
    
    for (int i = 0; i < count; i++) {
        CGFloat x = (self.scrollView.bounds.size.width - sunWidth) * 0.5 + (width+space) * i;
        UIView *tipView = [[UIView alloc] init];
        tipView.frame = CGRectMake(x, y, width, height);
        if (i == 0) {
            self.currentTipView = tipView;
            tipView.backgroundColor = UIColor.whiteColor;
        }else {
            tipView.backgroundColor = UIColor.lightGrayColor;
        }
        [self addSubview:tipView];
        [self.tipViews addObject:tipView];
    }
}

- (void)configureAutoScrollTimer {
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(leftScroll) userInfo:nil repeats:YES];
}

- (void)resetImageViewSource {
    NSInteger count = self.imageNames.count > 0 ? self.imageNames.count : self.imageUrls.count;
    // //重新设置各个imageView的图片
    if (self.currentIndex == 0) {
        if (self.imageNames != nil) {
            self.leftImageView.image = [UIImage imageNamed:self.imageNames.lastObject];
            self.middleImageView.image = [UIImage imageNamed:self.imageNames[self.currentIndex]];
            self.rightImageView.image = [UIImage imageNamed:self.imageNames[self.currentIndex+1]];
        }else { // imageUrls
            
        }
    }else if (self.currentIndex == count-1) {
        if (self.imageNames != nil) {
            self.leftImageView.image = [UIImage imageNamed:self.imageNames[self.currentIndex-1]];
            self.middleImageView.image = [UIImage imageNamed:self.imageNames[self.currentIndex]];
            self.rightImageView.image = [UIImage imageNamed:self.imageNames.firstObject];
        }else { // imageUrls
            
        }
    }else {
        if (self.imageNames != nil) {
            self.leftImageView.image = [UIImage imageNamed:self.imageNames[self.currentIndex-1]];
            self.middleImageView.image = [UIImage imageNamed:self.imageNames[self.currentIndex]];
            self.rightImageView.image = [UIImage imageNamed:self.imageNames[self.currentIndex+1]];
        }else { // imageUrls
            
        }
    }
    
    // 设置指示器
    if (self.tipViews.count > 0) {
        self.currentTipView.backgroundColor = UIColor.lightGrayColor;
        UIView *tipView = self.tipViews[self.currentIndex];
        self.currentTipView = tipView;
        tipView.backgroundColor = UIColor.whiteColor;
    }
}

- (void)leftScroll {
    CGPoint offset = CGPointMake(2.0 * self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)tapAction {
    if (self.didSelectItemAtBlock) {
        self.didSelectItemAtBlock(self.currentIndex);
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat count = self.imageUrls.count;
    if (count < 1) {
        count = self.imageNames.count;
    }
    if (count < 1) {
        return;
    }
    //获取当前偏移量
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat swidth = scrollView.bounds.size.width;
    
    if (self.isForbiddenCycleScroll == YES) {
        if (self.currentIndex == 0) {
            //如果向右滑动
            if (offset < swidth) {
                // 还原偏移量
                scrollView.contentOffset = CGPointMake(swidth, 0);
            }
        }
        if (self.currentIndex == count-1) {
            // 如果向右滑动
            if (offset > swidth) {
                // 还原偏移量
                scrollView.contentOffset = CGPointMake(swidth, 0);
            }
        }
    }
    
    //如果向左滑动（显示下一张）
    if (offset >= swidth*2) {
        // 还原偏移量
        scrollView.contentOffset = CGPointMake(swidth, 0);
        //视图索引+1
        self.currentIndex = self.currentIndex + 1;
        if (self.currentIndex == count) {
            self.currentIndex = 0;
        }
        [self resetImageViewSource];
    }
    //如果向右滑动（显示上一张）
    if (offset <= 0) {
        // 还原偏移量
        scrollView.contentOffset = CGPointMake(swidth, 0);
        
        //视图索引-1
        self.currentIndex = self.currentIndex - 1;
        
        if (self.currentIndex == -1) {
            self.currentIndex = count - 1;
        }
        [self resetImageViewSource];
    }
}

#pragma mark - get

- (UIScrollView *)scrollView {
    if (_scrollView) return _scrollView;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    CGFloat width = self.bounds.size.width * 3;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(width, self.bounds.size.height);
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    _scrollView.backgroundColor = [UIColor brownColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    return _scrollView;
}

- (UIImageView *)leftImageView {
    if (_leftImageView) return _leftImageView;
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if (_middleImageView) return _middleImageView;
    _middleImageView = [[UIImageView alloc] init];
    _middleImageView.frame = CGRectMake(self.bounds.size.width, 0, self.frame.size.width, self.frame.size.height);
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if (_rightImageView) return _rightImageView;
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.frame = CGRectMake(self.bounds.size.width*2, 0, self.frame.size.width, self.frame.size.height);
    return _rightImageView;
}

- (NSMutableArray *)tipViews {
    if (_tipViews) return _tipViews;
    _tipViews = [NSMutableArray array];
    return _tipViews;
}

@end
