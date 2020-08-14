//
//  ViewController.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/2/23.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"
#import "NewsDetailsVC.h"
#import "PageViewVC.h"
#import "PopoverVC.h"
#import "ArrangeCellectionVC.h"
#import "VisualEffectVC.h"
#import "MenuSplitVC.h"
#import "SubMenuSplitVC.h"
#import "CommentVC.h"
#import "ChatVC.h"
#import "NewVesionTipsTool.h"
#import "CycleTestVC.h"
#import "TestJhButtonVC.h"
#import "TZPhotoSelectorVC.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UISplitViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"demo集";
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}
- (void)dealloc {}

#pragma mark - Public Methods



#pragma mark - Private Methods

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"UISearchController的基本使用";
        cell.detailTextLabel.text = @"UISearchController的基本使用";
        return cell;
    }else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"UIWebView加载新闻详情";
        cell.detailTextLabel.text = @"UIWebView加载新闻详情";
    }else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"UIPageViewController";
        cell.detailTextLabel.text = @"UIPageViewController的基本使用";
    }else if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"UIPopoverPresentationController";
        cell.detailTextLabel.text = @"UIPopoverPresentationController的基本使用";
    }else if (indexPath.row == 4) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"UICollectionView排列方式之算法初体验";
        cell.detailTextLabel.text = @"UICollectionView排列方式之算法初体验";
    }else if (indexPath.row == 5) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"UIVisualEffectView";
        cell.detailTextLabel.text = @"毛玻璃效果";
    }else if (indexPath.row == 6) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"UISplitViewController";
        cell.detailTextLabel.text = @"UISplitViewController 菜谱实现";
    }else if (indexPath.row == 7) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"tableView 嵌套 tableView";
        cell.detailTextLabel.text = @"难点在于计算cell的高度";
    }else if (indexPath.row == 8) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"ChatKeyBoard(丰富的聊天键盘)";
    }else if (indexPath.row == 9) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"NewVesionTipsTool(版本更新)";
        cell.detailTextLabel.text = @"提示有新版本，前往下载";
    }else if (indexPath.row == 10) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"轮播图";
        cell.detailTextLabel.text = @"轮播图";
    }else if (indexPath.row == 11) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"JHButton";
        cell.detailTextLabel.text = @"一键改变UIButton的title和image的位置";
    }else if (indexPath.row == 12) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"图片选择器";
        cell.detailTextLabel.text = @"图片选择器";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) { // UISearchController的基本使用
        SearchViewController *vc = [SearchViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) { // UIWebView加载新闻详情
        NewsDetailsVC *vc = [NewsDetailsVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) { // UIPageViewController的基本使用
        PageViewVC *pageVC = [PageViewVC new];
        [self.navigationController pushViewController:pageVC animated:YES];
    }else if (indexPath.row == 3) { // UIPopoverPresentationController的基本使用
        PopoverVC *popoverVC = [PopoverVC new];
        [self.navigationController pushViewController:popoverVC animated:YES];
    }else if (indexPath.row == 4) { // UICollectionView排列方式之算法初体验
        ArrangeCellectionVC *vc = [ArrangeCellectionVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5) { // 毛玻璃效果
        VisualEffectVC *vc = [VisualEffectVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 6) { // UISplitViewController
        MenuSplitVC *menuSplitVC = [[MenuSplitVC alloc] init];
        UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menuSplitVC];
        
        SubMenuSplitVC *subMenuSplitVC = [[SubMenuSplitVC alloc] init];
        UINavigationController *subMenuNav = [[UINavigationController alloc] initWithRootViewController:subMenuSplitVC];
        
        UISplitViewController *split = [[UISplitViewController alloc] init];
        split.viewControllers = @[menuNav, subMenuNav];
        split.delegate = self;
        split.modalTransitionStyle = UIModalPresentationFullScreen;
        [self presentViewController:split animated:YES completion:nil];
    }else if (indexPath.row == 7) { // tableView 嵌套 tableView
        CommentVC *vc = [CommentVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 8) { // ChatKeyBoard(丰富的聊天键盘)
        ChatVC *vc = [ChatVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 9) {
        [NewVesionTipsTool newVesionTipsUpdate:^(UIAlertController *alert) {
            if (alert != nil) {
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }else if (indexPath.row == 10) {
        CycleTestVC *vc = [[CycleTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 11) {
        TestJhButtonVC *vc = [[TestJhButtonVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 12) {
        TZPhotoSelectorVC *vc = [[TZPhotoSelectorVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    // 在collapse状态时默认显示Master控制器
    return YES;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    return _tableView;
}

#pragma mark - Setter


@end
