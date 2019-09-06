//
//  XuToolBarView.h
//  微信朋友圈
//
//  Created by 许明洋 on 2019/9/6.
//  Copyright © 2019 许明洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLCustomButton.h"

NS_ASSUME_NONNULL_BEGIN

//声明协议
@protocol btnClickedDelegate <NSObject>

- (void)BtnLeftClicked;
- (void)BtnRightClicked;

@end

@interface XuToolBarView : UIView
@property (nonatomic,weak) id<btnClickedDelegate> btnDelegate;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *line1;

@property (nonatomic,strong) YSLCustomButton *buttonLeft;
@property (nonatomic,strong) YSLCustomButton *buttonRight;

@end

NS_ASSUME_NONNULL_END
