//
//  BaseTable.m
//  FMDB_Detail
//
//  Created by minsol on 2018/5/8.
//  Copyright © 2018年 A8. All rights reserved.
//

#import "BaseTable.h"

@interface BaseTable()
@end

@implementation BaseTable

-(instancetype)initWithDataBase:(FMDatabase *)database{
    self = [super init];
    if (self) {
        self.database = database;
    }
    return self;
}

@end



