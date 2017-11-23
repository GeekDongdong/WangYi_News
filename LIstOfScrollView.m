//
//  LIstOfScrollView.m
//  WangYi_News
//
//  Created by JACK on 2017/11/20.
//  Copyright © 2017年 JACK. All rights reserved.
//
#import "LIstOfScrollView.h"
#import "ShouYeTVCell.h"
#import "ShouYeTVCellTwo.h"
#import "ShouYeTVCellOnlyText.h"
#import <AFNetworking.h>
#import "MBProgressHUD.h"
#import "MJRefreshGifHeader.h"

@implementation LIstOfScrollView{
    MBProgressHUD *hud;
    ShouYeTVCell* cellOne;
    ShouYeTVCellTwo *cellTwo;
    ShouYeTVCellOnlyText *cellOnlyText;
}
- (id)init{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 550) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_tableView];
        [_tableView registerClass:[ShouYeTVCell class] forCellReuseIdentifier:@"cellId1"];
        [_tableView registerClass:[ShouYeTVCellTwo class] forCellReuseIdentifier:@"cellId2"];
        [_tableView registerClass:[ShouYeTVCellOnlyText class] forCellReuseIdentifier:@"cellId3"];
        [self getData];
        //MBProgressHUD
        hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"Loading";
        //addRefreshGif
        [self addRefreshGif];
        }
    return self;
}
- (void)getData{
    _dataPara = @{
                           @"showapi_appid":@"49852",
                        @"showapi_sign":@"81497a5a58de4543afdbb9aa42d32f2c",
                           @"page":@"1",
                           @"title":@"娱乐"
                           };
    NSString *urlString = @"http://route.showapi.com/109-35";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer= [AFHTTPRequestSerializer serializer];
    [manger GET:urlString parameters:_dataPara progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        //                            NSLog(@"%@",responseObject);
        _orderModel = [[TVOrderModel alloc] initWithDictionary:responseObject error:nil];
        [self.tableView reloadData];
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderModel.showapi_res_body.pagebean.contentlist.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = _orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
    if (tvModel.imageurls.count<3 && tvModel.imageurls.count!=0) {
        return [ShouYeTVCell setIntroductionText:cellOne];
    }else if (tvModel.imageurls.count==0){
        return [ShouYeTVCellOnlyText setIntroductionText:cellOnlyText];
    }
    else{
        return [ShouYeTVCellTwo setIntroductionText:cellTwo];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = _orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
    if (tvModel.imageurls.count<3&&tvModel.imageurls.count!=0) {
        cellOne = [tableView dequeueReusableCellWithIdentifier:@"cellId1" forIndexPath:indexPath];
        [cellOne updateData:tvModel];
        return cellOne;
    }else if (tvModel.imageurls.count==0){
        cellOnlyText = [tableView dequeueReusableCellWithIdentifier:@"cellId3" forIndexPath:indexPath];
        [cellOnlyText updateData:tvModel];
        return cellOnlyText;
    }
    else{
        cellTwo = [tableView dequeueReusableCellWithIdentifier:@"cellId2" forIndexPath:indexPath];
        [cellTwo updateData:tvModel];
        return cellTwo;
    }
}
- (void)addRefreshGif{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:[UIImage imageNamed:@"timg"]];
    [array addObject:[UIImage imageNamed:@"timg"]];
    // Set the ordinary state of animated images
    [header setImages:array forState:MJRefreshStateIdle];
    // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
    [header setImages:array forState:MJRefreshStatePulling];
    // Set the refreshing state of animated images
    [header setImages:array forState:MJRefreshStateRefreshing];
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
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
}
- (void)loadNewData{
    [self getData];
    [self.tableView.mj_header endRefreshing];
}
@end
