//
//  CycleTestVC.m
//  iOSDemoSet
//
//  Created by huangjunhuang on 2018/12/8.
//  Copyright © 2018 yunshi. All rights reserved.
//

#import "CycleTestVC.h"
#import "JHCycleView.h"

@interface CycleTestVC ()

@property (nonatomic, strong) JHCycleView *cycleView;

@end

@implementation CycleTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.cycleView];
}

- (JHCycleView *)cycleView {
    if (_cycleView) return _cycleView;
    CGRect rect = CGRectMake(20, 200, 300, 150);
    NSArray *imageNames = @[@"1", @"2", @"3"];
    _cycleView = [[JHCycleView alloc] initWithFrame:rect imageNames:imageNames imageUrls:nil];
    return _cycleView;
}

@end
