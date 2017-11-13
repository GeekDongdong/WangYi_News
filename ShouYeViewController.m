//
//  ShouYeViewController.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//
#define URL @"http://route.showapi.com/109-35"
#define width self.view.frame.size.width
#define height self.view.frame.size.height
#define Touch UIControlEventTouchUpInside
#import "ShouYeViewController.h"
#import "ShouYeTVCell.h"
#import <AFNetworking.h>
#import "MJRefreshGifHeader.h"
#import "MBProgressHUD.h"

@interface ShouYeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    MBProgressHUD *hud;
}

@end

@implementation ShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //navigationBar
    _shouYeView = [[ShouYeView alloc]init];
    [_shouYeView.titleButton addTarget:self action:@selector(backToMain) forControlEvents:Touch];
    [_shouYeView.searchButton addTarget:self action:@selector(search) forControlEvents:Touch];
    [_shouYeView.zhiBoButton addTarget:self action:@selector(zhiBo) forControlEvents:Touch];
    [self.navigationController.navigationBar addSubview:_shouYeView.titleButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.searchButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.zhiBoButton];
    [self.navigationController.navigationBar addSubview:_listSV];
    //tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, width, height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ShouYeTVCell class] forCellReuseIdentifier:@"cellId1"];
    [self getData];
    //下拉刷新gif
    [self addRefreshGif];
    //列表scrollView
    [self addScrollView];
    //MBProgressHUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading";
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
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}
- (void)addScrollView{
    _listSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, width, 30)];
    //    _listSV.backgroundColor = [UIColor blackColor];
    _listSV.pagingEnabled = YES;
    _listSV.showsHorizontalScrollIndicator=NO;
    _listSV.delegate =self;
    _listSV.backgroundColor = [UIColor whiteColor];
    _listSV.contentSize=CGSizeMake(width*3, 30);
    [_listSV addSubview:_shouYeView.touTiaoOfListButton];
    [_shouYeView.touTiaoOfListButton addTarget:self action:@selector(touTiaoOfListTask) forControlEvents:Touch];
    [_listSV addSubview:_shouYeView.shiPinOfListButton];
    [_listSV addSubview:_shouYeView.yaoWenOfListButton];
    [_listSV addSubview:_shouYeView.yuLeOfListButton];
    [_listSV addSubview:_shouYeView.tiYuOfListButton];
    [_listSV addSubview:_shouYeView.duanZiOfListButton];
    [_listSV addSubview:_shouYeView.caiJingOfListButton];
    [_listSV addSubview:_shouYeView.keJiOfListButton];
    [_listSV addSubview:_shouYeView.qiCheOfListButton];
    [_listSV addSubview:_shouYeView.sheHuiOfListButton];
    [_listSV addSubview:_shouYeView.junShiOfListButton];
    [_listSV addSubview:_shouYeView.NBAOfListButton];
    [_listSV addSubview:_shouYeView.fangChanOfListButton];
    [_listSV addSubview:_shouYeView.guPiaoOfListButton];
    [_listSV addSubview:_shouYeView.jiaJuOfListButton];
    [_listSV addSubview:_shouYeView.youXiOfListButton];
    [_listSV addSubview:_shouYeView.jianKangOfListButton];
    [_listSV addSubview:_shouYeView.qingSongYiKeOfListButton];
    [self.view addSubview:_listSV];
}
- (void)touTiaoOfListTask{
}
- (void)getData{
    NSDictionary *para = @{
                          @"showapi_appid":@"49852",
                          @"showapi_sign":@"81497a5a58de4543afdbb9aa42d32f2c",
                          @"page":@"1",
                          @"title":@"娱乐"
                          };
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer= [AFHTTPRequestSerializer serializer];
    [manger GET:URL parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
//                NSLog(@"%@",responseObject);
        _orderModel = [[TVOrderModel alloc] initWithDictionary:responseObject error:nil];
        [self.tableView reloadData];
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
- (void)backToMain{
    NSLog(@"");
}
- (void)search{
    NSLog(@"");
}
- (void)zhiBo{
    NSLog(@"");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_orderModel.showapi_res_body.pagebean.allNum intValue] - 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShouYeTVCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellId1" forIndexPath:indexPath];
    [cell updateData:_orderModel.showapi_res_body.pagebean.contentlist[indexPath.row]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
