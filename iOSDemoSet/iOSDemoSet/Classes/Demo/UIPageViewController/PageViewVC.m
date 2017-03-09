//
//  PageViewVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/3/9.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "PageViewVC.h"

@interface PageViewVC ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(nonatomic,strong) UIPageViewController *pageVC;

@property(nonatomic,strong) NSMutableArray *viewControllers;


@end

@implementation PageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
}



// 根据数组元素，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewControlller {
    return [self.viewControllers indexOfObject:viewControlller];
}

#pragma mark - UIPageViewControllerDataSource
// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.viewControllers count]) {
        return nil;
    }
    
    return self.viewControllers[index];
}
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    
    return self.viewControllers[index];
}

#pragma mark - UIPageViewControllerDelegate

// 开始翻页调用
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0) {
    NSLog(@"1");
}

// 翻页完成调用
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    NSLog(@"2");
}

//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation __TVOS_PROHIBITED {
//
//}

//- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
//    return UIInterfaceOrientationMaskPortraitUpsideDown;
//}

- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationPortrait;
}


#pragma mark - lazy load

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        
        /*
         UIPageViewControllerSpineLocationNone = 0, // 默认UIPageViewControllerSpineLocationMin
         UIPageViewControllerSpineLocationMin = 1,  // 书棱在左边
         UIPageViewControllerSpineLocationMid = 2,  // 书棱在中间，同时显示两页
         UIPageViewControllerSpineLocationMax = 3   // 书棱在右边
         */
        
        // 设置UIPageViewController的配置项
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
        
        /*
         UIPageViewControllerNavigationOrientationHorizontal = 0, 水平翻页
         UIPageViewControllerNavigationOrientationVertical = 1    垂直翻页
         */
        /*
         UIPageViewControllerTransitionStylePageCurl = 0, // 书本效果
         UIPageViewControllerTransitionStyleScroll = 1 // Scroll效果
         */
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        
        // 定义“这本书”的尺寸
        //        _pageVC.view.frame = CGRectMake(50, 100, 200, 300);
        _pageVC.view.frame = self.view.bounds;
        
        // 要显示的第几页
        //        NSArray *vcs = [NSArray arrayWithObject:self.viewControllers[2]];
        
        // 如果要同时显示两页，options参数要设置为UIPageViewControllerSpineLocationMid
        NSArray *vcs = [NSArray arrayWithObjects:self.viewControllers[0], self.viewControllers[1], nil];
        
        [_pageVC setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return _pageVC;
}

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            UIViewController *VC = [UIViewController new];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
            label.text = [NSString stringWithFormat:@"%d",i];
            
            [VC.view addSubview:label];
            
            VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
            [_viewControllers addObject:VC];
        }
    }
    return _viewControllers;
}


@end
