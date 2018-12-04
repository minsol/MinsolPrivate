//
//  DatabaseAdaptor.h
//  FMDB_Detail
//
//  Created by minsol on 2018/5/8.
//  Copyright © 2018年 A8. All rights reserved.
//

#import <Foundation/Foundation.h>

///数据库的管理类-----以后添加的表格在都在这个类里面添加
@interface DatabaseAdaptor : NSObject
@property (nonatomic, strong) NSString *databaseDictionaryPath;/**< 数据库路径 */

+ (instancetype)sharedInstance; /**< 单例 */

@end
