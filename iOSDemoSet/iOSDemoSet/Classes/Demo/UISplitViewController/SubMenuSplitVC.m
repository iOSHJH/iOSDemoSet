//
//  SubMenuSplitVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "SubMenuSplitVC.h"
#import "FootTypeModel.h"
#import "FoodModel.h"
#import "MenuDetailVC.h"

@interface SubMenuSplitVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *foods;

@end

@implementation SubMenuSplitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"菜谱";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    FoodModel *food = self.foods[indexPath.row];
    cell.textLabel.text = food.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时间:%@  难度:%@", food.time, food.diff];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MenuDetailVC *vc = [MenuDetailVC new];
    vc.food = self.foods[indexPath.row];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    // 修改弹出样式
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
    // 修改弹出效果
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
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

#pragma mark - setter 

- (void)setFoodType:(FootTypeModel *)foodType {
    _foodType = foodType;
    
    NSString *plistName = [NSString stringWithFormat:@"type_%@_foods.plist", _foodType.idstr];
    NSURL *url  = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    NSArray *dictArr = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *tempArrM = [NSMutableArray array];
    for (NSDictionary *dict in dictArr) {
        FoodModel *food = [FoodModel yy_modelWithDictionary:dict];
        [tempArrM addObject:food];
    }
    
    self.foods = tempArrM;
    [self.tableView reloadData];
}

@end
