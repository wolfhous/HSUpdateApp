//
//  HSUpdateApp.h
//  HSUpdateAppDemo
//
//  Created by 侯帅 on 2017/5/8.
//  Copyright © 2017年 com.houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSUpdateApp : NSObject

/**
 检测程序更新

 @param appid  来自程序id
 @param block block回调
 */
+(void)hs_updateWithAPPID:(NSString *)appid block:(void(^)(NSString *currentVersion,NSString *storeVersion, NSString *openUrl,BOOL isUpdate))block;
    

@end
