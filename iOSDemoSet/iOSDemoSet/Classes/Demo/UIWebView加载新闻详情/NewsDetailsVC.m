//
//  NewsDetailsVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/2/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "NewsDetailsVC.h"

@interface NewsDetailsVC ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation NewsDetailsVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.xinhuanet.com/photo/2017-02/27/c_129497220.htm"]];
    [self.webView loadRequest:request];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"我是label我是label我是label";
    [self.webView.scrollView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.webView);
        make.bottom.equalTo(self.webView.scrollView.mas_bottom);
    }];
}

- (void)viewWillAppear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}
- (void)dealloc {}

#pragma mark - Public Methods



#pragma mark - Private Methods

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    DLog(@"webView.scrollView.contentSize = %@",NSStringFromCGSize(webView.scrollView.contentSize));
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    DLog(@"scrollView contentOffset = %@",NSStringFromCGPoint(scrollView.contentOffset));
    
}

#pragma mark - Getter

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
//        _webView.scrollView.scrollEnabled = NO;
        //        [_conWebView sizeToFit];
//        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

#pragma mark - Setter


@end
