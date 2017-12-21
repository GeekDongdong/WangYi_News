//
//  WeiZiXunView.m
//  WangYi_News
//
//  Created by JACK on 2017/11/2.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "WeiZiXunView.h"

@implementation WeiZiXunView

- (id)init{
    self = [super init];
    if (self) {
        //微资讯标题button
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleButton setTitle:@"微资讯" forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [self setButtonIF:_titleButton ImageName:nil StImageName:nil Frame:CGRectMake(10, 10, 80, 25)];
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
