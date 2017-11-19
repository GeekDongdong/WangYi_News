//
//  ShouYeTVCellTwo.m
//  WangYi_News
//
//  Created by JACK on 2017/11/15.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "ShouYeTVCellTwo.h"
#import "UIImageView+WebCache.h"

@implementation ShouYeTVCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellEditingStyleNone;
        //_titleLabel
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 355, 0)];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        //_leftImage
        _leftImage = [[UIImageView alloc]init];
        [self addSubview:_leftImage];
        //_middleImage
        _middleImage = [[UIImageView alloc]init];
        [self addSubview:_middleImage]; 
        //_rightImage
        _rightImage = [[UIImageView alloc]init];
        [self addSubview:_rightImage];
        //_timeLabel
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_timeLabel];
        //_sourceLabel
        _sourceLabel = [[UILabel alloc]init];
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
    
    TVPicModel *picModel = [[TVPicModel alloc]init];
    //添加图片
        picModel = data.imageurls[0];
        [_leftImage sd_setImageWithURL:picModel.url placeholderImage:[UIImage imageNamed:@"wangYiImage"]];
        picModel = data.imageurls[1];
        [_middleImage sd_setImageWithURL:picModel.url placeholderImage:[UIImage imageNamed:@"wangYiImage"]];
        picModel = data.imageurls[2];
        [_rightImage sd_setImageWithURL:picModel.url placeholderImage:[UIImage imageNamed:@"wangYiImage"]];

}
+(float)setIntroductionText:(ShouYeTVCellTwo *)cell{
    //获得当前cell高度
    CGRect frame = [cell frame];
    
    //设置label的最大行数
    cell.titleLabel.numberOfLines = 10;
    CGSize size = CGSizeMake(355, 1000);
    CGSize labelSize = [cell.titleLabel.text sizeWithFont:cell.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    cell.titleLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, 10, labelSize.width, labelSize.height);
    cell.leftImage.frame = CGRectMake(10, cell.titleLabel.frame.size.height+20, 110, 70);
    cell.middleImage.frame = CGRectMake(130, cell.titleLabel.frame.size.height+20, 110, 70);
    cell.rightImage.frame = CGRectMake(250, cell.titleLabel.frame.size.height+20, 110, 70);
    cell.timeLabel.frame = CGRectMake(10,  cell.titleLabel.frame.size.height+100, 130, 10);
    cell.sourceLabel.frame = CGRectMake(310, cell.titleLabel.frame.size.height+100, 60, 10);
    //计算出自适应的高度
    frame.size.height = labelSize.height+120;
    
    cell.frame = frame;
    return frame.size.height;
}
@end
