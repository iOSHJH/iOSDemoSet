//
//  NSObject+Extension.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

+ (void)autoCreatePropertyCodeWithDict:(NSDictionary *)dict {
    NSMutableString *strM = [NSMutableString string];
    
    // 1.遍历字典，把字典中的所有key取出来，生成对应的属性代码
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *type;
        
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            type = @"NSNumber";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            type = @"NSDictionary";
        }
        
        NSString *str;
        if ([type containsString:@"NSString"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) %@ *%@;",type,key];
        }else if ([type containsString:@"NS"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",type,key];
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) %@ %@;",type,key];
        }
        [strM appendFormat:@"\n%@\n",str];
        
    }];
    NSLog(@"\n\n/**************自动生成属性代码**************/\n %@ \n/**************自动生成属性代码**************/\n\n",strM);
}

@end
