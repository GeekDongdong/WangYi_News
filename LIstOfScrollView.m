//
//  LIstOfScrollView.m
//  WangYi_News
//
//  Created by JACK on 2017/11/20.
//  Copyright © 2017年 JACK. All rights reserved.
//
#import "LIstOfScrollView.h"
#import <AFNetworking.h>
#import "MJRefreshGifHeader.h"
#import "MJRefreshFooter.h"
#import "MJRefreshAutoGifFooter.h"
#import "DataBase.h"

@implementation LIstOfScrollView{
    NSString* listTitle;
}
- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        //_tableView
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-94) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_tableView];
        [_tableView registerClass:[ShouYeTVCell class] forCellReuseIdentifier:@"cellId1"];
        [_tableView registerClass:[ShouYeTVCellTwo class] forCellReuseIdentifier:@"cellId2"];
        [_tableView registerClass:[ShouYeTVCellOnlyText class] forCellReuseIdentifier:@"cellId3"];
        listTitle = title;
        //MBProgressHUD
        [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
        [SVProgressHUD setForegroundColor:[UIColor lightGrayColor]];
        [SVProgressHUD showWithStatus:@"加载中..."];
        [SVProgressHUD setRingRadius:12.0];
        [SVProgressHUD setRingThickness:4.0];
        //addRefreshGif
        [self addRefreshGif];
        }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderModel.showapi_res_body.pagebean.contentlist.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = _orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
//    NSLog(@"cellForRowAtIndexPath:");
    
    if (tvModel.imageurls.count<3 && tvModel.imageurls.count!=0) {
        _cellOne = [tableView dequeueReusableCellWithIdentifier:@"cellId1" forIndexPath:indexPath];
        [_cellOne updateData:tvModel];
        return _cellOne;
    }else if (tvModel.imageurls.count==0){
        _cellOnlyText = [tableView dequeueReusableCellWithIdentifier:@"cellId3" forIndexPath:indexPath];
        [_cellOnlyText updateData:tvModel];
        return _cellOnlyText;
    }
    else{
        _cellTwo = [tableView dequeueReusableCellWithIdentifier:@"cellId2" forIndexPath:indexPath];
        [_cellTwo updateData:tvModel];
        return _cellTwo;
    }
}

- (void)addRefreshGif{
//MJRefreshGifHeader
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    NSMutableArray *refreshHeaderArray = [[NSMutableArray alloc]init];
    [refreshHeaderArray addObject:[UIImage imageNamed:@"飞碟"]];
    [refreshHeaderArray addObject:[UIImage imageNamed:@"飞碟"]];
    // Set the ordinary state of animated images
    [header setImages:refreshHeaderArray forState:MJRefreshStateIdle];
    // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
    [header setImages:refreshHeaderArray forState:MJRefreshStatePulling];
    // Set the refreshing state of animated images
    [header setImages:refreshHeaderArray forState:MJRefreshStateRefreshing];
    // Set header
    self.tableView.mj_header = header;
    // Hide the time
    header.lastUpdatedTimeLabel.hidden = YES;
    // Hide the status
    header.stateLabel.hidden = NO;
    //set title
    [header setTitle:@"下拉推荐" forState:MJRefreshStateIdle];
    [header setTitle:@"松开推荐" forState:MJRefreshStatePulling];
    [header setTitle:@"推荐..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:17];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:17];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
//MJRefreshAutoNormalFooter
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    NSMutableArray *refreshFooterArray = [[NSMutableArray alloc]init];
    [refreshFooterArray addObject:[UIImage imageNamed:@"加载"]];
    [refreshFooterArray addObject:[UIImage imageNamed:@"加载"]];
    // Set the refresh image
    [footer setImages:refreshFooterArray forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在载入..." forState:MJRefreshStateRefreshing];
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    // Set footer
    self.tableView.mj_footer = footer;
}
- (void)loadNewData{
    NSNotification *notification =[NSNotification notificationWithName:@"loadNewData" object:listTitle userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.tableView.mj_header endRefreshing];
}
- (void)loadMoreData{
    [self.tableView.mj_footer endRefreshing];
    // 创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:nil];
    // 通过 通知中心 发送 通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
