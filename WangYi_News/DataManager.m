//
//  DataManager.m
//  WangYi_News
//
//  Created by JACK on 2017/12/8.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "DataManager.h"
#import <AFNetworking.h>

@implementation DataManager
- (void)getData:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock channelName:(NSString *)channelName maxResult:(NSString *)maxResult{
    NSString *urlString = @"http://route.showapi.com/109-35";
    NSDictionary *paraDictionary =  [NSDictionary dictionaryWithObjectsAndKeys:@"49852",@"showapi_appid",@"81497a5a58de4543afdbb9aa42d32f2c",@"showapi_sign",@"1",@"needHtml",@"1", @"page",channelName, @"channelName",maxResult,@"maxResult",nil];

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer= [AFHTTPRequestSerializer serializer];
    [manger GET:urlString parameters:paraDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _orderModel = [[TVOrderModel alloc] initWithDictionary:responseObject error:nil];

        sucessBlock(_orderModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSNotification *notification =[NSNotification notificationWithName:@"AFNetWorkingRequestError" object:nil userInfo:nil];
        // 通过 通知中心 发送 通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        failureBlock();
    }];

}
@end
