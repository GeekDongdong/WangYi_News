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
#import "Masonry.h"
#import "MJRefreshGifHeader.h"
#import "LIstOfScrollView.h"
#import "LinkViewController.h"
#import <WebKit/WebKit.h>
#import "DataManager.h"
#import "DataBase.h"

@interface ShouYeViewController ()<UITableViewDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>{
    LIstOfScrollView *agencyListOfScrollView;
    UIButton *keyButton;
    DataManager *dataManger;
    NSString *pageValueString;
    int tableViewBackgroundColorKey;
    int keyOfScrollView;
    int maxResult;
}

@end

@implementation ShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //需要显示的新闻数量
    maxResult = 10;
    self.view.backgroundColor = [UIColor whiteColor];
    //navigationBar
   self.navigationController.delegate = self;
    _shouYeView = [[ShouYeView alloc]init];
    [_shouYeView.titleButton addTarget:self action:@selector(backToMain) forControlEvents:Touch];
    [self.navigationController.navigationBar addSubview:_shouYeView.titleButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.searchButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.zhiBoButton];
    //scrollView
    [self addScrollView];
    //列表listScrollView
    [self addListScrollView];
    
    //添加主页内容
    _titleOfListArray = [[NSArray alloc]initWithObjects:@"国内焦点",@"电影",@"健康",@"娱乐",@"体育",@"情感两性最新",@"财经",@"科技",@"汽车",@"社会",@"军事",@"CBA最新",@"房产",@"理财最新",@"美容护肤最新", nil];
    dataManger = [[DataManager alloc]init];
    LIstOfScrollView *listOfScrollView = [[LIstOfScrollView alloc]initWithTitle:@"国内焦点"];
    agencyListOfScrollView = [[LIstOfScrollView alloc]init];
    agencyListOfScrollView = listOfScrollView;
    listOfScrollView.tableView.delegate = self;
    listOfScrollView.frame = CGRectMake(0, 0, Width, 550);
    [self.scrollView addSubview:listOfScrollView];
    [dataManger getData:^(TVOrderModel *model) {

        agencyListOfScrollView.orderModel = model;
        agencyListOfScrollView.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [SVProgressHUD dismiss];
        //数据库存储
        [[DataBase sharedDataBase]addNews:agencyListOfScrollView.orderModel];
        [agencyListOfScrollView.tableView reloadData];
    } faliure:^{
        //初始化orderModel极其属性，否则其属性不能接受数据
        TVOrderModel *orderModel = [[TVOrderModel alloc]init];
        TVbodyModel *bodyModel = [[TVbodyModel alloc]init];
        TVpagebeanModel *pagebeanModel = [[TVpagebeanModel alloc]init];
        pagebeanModel.contentlist = [[[DataBase sharedDataBase]getAllPerson] mutableCopy];
        pagebeanModel.allNum = @10;
        bodyModel.pagebean = pagebeanModel;
        orderModel.showapi_res_body = bodyModel;
        agencyListOfScrollView.orderModel = orderModel;
        NSLog(@"-----%@",listOfScrollView.orderModel);
        [agencyListOfScrollView.tableView reloadData];
        [SVProgressHUD dismiss];
    } channelName:@"国内焦点" maxResult:@"10"];
    listOfScrollView.tag = 0;
//    agencyListOfScrollView = [[LIstOfScrollView alloc]init];
    //请求成功是需要时间的，所以执行了后面初始化的代码，失败的很迅速的，因此在未执行后面初始化的代码前就reloadData，就crush了，因此这句需要写在block里
    
    //
    for (int i=0; i<15; i++) {
       [_tableViewOfScrollViewArray addObject:listOfScrollView];
    }

}

