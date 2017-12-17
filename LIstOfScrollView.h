//
//  LIstOfScrollView.h
//  WangYi_News
//
//  Created by JACK on 2017/11/20.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVOrderModel.h"
#import "ShouYeTVCell.h"
#import "ShouYeTVCellTwo.h"
#import "ShouYeTVCellOnlyText.h"
#import "SVProgressHUD.h"

@interface LIstOfScrollView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) TVOrderModel *orderModel;
@property(nonatomic,strong) ShouYeTVCell* cellOne;
@property(nonatomic,strong) ShouYeTVCellTwo *cellTwo;
@property(nonatomic,strong) ShouYeTVCellOnlyText *cellOnlyText;
- (id)initWithTitle:(NSString *)title;
//- (void)getData:(NSString *)title;
@end
