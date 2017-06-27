//
//  MenuDetailVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "MenuDetailVC.h"
#import <WebKit/WebKit.h>
#import "FoodModel.h"

@interface MenuDetailVC ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation MenuDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];

}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter

- (WKWebView *)webView {
    if (_webView) {
        return _webView;
    }
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_webView];
    
    return _webView;
}

#pragma mark - setter

- (void)setFood:(FoodModel *)food {
    _food = food;
    
    self.title = _food.name;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"1.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


@end



