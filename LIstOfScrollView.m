//
//  LIstOfScrollView.m
//  WangYi_News
//
//  Created by JACK on 2017/11/20.
//  Copyright © 2017年 JACK. All rights reserved.
//
#import "LIstOfScrollView.h"
#import <AFNetworking.h>
#import "MBProgressHUD.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshFooter.h"
#import "MJRefreshAutoGifFooter.h"

NSString* listTitle;
@implementation LIstOfScrollView{
    MBProgressHUD *hud;
}
- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        //_dataPara
            _dataPara =  [NSMutableDictionary dictionaryWithObjectsAndKeys:@"49852",@"showapi_appid",@"81497a5a58de4543afdbb9aa42d32f2c",@"showapi_sign",@"1", @"page",title, @"channelName",@"10",@"maxResult",nil];
        //_tableView
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 525) style:UITableViewStylePlain];
//        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_tableView];
        [_tableView registerClass:[ShouYeTVCell class] forCellReuseIdentifier:@"cellId1"];
        [_tableView registerClass:[ShouYeTVCellTwo class] forCellReuseIdentifier:@"cellId2"];
        [_tableView registerClass:[ShouYeTVCellOnlyText class] forCellReuseIdentifier:@"cellId3"];
        [self getData:title];
        listTitle = title;
        //MBProgressHUD
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"Loading";
        //addRefreshGif
        [self addRefreshGif];
        }
    return self;
}
- (void)getData:(NSString *)title{
    __weak LIstOfScrollView *weakself = self;
    NSString *urlString = @"http://route.showapi.com/109-35";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer= [AFHTTPRequestSerializer serializer];
    [manger GET:urlString parameters:_dataPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功");
//        NSLog(@"%@",responseObject);
        _orderModel = [[TVOrderModel alloc] initWithDictionary:responseObject error:nil];
        [weakself.tableView reloadData];
        [hud hideAnimated:YES];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSNotification *notification =[NSNotification notificationWithName:@"AFNetWorkingRequestError" object:nil userInfo:nil];
        // 通过 通知中心 发送 通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [hud hideAnimated:YES];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderModel.showapi_res_body.pagebean.contentlist.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = _orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
    if (tvModel.imageurls.count<3&&tvModel.imageurls.count!=0) {
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
    [self getData:listTitle];
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
