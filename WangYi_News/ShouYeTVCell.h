//
//  ShouYeTVCell.h
//  WangYi_News
//
//  Created by JACK on 2017/11/3.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVOrderModel.h"


@interface ShouYeTVCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
- (void)updateData:(TVcontentlistModel *)data;
+(float)setIntroductionText:(ShouYeTVCell *)shouYeTVCell;
@end
