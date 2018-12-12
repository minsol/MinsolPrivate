//
//  DictionaryParamMaker.h
//  demo
//
//  Created by Minsol on 2018/12/12.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionaryParamMaker : NSObject

typedef DictionaryParamMaker *(^AddParamSetBlock)(NSString *key, id object);

@property (strong, nonatomic) NSMutableDictionary *paramDictionary;

- (instancetype)initDictionary:(NSDictionary*)dicTionary;

- (AddParamSetBlock)addParam;

@end
