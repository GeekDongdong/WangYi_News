//
//  ShouYeTVCell.m
//  WangYi_News
//
//  Created by JACK on 2017/11/3.
//  Copyright © 2017年 JACK. All rights reserved.
//
//#define width self.view.frame.size.width
//#define height self.view.frame.size.height
#import "ShouYeTVCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#define screenLength [UIScreen mainScreen].bounds.size.width

@implementation ShouYeTVCell

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
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 210, 0)];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        //_leftImage
        _leftImage = [[UIImageView alloc]init];        //_timeLabel
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 130, 10)];
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
        shiCha = [NSString stringWithFormat:@"%ld天前",seconds/1440];
    }
    _timeLabel.text = shiCha;
    //添加来源
    _sourceLabel.text = data.channelName;
    
    TVPicModel *picModel = [[TVPicModel alloc]init];
    //添加图片
   if(data.imageurls.count) {
            picModel = data.imageurls[0];
            [_leftImage sd_setImageWithURL:picModel.url placeholderImage:[UIImage imageNamed:@"wangYiImage"]];
            [self addSubview:_leftImage];
   }
}
+(float)setIntroductionText:(ShouYeTVCell *)cell{
    //获得当前cell高度
    CGRect frame = [cell frame];

    //设置label的最大行数
    cell.titleLabel.numberOfLines = 10;
    CGSize size = CGSizeMake((screenLength-30)/4*3, 1000);
    CGSize labelSize = [cell.titleLabel.text sizeWithFont:cell.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    cell.titleLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, 10, labelSize.width, labelSize.height);
    cell.leftImage.frame = CGRectMake(20+(screenLength-30)/4*3, 10, (screenLength-30)/4*1, cell.titleLabel.frame.size.height+30);
    cell.timeLabel.frame = CGRectMake(10, cell.titleLabel.frame.size.height+30, 130, 10);
    cell.sourceLabel.autoresizingMask = YES;
    [cell.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.leftImage).with.offset(-cell.leftImage.frame.size.width-10);
        make.bottom.mas_equalTo(@-10);
        make.height.mas_equalTo(@10);
    }];
    //计算出自适应的高度
    frame.size.height = labelSize.height+50;
    
    cell.frame = frame;
    return frame.size.height;
}

@end
