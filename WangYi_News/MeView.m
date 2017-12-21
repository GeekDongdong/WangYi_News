//
//  MeView.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "MeView.h"

@implementation MeView

- (id)init{
    self = [super init];
    if (self) {
        //‘我’标题button
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleButton setTitle:@"我" forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [self setButtonIF:_titleButton ImageName:nil StImageName:nil Frame:CGRectMake(10, 10, 40, 25)];
    }
    return self;
}
- (void)setButtonIF:(UIButton *)button ImageName:(NSString *)image StImageName:(NSString *)selectedImage Frame:(CGRect)frame{
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [button setFrame:frame];
    button.adjustsImageWhenDisabled = NO;
    [self addSubview:button];
}


@end
