//
//  PopoverVC.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/18.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "PopoverVC.h"
#import "MenuVC.h"

@interface PopoverVC ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) MenuVC *menuVC;

@property (nonatomic, strong) UIButton *button;

@end

@implementation PopoverVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"弹出" style:UIBarButtonItemStylePlain target:self action:@selector(popover)];
    
    [self.view addSubview:self.button];
    
}

- (void)viewWillAppear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}
- (void)dealloc {

}

#pragma mark - Public Methods


#pragma mark - UIPopoverPresentationControllerDelegate

/** 弹出*/
- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {

}

/** 点击其他地方 是否关闭*/
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    return YES;
}

/** 关闭完成*/
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {

}

/** <#Description#>*/
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView  * __nonnull * __nonnull)view {

}

#pragma mark - UIAdaptivePresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

#pragma mark - Private Methods

- (void)popover {
    self.menuVC.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;  //rect参数是以view的左上角为坐标原点（0，0）
    self.menuVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUnknown; //箭头方向 默认up
    [self presentViewController:self.menuVC animated:YES completion:nil];
}

- (void)buttonClick {
    self.menuVC.popoverPresentationController.sourceView = self.button;  //rect参数是以view的左上角为坐标原点（0，0）
    self.menuVC.popoverPresentationController.sourceRect = self.button.bounds; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    self.menuVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp; //箭头方向

    [self presentViewController:self.menuVC animated:YES completion:nil];
}

#pragma mark - Getter

- (MenuVC *)menuVC {
    if (_menuVC) {
        return _menuVC;
    }
    _menuVC = [[MenuVC alloc] init];
    _menuVC.modalPresentationStyle = UIModalPresentationPopover;
    _menuVC.popoverPresentationController.delegate = self;
    WeakSelf;
    _menuVC.didSelectRowAtIndexPathBlock = ^(NSIndexPath *indexPath) {
        switch (indexPath.row) {
            case 0:
                weakSelf.view.backgroundColor = [UIColor greenColor];
                break;
            case 1:
                weakSelf.view.backgroundColor = [UIColor grayColor];
                break;
            case 2:
                weakSelf.view.backgroundColor = [UIColor blueColor];
                break;
            case 3:
                weakSelf.view.backgroundColor = [UIColor purpleColor];
                break;
            case 4:
                weakSelf.view.backgroundColor = [UIColor yellowColor];
                break;
        }
    };
    
    return _menuVC;
}

- (UIButton *)button {
    if (_button) {
        return _button;
    }
    _button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 30)];
    [_button setBackgroundColor:[UIColor redColor]];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return _button;
}



#pragma mark - Setter

@end








