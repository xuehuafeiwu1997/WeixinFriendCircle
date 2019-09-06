//
//  XuCustomTableViewCell.m
//  微信朋友圈
//
//  Created by 许明洋 on 2019/9/6.
//  Copyright © 2019 许明洋. All rights reserved.
//

#import "XuCustomTableViewCell.h"
#import "SDPhotoBrowser.h"
#import "UIColor+YMHex.h"
#import "Masonry.h"
#import "UILabel+MCLabel.h"
#import "XuCustomCollectionViewCell.h"

//列数
#define item_num 3
#define pading 10

@interface XuCustomTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate,btnClickedDelegate>

@end

@implementation XuCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - 初始化布局
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //折叠效果
        self.isShowFoldBtn = YES;
        
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.nameL];
        [self.contentView addSubview:self.textContentL];
        [self.contentView addSubview:self.timeL];
        [self.contentView addSubview:self.personalLibL];
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.toolBar];
        [self.contentView addSubview:self.moreBtn];
        
        //设置各个控件在界面中的位置
        [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.contentView.mas_left);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.height.mas_equalTo(@40);
            make.width.mas_equalTo(@40);
        }];
        
        [self.timeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.height.mas_equalTo(@15);
            make.width.mas_equalTo(@120);
            
        }];
        
        [self.nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImg.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.timeL.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.height.mas_equalTo(@15);
        }];
        
        [self.personalLibL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImg.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.nameL.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(@15);
        }];
        
        [self.textContentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.iconImg.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(@1).priorityLow();//设置一个高度，以便赋值后更新
            
        }];
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            //            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.textContentL.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(@20.0);
            make.width.mas_equalTo(@40.0);
            
            
        }];
        
        //设置子视图与父视图的约束，以便子视图变化能撑起父视图
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.isShowFoldBtn == YES) {
                make.top.mas_equalTo(self.moreBtn.mas_bottom).mas_offset(10);
            } else {
                make.top.mas_equalTo(self.textContentL.mas_bottom).mas_offset(10);
            }
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            
            //设置一个高度，以赋值后更新
            make.height.mas_equalTo(@1).priorityLow();
        }];
        
        //设置子视图与父视图的约束，以便子视图变化能撑起父视图
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectionView.mas_bottom).mas_offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(@50.0);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.height.mas_equalTo(@1.0);
        }];
        
    }
    
    return self;
}

- (void)setModel:(XuCustomModel *)model {
    _model = model;
    self.iconImg.image = [UIImage imageNamed:model.iconImg];
    self.nameL.text = model.nickName;
    self.timeL.text = model.timeStr;
    self.textContentL.text = model.textContent;
    self.personalLibL.text = model.personal;
    
    //行距 字间距
    [_textContentL setColumnSpace:2.0];
    [_textContentL setRowSpace:10.0];
    //这里目前没有调用
}

- (void)reloadCell:(NSArray *)imgArr isShowMore:(BOOL)isShowMore {
    
    //更新collectionView
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    [self.collectionView setNeedsLayout];
    
    CGFloat height_padding;
    CGFloat height_collectionView;
    if (imgArr.count > 0) {
        
        height_padding = 15;
        height_collectionView = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    } else {
        height_padding = 0;
        height_collectionView = 5;
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height_collectionView));
    }];
    
    if ([self needLinesWithWidth:self.contentView.frame.size.width-20 currentLabel:_textContentL] > 3) {
        
        self.moreBtn.hidden = NO;
        
        //修改按钮的折叠打开状态
        if (isShowMore) {
            
            self.textContentL.numberOfLines = 0;
            [self.moreBtn setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            
            self.textContentL.numberOfLines = 3;
            [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        self.textContentL.numberOfLines = 0;
        self.moreBtn.hidden = YES;
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.iconImg.mas_bottom).mas_offset(10);
            
            make.height.equalTo(@(height_collectionView));
        }];
    }
}

//获取文字所需行数
- (NSInteger)needLinesWithWidth:(CGFloat)width currentLabel:(UILabel *)currentLabel {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = currentLabel.font;
    NSString *text = currentLabel.text;
    NSInteger sum = 0;
    //加上换行符
    NSArray *rowType = [text componentsSeparatedByString:@"\n"];
    for (NSString *currentText in rowType) {
        label.text = currentText;
        //获取需要的size
        CGSize textSize = [label systemLayoutSizeFittingSize:CGSizeZero];
        NSInteger lines = ceil(textSize.width/width);
        lines = lines == 0 ? 1 : lines;
        sum += lines;
    }
    return sum;
}

