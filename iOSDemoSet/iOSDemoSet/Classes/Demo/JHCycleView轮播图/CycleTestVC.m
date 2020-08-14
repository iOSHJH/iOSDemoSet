//
//  CycleTestVC.m
//  iOSDemoSet
//
//  Created by huangjunhuang on 2018/12/8.
//  Copyright © 2018 yunshi. All rights reserved.
//

#import "CycleTestVC.h"
#import "JHCycleView.h"
#import "JHCycleView1.h"

@interface CycleTestVC ()

@property (nonatomic, strong) JHCycleView *cycleView;
@property (nonatomic, strong) JHCycleView1 *cycleView1;

@end

@implementation CycleTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.cycleView];
    [self.view addSubview:self.cycleView1];
}

- (JHCycleView *)cycleView {
    if (_cycleView) return _cycleView;
    CGRect rect = CGRectMake(0, 100, ScreenWidth, 200);
    NSArray *imageNames = @[@"1", @"2", @"3"];
    _cycleView = [[JHCycleView alloc] initWithFrame:rect imageNames:imageNames imageUrls:nil];
    return _cycleView;
}

- (JHCycleView1 *)cycleView1 {
    if (_cycleView1) return _cycleView1;
    CGRect rect = CGRectMake(0, 320, ScreenWidth, 200);
    NSArray *imageNames = @[@"1", @"2", @"3"];
    _cycleView1 = [[JHCycleView1 alloc] initWithFrame:rect imageNames:imageNames imageUrls:nil];
    return _cycleView1;
}

@end
