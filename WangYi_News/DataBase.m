//
//  DataBase.m
//  WangYi_News
//
//  Created by JACK on 2017/12/21.
//  Copyright © 2017年 JACK. All rights reserved.
//

#import "DataBase.h"
#import "FMDB.h"

static DataBase *_DBCtl = nil;

@implementation DataBase{
    FMDatabase  *_db;
}
+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}
-(void)initDataBase{
//    // 获得Documents目录路径
//    
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    // 文件路径
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:@"/Users/jack/Public/iOS/tmp.db"];
    NSLog(@"/////////////// %d",    [_db open]);

    
    // 初始化数据表
    NSString *news = @"create table 'news' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'news_title' VARCHAR(255),'news_channelName' VARCHAR(255),'news_date' VARCHAR(255),'news_link',VARCHAR(255) ,'news_html' VARCHAR(255),'news_imageurls' VARCHAR(255))";
    
    NSLog(@"------------------ %d",[_db executeUpdate:news]);
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addNews:(TVOrderModel *)orderModel{
    [_db open];
    int num = (int)orderModel.showapi_res_body.pagebean.contentlist.count;
    if(num>10){
        num = 10;
    }
    TVcontentlistModel *contentlistModel = [[TVcontentlistModel alloc]init];
    for(int i=0;i<num;i++){
        contentlistModel = orderModel.showapi_res_body.pagebean.contentlist[i];
        [_db executeUpdate:@"INSERT INTO news(news_title,news_channelName,news_pubDate,news_link,news_html,news_imageurls)VALUES(?,?,?,?)",contentlistModel.title,contentlistModel.channelName,contentlistModel.pubDate,contentlistModel.link,contentlistModel.html,contentlistModel.imageurls];
    }
    [_db close];
    
}
- (void)updateNews:(TVOrderModel *)orderModel{
    [_db open];
    
//    int num = (int)orderModel.showapi_res_body.pagebean.contentlist.count;
//    TVcontentlistModel *tvModel = [[TVcontentlistModel alloc]init];
//    for(int i=0;i<num;i++){
//        tvModel = orderModel.showapi_res_body.pagebean.contentlist[i];
//        [_db executeUpdate:@"UPDATE INTO person(news_title,news_channelName,news_pubDate,news_link,news_html,news_imageurls)VALUES(?,?,?,?)",tvModel.title,tvModel.channelName,tvModel.pubDate,tvModel.pubDate,tvModel.html,tvModel.imageurls];
//    }
    [_db close];

}
- (NSMutableArray *)getAllPerson{
    [_db open];
    
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM news"];
    
    while ([res next]) {
        TVcontentlistModel *contentlistModel = [[TVcontentlistModel alloc] init];
        contentlistModel.title = [res stringForColumn:@"news_title"];
        contentlistModel.channelName = [res stringForColumn:@"news_channelName"];
        contentlistModel.pubDate = [res stringForColumn:@"news_pubDate"];
        contentlistModel.link = [res stringForColumn:@"news_link"];
        contentlistModel.html = [res stringForColumn:@"news_html"];
        contentlistModel.imageurls = [res objectForColumn:@"news_imageurls"];
        [_contentlistAll addObject:contentlistModel];
        
    }
    
    [_db close];
    
    
    
    return _contentlistAll;
    
    
}

@end
