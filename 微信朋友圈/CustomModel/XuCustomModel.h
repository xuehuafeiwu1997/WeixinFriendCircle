//
//  XuCustomModel.h
//  微信朋友圈
//
//  Created by 许明洋 on 2019/9/6.
//  Copyright © 2019 许明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XuCustomModel : NSObject

//头像
@property (nonatomic,copy) NSString *iconImg;
//昵称
@property (nonatomic,copy) NSString *nickName;
//时间
@property (nonatomic,copy) NSString *timeStr;
//个人等级或星级
@property (nonatomic,copy) NSString *personal;
//文字内容
@property (nonatomic,copy) NSString *textContent;
//图片(图片不止有一张，所以要用数组)
@property (nonatomic,strong) NSArray *imageArr;
//id
@property (nonatomic,copy) NSString *idStr;
@property (nonatomic,assign) BOOL isShowMore;

@end

NS_ASSUME_NONNULL_END
