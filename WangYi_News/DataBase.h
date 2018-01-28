//
//  DataBase.h
//  WangYi_News
//
//  Created by JACK on 2017/12/21.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TVOrderModel.h"


@interface DataBase : NSObject

@property (strong, nonatomic) NSMutableArray<TVcontentlistModel,Optional> *contentlistAll;
+ (instancetype)sharedDataBase;
#pragma mark - News
/*
 *添加News
 *
 */
- (void)addNews:(TVOrderModel *)orderModel;
/*
 *更新News
 *
 */
- (void)updateNews:(TVOrderModel *)orderModel;
/*
 *获取全部
 *
 */
- (NSMutableArray *)getAllPerson;

@end
