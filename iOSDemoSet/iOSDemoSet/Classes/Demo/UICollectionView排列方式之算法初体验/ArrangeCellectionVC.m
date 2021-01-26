//
//  ArrangeCellectionVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/19.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "ArrangeCellectionVC.h"
#import "CollectionViewCell.h"
#import "UICollectionView+AJAnimation.h"

@interface ArrangeCellectionVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

// 排列前
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *datas;

// 排列后
@property (nonatomic, strong) UILabel *arrangeTitleLabel;
@property (nonatomic, strong) UICollectionView *arrangeCollectionView;
@property (nonatomic, strong) NSArray *arrangedatas;

@end

static NSString * const CollectionViewCellIdentifer = @"CollectionViewCellIdentifer";

@implementation ArrangeCellectionVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"列表动画" style:(UIBarButtonItemStyleDone) target:self action:@selector(reloadCollection)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initUI];
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifer];
    [self.arrangeCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifer];
    
    // @[@"0", @"1", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16"];
    self.datas = @[@"0", @"1", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16"];
    
    self.arrangedatas = [self leftRightTopBottomArrangeWithDatas:self.datas];
}

- (void)viewWillAppear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}
- (void)dealloc {}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    int a = 1;
    int sum = 0;
    
    for (int i = 0; i < 5; i++) {
        sum = i + a;
        DLog(@"sum = %d",sum);
    }
    
}

#pragma mark - Public Methods


#pragma mark - Private Methods

- (void)reloadCollection {
    [self.collectionView moveLeftAnimation];
    [self.arrangeCollectionView moveRightAnimation];
}

/*
     数组重新排列：
     排列前 indexPath.item 0、1、2、3、4、5、6、7
     排列后 indexPath.item 0、4、1、5、2、6、3、7
 */
- (NSArray *)leftRightTopBottomArrangeWithDatas:(NSArray *)datas {
    /*
        不是8的整数要补满8位
     */
    NSMutableArray *array = [NSMutableArray arrayWithArray:datas]; // 排列前数组
    // 计算还差多少位到达8的整数
    NSInteger cha = 8 - datas.count % 8;
    if (cha < 8) {
        for (int i = 0; i < cha; i++) {
            [array addObject:@"i"];
        }
    }
    
    NSMutableArray *lrtbArray = [NSMutableArray arrayWithArray:array]; // 排列后数组
    
    NSInteger temp = 0;
    NSInteger index = 4;
    
    for (int i = 0; i < array.count; i++) {
        if (i == 0) {
            lrtbArray[i] = array[i];
        }else {
            temp = temp + index;
            lrtbArray[i] = array[temp];
            if (index == 4) {
                index = -3;
            }else {
                index = 4;
            }
            if ((i + 1) % 8 == 0) { // 能被8整除，说明是datas的个数是8的整数
                index = 1;
            }
        }
    }
    return lrtbArray;
}

- (void)initUI {
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(100);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.left.equalTo(self.view);
        make.height.equalTo(120);
    }];
    
    [self.view addSubview:self.arrangeTitleLabel];
    [self.arrangeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.collectionView.mas_bottom).offset(20);
    }];
    
    [self.view addSubview:self.arrangeCollectionView];
    [self.arrangeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.arrangeTitleLabel.mas_bottom).offset(10);
        make.right.left.height.equalTo(self.collectionView);
    }];
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 100) {
        return self.datas.count;
    }else {
        return self.arrangedatas.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifer forIndexPath:indexPath];
    cell.backgroundColor = RandomColor;
    
    if (collectionView.tag == 100) { // 默认
        cell.indexLabel.text = self.datas[indexPath.item];
    }else { // 排列后
        cell.indexLabel.text = self.arrangedatas[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth / 4, 60);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.tag = 100;
    
    return _collectionView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"  默认是上下左右排列";
    
    return _titleLabel;
}

- (UICollectionView *)arrangeCollectionView {
    if (_arrangeCollectionView) {
        return _arrangeCollectionView;
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth / 4, 60);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _arrangeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 120) collectionViewLayout:layout];
    _arrangeCollectionView.dataSource = self;
    _arrangeCollectionView.delegate = self;
    _arrangeCollectionView.pagingEnabled = YES;
    _arrangeCollectionView.bounces = NO;
    _arrangeCollectionView.backgroundColor = [UIColor lightGrayColor];
    _arrangeCollectionView.showsHorizontalScrollIndicator = NO;
    _arrangeCollectionView.tag = 101;
    
    return _arrangeCollectionView;
}

- (UILabel *)arrangeTitleLabel {
    if (_arrangeTitleLabel) {
        return _arrangeTitleLabel;
    }
    _arrangeTitleLabel = [[UILabel alloc] init];
    _arrangeTitleLabel.textColor = [UIColor blackColor];
    _arrangeTitleLabel.text = @"  改为左右上下排列";
    
    return _arrangeTitleLabel;
}


#pragma mark - Setter

@end
