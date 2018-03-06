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
    
    _db = [FMDatabase databaseWithPath:@"/Users/jack/Public/iOS/fmdb.db"];
    [_db open];

    
    // 初始化数据表
    NSString *news = @"CREATE TABLE IF NOT EXISTS news(id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,title VARCHAR(255),channelName VARCHAR(255),pubDate VARCHAR(255),link VARCHAR(255) ,picUrls blob not null)";
    
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
        NSData *dataImageUrls = [NSKeyedArchiver archivedDataWithRootObject:contentlistModel.imageurls];
        NSLog(@"+++++++++%d",[_db executeUpdate:@"INSERT INTO news(title,channelName,pubDate,link,picUrls)VALUES(?,?,?,?,?)",contentlistModel.title,contentlistModel.channelName,contentlistModel.pubDate,contentlistModel.link,dataImageUrls]);
    }

    
    [_db close];
    
}
- (void)updateNews:(TVOrderModel *)orderModel{
    [_db open];
    
    int num = (int)orderModel.showapi_res_body.pagebean.contentlist.count;
    if(num>10){
        num = 10;
    }
    TVcontentlistModel *contentlistModel = [[TVcontentlistModel alloc]init];
    for(int i=0;i<num;i++){
        contentlistModel = orderModel.showapi_res_body.pagebean.contentlist[i];
        NSData *dataImageUrls = [NSKeyedArchiver archivedDataWithRootObject:contentlistModel.imageurls];
        NSLog(@"------%d",[_db executeUpdate:@"UPDATE news set title = ?,channelName = ?,pubDate = ?,link = ?,picUrls = ?",contentlistModel.title,contentlistModel.channelName,contentlistModel.pubDate,contentlistModel.link,dataImageUrls]);
    }
    
    [_db close];

}
- (NSMutableArray *)getAllPerson{
    [_db open];
    
    FMResultSet *res = [_db executeQuery:@"select * from news"];
    _contentlistAll = [NSMutableArray array];

    while ([res next]) {

        TVcontentlistModel *contentlistModel = [[TVcontentlistModel alloc]init];
        contentlistModel.channelName = [res stringForColumn:@"channelName"];
        contentlistModel.pubDate = [res stringForColumn:@"pubDate"];
        contentlistModel.title = [res stringForColumn:@"title"];
        contentlistModel.link = [res stringForColumn:@"link"];
        NSArray <TVPicModel,Optional>* dataImageUrlsArray = [NSKeyedUnarchiver unarchiveObjectWithData:[res dataForColumn:@"picUrls"]];
        contentlistModel.imageurls = dataImageUrlsArray;
        
        [_contentlistAll addObject:contentlistModel];
    }
    [_db close];
    NSLog(@"%@",_contentlistAll);
    return _contentlistAll;
    
}
//判断数据库里数据是否为空
//YES==存在
//NO==不存在
-(BOOL)isNilOrNot{
    [_db open];
    FMResultSet *res = [_db executeQuery:@"select * from news"];
    [res next];
    if ([res resultDictionary]) {
        [_db close];
        return YES;
    }else{
        [_db close];
        return NO;
    }
}

@end
