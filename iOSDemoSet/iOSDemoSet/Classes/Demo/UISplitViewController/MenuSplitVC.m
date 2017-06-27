//
//  MenuSplitVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "MenuSplitVC.h"
#import "FootTypeModel.h"
#import "SubMenuSplitVC.h"

@interface MenuSplitVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *footTypes;

@end

@implementation MenuSplitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"菜谱分类";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    [self.view addSubview:self.tableView];

}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.footTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    FootTypeModel *model = self.footTypes[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SubMenuSplitVC *subMenu = [[SubMenuSplitVC alloc] init];
    FootTypeModel *foodtype = self.footTypes[indexPath.row];
    subMenu.foodType = foodtype;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:subMenu];
    [self.splitViewController showDetailViewController:nav sender:nil];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    return _tableView;
}

- (NSArray *)footTypes {
    if (_footTypes) {
        return _footTypes;
    }
    NSURL *url  = [[NSBundle mainBundle] URLForResource:@"food_types" withExtension:@"plist"];
    NSArray *dictArr = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dictArr) {
        FootTypeModel *model = [FootTypeModel yy_modelWithDictionary:dict];
        [array addObject:model];
    }
    _footTypes = array;
    
    return _footTypes;
}


@end
