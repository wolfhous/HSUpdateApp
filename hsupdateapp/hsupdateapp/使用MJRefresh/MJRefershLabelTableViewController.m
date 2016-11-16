//
//  MJRefershLabelTableViewController.m
//  hsupdateapp
//
//  Created by 壹号商圈 on 16/11/16.
//  Copyright © 2016年 houshuai. All rights reserved.
//  正确用法（无动画）

#import "MJRefershLabelTableViewController.h"
#import "HSRefModel.h"
#import "HSNormalHeader.h"
@interface MJRefershLabelTableViewController ()
@property (nonatomic,strong)NSMutableArray<HSRefModel *> *arrayM;
@end

@implementation MJRefershLabelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"basicCell"];
    self.tableView.tableFooterView = [UIView new];
    
    //============正确用法============
    self.tableView.mj_header = [HSNormalHeader headerWithRefreshingBlock:^{
        [self beginRef];
    }];
    //============正确用法============
}
-(void)beginRef{
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
