//
//  ShouYeView.m
//  WangYi_News
//
//  Created by JACK on 2017/10/29.
//  Copyright © 2017年 JACK. All rights reserved.
//
#define Width self.frame.size.width
#define Height self.frame.size.height
#define screenLength [UIScreen mainScreen].bounds.size.width
#import "ShouYeView.h"
#import "Masonry.h"

@implementation ShouYeView
- (id)init{
    self = [super init];
    if (self) {
        //网易标题button
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:20];
        _titleButton.tag = 1;
        [self setButtonIF:_titleButton Title:nil ImageName:@"网易" StImageName:nil Frame:CGRectMake(10, 10, 50, 25)];
        //首页搜索button
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.tag = 2;
        [self setButtonIF:_searchButton Title:nil ImageName:@"搜索" StImageName:nil Frame:CGRectMake(screenLength-110, 13, 20, 20)];
        //直播button
        _zhiBoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _zhiBoButton.tag = 3;
        [self setButtonIF:_zhiBoButton Title:nil ImageName:@"直播" StImageName:nil Frame:CGRectMake(screenLength-50, 13, 30, 20)];
        //listButton
        [self addListButton];
    }
    return self;
}
- (void)addListButton{
    int i = 0;
    int chang = [UIScreen mainScreen].bounds.size.width/5;
    //touTiaoOfListButton 1
    _touTiaoOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_touTiaoOfListButton Title:@"头条" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_touTiaoOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_touTiaoOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //shiPinOfListButton 2
    _shiPinOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_shiPinOfListButton Title:@"视频" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_shiPinOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_shiPinOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_jianKangOfListButton 3
    _jianKangOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_jianKangOfListButton Title:@"健康" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_jianKangOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_jianKangOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_yuLeOfListButton 4
    _yuLeOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_yuLeOfListButton Title:@"娱乐" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_yuLeOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_yuLeOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_tiYuOfListButton 5
    _tiYuOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_tiYuOfListButton Title:@"体育" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_tiYuOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_tiYuOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_duanZiOfListButton 6
    _duanZiOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_duanZiOfListButton Title:@"段子" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_duanZiOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_duanZiOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_caiJingOfListButton 7
    _caiJingOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_caiJingOfListButton Title:@"财经" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_caiJingOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_caiJingOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_keJiOfListButton 8
    _keJiOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_keJiOfListButton Title:@"科技" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_keJiOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_keJiOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_qiCheOfListButton 9
    _qiCheOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_qiCheOfListButton Title:@"汽车" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_qiCheOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_qiCheOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_sheHuiOfListButton 10
    _sheHuiOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_sheHuiOfListButton Title:@"社会" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_sheHuiOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_sheHuiOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_junShiOfListButton 11
    _junShiOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_junShiOfListButton Title:@"军事" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_junShiOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_junShiOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_NBAOfListButton 12
    _NBAOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_NBAOfListButton Title:@"篮球" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_NBAOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_NBAOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_fangChanOfListButton 13
    _fangChanOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_fangChanOfListButton Title:@"房产" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_fangChanOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_fangChanOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_guPiaoOfListButton 14
    _guPiaoOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_guPiaoOfListButton Title:@"股票" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_guPiaoOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_guPiaoOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    //_jiaJuOfListButton 15
    _jiaJuOfListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonIF:_jiaJuOfListButton Title:@"家居" ImageName:nil StImageName:nil Frame:CGRectMake(chang*i++, 0, chang, 25)];
    [_jiaJuOfListButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_jiaJuOfListButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

}
- (void)setButtonIF:(UIButton *)button Title:(NSString *)title ImageName:(NSString *)image StImageName:(NSString *)selectedImage Frame:(CGRect)frame{
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    button.showsTouchWhenHighlighted = NO;
    button.adjustsImageWhenHighlighted = NO;
    [button setFrame:frame];
    button.adjustsImageWhenDisabled = NO;
    [self addSubview:button];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
