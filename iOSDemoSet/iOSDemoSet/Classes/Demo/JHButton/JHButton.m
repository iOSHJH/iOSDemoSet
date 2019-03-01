//
//  JHButton.m
//  AlarmChaser
//
//  Created by huangjunhuang on 2019/3/1.
//  Copyright © 2019 tongari. All rights reserved.
//

#import "JHButton.h"

@interface JHButton()

@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) TitleTextType titleTextType;

@end

@implementation JHButton

- (instancetype)initWithFrame:(CGRect)frame imageSize:(CGSize)imageSize space:(CGFloat)space titleTextType:(TitleTextType)titleTextType {
    self = [super initWithFrame:frame];
    
    self.imageSize = imageSize;
    self.space = space;
    self.titleTextType = titleTextType;
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    if (self.titleTextType == TopImage_BottomText) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat textH = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size.height;
        CGFloat margin = (self.frame.size.height-self.imageSize.height-self.space-textH)/2;
        self.imageView.frame = CGRectMake((self.frame.size.width-self.imageSize.width)/2, margin, self.imageSize.width, self.imageSize.height);
        self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+self.space, self.frame.size.width, textH);
    }
    
    if (self.titleTextType == TopText_BottomImage) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat textH = [self.titleLabel.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size.height;
        CGFloat margin = (self.frame.size.height-self.imageSize.height-self.space-textH)/2;
        self.titleLabel.frame = CGRectMake(0, margin, self.frame.size.width, textH);
        self.imageView.frame = CGRectMake((self.frame.size.width-self.imageSize.width)/2, CGRectGetMaxY(self.titleLabel.frame)+self.space, self.imageSize.width, self.imageSize.height);
    }
    
    if (self.titleTextType == LeftImage_RightText) {
        CGFloat textW = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size.width;
        CGFloat margin = (self.frame.size.width-self.imageSize.width-self.space-textW)/2;
        self.imageView.frame = CGRectMake(margin, (self.frame.size.height-self.imageSize.height)/2, self.imageSize.width, self.imageSize.height);
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+self.space, 0, textW, self.frame.size.height);
    }
    
    if (self.titleTextType == LeftText_RightImage) {
        CGFloat textW = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleLabel.font} context:nil].size.width;
        CGFloat margin = (self.frame.size.width-self.imageSize.width-self.space-textW)/2;
        self.titleLabel.frame = CGRectMake(margin, 0, textW, self.frame.size.height);
        self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+self.space, (self.frame.size.height-self.imageSize.height)/2, self.imageSize.width, self.imageSize.height);
    }
}


@end
