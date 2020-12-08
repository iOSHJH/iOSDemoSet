//
//  NSString+Verify.m
//  win
//
//  Created by huangjunhuang on 2018/10/3.
//  Copyright © 2018年 . All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)

/// 判断手机号是否正确
- (BOOL)isPhoneNumber {
    return [self evaluateWithRegex:@"^1[0123456789]\\d{9}$"];
}

/// 是否是短信验证码
- (BOOL)isMobileCode {
    if (self.length == 5 || self.length == 6) {
        return YES;
    }
    return NO;
}

/// 是否是密码
- (BOOL)isPassword {
    if (self.length < 6 || self.length > 15) {
        return NO;
    }
    return YES;
}

/// 是否是支付密码
- (BOOL)isPayPassword {
    if (self.length == 6) {
        return YES;
    }
    return NO;
}

/// 是否是银行卡号
- (BOOL)isBankId {
    if (self.length < 1) {
        return NO;
    }
    return YES;
//    return [self evaluateWithRegex:@"^[1-9]\\d{15,19}$"];
}

/// 是否是姓名
- (BOOL)isName {
    if (self.length < 1) {
        return NO;
    }
    return YES;
//    return [self evaluateWithRegex:@"^[\u4e00-\u9fa5]{0,8}"];
}

/// 是否是账号名称
- (BOOL)isAccountName {
    if (self.length < 1) {
        return NO;
    }
    return YES;
//    return [self evaluateWithRegex:@"^[\u4e00-\u9fa5]{0,8}"];
}

/// 判断是否是全数字
- (BOOL)isNumber {
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/// 身份证号码验证
- (BOOL)isIdCard {
    if (self.length == 0) {
        return NO;
    }
    return YES;
//    return [self evaluateWithRegex:@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"];
}

- (BOOL)evaluateWithRegex:(NSString *)regex {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [pred evaluateWithObject:str];
}




@end
