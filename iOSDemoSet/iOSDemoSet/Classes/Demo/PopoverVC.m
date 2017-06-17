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

@end

@implementation PopoverVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"弹出" style:UIBarButtonItemStylePlain target:self action:@selector(popover)];
    
}

- (void)viewWillAppear:(BOOL)animated {}
- (void)didReceiveMemoryWarning {}
- (void)dealloc {}

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
    
    self.menuVC = [[MenuVC alloc] init];
    self.menuVC.modalPresentationStyle = UIModalPresentationPopover;
    self.menuVC.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;  //rect参数是以view的左上角为坐标原点（0，0）
    self.menuVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUnknown; //箭头方向,如果是baritem不设置方向，会默认up，up的效果也是最理想的
    self.menuVC.popoverPresentationController.delegate = self;
    [self presentViewController:self.menuVC animated:YES completion:nil];
    
}

#pragma mark - Getter



#pragma mark - Setter

@end








