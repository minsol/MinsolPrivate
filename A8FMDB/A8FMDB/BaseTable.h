//
//  BaseTable.h
//  FMDB_Detail
//
//  Created by minsol on 2018/5/8.
//  Copyright © 2018年 A8. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface BaseTable : NSObject
@property (nonatomic, strong) FMDatabase *database;/**< 数据库 */
-(instancetype)initWithDataBase:(FMDatabase *)database;
-(void)createTable;
-(void)deleteTable;
@end

@interface NSString (SqlInsert)
-(NSString *)sqlInsertFileds:(NSArray*)fileds;
@end

@implementation NSString (SqlInsert)
-(NSString *)sqlInsertFileds:(NSArray*)fileds{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:fileds.count];
    [fileds enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:@"?"];
    }];
    return [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",self,[fileds componentsJoinedByString:@","],[result componentsJoinedByString:@","]];
}

@end