#pragma mark - 懒加载初始化各个控件
//头像
- (UIImageView *)iconImg {
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] init];
        _iconImg.backgroundColor = [UIColor whiteColor];
        _iconImg.clipsToBounds = YES;
        _iconImg.contentMode = UIViewContentModeScaleAspectFill;
        _iconImg.layer.cornerRadius = 20;
        
        //开启手势交互事件
        _iconImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapClick)];
        [_iconImg addGestureRecognizer:tap];
    }
    return _iconImg;
}

//昵称
- (UILabel *)nameL {
    if (!_nameL) {
        _nameL = [[UILabel alloc] init];
        _nameL.font = [UIFont systemFontOfSize:15];
        _nameL.backgroundColor = [UIColor whiteColor];
    }
    return _nameL;
}

//知名博主
- (UILabel *)personalLibL {
    if (_personalLibL) {
        _personalLibL = [[UILabel alloc] init];
        _personalLibL.font = [UIFont systemFontOfSize:13];
        _personalLibL.backgroundColor = [UIColor whiteColor];
        _personalLibL.textColor = [UIColor lightGrayColor];
    }
    return _personalLibL;
}

//评论的发表的时间
- (UILabel *)timeL {
    if (!_timeL) {
        _timeL = [[UILabel alloc] init];
        _timeL.font = [UIFont systemFontOfSize:13];
        _timeL.backgroundColor = [UIColor whiteColor];
        _timeL.textColor = [UIColor lightGrayColor];
        _timeL.textAlignment = NSTextAlignmentRight;
        _timeL.adjustsFontSizeToFitWidth = YES;
    }
    return _timeL;
}

//评论文本内容
- (UILabel *)textContentL {
    if (!_textContentL) {
        _textContentL = [[UILabel alloc] init];
        _textContentL.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightLight)];
        _textContentL.backgroundColor = [UIColor whiteColor];
        //表示对文本的行数不限制
        _textContentL.numberOfLines = 0;
    }
    return _textContentL;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XuCustomCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    }
    return _collectionView;
}

- (XuToolBarView *)toolBar {
    
    if (!_toolBar) {
        _toolBar = [[XuToolBarView alloc] init];
        _toolBar.backgroundColor = [UIColor whiteColor];
        _toolBar.btnDelegate = self;
    }
    return _toolBar;
}

//全文/收起的按钮
- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:(UIFontWeightLight)];
        _moreBtn.backgroundColor = [UIColor whiteColor];
        [_moreBtn setTitleColor:[UIColor colorWithHexString:@"#1296db"] forState:(UIControlStateNormal)];
        [_moreBtn addTarget:self action:@selector(foldNewOrNoTap:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _moreBtn;
}

//头像点击
- (void)headerTapClick {
    NSString *idStr = _model.idStr;
    NSLog(@"------头像的序号为：%@",idStr);
}

//点击展开/收起全文
- (void)foldNewOrNoTap:(UIButton *)recognizer {
    
    if (self.cellDelegate && [self.cellDelegate respondsToSelector:@selector(clickFoldLabel:)]) {
        [self.cellDelegate clickFoldLabel:self];
    }
}

#pragma mark - UICollectionViewDelegate/UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.imageArr.count;
}
////这是错误的地方,UIColletionView 协议的方法搞错，这是设置有多少组，应该设置有多少个方块
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//
//    NSLog(@"图片的数量有多少组:%lu",(unsigned long)self.model.imageArr.count);
//    return self.model.imageArr.count;
//}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XuCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    NSArray *tagArr = self.model.imageArr;
    cell.img.image = [UIImage imageNamed:tagArr[indexPath.row]];
    
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(pading, pading, pading, pading);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat item_height = ([UIScreen mainScreen].bounds.size.width-((item_num+1)*pading))/item_num;
    CGSize size = CGSizeMake(item_height,item_height);
    return size;
}

//这个是两行cell之间的最小间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}


//两个cell之间的最小间距间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SDPhotoBrowser *broser = [[SDPhotoBrowser alloc] init];
    broser.currentImageIndex = indexPath.row;
    broser.sourceImagesContainerView = self.collectionView;
    NSArray *tagArrs = _model.imageArr;
    broser.imageCount = tagArrs.count;
    broser.delegate = self;
    [broser show];
}

//网址的image
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    //网络图片（如果崩溃，可能是此图片地址不存在了）
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *str in _model.imageArr) {
        [arr addObject:str];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", arr[index]]];
    
    return url;
}

//占位图
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    UIImage *image = [UIImage imageNamed:@"zhanweitu"];
    return image;
}

//底部按钮点击代理
- (void)BtnLeftClicked {
    NSLog(@"点到我了---%@",_model.idStr);
}

- (void)BtnRightClicked {
    NSLog(@"又点到我了---%@",_model.idStr);
    
}
@end
