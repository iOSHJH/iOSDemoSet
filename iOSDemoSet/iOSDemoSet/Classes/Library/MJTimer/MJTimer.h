//
//  MJTimer.h
//  Interview02-GCD定时器
//
//  Created by MJ Lee on 2018/6/21.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJTimer : NSObject

+ (NSString *)execTask:(void(^)(void))task
           start:(NSTimeInterval)start
        interval:(NSTimeInterval)interval
         repeats:(BOOL)repeats
           async:(BOOL)async;

+ (NSString *)execTask:(id)target
              selector:(SEL)selector
                 start:(NSTimeInterval)start
              interval:(NSTimeInterval)interval
               repeats:(BOOL)repeats
                 async:(BOOL)async;

+ (void)cancelTask:(NSString *)name;

@end


/*
 test
 
 - (void)viewDidLoad {
     [super viewDidLoad];
     
     NSLog(@"begin");
     
     // 接口设计
     self.task = [MJTimer execTask:self
                          selector:@selector(doTask)
                             start:2.0
                          interval:1.0
                           repeats:YES
                             async:NO];
     
 //    self.task = [MJTimer execTask:^{
 //        NSLog(@"111111 - %@", [NSThread currentThread]);
 //    } start:2.0 interval:-10 repeats:NO async:NO];
 }

 - (void)doTask
 {
     NSLog(@"doTask - %@", [NSThread currentThread]);
 }

 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
 {
     [MJTimer cancelTask:self.task];
 }
 */
