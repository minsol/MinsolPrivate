//
//  XQFRSATool.h
//  A8TV_IPhone
//
//  Created by Minsol on 2018/10/18.
//  Copyright © 2018 Minsol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSATool : NSObject

/**************************************************************
 *   1. .der 公钥  .p12 私钥
 *   2. 使用公钥加密的数据用私钥解密
 *   3. 使用私钥签名的数据用公钥验证
 *
 *
 *
 *
 *
 *****************************************************************
 */


/**
 *  加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 *  path -> 读取 SecKeyRef -> 加密NSData -> 加密字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;
/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 *  pubKey -> 拼接 SecKeyRef -> 加密NSData -> 加密字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 *  path -> 读取 SecKeyRef -> 解密NSData -> 解密字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 *  privKey -> 拼接 SecKeyRef -> 解密NSData -> 解密字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;

/**
 使用私钥签名数据
 
 @param str 需要签名的字符串
 @param path p12文件路径
 @param password p12文件密码
 @return 签名结果
 */
+ (NSData *)signString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;
/**
 使用私钥签名数据
 
 @param str 需要签名的数据
 @param privateKey 私钥
 @return 签名结果
 */
+ (NSData *)signString:(NSString *)str privateKey:(NSString *)privateKey;

/**
 使用公钥验证签名数据
 
 @param str 要验证的数据
 @param path 公钥路径
 @param signData 签名
 @return 结果
 */
+ (BOOL)verifyString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path signData:(NSData *)signData;

/**
 使用公钥,验证签名数据

 @param str 要验证的数据
 @param publicKey 公钥
 @param signData 签名
 @return 结果
 */
+ (BOOL)verifyString:(NSString *)str publicKey:(NSString *)publicKey signData:(NSData *)signData;



@end
