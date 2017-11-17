//
//  ShouYeTVCellOnlyText.m
//  WangYi_News
//
//  Created by JACK on 2017/11/16.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "ShouYeTVCellOnlyText.h"

@implementation ShouYeTVCellOnlyText

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellEditingStyleNone;
        //_titleLabel
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 355, 0)];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        //_timeLabel
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 130, 10)];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLabel];
        //_sourceLabel
        _sourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(310, 160, 60, 10)];
        _sourceLabel.textColor = [UIColor lightGrayColor];
        _sourceLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_sourceLabel];
    }
    return self;
}
- (void)updateData:(TVcontentlistModel *)data
{
    //添加标题
    _titleLabel.text = data.title;
    //添加时间
    _timeLabel.text = data.pubDate;
    //添加来源
    _sourceLabel.text = data.channelName;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(float)setIntroductionText:(ShouYeTVCellOnlyText *)cell{
    //获得当前cell高度
    CGRect frame = [cell frame];
    
    //设置label的最大行数
    cell.titleLabel.numberOfLines = 10;
    CGSize size = CGSizeMake(355, 1000);
    CGSize labelSize = [cell.titleLabel.text sizeWithFont:cell.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    cell.titleLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, 10, labelSize.width, labelSize.height);
    cell.timeLabel.frame = CGRectMake(10, cell.titleLabel.frame.size.height+20, 130, 10);
    cell.sourceLabel.frame = CGRectMake(310, cell.titleLabel.frame.size.height+20, 60, 10);
    //计算出自适应的高度
    frame.size.height = labelSize.height+40;
    
    cell.frame = frame;
    return frame.size.height;
}
@end
