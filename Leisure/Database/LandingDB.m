//
//  LandingDB.m
//  Leisure
//
//  Created by 若愚 on 16/2/16.
//  Copyright © 2016年 xinghu_wang. All rights reserved.
//

#import "LandingDB.h"

//@property(nonatomic, assign)BOOL isOk;
//@property(nonatomic, strong)NSString *auth;
//@property(nonatomic, strong)NSString *coverimg;
//@property(nonatomic, strong)NSString *icon;
//@property(nonatomic, assign)NSInteger myID;
//@property(nonatomic, strong)NSString *uname;

@implementation LandingDB

+ (sqlite3 *)open
{
    sqlite3 *db = nil;
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"landing.sqlite"];
    NSLog(@"filePath == %@", sqlitePath);
    sqlite3_open([sqlitePath UTF8String], &db);
    sqlite3_exec(db, "create table landing(auth text,coverimg text, icon text, myID integer, uname text)", nil, nil, nil);
    return db;
}

+ (void)addUserInfoWithModel:(LandingModel *)model
{
    sqlite3 *db = [LandingDB open];
    NSString *sql = [NSString stringWithFormat:@"insert into landing values('%@','%@','%@', '%ld', '%@')", model.auth, model.coverimg, model.icon, model.myID, model.uname];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    sqlite3_close(db);
}

+ (LandingModel *)findUserInfoWithName:(NSString *)name
{
    LandingModel *model = [[LandingModel alloc]init];
    sqlite3 *db = [LandingDB open];
    NSString *sql = [NSString stringWithFormat:@"select * from landing where uname='%@'", name];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    NSLog(@"result(one) == %d", result);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *tampAuth = sqlite3_column_text(stmt, 0);
            NSString *auth = [NSString stringWithUTF8String:(const char *)tampAuth];
            const unsigned char *tampCover = sqlite3_column_text(stmt, 1);
            NSString *coverimg = [NSString stringWithUTF8String:(const char *)tampCover];
            const unsigned char *tampIcon = sqlite3_column_text(stmt, 2);
            NSString *icon = [NSString stringWithUTF8String:(const char *)tampIcon];
            const unsigned char *tampUname = sqlite3_column_text(stmt, 4);
            NSString *uname = [NSString stringWithUTF8String:(const char *)tampUname];
            NSInteger myID = sqlite3_column_int(stmt, 3);
            model.auth = auth;
            model.coverimg = coverimg;
            model.icon = icon;
            model.myID = myID;
            model.uname = uname;
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return model;
}

+ (void)deleteUserInfoWithName:(NSString *)name
{
    sqlite3 *db = [LandingDB open];
    NSString *sql = [NSString stringWithFormat:@"delete from landing where name='%@'", name];
    sqlite3_exec(db, [sql UTF8String], nil, nil, nil);
    sqlite3_close(db);
}

+ (NSMutableArray *)selectAllData
{
    NSMutableArray *array = [NSMutableArray array];
    sqlite3 *db = [LandingDB open];
    NSString *sql = [NSString stringWithFormat:@"select * from landing"];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    NSLog(@"result(all) == %d", result);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *tampAuth = sqlite3_column_text(stmt, 0);
            NSString *auth = [NSString stringWithUTF8String:(const char *)tampAuth];
            const unsigned char *tampCover = sqlite3_column_text(stmt, 1);
            NSString *coverimg = [NSString stringWithUTF8String:(const char *)tampCover];
            const unsigned char *tampIcon = sqlite3_column_text(stmt, 2);
            NSString *icon = [NSString stringWithUTF8String:(const char *)tampIcon];
            const unsigned char *tampUname = sqlite3_column_text(stmt, 4);
            NSString *uname = [NSString stringWithUTF8String:(const char *)tampUname];
            NSInteger myID = sqlite3_column_int(stmt, 3);
            LandingModel *model = [[LandingModel alloc]init];
            model.auth = auth;
            model.coverimg = coverimg;
            model.icon = icon;
            model.myID = myID;
            model.uname = uname;
            [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return array;
}

@end
