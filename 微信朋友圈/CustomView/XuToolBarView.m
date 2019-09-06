//
//  XuToolBarView.m
//  微信朋友圈
//
//  Created by 许明洋 on 2019/9/6.
//  Copyright © 2019 许明洋. All rights reserved.
//

#import "XuToolBarView.h"
#import "UIColor+YMHex.h"

@implementation XuToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    //先调用父类的initWithFrame方法
    if (self = [super initWithFrame:frame]) {
        
        //再定义该类（UIView子类）的初始化操作
        [self setUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //获取到约束后的控件frame
    self.line.frame = CGRectMake(0, 0, self.frame.size.width, 1.0);
    
    self.buttonLeft.frame = CGRectMake(0, 1.0, (self.frame.size.width - 1.0)/2.0, self.frame.size.height);
    
    self.line1.frame = CGRectMake(self.buttonLeft.frame.size.width + self.buttonLeft.frame.origin.x, 7.5, 1.0, self.frame.size.height - 15);
    
    self.buttonRight.frame = CGRectMake(self.line1.frame.size.width+self.line1.frame.origin.x, 1.0, self.buttonLeft.frame.size.width, self.frame.size.height);
}

- (void)setUI {
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:_line];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:_line1];
    
    _buttonLeft = [YSLCustomButton buttonWithType:UIButtonTypeCustom];
    _buttonLeft.backgroundColor = [UIColor whiteColor];
    [_buttonLeft addTarget:self action:@selector(buttonLeftClick) forControlEvents:UIControlEventTouchUpInside];
    _buttonLeft.titleLabel.font = [UIFont systemFontOfSize:14];
    [_buttonLeft setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_buttonLeft setTitle:@"第一个按钮" forState:(UIControlStateNormal)];
    [_buttonLeft setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    _buttonLeft.ysl_spacing = 2.0;
    _buttonLeft.ysl_buttonType = YSLCustomButtonImageLeft;
    [self addSubview:_buttonLeft];
    
    _buttonRight = [YSLCustomButton buttonWithType:UIButtonTypeCustom];
    _buttonRight.backgroundColor = [UIColor whiteColor];
    [_buttonRight addTarget:self action:@selector(buttonRightClick) forControlEvents:UIControlEventTouchUpInside];
    _buttonRight.titleLabel.font = [UIFont systemFontOfSize:14];
    [_buttonRight setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_buttonRight setTitle:@"第二个按钮" forState:(UIControlStateNormal)];
    [_buttonRight setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    _buttonRight.ysl_spacing = 2.0;
    _buttonRight.ysl_buttonType = YSLCustomButtonImageLeft;
    [self addSubview:_buttonRight];
}

//左侧按钮点击
- (void)buttonLeftClick {
    [self.btnDelegate BtnLeftClicked];
}

//右侧按钮点击
- (void)buttonRightClick {
    [self.btnDelegate BtnRightClicked];
}

@end
