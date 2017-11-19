//
//  ShouYeViewController.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//

#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
#define Touch UIControlEventTouchUpInside
#import "ShouYeViewController.h"
#import "ShouYeTVCell.h"
#import "ShouYeTVCellTwo.h"
#import "ShouYeTVCellOnlyText.h"
#import <AFNetworking.h>
#import "MJRefreshGifHeader.h"
#import "MBProgressHUD.h"
#import "ShiPinOfScrollViewCtrler.h"

@interface ShouYeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    MBProgressHUD *hud;
    ShouYeTVCell* cellOne;
    ShouYeTVCellTwo *cellTwo;
    ShouYeTVCellOnlyText *cellOnlyText;
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
    //scrollView
    [self addScrollView];
    //tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-30) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.scrollView addSubview:_tableView];
    [_tableView registerClass:[ShouYeTVCell class] forCellReuseIdentifier:@"cellId1"];
    [_tableView registerClass:[ShouYeTVCellTwo class] forCellReuseIdentifier:@"cellId2"];
    [_tableView registerClass:[ShouYeTVCellOnlyText class] forCellReuseIdentifier:@"cellId3"];
    [self getData];
    //shiPinTableView
    _shiPinTableView = [[UITableView alloc]initWithFrame:CGRectMake(Width, 0, Width, Height-30) style:UITableViewStylePlain];
    _shiPinTableView.delegate = self;
    _shiPinTableView.dataSource = self;
    [self.scrollView addSubview:_shiPinTableView];
    [_shiPinTableView registerClass:[ShouYeTVCell class] forCellReuseIdentifier:@"cellId1"];
    [_shiPinTableView registerClass:[ShouYeTVCellTwo class] forCellReuseIdentifier:@"cellId2"];
    [_shiPinTableView registerClass:[ShouYeTVCellOnlyText class] forCellReuseIdentifier:@"cellId3"];

    //下拉刷新gif
    [self addRefreshGif];

    //列表segmentControl
    [self addSegmentControl];
    //MBProgressHUD
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading";
    
}
- (void)addScrollView{
    
_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,30, 375, Height-30)];
_scrollView.contentSize = CGSizeMake(375 * 3, 0);
_scrollView.delegate = self;
_scrollView.pagingEnabled = YES;
_scrollView.scrollEnabled = YES;
_scrollView.bounces = YES;
_scrollView.showsHorizontalScrollIndicator = NO;
[self.view addSubview:_scrollView];
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
- (void)addSegmentControl{
    NSArray *array = @[@"头条", @"视频", @"要闻",@"娱乐",@"体育",@"段子",@"财经",@"科技",@"汽车",@"社会",@"军事",@"时尚"];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:array];
    _segmentControl.frame = CGRectMake(0, 64, 375*2, 30);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.tintColor = [UIColor whiteColor];
    _segmentControl.momentary = NO;
    // 设置颜色
    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                  forState:UIControlStateNormal];
    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                  forState:UIControlStateSelected];
    [_segmentControl setBackgroundColor:[UIColor whiteColor]];
    [_segmentControl addTarget:self action:@selector(doSomethingInSegment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentControl];
}
-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            [_scrollView scrollRectToVisible:CGRectMake(0, 0, 375, 550) animated:YES];
            break;
        case 1:
            [_scrollView scrollRectToVisible:CGRectMake(375, 0, 375, 550) animated:YES];
            break;
        case 2:
            [_scrollView scrollRectToVisible:CGRectMake(375 * 2, 0, 375, 550) animated:YES];
            break;
    }
}

- (void)touTiaoOfListTask:(UIButton *)button{
    
}
- (void)shiPinOfListTask:(UIButton *)button{
    button.selected = !button.selected;
    ShiPinOfScrollViewCtrler *shiPinOfScrollViewCtrler = [[ShiPinOfScrollViewCtrler alloc]init];
    [self.navigationController pushViewController:shiPinOfScrollViewCtrler animated:YES];
    
}
- (void)yaoWenOfListTask:(UIButton *)button{
    button.selected = !button.selected;
}
- (void)getData{

        NSDictionary *para = @{
                               @"showapi_appid":@"49852",
                            @"showapi_sign":@"81497a5a58de4543afdbb9aa42d32f2c",
                               @"page":@"1",
                               @"title":@"体育"
                               };
    NSString *urlString = @"http://route.showapi.com/109-35";
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        manger.requestSerializer= [AFHTTPRequestSerializer serializer];
        [manger GET:urlString parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求成功");
//                            NSLog(@"%@",responseObject);
            _orderModel = [[TVOrderModel alloc] initWithDictionary:responseObject error:nil];
                [self.tableView reloadData];
                [hud hideAnimated:YES];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];

}
- (void)backToMain{
     [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}
- (void)search{
    NSLog(@"");
}
- (void)zhiBo{
    NSLog(@"");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderModel.showapi_res_body.pagebean.contentlist.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = _orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
    if (tvModel.imageurls.count<3&&tvModel.imageurls.count!=0) {
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
