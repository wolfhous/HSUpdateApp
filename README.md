
![](http://upload-images.jianshu.io/upload_images/2923333-9ea6356bfcee6c4b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

***
基于天朝的AppStore检测自动更新功能，现已适配iOS11

最好在真机上运行才能看到完全效果哦





![](http://upload-images.jianshu.io/upload_images/2923333-8e18020d930c9d04.gif?imageMogr2/auto-orient/strip)




***
实现思路

1.本地检测项目版本号；

2.联网检测项目在AppStore上的版本号；

3.比较版本号，可选提供跳转到手机自带的AppStore项目页面供用户下载的地址；
***
文件小巧，轻便：

![只有一个.h和.m文件.png](http://upload-images.jianshu.io/upload_images/2923333-3a2c1de010ebd857.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

支持cocoapods：

```
pod 'HSUpdateApp'
```

具体用法：


```
#import "HSUpdateApp.h"
```

```
/**
   一行代码实现检测app是否为最新版本。appId，bundelId，随便传一个 或者都传nil 即可实现检测。

  @param currentVersion 返回当前版本号
  @param storeVersion 返回商店版本号
  @param openUrl 跳转到商店下载的链接
  @param isUpdate 是否需要更新
  @return 
*/
 [HSUpdateApp hs_updateWithAPPID:nil withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *openUrl, BOOL isUpdate) {
  }];
```


***
问题1：这样审核能通过？

答1：亲测能通过，没问题的。
***
问题2：我项目APP ID 在哪里看？

答2：[itunes connect](https://itunesconnect.apple.com/) 》我的APP》APP ID
***
问题3：假如我的项目还没上线，也没有APP ID 怎么搞？

--直接利用自动检测，appId和bundelId都传nil即可。

--或者去 [itunes connect](https://itunesconnect.apple.com/)  申请一个APP，就会有对应的APP ID。

--如果你连开发者账号都没有，那就先用demo里面的APP ID 测试吧，上线的时候改过来即可。

***
简书介绍：[http://www.jianshu.com/p/1d08c786b52f](http://www.jianshu.com/p/1d08c786b52f)

✨欢迎star✨
***

