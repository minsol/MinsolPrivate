//
//  DatabaseAdaptor.m
//  FMDB_Detail
//
//  Created by minsol on 2018/5/8.
//  Copyright © 2018年 A8. All rights reserved.
//

#import "DatabaseAdaptor.h"
#import "FMDatabase.h"

@interface DatabaseAdaptor()

@end

@implementation DatabaseAdaptor

+ (instancetype)sharedInstance {
    static DatabaseAdaptor *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

/**
 init
 子类需要重写
 并且需要创建相关的表实例
 ///2.创建文章表的数据库
 FMDatabase *database = [FMDatabase databaseWithPath:[self.databaseDictionaryPath stringByAppendingPathComponent:self.articleDatabaseFileName]];
 database.logsErrors = YES;
 if ([database open]) {
 ///3.创建文章的表--并且持有本数据库
 self.articleTable = [[ArticleTable alloc]initWithDataBase: database];
 [self.articleTable createTable];
 }
 
 @return instancetype
 */
-(instancetype)init{
    self = [ super init];
    if (self) {
        ///1.创建默认数据库的路径文件夹
        self.databaseDictionaryPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"database"];
        if (![NSFileManager.defaultManager fileExistsAtPath:self.databaseDictionaryPath]){
            [NSFileManager.defaultManager createDirectoryAtPath:self.databaseDictionaryPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return self;
}





#pragma mark - -/**************************lazy load*********************************/
-(NSString *)databaseDictionaryPath{
    if (!_databaseDictionaryPath) {
        NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _databaseDictionaryPath = [str stringByAppendingPathComponent:@"database"];
    }
    return _databaseDictionaryPath;
}






@end
