//
//  MeViewController.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//
#define Touch UIControlEventTouchUpInside
#import "MeViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _meView = [[MeView alloc]init];
    [_meView.titleButton addTarget:self action:@selector(backToMain) forControlEvents:Touch];
    [self.navigationController.navigationBar addSubview:_meView.titleButton];
    //nightModeSwitch
    _nightModeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(100,200,100,40)];
    [_nightModeSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_nightModeSwitch];
}
- (void)switchValueChanged:(UISwitch *) sender {
    if(sender.isOn == YES){
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:153.0/255 green:3.0/255 blue:3.0/255 alpha:1];       
        NSNotification *notification =[NSNotification notificationWithName:@"switchDayOrNightMode" object:@"1" userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }else{
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        NSNotification *notification =[NSNotification notificationWithName:@"switchDayOrNightMode" object:@"0" userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}
- (void)backToMain{
    NSLog(@"");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