- (void)InfoNotificationAction:(NSNotification *)notification{
    maxResult+=10;
    pageValueString = [[NSString alloc]initWithFormat:@"%d",maxResult];
    [dataManger getData:^(TVOrderModel *model) {
        agencyListOfScrollView.orderModel = model;
//        agencyListOfScrollView.hud.hidden = YES;
        [agencyListOfScrollView.tableView reloadData];
    } faliure:^{
        
    } channelName:[_titleOfListArray objectAtIndex:keyOfScrollView] maxResult:pageValueString];

}
//通知事件AFNetWorkingRequestError
- (void)AFNetWorkingRequestError{
//    TVOrderModel *orderModel = [[TVOrderModel alloc]init];
//    orderModel.showapi_res_body.pagebean.contentlist = [[[DataBase sharedDataBase]getAllPerson]copy];
//    orderModel.showapi_res_body.pagebean.allNum = [NSNumber numberWithInteger:orderModel.showapi_res_body.pagebean.contentlist.count];
//    agencyListOfScrollView.orderModel = orderModel;
    [agencyListOfScrollView.tableView reloadData];
    NSLog(@"error!");
//    if (_requestErrorLabel.tag != -1) {
//        _requestErrorLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, Height/2-30, 150, 30)];
//        _requestErrorLabel.text = @"暂时没网了...";
//        _requestErrorLabel.tag = -1;
//        _requestErrorLabel.font = [UIFont systemFontOfSize:20];
//        [self.view addSubview:_requestErrorLabel];
//    }

}
//通知事件applyTheme
- (void)applyTheme:(NSNotification *)noti {
    NSString *info = [noti object];
    tableViewBackgroundColorKey = [info intValue];
    if ([info intValue]) {
        self.view.backgroundColor = [UIColor darkGrayColor];
        [agencyListOfScrollView.tableView  setValue:[UIColor darkGrayColor] forKey:@"backgroundColor"];
        [[UITableViewCell appearance]setBackgroundColor:[UIColor darkGrayColor]];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:153.0/255 green:3.0/255 blue:3.0/255 alpha:1];       self.tabBarController.tabBar.barTintColor = [UIColor darkGrayColor];
        [_listSV setBackgroundColor:[UIColor darkGrayColor]];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
        [agencyListOfScrollView.tableView setValue:[UIColor whiteColor] forKey:@"backgroundColor"];
        [[UITableViewCell appearance]setBackgroundColor:[UIColor whiteColor]];
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        [_listSV setBackgroundColor:[UIColor whiteColor]];
    }
}
- (void)loadNewData:(NSNotification *)noti{
    NSString *channelName = [noti object];
    [dataManger getData:^(TVOrderModel *model) {
        agencyListOfScrollView.orderModel = model;
//        agencyListOfScrollView.hud.hidden = YES;
        [agencyListOfScrollView.tableView reloadData];
    } faliure:^{
    } channelName:channelName maxResult:pageValueString];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AFNetWorkingRequestError) name:@"AFNetWorkingRequestError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyTheme:) name:@"switchDayOrNightMode" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData:) name:@"loadNewData" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InfoNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AFNetWorkingRequestError" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"loadNewData" object:nil];
}
- (void)addListScrollView{
    
    _listSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Width, 30)];
    _listSV.delegate = self;
    _listSV.showsHorizontalScrollIndicator=NO;
    _listSV.backgroundColor = [UIColor whiteColor];
    _listSV.contentSize=CGSizeMake(Width*3, 30);
    [_listSV addSubview:_shouYeView.touTiaoOfListButton];
    _shouYeView.touTiaoOfListButton.selected = YES;
    //初始化字典
    _listButtonOfScrollViewArray = [[NSArray alloc]initWithObjects:
                                    _shouYeView.touTiaoOfListButton,
                                    _shouYeView.shiPinOfListButton,
                                    _shouYeView.jianKangOfListButton,
                                    _shouYeView.yuLeOfListButton,
                                    _shouYeView.tiYuOfListButton,
                                    _shouYeView.duanZiOfListButton,
                                    _shouYeView.caiJingOfListButton,
                                    _shouYeView.keJiOfListButton,
                                    _shouYeView.qiCheOfListButton,
                                    _shouYeView.sheHuiOfListButton,
                                    _shouYeView.junShiOfListButton,
                                    _shouYeView.NBAOfListButton,
                                    _shouYeView.fangChanOfListButton,
                                    _shouYeView.guPiaoOfListButton,
                                    _shouYeView.jiaJuOfListButton,
                                    nil];
    for (int i=0; i<15; i++) {
        //添加点击事件
        [[_listButtonOfScrollViewArray objectAtIndex:i]addTarget:self action:@selector(listTask:) forControlEvents:Touch];
        //添加上去
        [_listSV addSubview:[_listButtonOfScrollViewArray objectAtIndex:i]];
    }
    
    //初始化_loadChooseArray
    _loadChooseMutableArray = [[NSMutableArray alloc]initWithObjects:@"1",@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", nil];
    [self.view addSubview:_listSV];
    //初始化_tableViewOfScrollViewArray
    _tableViewOfScrollViewArray = [[NSMutableArray alloc]init];
    
}
- (void)addScrollView{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,30, Width, Height)];
    _scrollView.contentSize = CGSizeMake(Width * 15, 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    for (int i=0; i<15;i++) {
        UIImageView *tableViewOfplaceholderImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"网易2"]];
        tableViewOfplaceholderImageView.frame = CGRectMake(Width/2+Width*i-30, (Height-94)/2-60, 60, 30);
        [self.scrollView addSubview:tableViewOfplaceholderImageView];
    }
   }

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int number=(int)scrollView.contentOffset.x/Width;
    if (scrollView == self.scrollView) {
        if (keyOfScrollView!=number) {
            [[_listButtonOfScrollViewArray objectAtIndex:keyOfScrollView]setSelected:NO];//把原来的buttonSelected设置NO
            [[_listButtonOfScrollViewArray objectAtIndex:number]setSelected:YES];//把现在的buttonSelected设置YES
            //判断是否已经请求过
            int loadChooseKey = [[_loadChooseMutableArray objectAtIndex:number]intValue];
            if (!loadChooseKey) {
                LIstOfScrollView *listOfScrollView = [[LIstOfScrollView alloc]initWithTitle:[_titleOfListArray objectAtIndex:number]];
                listOfScrollView.tableView.tag = number;
                listOfScrollView.tableView.delegate = self;
                [dataManger getData:^(TVOrderModel *model) {
                    listOfScrollView.orderModel = model;
                    listOfScrollView.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                    [SVProgressHUD dismiss];
                    [listOfScrollView.tableView reloadData];
                } faliure:^{
                    [SVProgressHUD dismiss];
                } channelName:[_titleOfListArray objectAtIndex:number] maxResult:@"10"];
                listOfScrollView.frame = CGRectMake(Width*number, 0, Width, 550);
                [self.scrollView addSubview:listOfScrollView];
                [_loadChooseMutableArray replaceObjectAtIndex:number withObject:@"1"
                 ];//设置为已经加载的记号
                [_tableViewOfScrollViewArray replaceObjectAtIndex:number withObject:listOfScrollView];
            }
            agencyListOfScrollView = [_tableViewOfScrollViewArray objectAtIndex:number];
            if(tableViewBackgroundColorKey){
                agencyListOfScrollView.tableView.backgroundColor = [UIColor darkGrayColor];
            }else{
                agencyListOfScrollView.tableView.backgroundColor = [UIColor whiteColor];
            }
            [self.listSV scrollRectToVisible:CGRectMake((Width)/5*number, 0, Width, 550) animated:YES];
            maxResult = 10;
            keyOfScrollView = number;
            keyButton = [_listButtonOfScrollViewArray objectAtIndex:number];
        }
    }
}

