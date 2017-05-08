//
//  ViewController.m
//  HSUpdateAppDemo
//
//  Created by 侯帅 on 2017/5/8.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "ViewController.h"
#import "HSUpdateApp.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加一个监测更新的按钮
    UIButton *btn = [UIButton buttonWithType:0];
    [btn setTitle:@"继续监测" forState:0];
    [btn sizeToFit];
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(hsUpdateApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //一句代码实现检测更新,很简单哦 （需要在viewDidAppear完成时，再调用改方法。不然在网速飞快的时候，会出现一个bug，就是当前控制器viewDidLoad调用的话，可能当前视图还没加载完毕就需要推出UIAlertAction）
    [self hsUpdateApp];
}

-(void)hsUpdateApp{
    __weak __typeof(&*self)weakSelf = self;
    [HSUpdateApp hs_updateWithAPPID:@"1104867082" block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
        if (isUpdate == YES) {
            [weakSelf showStoreVersion:storeVersion openUrl:openUrl];
        }
    }];
}
    
    
    
    
-(void)showStoreVersion:(NSString *)storeVersion openUrl:(NSString *)openUrl{
    UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",storeVersion] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:openUrl];
        [[UIApplication sharedApplication] openURL:url];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alercConteoller addAction:actionYes];
    [alercConteoller addAction:actionNo];
    [self presentViewController:alercConteoller animated:YES completion:nil];
}
@end
