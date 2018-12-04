//
//  ArticleTable.m
//  FMDB_Detail
//
//  Created by minsol on 2018/5/8.
//  Copyright © 2018年 A8. All rights reserved.
//

#import "ArticleTable.h"

@implementation ArticleTable

///创建文章的TABLE
-(void)createTable{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS article (%@,%@)",
                     @"articleId INTEGER NOT NULL PRIMARY KEY",
                     @"visits INTEGER"];
    BOOL result = [self.database executeUpdate:sql];
    if (result) {
        NSLog(@"建表成功");
    }
}
///在表里面插入数据
-(void)insertArticle:(Article*)article{
    NSArray *array = @[@"articleId",
                       @"visits"];
    NSString *sql = [@"article" sqlInsertFileds:array];
    NSArray *values = @[[NSString stringWithFormat:@"%ld",(long)article.aritcleId.integerValue],
                        [NSString stringWithFormat:@"%ld",(long)article.visits.integerValue]];
    BOOL result = [self.database executeUpdate:sql values:values error:nil];
    if (result) {
        NSLog(@"插入成功");
    }
}
///读取表数据
-(NSArray<Article *>*)select{
    NSString *sql = @"SELECT * FROM article ORDER BY articleId DESC";
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *resultSet = [self.database executeQuery:sql];
    while ([resultSet next]) {
        Article *article = [[Article alloc]init];
        article.aritcleId = [NSNumber numberWithInt:[resultSet intForColumn:@"articleId"]];
        article.visits = [NSNumber numberWithInt:[resultSet intForColumn:@"visits"]];
        [array addObject:article];
    }
    return [NSArray arrayWithArray:array];
}
///更新表数据
-(void)updateArticle:(Article*)article{
    NSString *sql = @"UPDATE article SET visits = ?  WHERE articleId = ?";
    NSArray *values = @[article.visits,article.aritcleId];
    BOOL result = [self.database executeUpdate:sql values:values error:nil];
    if (result) {
        NSLog(@"更新成功");
    }
}
///删除表数据
-(void)deleteArticle:(Article*)article{
    NSString *sql = @"DELETE FROM article WHERE articleId = ?";
    NSArray *values = @[article.aritcleId];
    BOOL result = [self.database executeUpdate:sql values:values error:nil];
    if (result) {
        NSLog(@"删除数据成功");
    }
}

-(void)deleteTable{
    NSString *sql = @"DROP TABLE IF EXISTS article";
    BOOL result = [self.database executeUpdate:sql];
    if (result) {
        NSLog(@"删除表成功");
    }
}

@end