- (void)listTask:(UIButton *)button{
    int number = (int)[_listButtonOfScrollViewArray indexOfObject:button];
    int loadChooseKey = [[_loadChooseMutableArray objectAtIndex:number]intValue];
    if (button != keyButton) {
         button.selected = YES;//新的buttonSelected设置为YES
        [[_listButtonOfScrollViewArray objectAtIndex:keyOfScrollView]setSelected:NO];//原来的buttonSelected设置为NO
        [self setTabBarHidden:NO];//显示tabBar
        keyButton = button;
        keyOfScrollView = number;
        if (!loadChooseKey){
            LIstOfScrollView *listOfScrollView = [[LIstOfScrollView alloc]initWithTitle:[_titleOfListArray objectAtIndex:number]];
            listOfScrollView.tableView.tag = number;
            listOfScrollView.tableView.delegate = self;
            [dataManger getData:^(TVOrderModel *model) {
                listOfScrollView.orderModel = model;
                listOfScrollView.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [SVProgressHUD dismiss];
                [listOfScrollView.tableView reloadData];
            } faliure:^{
                [SVProgressHUD dismiss];
            } channelName:[_titleOfListArray objectAtIndex:number]  maxResult:@"10"];
            listOfScrollView.frame = CGRectMake(Width*keyOfScrollView, 0, Width, 550);
            [self.scrollView addSubview:listOfScrollView];
            [_loadChooseMutableArray replaceObjectAtIndex:keyOfScrollView withObject:@"1"];//设置为已经记载的记号
             [_tableViewOfScrollViewArray replaceObjectAtIndex:number withObject:listOfScrollView];
        }
        agencyListOfScrollView = [_tableViewOfScrollViewArray objectAtIndex:number];
        
        
        if(tableViewBackgroundColorKey){
            agencyListOfScrollView.tableView.backgroundColor = [UIColor darkGrayColor];
        }else{
            agencyListOfScrollView.tableView.backgroundColor = [UIColor whiteColor];
        }//判断是否改变tableView.backgroundColor
        [self.listSV scrollRectToVisible:CGRectMake((Width)/5*keyOfScrollView, 0, Width, 550) animated:YES];//list滑动
        [self.scrollView scrollRectToVisible:CGRectMake(Width*keyOfScrollView, 0, Width, 550) animated:YES];//tableView滑动
        maxResult = 10;
    }
}
- (void)backToMain{
    [agencyListOfScrollView.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self setTabBarHidden:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = agencyListOfScrollView.orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
    //    NSLog(@"--%@",tvModel);
    if (tvModel.imageurls.count<3 && tvModel.imageurls.count!=0) {
        return [ShouYeTVCell setIntroductionText:agencyListOfScrollView.cellOne];
    }else if (tvModel.imageurls.count==0){
        return [ShouYeTVCellOnlyText setIntroductionText:agencyListOfScrollView.cellOnlyText];
    }
    else{
        return [ShouYeTVCellTwo setIntroductionText:agencyListOfScrollView.cellTwo];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = agencyListOfScrollView.orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
    LinkViewController *linkVC = [[LinkViewController alloc]init];
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    //    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [linkVC.view addSubview:webView];
    NSURL* url = [NSURL URLWithString:tvModel.link];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    [self presentViewController:linkVC animated:YES completion:nil];
    
}

//tabbar动态隐藏
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_historyY+20<targetContentOffset->y)
    {
        [self setTabBarHidden:YES];
    }
    else if(_historyY-20>targetContentOffset->y)
    {
        [self setTabBarHidden:NO];
    }
    _historyY=targetContentOffset->y;
}

//设置tabBar
- (void)setTabBarHidden:(BOOL)hidden
{
    
    CGRect  tabRect=self.tabBarController.tabBar.frame;
    
    if (hidden) {
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    } else {
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame=tabRect;
    }completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
