//
//  MJRefreshMistakeTableViewController.m
//  hsupdateapp
//
//  Created by 壹号商圈 on 16/11/16.
//  Copyright © 2016年 houshuai. All rights reserved.
//  错误用法

#import "MJRefreshMistakeTableViewController.h"
#import "HSRefModel.h"
#import "MJRefresh.h"
@interface MJRefreshMistakeTableViewController ()
@property (nonatomic,strong)NSMutableArray<HSRefModel *> *arrayM;
@end

@implementation MJRefreshMistakeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"basicCell"];
    self.tableView.tableFooterView = [UIView new];
    
    //开始错误用法1
//    [self mistake1];
    //开始错误用法2
    [self mistake2];
    
}

-(void)mistake1{
    //一下两种方法是同样的效果
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self brginRef];
    }];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(brginRef)];
}
-(void)mistake2{
    MJRefreshNormalHeader *customRef =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self brginRef];
    }];
    [customRef setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
    [customRef setTitle:@"松开就可以进行刷新的状态" forState:MJRefreshStatePulling];
    [customRef setTitle:@"正在刷新中的状态" forState:MJRefreshStateRefreshing];
    [customRef setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
    [customRef setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    
    self.tableView.mj_header = customRef;
    
    //一些其他属性设置
    /*
    // 设置字体
    customRef.stateLabel.font = [UIFont systemFontOfSize:15];
    customRef.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    customRef.stateLabel.textColor = [UIColor redColor];
    customRef.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    // 隐藏时间
    customRef.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    customRef.stateLabel.hidden = YES;
     // 设置自动切换透明度(在导航栏下面自动隐藏)
     customRef.automaticallyChangeAlpha = YES;
     */
}




-(void)brginRef{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 5; i ++) {
            [self.arrayM addObject:[[HSRefModel alloc]init]];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
    
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.arrayM[indexPath.row].title;
    
    return cell;
}

-(NSMutableArray *)arrayM{
    if (!_arrayM) {
        _arrayM = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i ++) {
            [_arrayM addObject:[[HSRefModel alloc]init]];
        }
    }
    return _arrayM;
}


@end
