//
//  NSString+Verify.h
//  win
//
//  Created by huangjunhuang on 2018/10/3.
//  Copyright © 2018年 hongsui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Verify)

/// 判断手机号是否正确
- (BOOL)isPhoneNumber;

/// 是否是短信验证码
- (BOOL)isMobileCode;

/// 判断是否是全数字
- (BOOL)isNumber;

/// 是否是密码
- (BOOL)isPassword;

/// 是否是支付密码
- (BOOL)isPayPassword;

/// 是否是银行卡号
- (BOOL)isBankId;

/// 是否是姓名
- (BOOL)isName;

/// 是否是账号名称
- (BOOL)isAccountName;

/// 身份证号码验证
- (BOOL)isIdCard;

@end

NS_ASSUME_NONNULL_END
