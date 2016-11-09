# HSUpdateApp
基于天朝的AppStore检测自动更新功能，适配iOS10

####[1]一定要先配置自己项目在商店的APPID,配置完最好在真机上运行才能看到完全效果哦

```
define STOREAPPID @"**********"
```
####[2]一句代码实现检测更新


```
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //一句代码实现检测更新
    [self hsUpdateApp];
}
```
***
好用给个star,让更多人知道

![image](https://github.com/wolfhous/HSUpdateApp/blob/master/hsupdateapp/hsupdateapp/2016-11-09 09.50.59.gif)
***
简书介绍：[http://www.jianshu.com/p/1d08c786b52f](http://www.jianshu.com/p/1d08c786b52f)
***

