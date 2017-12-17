//
//  DataManager.h
//  WangYi_News
//
//  Created by JACK on 2017/12/8.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVOrderModel.h"
typedef void(^requestSuccess) (TVOrderModel *model);
typedef void(^requestFailure) ();
@interface DataManager : NSObject
@property(nonatomic,strong) TVOrderModel *orderModel;
//请求方法
- (void)getData:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock channelName:(NSString *)channelName maxResult:(NSString *)maxResult;
@end
