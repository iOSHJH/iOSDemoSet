//
//  NSObject+Log.m
//  win
//
//  Created by Jone on 2017/9/20.
//  Copyright © 2017年 hongsui. All rights reserved.
//

#import "NSObject+Log.h"
#import <objc/runtime.h>
//#import "FMDatabaseQueue.h"

@implementation NSObject (Log)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([NSObject class], @selector(description)), class_getInstanceMethod([NSObject class], @selector(textDescription)));
}

- (NSString *)textDescription {
    
    Class class = [self class];
//    if ([self isKindOfClass:[FMDatabaseQueue class]]) return nil;

    NSMutableString *resultStr = [NSMutableString stringWithFormat:@"%@ = {\n",[self textDescription]];
    while (class != [NSObject class]) {
        if (![[NSBundle bundleForClass:class] isEqual:[NSBundle mainBundle]])return [self textDescription];
        
        unsigned int count = 0;
        Ivar *vars = class_copyIvarList(class, &count);
        for (int index = 0; index < count; index ++) {
            Ivar var = vars[index];
            const char *name = ivar_getName(var);
            NSString *varName = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:varName];
            
            [resultStr appendFormat:@"\t%@ = %@;\n", varName, value];
        }
        free(vars);
        class = class_getSuperclass(class);
    }
    [resultStr appendString:@"}\n"];
    
    return resultStr;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

@end
