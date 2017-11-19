//
//  ShouYeViewController.h
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouYeView.h"
#import "TVOrderModel.h"

@interface ShouYeViewController : UIViewController
@property(nonatomic,strong)ShouYeView *shouYeView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITableView *shiPinTableView;
@property(nonatomic,strong) TVOrderModel *orderModel;
@property(nonatomic,strong)UISegmentedControl *segmentControl;
@property(nonatomic,strong)UIScrollView *scrollView;
@end
