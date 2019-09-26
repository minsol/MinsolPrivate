//
//  NSString+EncoderTransfrom.h
//  test
//
//  Created by Minsol on 2019/9/26.
//  Copyright © 2019 Mvm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (EncoderTransfrom)
@property (nonatomic, strong) NSString * urlEncodeString;/** UTF-8  URLEncode */

@property (nonatomic, strong) NSString * base64String;/** base */
@property (nonatomic, strong) NSString * deBase64String;/** base */

@property (nonatomic, strong) NSString * unicodeString;/** Unicode */
@property (nonatomic, strong) NSString * deUnicodeString;/** Unicode */


@property (nonatomic, strong) NSString * md5Of32BitString;/** md5 16位 大写 */
@property (nonatomic, strong) NSString * md5Of16BitString;/** md5 32位 大写 */


@property (nonatomic, strong) NSData * utfData;/** UTF-8 编码 Data */
@property (nonatomic, strong) NSData * hexData;/** 十六进制 字符串转成Data */
@property (nonatomic, strong) NSData * byteData;/** int32_t 转4字节data */

@end

@interface NSData (EncoderTransfrom)

@property (nonatomic, strong) NSString * utfString;/** UTF-8 编码 NSString */
@property (nonatomic, strong) NSString * hexString;/** Data转成十六进制字符串 */
@property (nonatomic, strong) NSString * decimalString;/** 十六进制data 转十进制字符串 */
@end

NS_ASSUME_NONNULL_END
