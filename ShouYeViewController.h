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
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIScrollView *listSV;
@property(nonatomic,strong) NSMutableDictionary *requestPara;
@property(nonatomic,strong) NSArray *listOfScrollViewArray;
@property(nonatomic,strong) NSArray *titleOfListArray;
@property(nonatomic,strong) NSMutableArray *loadChooseMutableArray;
@property(nonatomic,assign)CGFloat historyY;
@property(nonatomic,strong) UILabel *requestErrorLabel;
@end
