//
//  HSUpdateApp.m
//  HSUpdateAppDemo
//
//  Created by 侯帅 on 2017/5/8.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import "HSUpdateApp.h"
@implementation HSUpdateApp

+(void)hs_updateWithAPPID:(NSString *)appId withBundleId:(NSString *)bundelId block:(UpdateBlock)block{
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    __block NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    NSURLRequest *request;
    if (appId != nil) {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",appId]]];
        NSLog(@"【1】当前为APPID检测，您设置的APPID为:%@  当前版本号为:%@",appId,currentVersion);
    }else if (bundelId != nil){
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@&country=cn",bundelId]]];
        NSLog(@"【1】当前为BundelId检测，您设置的bundelId为:%@  当前版本号为:%@",bundelId,currentVersion);
    }else{
        NSString *currentBundelId=infoDic[@"CFBundleIdentifier"];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@&country=cn",currentBundelId]]];
        NSLog(@"【1】当前为自动检测检测,  当前版本号为:%@",currentVersion);
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSLog(@"【2】开始检测...");
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"【3】检测失败，原因：\n%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                block(currentVersion,@"",@"",NO);
            });
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([appInfoDic[@"resultCount"] integerValue] == 0) {
                NSLog(@"检测出未上架的APP或者查询不到");
                block(currentVersion,@"",@"",NO);
                return;
            }
            NSLog(@"【3】苹果服务器返回的检测结果：\n appId = %@ \n bundleId = %@ \n 开发账号名字 = %@ \n 商店版本号 = %@ \n 应用名称 = %@ \n 打开连接 = %@",appInfoDic[@"results"][0][@"artistId"],appInfoDic[@"results"][0][@"bundleId"],appInfoDic[@"results"][0][@"artistName"],appInfoDic[@"results"][0][@"version"],appInfoDic[@"results"][0][@"trackName"],appInfoDic[@"results"][0][@"trackViewUrl"]);
            NSString *appStoreVersion = appInfoDic[@"results"][0][@"version"];
            currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            if (currentVersion.length==2) {
                currentVersion  = [currentVersion stringByAppendingString:@"0"];
            }else if (currentVersion.length==1){
                currentVersion  = [currentVersion stringByAppendingString:@"00"];
            }
            appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            if (appStoreVersion.length==2) {
                appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
            }else if (appStoreVersion.length==1){
                appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
            }
            if([currentVersion floatValue] < [appStoreVersion floatValue])
            {
                NSLog(@"【4】判断结果：当前版本号%@ < 商店版本号%@ 需要更新\n=========我是分割线========",[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"],appInfoDic[@"results"][0][@"version"]);
                block(currentVersion,appInfoDic[@"results"][0][@"version"],appInfoDic[@"results"][0][@"trackViewUrl"],YES);
            }else{
                NSLog(@"【4】判断结果：当前版本号%@ > 商店版本号%@ 不需要更新\n========我是分割线========",[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"],appInfoDic[@"results"][0][@"version"]);
                block(currentVersion,appInfoDic[@"results"][0][@"version"],appInfoDic[@"results"][0][@"trackViewUrl"],NO);
            }
        });
    }];
    [task resume];
}

@end
