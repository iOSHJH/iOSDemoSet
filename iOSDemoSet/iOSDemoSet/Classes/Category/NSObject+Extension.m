//
//  NSObject+Extension.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

/** 打印对象的详细信息*/
- (void)objDescription {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:props options:NSJSONWritingPrettyPrinted error:NULL];
    NSString *description = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@ = %@",self,description);
}

+ (void)autoCreatePropertyCodeWithDict:(NSDictionary *)dict {
    NSMutableString *strM = [NSMutableString string];
    
    // 1.遍历字典，把字典中的所有key取出来，生成对应的属性代码
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *type;
        
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")] || [obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")]) {
            type = @"NSString";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")] || [obj isKindOfClass:NSClassFromString(@"__NSSingleObjectArrayI")]){
            type = @"NSArray";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            type = @"NSNumber";
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]){
            type = @"NSDictionary";
        }else {
            NSLog(@"obj = %@", [obj class]);
        }
        
        NSString *str;
        if ([type containsString:@"NSString"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) %@ *%@;",type,key];
        }else if ([type containsString:@"NS"]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",type,key];
        }else{
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) %@ *%@;",type,key];
        }
        [strM appendFormat:@"\n%@\n",str];
        
    }];
    NSLog(@"\n\n/**************自动生成属性代码**************/\n %@ \n/**************自动生成属性代码**************/\n\n",strM);
}

@end
