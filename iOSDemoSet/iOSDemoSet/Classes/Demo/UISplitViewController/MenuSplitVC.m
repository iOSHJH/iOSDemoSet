//
//  MenuSplitVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/27.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "MenuSplitVC.h"
#import "FootTypeModel.h"

@interface MenuSplitVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *footTypes;

@end

@implementation MenuSplitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"菜谱";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];

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
    
    NSLog(@"indexPath = %@",indexPath);
}

#pragma mark - getter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    return _tableView;
}

- (NSArray *)footTypes {
    if (_footTypes) {
        return _footTypes;
    }
    // 1. 获取plist文件的url
    NSURL *url  = [[NSBundle mainBundle] URLForResource:@"food_types" withExtension:@"plist"];
    // 2. 通过url加载数组
    NSArray *dictArr = [NSArray arrayWithContentsOfURL:url];
    // 3. 遍历数组中的字典
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in dictArr) {
        FootTypeModel *model = [FootTypeModel yy_modelWithDictionary:dict];
        [array addObject:model];
    }
   
    return array;
}


@end
