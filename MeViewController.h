//
//  MeViewController.h
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeView.h"

@interface MeViewController : UIViewController
@property(nonatomic,strong) MeView *meView;
@property (copy, nonatomic)  UISwitch *nightModeSwitch;
@end
