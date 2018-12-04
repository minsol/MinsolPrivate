//
//  ArticleTable.h
//  FMDB_Detail
//
//  Created by minsol on 2018/5/8.
//  Copyright © 2018年 A8. All rights reserved.
//

#import "BaseTable.h"
#import "Article.h"

@interface ArticleTable : BaseTable
-(void)insertArticle:(Article*)article;
-(void)deleteArticle:(Article*)article;
-(void)updateArticle:(Article*)article;
-(NSArray<Article *>*)select;
@end
