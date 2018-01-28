//
//  News.h
//  WangYi_News
//
//  Created by JACK on 2017/12/21.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *channelName;
@property (copy, nonatomic) NSString *pubDate;
@property (copy, nonatomic) NSString *link;
@property (copy, nonatomic) NSString *html;
@property (copy, nonatomic) NSString *imageurls;

@end
