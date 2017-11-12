//
//  ZhiBoViewController.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//
#define Touch UIControlEventTouchUpInside
#import "ZhiBoViewController.h"

@interface ZhiBoViewController ()

@end

@implementation ZhiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _zhiBoView = [[ZhiBoView alloc]init];
    [_zhiBoView.titleButton addTarget:self action:@selector(backToMain) forControlEvents:Touch];
    [self.navigationController.navigationBar addSubview:_zhiBoView.titleButton];
}
- (void)backToMain{
    NSLog(@"");
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
