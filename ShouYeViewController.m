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
#import "MBProgressHUD.h"
#import "LIstOfScrollView.h"
#import "LinkViewController.h"
#import <WebKit/WebKit.h>

int keyOfScrollView;
int maxResult = 10;
UIButton *keyButton;
@interface ShouYeViewController ()<UITableViewDelegate,UINavigationControllerDelegate>{
    LIstOfScrollView *listOfScrollView;
    int tableViewBackgroundColorKey;
}

@end

@implementation ShouYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //navigationBar
   self.navigationController.delegate = self;
    _shouYeView = [[ShouYeView alloc]init];
    [_shouYeView.titleButton addTarget:self action:@selector(backToMain) forControlEvents:Touch];
    [_shouYeView.searchButton addTarget:self action:@selector(search) forControlEvents:Touch];
    [_shouYeView.zhiBoButton addTarget:self action:@selector(zhiBo) forControlEvents:Touch];
    [self.navigationController.navigationBar addSubview:_shouYeView.titleButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.searchButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.zhiBoButton];
    //scrollView
    [self addScrollView];
    //列表listScrollView
    [self addListScrollView];
    
    //添加主页内容
    _titleOfListArray = [[NSArray alloc]initWithObjects:@"国内焦点",@"电影",@"健康",@"娱乐",@"体育",@"段子",@"财经",@"科技",@"汽车",@"社会",@"军事",@"篮球",@"房产",@"股票",@"家居", nil];
    listOfScrollView = [[LIstOfScrollView alloc]initWithTitle:@"国内焦点"];
    listOfScrollView.tableView.delegate = self;
    listOfScrollView.frame = CGRectMake(0, 0, Width, 550);
    [self.scrollView addSubview:listOfScrollView];
}
- (void)InfoNotificationAction:(NSNotification *)notification{
    maxResult+=10;
    NSString *pageValueString = [[NSString alloc]initWithFormat:@"%d",maxResult];
    [listOfScrollView.dataPara setValue:pageValueString forKey:@"maxResult"];
    [listOfScrollView getData:[_titleOfListArray objectAtIndex:keyOfScrollView]];
}
//通知事件AFNetWorkingRequestError
- (void)AFNetWorkingRequestError{
    [listOfScrollView.tableView removeFromSuperview];
    if (_requestErrorLabel.tag != -1) {
        _requestErrorLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, Height/2-30, 150, 30)];
        _requestErrorLabel.text = @"暂时没网了...";
        _requestErrorLabel.tag = -1;
        _requestErrorLabel.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:_requestErrorLabel];
    }

}
//通知事件applyTheme
- (void)applyTheme:(NSNotification *)noti {
    NSString *info = [noti object];
    tableViewBackgroundColorKey = [info intValue];
    if ([info intValue]) {
        self.view.backgroundColor = [UIColor darkGrayColor];
        [listOfScrollView.tableView  setValue:[UIColor darkGrayColor] forKey:@"backgroundColor"];
        [[UITableViewCell appearance]setBackgroundColor:[UIColor darkGrayColor]];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:153.0/255 green:3.0/255 blue:3.0/255 alpha:1];       self.tabBarController.tabBar.barTintColor = [UIColor darkGrayColor];
        [_listSV setBackgroundColor:[UIColor darkGrayColor]];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
        [listOfScrollView.tableView setValue:[UIColor whiteColor] forKey:@"backgroundColor"];
        [[UITableViewCell appearance]setBackgroundColor:[UIColor whiteColor]];
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
        [_listSV setBackgroundColor:[UIColor whiteColor]];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"InfoNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AFNetWorkingRequestError) name:@"AFNetWorkingRequestError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyTheme:) name:@"switchDayOrNightMode" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"InfoNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AFNetWorkingRequestError" object:nil];
}
- (void)addListScrollView{
    
    _listSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Width, 30)];
    _listSV.delegate = self;
    _listSV.showsHorizontalScrollIndicator=NO;
    _listSV.backgroundColor = [UIColor whiteColor];
    _listSV.contentSize=CGSizeMake(Width*3, 30);
    [_listSV addSubview:_shouYeView.touTiaoOfListButton];
    _shouYeView.touTiaoOfListButton.selected = YES;
    [_shouYeView.touTiaoOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    keyButton = [[UIButton alloc]init];
    keyButton = _shouYeView.touTiaoOfListButton;
    [_shouYeView.shiPinOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.jianKangOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.yuLeOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.tiYuOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.duanZiOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.caiJingOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.keJiOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.qiCheOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.sheHuiOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.junShiOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.NBAOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.fangChanOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.guPiaoOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    [_shouYeView.jiaJuOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    //添加上去
    [_listSV addSubview:_shouYeView.shiPinOfListButton];
    [_listSV addSubview:_shouYeView.jianKangOfListButton];
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
    //初始化字典
    _listOfScrollViewArray = [[NSArray alloc]initWithObjects:
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
     //初始化_loadChooseArray
    _loadChooseMutableArray = [[NSMutableArray alloc]initWithObjects:@"1",@"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", nil];
    [self.view addSubview:_listSV];
}
- (void)addScrollView{

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,30, 375, Height)];
    _scrollView.contentSize = CGSizeMake(Width * 15, 0);
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int number=(int)scrollView.contentOffset.x/Width;
    if (scrollView == self.scrollView) {
        if (keyOfScrollView!=number) {
            [[_listOfScrollViewArray objectAtIndex:keyOfScrollView]setSelected:NO];//把原来的buttonSelected设置NO
            [[_listOfScrollViewArray objectAtIndex:number]setSelected:YES];//把现在的buttonSelected设置YES
            //判断是否已经请求过
            int loadChooseKey = [[_loadChooseMutableArray objectAtIndex:number]intValue];
            if (loadChooseKey) {
                 //移除之前的tableView
                for (UIView *subviews in [self.scrollView subviews]) {
                    if (subviews.tag==number) {
                        [subviews removeFromSuperview];
                    }
                }
            }
            listOfScrollView = [[LIstOfScrollView alloc]initWithTitle:[_titleOfListArray objectAtIndex:number]];
            listOfScrollView.tableView.tag = number;
            listOfScrollView.tableView.delegate = self;
            if(tableViewBackgroundColorKey){
                listOfScrollView.tableView.backgroundColor = [UIColor darkGrayColor];
            }else{
                listOfScrollView.tableView.backgroundColor = [UIColor whiteColor];
            }
            listOfScrollView.frame = CGRectMake(Width*number, 0, Width, 550);
            [self.scrollView addSubview:listOfScrollView];
            [_loadChooseMutableArray replaceObjectAtIndex:number withObject:@"1"
             ];//设置为已经加载的记号
            [self.listSV scrollRectToVisible:CGRectMake((Width)/5*number, 0, Width, 550) animated:YES];
            maxResult = 10;
            keyOfScrollView = number;
            keyButton = [_listOfScrollViewArray objectAtIndex:number];
        }
    }
}


- (void)listTask:(UIButton *)button{
    int number = (int)[_listOfScrollViewArray indexOfObject:button];
    int loadChooseKey = [[_loadChooseMutableArray objectAtIndex:number]intValue];
   
    if (button!=[_listOfScrollViewArray objectAtIndex:keyOfScrollView]) {
         button.selected = YES;//新的buttonSelected设置为YES
        [[_listOfScrollViewArray objectAtIndex:keyOfScrollView]setSelected:NO];//原来的buttonSelected设置为NO
        keyButton = button;
        //判断是否请求过
        keyOfScrollView = number;
        if (loadChooseKey) {
         //移除之前的tableView
            for (UIView *subviews in [self.scrollView subviews]) {
                if (subviews.tag==number) {
                    [subviews removeFromSuperview];
                }
            }
        }
        listOfScrollView = [[LIstOfScrollView alloc]initWithTitle:[_titleOfListArray objectAtIndex:number]];
        listOfScrollView.tableView.tag = number;
        listOfScrollView.tableView.delegate = self;
        //判断是否改变tableView.backgroundColor
        if(tableViewBackgroundColorKey){
            listOfScrollView.tableView.backgroundColor = [UIColor darkGrayColor];
        }else{
            listOfScrollView.tableView.backgroundColor = [UIColor whiteColor];
        }
        listOfScrollView.frame = CGRectMake(Width*keyOfScrollView, 0, Width, 550);
        [self.scrollView addSubview:listOfScrollView];
        [_loadChooseMutableArray replaceObjectAtIndex:keyOfScrollView withObject:@"1"];//设置为已经记载的记号
        [self.listSV scrollRectToVisible:CGRectMake((Width)/5*keyOfScrollView, 0, Width, 550) animated:YES];
        [self.scrollView scrollRectToVisible:CGRectMake(Width*keyOfScrollView, 0, Width, 550) animated:YES];
        maxResult = 10;
    }
}
- (void)backToMain{
    [listOfScrollView.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self setTabBarHidden:NO];
    listOfScrollView.tableView.frame = CGRectMake(0, 0, 375, Height-94);
}
- (void)search{
    NSLog(@"");
}
- (void)zhiBo{
    NSLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = listOfScrollView.orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
//    NSLog(@"--%@",tvModel);
    if (tvModel.imageurls.count<3 && tvModel.imageurls.count!=0) {
        return [ShouYeTVCell setIntroductionText:listOfScrollView.cellOne];
    }else if (tvModel.imageurls.count==0){
        return [ShouYeTVCellOnlyText setIntroductionText:listOfScrollView.cellOnlyText];
    }
    else{
        return [ShouYeTVCellTwo setIntroductionText:listOfScrollView.cellTwo];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
    tvModel = listOfScrollView.orderModel.showapi_res_body.pagebean.contentlist[indexPath.row];
    LinkViewController *linkVC = [[LinkViewController alloc]init];
    [linkVC.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    linkVC.hidesBottomBarWhenPushed = YES;
//    self.navigationController.navigationBar.hidden = YES;
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
//    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [linkVC.view addSubview:webView];
    NSURL* url = [NSURL URLWithString:tvModel.link];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
//    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回按钮" style:UIBarButtonItemStylePlain target:self action:@selector(backTask)];
    [self presentViewController:linkVC animated:YES completion:nil];
}

//tabbar动态隐藏
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    if (_historyY+20<targetContentOffset->y)
    {
        [self setTabBarHidden:YES];
        listOfScrollView.tableView.frame = CGRectMake(0, 0, 375, Height-94);
    }
    else if(_historyY-20>targetContentOffset->y)
    {
        [self setTabBarHidden:NO];
        listOfScrollView.tableView.frame = CGRectMake(0, 0, 375, Height-94);
    }
    _historyY=targetContentOffset->y;
}
//设置tabBar
- (void)setTabBarHidden:(BOOL)hidden
{
//    UIView *tab = self.tabBarController.view;
    CGRect  tabRect=self.tabBarController.tabBar.frame;
//    if ([tab.subviews count] < 2) {
//        return;
//    }
    
//    UIView *view;
//    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
//        view = [tab.subviews objectAtIndex:1];
//    } else {
//        view = [tab.subviews objectAtIndex:0];
//    }
    if (hidden) {
//        view.frame = tab.bounds;
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    } else {
//        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame=tabRect;
    }completion:^(BOOL finished) {
        
    }];
}
@end
