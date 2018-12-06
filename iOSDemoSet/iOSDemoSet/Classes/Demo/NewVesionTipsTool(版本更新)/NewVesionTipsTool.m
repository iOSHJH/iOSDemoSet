//
//  NewVesionTipsTool.m
//  IntelligentRepaymentButlerTests
//
//  Created by huangjunhuang on 2018/6/25.
//  Copyright © 2018年 lmj. All rights reserved.
//

#import "NewVesionTipsTool.h"
#import <UIKit/UIKit.h>

@implementation NewVesionTipsTool

#pragma mark - 版本更新
+ (void)newVesionTipsUpdate:(void (^)(UIAlertController *alert))finished {
    NSString* thisVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    //存储当前版本号数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:thisVersion forKey:@"versionName"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=1438374035"]];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!data) {
                    return ;
                }
                id result =[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSArray *arr = [result objectForKey:@"results"];
                if (arr.count == 0) {
                    return ;
                }
                NSDictionary *dic = [arr firstObject];
                NSString *trackViewUrl = [dic objectForKey:@"trackViewUrl"];
                NSString *releaseNotes = [dic objectForKey:@"releaseNotes"];//更新日志
                NSString *versionStr = [dic objectForKey:@"version"];
                
                if ([self compareVersionsFormAppStore:versionStr WithAppVersion:thisVersion]) {
                    NSArray *arry = [[NSArray alloc]init];
                    if ([releaseNotes rangeOfString:@"确保第一时间体验更好的摩富金服。"].location != NSNotFound) {
                        arry=[releaseNotes componentsSeparatedByString:@"确保第一时间体验更好的摩富金服。"];
                        UIAlertController *alertC =[self showUpateMessage:arry[1] versionStr:versionStr trackViewUrl:trackViewUrl];
                        finished(alertC);
                    }else{//不切割 显示全部
                        UIAlertController *alertC = [self showUpateMessage:releaseNotes versionStr:versionStr trackViewUrl:trackViewUrl];
                        finished(alertC);
                    }
                }else {
                    finished(nil);
                }
            });
        }];
        //5.最后一步，执行任务，(resume也是继续执行)。
        [sessionDataTask resume];
    });
}

//show 版本信息
+ (UIAlertController *)showUpateMessage:(NSString *)showmessages versionStr:(NSString *)versionStr trackViewUrl:(NSString *)trackViewUrl
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本:%@",versionStr] message:showmessages preferredStyle:UIAlertControllerStyleAlert];
    UIView *subView1 = alertVC.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    //取message：
    UILabel *message = subView5.subviews[1];
    UILabel *title = subView5.subviews[2];
    message.textAlignment = NSTextAlignmentLeft;
    title.textAlignment = NSTextAlignmentLeft;
    
    UIAlertAction *cancelAction  = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *OKAction  = [UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:trackViewUrl];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [OKAction setValue:[UIColor brownColor] forKey:@"_titleTextColor"];
    [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
//    [self presentViewController:alertVC animated:YES completion:nil];
    return alertVC;
}

+ (BOOL)compareVersionsFormAppStore:(NSString*)AppStoreVersion WithAppVersion:(NSString*)AppVersion{
    
    BOOL littleSunResult = false;
    
    NSMutableArray* a = (NSMutableArray*) [AppStoreVersion componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [AppVersion componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int j = 0; j<a.count; j++) {
        if ([[a objectAtIndex:j] integerValue] > [[b objectAtIndex:j] integerValue]) {
            littleSunResult = true;
            break;
        }else if([[a objectAtIndex:j] integerValue] < [[b objectAtIndex:j] integerValue]){
            littleSunResult = false;
            break;
        }else{
            littleSunResult = false;
        }
    }
    return littleSunResult;
    
}


@end
