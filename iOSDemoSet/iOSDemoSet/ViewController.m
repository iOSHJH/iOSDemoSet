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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

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
    return 5;
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
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
