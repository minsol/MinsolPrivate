//
//  ArticleDatabaseAdaptor.m
//  FMDB_Detail
//
//  Created by Minsol on 2018/12/4.
//  Copyright © 2018 A8. All rights reserved.
//

#import "ArticleDatabaseAdaptor.h"

@interface ArticleDatabaseAdaptor()

@property (nonatomic, strong) ArticleTable *articleTable;/**< 文章表 */
@property (nonatomic, strong) NSString *articleDatabaseFileName;/**< 数据库名称 */

@end
@implementation ArticleDatabaseAdaptor

-(instancetype)init{
    self = [ super init];
    if (self) {
///如果有需要删除数据库
//        if (YES) {
//            [NSFileManager.defaultManager removeItemAtPath:self.databaseDictionaryPath error:nil];
//        }
        ///1.创建数据库的路径文件夹
//        self.databaseDictionaryPath = @"新的路径"
//        if (![NSFileManager.defaultManager fileExistsAtPath:self.databaseDictionaryPath]){
//            [NSFileManager.defaultManager createDirectoryAtPath:self.databaseDictionaryPath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
        ///2.创建文章表的数据库
        FMDatabase *database = [FMDatabase databaseWithPath:[self.databaseDictionaryPath stringByAppendingPathComponent:self.articleDatabaseFileName]];
        database.logsErrors = YES;
        if ([database open]) {
            ///3.创建文章的表--并且持有本数据库
            self.articleTable = [[ArticleTable alloc]initWithDataBase: database];
            [self.articleTable createTable];
        }
    }
    return self;
}

#pragma mark - -/***********************文章************************************/
-(void)insertArticle:(Article*)article{
    [self.articleTable insertArticle:article];
}

-(NSArray<Article *>*)articleInfoList{
    return [self.articleTable select];
}
-(void)deleteArticle:(Article*)article{
    [self.articleTable deleteArticle:article];
}
-(void)updateArticle:(Article*)article{
    [self.articleTable updateArticle:article];
}
-(void)deleteArticleTable{
    [self.articleTable deleteTable];
}

#pragma mark - -/**************************lazy load*********************************/
-(NSString *)articleDatabaseFileName{
    if (!_articleDatabaseFileName) {
        _articleDatabaseFileName = @"article.db";
    }
    return _articleDatabaseFileName;
}

@end
