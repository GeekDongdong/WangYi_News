//
//  ShiPinViewController.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//
#define Touch UIControlEventTouchUpInside
#import "ShiPinViewController.h"


@interface ShiPinViewController ()

@end

@implementation ShiPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _shiPinView = [[ShiPinView alloc]init];
     [_shiPinView.titleButton addTarget:self action:@selector(backToMain) forControlEvents:Touch];
    [self.navigationController.navigationBar addSubview:_shiPinView.titleButton];
}
- (void)backToMain{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
