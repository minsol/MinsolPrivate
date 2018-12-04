//
//  NSData+AES.h
//  demo
//
//  Created by Minsol on 2018/12/4.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密

@end
