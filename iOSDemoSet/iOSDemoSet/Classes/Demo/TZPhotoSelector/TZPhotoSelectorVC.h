//
//  TZPhotoSelectorVC.h
//  TZImagePickerController
//
//  Created by huangjunhuang on 2019/5/29.
//  Copyright © 2019 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TZPhotoSelectorVC : UIViewController {
//    NSMutableArray *_selectedPhotos;
//    NSMutableArray *_selectedAssets;
//    BOOL _isSelectOriginalPhoto;
    
//    CGFloat _itemWH;
//    CGFloat _margin;
}

@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
/// 设置itemWH，itemCount将不生效
@property (nonatomic, assign) CGFloat itemWH;
/// item 几列
@property (nonatomic, assign) NSInteger itemColumnCount;
@property (nonatomic, assign) CGFloat margin;

// 设置开关
@property (nonatomic, assign) BOOL showTakePhotoBtnSwitch;///< 允许拍照
@property (nonatomic, assign) BOOL showTakeVideoBtnSwitch;  ///< 允许拍视频
@property (nonatomic, assign) BOOL sortAscendingSwitch;     ///< 照片排列按修改时间升序
@property (nonatomic, assign) BOOL allowPickingVideoSwitch; ///< 允许选择视频
@property (nonatomic, assign) BOOL allowPickingImageSwitch; ///< 允许选择图片
@property (nonatomic, assign) BOOL allowPickingGifSwitch;
@property (nonatomic, assign) BOOL allowPickingOriginalPhotoSwitch; ///< 允许选择原图
@property (nonatomic, assign) BOOL showSheetSwitch; ///< 显示一个sheet,把拍照/拍视频按钮放在外面
@property (nonatomic, assign) NSInteger maxCountTF;  ///< 照片最大可选张数，设置为1即为单选模式
@property (nonatomic, assign) NSInteger columnNumberTF; /// 每行展示照片张数
@property (nonatomic, assign) BOOL allowCropSwitch; /// 单选模式下允许裁剪
@property (nonatomic, assign) BOOL needCircleCropSwitch; /// 使用圆形裁剪框
@property (nonatomic, assign) BOOL allowPickingMuitlpleVideoSwitch; /// 允许多选视频/GIF/图片
@property (nonatomic, assign) BOOL showSelectedIndexSwitch; /// 右上角显示图片选中序号

@end

NS_ASSUME_NONNULL_END
