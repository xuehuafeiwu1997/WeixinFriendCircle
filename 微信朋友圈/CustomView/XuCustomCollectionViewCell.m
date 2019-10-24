//
//  XuCustomCollectionViewCell.m
//  微信朋友圈
//
//  Created by 许明洋 on 2019/9/6.
//  Copyright © 2019 许明洋. All rights reserved.
//

#import "XuCustomCollectionViewCell.h"

@implementation XuCustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _img = [[UIImageView alloc] init];
        [self.contentView addSubview:_img];
        _img.contentMode = UIViewContentModeScaleAspectFill;
        //将图片超出部分裁剪
        _img.clipsToBounds = YES;
        _img.layer.cornerRadius = 5.0;
    }
    return self;
}

//这个方法什么时候调用
- (void)layoutSubviews {
    [super layoutSubviews];
    _img.frame = self.contentView.frame;
    //NSLog(@"UICollectionViewCell的大小为：%@",self.contentView.frame);
}

@end
