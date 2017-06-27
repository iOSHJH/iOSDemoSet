//
//  NSObject+Extension.h
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/** 自动生成成员变量代码*/
+ (void)autoCreatePropertyCodeWithDict:(NSDictionary *)dict;

@end
