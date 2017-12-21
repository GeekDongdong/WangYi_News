//
//  TVOrderModel.h
//  WangYi_News
//
//  Created by JACK on 2017/11/6.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "JSONModel.h"
#import "TVOrderModel.h"

@protocol TVcontentlistModel
@end
@protocol TVPicModel
@end
@interface TVPicModel : JSONModel
@property (copy, nonatomic) NSURL<Optional> *url;
@end

@interface TVcontentlistModel :JSONModel
@property (copy, nonatomic) NSString<Optional> *title;
@property (copy, nonatomic) NSString<Optional> *channelName;
@property (copy, nonatomic) NSString<Optional> *pubDate;
@property (copy, nonatomic) NSString<Optional> *link;
@property (copy, nonatomic) NSString<Optional> *html;
@property (strong, nonatomic) NSArray <TVPicModel,Optional> *imageurls;

@end

@interface TVpagebeanModel :JSONModel
@property (copy, nonatomic) NSNumber<Optional> *allNum;
@property (strong, nonatomic) NSArray<TVcontentlistModel,Optional> *contentlist;
@end

@interface  TVbodyModel: JSONModel
@property (strong, nonatomic)  TVpagebeanModel *pagebean;
@end

@interface  TVOrderModel: JSONModel
@property (strong, nonatomic)  TVbodyModel *showapi_res_body;
@end



