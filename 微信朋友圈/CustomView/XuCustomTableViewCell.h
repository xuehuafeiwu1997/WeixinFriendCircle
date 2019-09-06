//
//  XuCustomTableViewCell.h
//  微信朋友圈
//
//  Created by 许明洋 on 2019/9/6.
//  Copyright © 2019 许明洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XuToolBarView.h"
#import "XuCustomModel.h"

NS_ASSUME_NONNULL_BEGIN

@class XuCustomTableViewCell;

@protocol XuCustomTableViewCellDelegate <NSObject>

/**
 *折叠按钮的点击处理
 *@param cell 按钮所属cell
 */
- (void)clickFoldLabel:(XuCustomTableViewCell *)cell;

@end

@interface XuCustomTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UILabel *nameL;
@property (nonatomic,strong) UILabel *textContentL;
@property (nonatomic,strong) UILabel *timeL;
@property (nonatomic,strong) UILabel *personalLibL;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *moreBtn;
@property (nonatomic,weak) id<XuCustomTableViewCellDelegate> cellDelegate;

//底部工具栏
@property (nonatomic,strong) XuToolBarView *toolBar;
@property (nonatomic,strong) XuCustomModel *model;

//表示是否需要收起全文
@property (nonatomic,assign) BOOL isShowFoldBtn;

@end

NS_ASSUME_NONNULL_END
