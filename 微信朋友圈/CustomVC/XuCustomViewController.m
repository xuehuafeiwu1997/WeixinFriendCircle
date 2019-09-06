//
//  XuCustomViewController.m
//  微信朋友圈
//
//  Created by 许明洋 on 2019/9/6.
//  Copyright © 2019 许明洋. All rights reserved.
//

#import "XuCustomViewController.h"
#import "UIColor+YMHex.h"
#import "Masonry.h"
#import "XuCustomModel.h"
#import "XuCustomTableViewCell.h"

@interface XuCustomViewController ()<UITableViewDelegate,UITableViewDataSource,XuCustomTableViewCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation XuCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    //获取数据
    [self getData];
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"--------000---------%f",self.tableView.frame.size.height);
}

#pragma mark - dataSource懒加载
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

//给模型赋值
- (void)getData {
    for (int i = 0; i < 10; i++) {
        XuCustomModel *model = [[XuCustomModel alloc] init];
        model.idStr = [NSString stringWithFormat:@"%d",i];
        model.iconImg = @"zhanweitu";
        model.nickName = @"我是昵称";
        model.timeStr = @"2019-09-08";
        model.personal = @"知名博主";
        model.textContent = @"我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我222";
        model.imageArr = @[@"zhanweitu",@"zhanweitu",@"zhanwietu",@"zhanweitu",@"zhanweitu"];
        if (i == 0) {
            model.textContent = @"";
        }
        if (i == 1) {
            model.textContent = @"我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我是内容我2223333333333339999999999999dadadadadwaudbwabdwadwbadbwauduadowadubwaubdbwadwabdaw";
        }
        [self.dataSource addObject:model];
    }
}

#pragma mark - 懒加载tableView
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        //高度自适应
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}

#pragma mark - delegate/dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu",(unsigned long)self.dataSource.count);
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //和以前的创建cell的写法不同，这算是第二种写法(不用注册)
    static NSString *CellIdentifier = @"Cell";
    
    XuCustomTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[XuCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = NO;
    XuCustomModel *model = self.dataSource[indexPath.row];
    cell.cellDelegate = self;
    cell.model = model;
    
    return cell;
}

- (void)clickFoldLabel:(nonnull XuCustomTableViewCell *)cell {
    
    /**
     根据传入的cell对象得到cell的索引值，使用indexPathForCell
     */
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    XuCustomModel *model = self.dataSource[indexPath.row];
    model.isShowMore = !model.isShowMore;
    [UIView setAnimationsEnabled:NO];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    [UIView setAnimationsEnabled:YES];
}


@end
