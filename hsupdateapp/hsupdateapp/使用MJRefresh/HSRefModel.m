//
//  HSRefModel.m
//  hsupdateapp
//
//  Created by 壹号商圈 on 16/11/16.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSRefModel.h"

@implementation HSRefModel
-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = [NSString stringWithFormat:@"随机数据%u",arc4random()/1000];
    }
    return self;
}
@end
