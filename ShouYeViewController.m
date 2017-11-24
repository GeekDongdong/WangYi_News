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
#import "LIstOfScrollView.h"
int keyOfScrollView;
UIButton *keyButton;
@interface ShouYeViewController ()<UITableViewDelegate>{
    MBProgressHUD *hud;
    LIstOfScrollView *listOfScrollView;
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
    //列表listScrollView
    [self addListScrollView];   
    //添加主页内容
    _titleOfListArray = [[NSArray alloc]initWithObjects:@"头条",@"视频",@"要闻",@"娱乐",@"体育",@"段子",@"财经",@"科技",@"汽车",@"社会",@"军事",@"篮球",@"房产",@"股票",@"家居", nil];
    listOfScrollView = [[LIstOfScrollView alloc]init:@"头条"];
    listOfScrollView.tableView.delegate = self;
    listOfScrollView.frame = CGRectMake(0, 0, Width, 550);
    [self.scrollView addSubview:listOfScrollView];
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
    [_shouYeView.yaoWenOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
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
//    [_shouYeView.youXiOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
//    [_shouYeView.jianKangOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
//    [_shouYeView.qingSongYiKeOfListButton addTarget:self action:@selector(listTask:) forControlEvents:Touch];
    //添加上去
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
//    [_listSV addSubview:_shouYeView.youXiOfListButton];
//    [_listSV addSubview:_shouYeView.jianKangOfListButton];
//    [_listSV addSubview:_shouYeView.qingSongYiKeOfListButton];
    //初始化字典
    _listOfScrollViewArray = [[NSArray alloc]initWithObjects:
        _shouYeView.touTiaoOfListButton,
        _shouYeView.shiPinOfListButton,
        _shouYeView.yaoWenOfListButton,
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
//        _shouYeView.youXiOfListButton,
//        _shouYeView.jianKangOfListButton,
//        _shouYeView.qingSongYiKeOfListButton,
                              nil];

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
    if (scrollView == self.scrollView) {
        int number=(int)scrollView.contentOffset.x/Width;
        if (keyOfScrollView!=number) {
            [[_listOfScrollViewArray objectAtIndex:keyOfScrollView]setSelected:NO];//把原来的buttonSelected设置NO
            [[_listOfScrollViewArray objectAtIndex:number]setSelected:YES];//把现在的buttonSelected设置YES
            listOfScrollView = [[LIstOfScrollView alloc]init:[_titleOfListArray objectAtIndex:number]];
            listOfScrollView.tableView.delegate = self;
            listOfScrollView.frame = CGRectMake(Width*number, 0, Width, 550);
            [self.scrollView addSubview:listOfScrollView];
            [self.listSV scrollRectToVisible:CGRectMake((Width)/5*number, 0, Width, 550) animated:YES];
            keyOfScrollView = number;//判断是否为上下滑动，如果是，则不再执行此方法
            keyButton = [_listOfScrollViewArray objectAtIndex:number];
        }
    }
}
- (void)listTask:(UIButton *)button{

    button.selected = YES;//新的buttonSelected设置为YES
    if (button!=[_listOfScrollViewArray objectAtIndex:keyOfScrollView]) {
        [[_listOfScrollViewArray objectAtIndex:keyOfScrollView]setSelected:NO];//原来的buttonSelected设置为NO
        keyButton = button;
        keyOfScrollView = (int)[_listOfScrollViewArray indexOfObject:button];
        listOfScrollView = [[LIstOfScrollView alloc]init:[_titleOfListArray objectAtIndex:keyOfScrollView]];
        listOfScrollView.tableView.delegate = self;
        listOfScrollView.frame = CGRectMake(Width*keyOfScrollView, 0, Width, 550);
        [self.listSV scrollRectToVisible:CGRectMake((Width)/5*keyOfScrollView, 0, Width, 550) animated:YES];
        [self.scrollView addSubview:listOfScrollView];
        [self.scrollView scrollRectToVisible:CGRectMake(Width*keyOfScrollView, 0, Width, 550) animated:YES];
    }
    
    
}
- (void)backToMain{
//     [scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
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
    UIViewController *vc = [[UIViewController alloc]init];
    [vc.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backTask)];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [vc.view addSubview:webView];
    NSURL* url = [NSURL URLWithString:tvModel.link];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    [self.navigationController pushViewController:vc animated:YES];
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==1||subviews.tag==2||subviews.tag==3) {
            [subviews removeFromSuperview];
        }
    }
}
- (void)backTask{
    [self.navigationController.navigationBar addSubview:_shouYeView.titleButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.searchButton];
    [self.navigationController.navigationBar addSubview:_shouYeView.zhiBoButton];
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
