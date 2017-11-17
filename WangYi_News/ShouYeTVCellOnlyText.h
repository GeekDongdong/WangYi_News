//
//  ShouYeTVCellOnlyText.h
//  WangYi_News
//
//  Created by JACK on 2017/11/16.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVOrderModel.h"

@interface ShouYeTVCellOnlyText : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
- (void)updateData:(TVcontentlistModel *)data;
+(float)setIntroductionText:(ShouYeTVCellOnlyText *)shouYeTVCellOnlyText;
@end
