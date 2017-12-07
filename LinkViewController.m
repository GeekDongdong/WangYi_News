//
//  LinkViewController.m
//  WangYi_News
//
//  Created by JACK on 2017/11/25.
//  Copyright © 2017年 JACK. All rights reserved.
//
#define Width self.view.frame.size.width
#define Height self.view.frame.size.height
#import "LinkViewController.h"

@interface LinkViewController (){
    UIView *navView;
}

@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 30, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [navView addSubview:backButton];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *qiTaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    qiTaButton.frame = CGRectMake(Width-35, 28, 25, 25);
    [qiTaButton setImage:[UIImage imageNamed:@"其他"] forState:UIControlStateNormal];
    [navView addSubview:qiTaButton];

}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyTheme:) name:@"switchDayOrNightMode" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"switchDayOrNightMode" object:nil];
}
//通知事件applyTheme
- (void)applyTheme:(NSNotification *)noti {
    NSString *info = [noti object];
    if ([info intValue]) {
        self.view.backgroundColor = [UIColor darkGrayColor];
        navView.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.view.backgroundColor = [UIColor whiteColor];
        navView.backgroundColor = [UIColor darkGrayColor];
    }
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
