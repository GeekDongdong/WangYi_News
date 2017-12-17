//
//  ShouYeTVCellOnlyText.m
//  WangYi_News
//
//  Created by JACK on 2017/11/16.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "ShouYeTVCellOnlyText.h"
#import "Masonry.h"
#define screenLength [UIScreen mainScreen].bounds.size.width
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
    //由 NSString 转换为 NSDate:
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString: data.pubDate];
    NSDate *dateNow = [[NSDate alloc]init];
    NSInteger seconds = [dateNow timeIntervalSinceDate:date]/60;
    NSString *shiCha = [[NSString alloc]init];
    if (seconds<60) {
        shiCha = [NSString stringWithFormat:@"%ld分钟前",seconds];
    }else if(seconds<24*60){
        shiCha = [NSString stringWithFormat:@"%ld小时前",seconds/60];
    }else{
        shiCha = [NSString stringWithFormat:@"%ld天前",seconds/3600];
    }
    _timeLabel.text = shiCha;
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
    CGSize size = CGSizeMake(screenLength-20, 1000);
    CGSize labelSize = [cell.titleLabel.text sizeWithFont:cell.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    cell.titleLabel.frame = CGRectMake(10, 10, labelSize.width, labelSize.height);
    cell.timeLabel.frame = CGRectMake(10, cell.titleLabel.frame.size.height+20, 130, 10);
    cell.sourceLabel.autoresizingMask = YES;
    [cell.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell).with.offset(-10);
        make.bottom.mas_equalTo(@-10);
        make.height.mas_equalTo(@10);
    }];
    //计算出自适应的高度
    frame.size.height = labelSize.height+40;
    
    cell.frame = frame;
    return frame.size.height;
}
@end
