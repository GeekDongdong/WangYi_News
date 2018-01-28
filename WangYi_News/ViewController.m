//
//  ViewController.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "ViewController.h"
#import "TabBarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //壁纸
    NSString *str = [[NSArray array] componentsJoinedByString:@"ZD"];
    NSArray *arrau = [str componentsSeparatedByString:@"ZD"];
    UIImageView *wallpaperIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wallpaper"]];
    wallpaperIV.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:wallpaperIV];
    //2s后跳转主界面
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(switchView) userInfo:nil repeats:NO];
}
- (void)switchView{
   TabBarController *tbC = [[TabBarController alloc]init];
   [self.navigationController pushViewController:tbC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


@end
