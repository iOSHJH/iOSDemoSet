//
//  CollectionViewCell.m
//  iOSDemoSet
//
//  Created by 黄俊煌 on 2017/6/19.
//  Copyright © 2017年 yunshi. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()



@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.indexLabel];
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}


- (UILabel *)indexLabel {
    if (_indexLabel) {
        return _indexLabel;
    }
    _indexLabel = [[UILabel alloc] init];
    
    return _indexLabel;
}

@end
