# HSUpdateApp
基于天朝的AppStore检测自动更新功能，适配iOS10

最好在真机上运行才能看到完全效果哦

支持cocoapods
```
pod ‘HSUpdateApp’
```

一句代码实现检测更新
```
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //一句代码实现检测更新
    [HSUpdateApp hs_updateWithAPPID:@"1104867082" block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {

    }];
}
```
***
好用给个star,让更多人知道

***
简书介绍：[http://www.jianshu.com/p/1d08c786b52f](http://www.jianshu.com/p/1d08c786b52f)
***

