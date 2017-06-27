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

@interface MenuDetailVC ()<WKNavigationDelegate, WKUIDelegate>

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
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    
    [self.view addSubview:_webView];
    
    return _webView;
}

#pragma mark - WKNavigationDelegate

/**
 *  根据webView、navigationAction相关信息决定这次跳转是否可以继续进行,这些信息包含HTTP发送请求，如头部包含User-Agent,Accept,refer
 *  在发送请求之前，决定是否跳转的代理
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

/**
 *  这个代理方法表示当客户端收到服务器的响应头，根据response相关信息，可以决定这次跳转是否可以继续进行。
 *  在收到响应后，决定是否跳转的代理
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

/**
 *  准备加载页面。等同于UIWebViewDelegate: - webView:shouldStartLoadWithRequest:navigationType
 *
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
}

/**
 *  这个代理是服务器redirect时调用
 *  接收到服务器跳转请求的代理
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

/**
 *  内容开始加载. 等同于UIWebViewDelegate: - webViewDidStartLoad:
 *
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    [SVProgressHUD show];
}

/**
 *  页面加载完成。 等同于UIWebViewDelegate: - webViewDidFinishLoad:
 *
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}

/**
 *  页面加载失败。 等同于UIWebViewDelegate: - webView:didFailLoadWithError:
 *
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"加载失败~"];
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
    
}

/*
 我们看看WKUIDelegate的几个代理方法，虽然不是必须实现的，但是如果我们的页面中有调用了js的alert、confirm、prompt方法，我们应该实现下面这几个代理方法，然后在原来这里调用native的弹出窗，因为使用WKWebView后，HTML中的alert、confirm、prompt方法调用是不会再弹出窗口了，只是转化成ios的native回调代理方法
 */
#pragma mark - WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"h5Container" message:message preferredStyle:UIAlertControllerStyleAlert];
    //    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //        textField.textColor = [UIColor redColor];
    //    }];
    [alertView addAction:[UIAlertAction actionWithTitle:@"我很确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertView animated:YES completion:nil];
}



#pragma mark - setter

- (void)setFood:(FoodModel *)food {
    _food = food;
    
    self.title = _food.name;
    
    NSString *htmlName = [NSString stringWithFormat:@"%@.html", self.food.idstr];
    NSURL *url = [[NSBundle mainBundle] URLForResource:htmlName withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


@end



