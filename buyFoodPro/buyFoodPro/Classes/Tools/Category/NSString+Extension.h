//
//  NSString+Extension.h
//  ModelArea
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 jinhuadiqigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGRect)boundsWithFont:(UIFont *)font size:(CGSize)size;
- (CGSize)hu_sizeWithFont:(UIFont *)font;
- (NSString *)md5String32;
- (NSString *)md5;
- (BOOL)stringContainsEmoji;

- (BOOL)isEmpty;

/**
 *  Unicode string转化为 NSString
 */
- (NSString *)UnicodeStringToString;

/**
 *  NSString 转化为 Unicode string
 */
-(NSString *)stringToUnicodeString;

- (BOOL)phoneNumberIsAvailable;

- (BOOL) phoneIs11Numbers;
/**
 *  判断密码是否合法
 */
- (BOOL) validatePassword;
/*!判断QQ账号*/
- (BOOL) validateqqNumber;
/*!判断微信账号*/
- (BOOL) validatewxNumber;
/*!邮箱*/
- (BOOL) validateEmail;
/*! 16到19位的银行卡号*/
- (BOOL) validateBankCardNumber;
/*! 判断是否是中文*/
- (BOOL)isChineseString;
/*! 匹配用户身份证号15或18位*/ 
- (BOOL)validateUserIdCard;
/**
 *  字符串转十六进制数
 *
 *  @return 转换后的十六进制数
 */
- (NSUInteger)stringToHex;

/**根据图片名生成带图片的文字, 文字在后*/
- (NSAttributedString *)appendBackAttachmentNamed:(NSString *)imageNamed;

/**根据图片名生成带图片的文字, 文字在前*/
- (NSAttributedString *)appendBehindAttachmentNamed:(NSString *)imageNamed;

/**根据图片名生成文字*/
+ (NSAttributedString *)attributedStringWithAttachments:(NSArray *)images;


/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


//判读是否是url
- (BOOL)isUrl;


- (CGSize)singleLineSizeWithAttributeText:(UIFont *)font;

- (CGSize)multiLineSizeWithAttributeText:(CGFloat)width font:(UIFont *)font;

- (CGSize)singleLineSizeWithText:(UIFont *)font;


- (NSURL *)urlScheme:(NSString *)scheme;

+ (NSString *)formatCount:(NSInteger)count;

+(NSDictionary *)readJson2DicWithFileName:(NSString *)fileName;

+ (NSString *)currentTime;


@end
