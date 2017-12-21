//
//  TabBarController.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "TabBarController.h"
#import "ShouYeViewController.h"
#import "WeiZiXunViewController.h"
#import "MeViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页
    ShouYeViewController *shouYeVC = [[ShouYeViewController alloc]init];
    UINavigationController *shouYeNC = [[UINavigationController alloc]initWithRootViewController:shouYeVC];
    [self controller:shouYeVC Title:@"首页" tabBarItemImage:@"shouYeImage" tabBarItemSelectedImage:@"shouYeSelectedImage"];

    //微资讯
    WeiZiXunViewController *weiZiXunVC = [[WeiZiXunViewController alloc]init];
    UINavigationController *weiZiXunNC = [[UINavigationController alloc]initWithRootViewController:weiZiXunVC];
    [self controller:weiZiXunVC Title:@"微资讯" tabBarItemImage:@"weiZiXunImage" tabBarItemSelectedImage:@"weiZiXunSelectedImage"];

    //我
    MeViewController *meVC = [[MeViewController alloc]init];
    UINavigationController *meNC = [[UINavigationController alloc]initWithRootViewController:meVC];
     [self controller:meVC Title:@"我" tabBarItemImage:@"woImage" tabBarItemSelectedImage:@"woSelectedImage"];
    
    self.viewControllers = @[shouYeNC,weiZiXunNC,meNC];
    [[UINavigationBar appearance]setBarTintColor:[UIColor redColor]];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)controller:(UIViewController *)controller Title:(NSString *)title tabBarItemImage:(NSString *)image tabBarItemSelectedImage:(NSString *)selectedImage
{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:image];
    // 设置 tabbarItem 选中状态的图片(不被系统默认渲染,显示图像原始颜色)
    UIImage *imageHome = [UIImage imageNamed:selectedImage];
    imageHome = [imageHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [controller.tabBarItem setSelectedImage:imageHome];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    NSDictionary *selectedDict = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    //设置tabbarItem 未选中状态下的文字颜色
    NSDictionary *normalDict = [NSDictionary dictionaryWithObject:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    [controller.tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
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
