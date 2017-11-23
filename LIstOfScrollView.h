//
//  LIstOfScrollView.h
//  WangYi_News
//
//  Created by JACK on 2017/11/20.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVOrderModel.h"

@interface LIstOfScrollView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) TVOrderModel *orderModel;
@property(nonatomic,strong) NSDictionary *dataPara;
@end
