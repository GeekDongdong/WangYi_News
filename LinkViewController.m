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

}

@end

@implementation LinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    _navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 30, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [_navView addSubview:backButton];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *qiTaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    qiTaButton.frame = CGRectMake(Width-35, 28, 25, 25);
    [qiTaButton setImage:[UIImage imageNamed:@"其他"] forState:UIControlStateNormal];
    [_navView addSubview:qiTaButton];

}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
