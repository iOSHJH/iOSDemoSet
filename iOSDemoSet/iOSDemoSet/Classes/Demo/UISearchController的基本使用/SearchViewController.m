//
//  ViewController.m
//  UISearchController
//
//  Created by 黄俊煌 on 2017/2/23.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultViewController.h"

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;

/** 联系人字典*/
@property (nonatomic, strong) NSDictionary *contactsDict;

@property (nonatomic, strong) NSMutableArray *sorts;

@end

@implementation SearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    self.contactsDict = @{@"A": @[@"abc"],
                          @"B": @[@"bb", @"baby", @"boy"],
                          @"J": @[@"Jone", @"Jack"],
                          @"M": @[@"Michaelia"],
                          @"#": @[@"121", @"520", @"1314"]};
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.rowHeight = 55;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0);
//    self.tableView.sectionIndexColor = HEXRGB(0x555555);
//    self.tableView.backgroundColor = HEXRGB(0xefeff4);
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}
- (void)dealloc {}

#pragma mark - Public Methods



#pragma mark - Private Methods


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sorts.count > 0 ? self.sorts.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else {
        NSString *key = self.sorts[section];
        NSArray *contacts = [self.contactsDict objectForKey:key];
        return contacts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
        cell.textLabel.text = @"新的朋友";
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"addcontact_group_chats"];
        cell.textLabel.text = @"群聊";
        return cell;
    }
    
    NSString *key = self.sorts[indexPath.section];
    NSArray *contacts = [self.contactsDict objectForKey:key];
    
    cell.imageView.image = [UIImage imageNamed:@"addcontact_add_friends"];
    cell.textLabel.text = contacts[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sorts[section];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sorts;
}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    return index;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.0;
        default:
            return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"indexPath = %@",indexPath);
}

#pragma mark - UISearchControllerDelegate

// UISearchController将要显示
- (void)willPresentSearchController:(UISearchController *)searchController {

}
// UISearchController显示完成
- (void)didPresentSearchController:(UISearchController *)searchController {

}
// UISearchController将要隐藏
- (void)willDismissSearchController:(UISearchController *)searchController {

}
// UISearchController隐藏完成
- (void)didDismissSearchController:(UISearchController *)searchController {

}

- (void)presentSearchController:(UISearchController *)searchController {
    
}

#pragma mark - UISearchResultsUpdating

// 必须实现：编辑搜索框就会调用
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *keyword = searchController.searchBar.text;
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (keyword.length < 1) {
        return;
    }
    
    NSMutableArray *results = [NSMutableArray array];
    
    [self.contactsDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 不区分大小 关键字是否等于分组标题，等于：添加一组
        if ([key caseInsensitiveCompare:keyword] == NSOrderedSame) {
            [results addObjectsFromArray:obj];
        }else {
            for (NSString *str in obj) {
                // 关键字 包含用户名字，包含：添加friend
                if ([str.lowercaseString containsString:keyword.lowercaseString]) {
                    [results addObject:str];
                }
            }
        }
    }];
    
    ResultViewController *vc = (ResultViewController *)searchController.searchResultsController;
    vc.results = results;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        // ResultsController为nil，将当前控制器作为结果控制器，这里将不演示
//        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        // ResultViewController作为结果控制器，当前控制器就不必写太多的逻辑代码，提高代码可读性、可维护性、扩展性
        _searchController = [[UISearchController alloc] initWithSearchResultsController:[ResultViewController new]];
        
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self; // 代理
        _searchController.searchBar.placeholder = @"搜索";
        
//        _searchController.searchBar.tintColor = [UIColor redColor];
//        _searchController.searchBar.backgroundColor = [UIColor redColor];
//        _searchController.searchBar.barTintColor = [UIColor redColor];
        
        //设置UISearchController的显示属性，以下3个属性默认为YES
        //搜索时，背景变暗色
//        _searchController.dimsBackgroundDuringPresentation = NO;
        //搜索时，背景变模糊
//        _searchController.obscuresBackgroundDuringPresentation = NO;
        //隐藏导航栏
//        _searchController.hidesNavigationBarDuringPresentation = NO;
        
//        [_searchController.searchBar setBackgroundImage:[UIImage imageWithColor:HEXRGB(0xefeff4)]];
//        [_searchController.searchBar ];
    }
    return _searchController;
}

- (NSMutableArray *)sorts {
    if (_sorts) {
        return _sorts;
    }
    _sorts = [[NSMutableArray alloc] init];
    
    return _sorts;
}

#pragma mark - Setter

- (void)setContactsDict:(NSDictionary *)contactsDict {
    _contactsDict = contactsDict;
    
    // 分组排序
    //    [self.sortArr addObject:@"🔍"];
    [self.sorts addObject:@"{search}"];
    
    NSArray *allKeys = [_contactsDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }]; // 根据字母从A-Z排序
    NSMutableArray *array = [NSMutableArray array];
    NSInteger index = 0;
    for (NSString *character in allKeys) {
        if (![character isEqualToString:@"#"]) {
            [array addObject:character];
        }else {
            index = 1;
        }
    }
    [self.sorts addObjectsFromArray:array];
    if (index == 1) {
        [self.sorts addObject:@"#"];
    }
}


@end
