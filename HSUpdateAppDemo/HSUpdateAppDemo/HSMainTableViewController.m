//
//  HSMainTableViewController.m
//  HSUpdateAppDemo
//
//  Created by 侯帅 on 2017/10/24.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "HSMainTableViewController.h"
#import "HSUpdateApp.h"
@interface HSMainTableViewController ()

@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong)NSMutableArray *arrayCellHeight;

@end

@implementation HSMainTableViewController

-(UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.center = self.view.center;
        [self.view addSubview:_indicatorView];
    }
    return _indicatorView;
}

-(NSMutableArray *)arrayCellHeight{
    if (!_arrayCellHeight) {
        _arrayCellHeight = [NSMutableArray array];
    }
    return _arrayCellHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HSUpDateApp";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"HSUpdateApp"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.arrayCellHeight[indexPath.section] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.numberOfLines = 0;
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"测试APPID:1104867082";
        cell.detailTextLabel.text = @"[HSUpdateApp hs_updateWithAPPID:@\"1104867082\" withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {\n}];";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"测试BundleId:com.houshuai.tgheight";
        cell.detailTextLabel.text = @"[HSUpdateApp hs_updateWithAPPID:nil withBundleId:@\"com.houshuai.tghealth\" block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {\n}];";
    }else{
        cell.textLabel.text = @"什么参数都不传，自动检测";
        cell.detailTextLabel.text = @"[HSUpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {\n}];";
    }
    [cell layoutIfNeeded];
    [self.arrayCellHeight addObject:@(CGRectGetHeight(cell.detailTextLabel.frame) + CGRectGetHeight(cell.textLabel.frame))];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"根据APPID检测";
    }else if (section == 1){
        return @"根据项目Bundle Identifier检测";
    }else{
        return @"自动检测";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.indicatorView startAnimating];
    if (indexPath.section == 0) {
        //=================根据appid检测====================
        [HSUpdateApp hs_updateWithAPPID:@"1104867082" withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
            if (isUpdate) {
                [self showAlertViewTitle:@"APPID检测" subTitle:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openUrl];
            }else{
                NSLog(@"当前版本%@,商店版本%@，不需要更新",currentVersion,storeVersion);
            }
            [self.indicatorView stopAnimating];
            
        }];
    }else if (indexPath.section == 1){
        //=================根据BundleId检测====================
        [HSUpdateApp hs_updateWithAPPID:nil withBundleId:@"com.houshuai.tghealth" block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
            if (isUpdate) {
                [self showAlertViewTitle:@"BundleId检测" subTitle:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openUrl];
            }else{
                NSLog(@"当前版本%@,商店版本%@，不需要更新",currentVersion,storeVersion);
            }
            
            [self.indicatorView stopAnimating];
        }];
    }else{
        //=================自动检测====================
        [HSUpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
            if (isUpdate) {
                [self showAlertViewTitle:@"自动检测" subTitle:[NSString stringWithFormat:@"检测到新版本%@,是否更新？",storeVersion] openUrl:openUrl];
            }else{
                NSLog(@"当前版本%@,商店版本%@，不需要更新",currentVersion,storeVersion);
            }
            
            [self.indicatorView stopAnimating];
        }];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)showAlertViewTitle:(NSString *)title subTitle:(NSString *)subTitle openUrl:(NSString *)openUrl{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:subTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0){
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            } else {
                BOOL success = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
                NSLog(@"Open  %d",success);
            }
            
        } else{
            bool can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:openUrl]];
            if(can){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
            }
        }
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
}



@end
