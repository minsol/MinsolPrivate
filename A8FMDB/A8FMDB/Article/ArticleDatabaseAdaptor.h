//
//  ArticleDatabaseAdaptor.h
//  FMDB_Detail
//
//  Created by Minsol on 2018/12/4.
//  Copyright © 2018 A8. All rights reserved.
//

#import "DatabaseAdaptor.h"
#import "ArticleTable.h"

@interface ArticleDatabaseAdaptor : DatabaseAdaptor

#pragma mark - -/**********************Article*************************************/
///文章Table的操作
-(void)insertArticle:(Article*)article;
-(void)deleteArticle:(Article*)article;
-(void)updateArticle:(Article*)article;
-(NSArray<Article *>*)articleInfoList;
-(void)deleteArticleTable;

@end
