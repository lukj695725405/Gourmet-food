//
//  NSString+Extension.m
//  ModelArea
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 jinhuadiqigan. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)


- (CGRect)boundsWithFont:(UIFont *)font size:(CGSize)size {
    
    CGRect textRect = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return textRect;
    
}

- (CGSize)hu_sizeWithFont:(UIFont *)font {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    return [self sizeWithAttributes:dict];
}

- (BOOL)isEmpty {
    if (self == nil) {
        return YES;
    }
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str.length == 0;
}

//md5 32位 加密 （小写）
- (NSString *)md5String32 {
    
    const char *cStr = [self UTF8String];
    
    unsigned char result[32];
    
    
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
   // @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
    return [NSString stringWithFormat:@"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
    
}



//md5 16位加密 （大写）

- (NSString *)md5 {
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (BOOL)stringContainsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


- (NSString *)UnicodeStringToString {
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
   
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}


-(NSString *)stringToUnicodeString {
    
    NSUInteger length = [self length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        //unichar _char = [self characterAtIndex:i];
        //判断是否为英文和数字
//        if (_char <= '9' && _char >= '0')
//        {
//            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i, 1)]];
//        }
//        else if(_char >= 'a' && _char <= 'z')
//        {
//            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i, 1)]];
//            
//        }
//        else if(_char >= 'A' && _char <= 'Z')
//        {
//            [s appendFormat:@"%@",[self substringWithRange:NSMakeRange(i, 1)]];
//            
//        }
//        else
//        {
            [s appendFormat:@"\\U%x",[self characterAtIndex:i]];
//        }
    }
    NSLog(@"%@",s);
    return s;
}

- (BOOL)phoneNumberIsAvailable {
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}
//密码
- (BOOL) validatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (NSUInteger)stringToHex {
    NSUInteger hex = strtoul([self UTF8String],0,16);
    return hex;
}

- (NSAttributedString *)appendBackAttachmentNamed:(NSString *)imageNamed {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];

    NSTextAttachment *attachment = [[NSTextAttachment alloc] init ];
    attachment.image = [UIImage imageNamed:imageNamed];
    NSAttributedString *aString = [NSAttributedString attributedStringWithAttachment:attachment];
    NSAttributedString *whitespace = [[NSAttributedString alloc] initWithString:self];
    [attributeStr appendAttributedString:aString];
    [attributeStr appendAttributedString:whitespace];
    return attributeStr;
}

- (NSAttributedString *)appendBehindAttachmentNamed:(NSString *)imageNamed {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init ];
    attachment.image = [UIImage imageNamed:imageNamed];
    NSAttributedString *aString = [NSAttributedString attributedStringWithAttachment:attachment];
    [attributeStr appendAttributedString:aString];
    
    return attributeStr;
}


+ (NSAttributedString *)attributedStringWithAttachments:(NSArray *)images {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];
    if (images && images.count > 0) {
        for (NSInteger i=0; i<images.count; i++) {
            //NSString *image = [NSString stringWithFormat:@"home_goodcell_icon_1"];
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init ];
            attachment.image = [UIImage imageNamed:images[i]];
            NSAttributedString *aString = [NSAttributedString attributedStringWithAttachment:attachment];
            
            NSAttributedString *whitespace = [[NSAttributedString alloc] initWithString:@" "];
            [attributeStr appendAttributedString:aString];
            [attributeStr appendAttributedString:whitespace];
        }
    }
   
    
    return attributeStr;
}

- (BOOL) phoneIs11Numbers {
    NSString *numberRegex = @"^([0-9]{11})$";
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberPredicate evaluateWithObject:self];
    
}


//微信账号
- (BOOL) validatewxNumber
{
    NSString *passWordRegex = @"^[a-zA-Z][a-zA-Z\\d_-]{5,19}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//QQ账号
- (BOOL) validateqqNumber
{
    NSString *passWordRegex = @"^[1-9]\\d{4,10}";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//邮箱
- (BOOL) validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//16到19位的银行卡号
- (BOOL) validateBankCardNumber {
    NSString *numberRegex = @"^([0-9]{16,19})$";
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberPredicate evaluateWithObject:self];
}

// 正则匹配用户身份证号15或18位
- (BOOL)validateUserIdCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


-(BOOL)isZhongWenFirst:(NSString *)firstStr
{
    //是否以中文开头(unicode中文编码范围是0x4e00~0x9fa5)
    int utfCode = 0;
    void *buffer = &utfCode;
    NSRange range = NSMakeRange(0, 1);
    //判断是不是中文开头的,buffer->获取字符的字节数据 maxLength-> buffer的最大长度 usedLength->实际写入的长度，不需要的话可以传递NULL encoding->字符编码常数，不同编码方式转换后的字节长是不一样的，这里我用了UTF16 Little-Endian，maxLength为2字节，如果使用Unicode，则需要4字节 options->编码转换的选项，有两个值，分别是NSStringEncodingConversionAllowLossy和NSStringEncodingConversionExternalRepresentation range->获取的字符串中的字符范围,这里设置的第一个字符 remainingRange->建议获取的范围，可以传递NULL
    BOOL b = [firstStr getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
    if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        return YES;
    else
        return NO;
}

/*! 判断是否是中文*/
- (BOOL)isChineseString{
    
    for (int i = 0; i < self.length; i++) {
        NSRange range=NSMakeRange(i,1);
        NSString *subString=[self substringWithRange:range];
        
        if(![self isZhongWenFirst:subString])
        {
            return NO;
        }
    }
    return YES;
    
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//判读是否是url
- (BOOL)isUrl {
    
    if(self == nil) {
        return NO;
    }
    
    NSString *url;
    if (self.length>4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    }else{
        url = self;
    }
    NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}



//计算单行文本行高、支持包含emoji表情符的计算。开头空格、自定义插入的文本图片不纳入计算范围
//- (CGSize)singleLineSizeWithAttributeText:(UIFont *)font {
//    CTFontRef cfFont = CTFontCreateWithName((CFStringRef) font.fontName, font.pointSize, NULL);
//    CGFloat leading = font.lineHeight - font.ascender + font.descender;
//    CTParagraphStyleSetting paragraphSettings[1] = { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof (CGFloat), &leading };
//
//    CTParagraphStyleRef  paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 1);
//    CFRange textRange = CFRangeMake(0, self.length);
//
//    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, self.length);
//
//    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (CFStringRef) self);
//
//    CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, cfFont);
//    CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle);
//
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
//    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSizeMake(DBL_MAX, DBL_MAX), nil);
//
//    CFRelease(paragraphStyle);
//    CFRelease(string);
//    CFRelease(cfFont);
//    CFRelease(framesetter);
//    return size;
//}

//固定宽度计算多行文本高度，支持包含emoji表情符的计算。开头空格、自定义插入的文本图片不纳入计算范围、
//- (CGSize)multiLineSizeWithAttributeText:(CGFloat)width font:(UIFont *)font {
//    CTFontRef cfFont = CTFontCreateWithName((CFStringRef) font.fontName, font.pointSize, NULL);
//    CGFloat leading = font.lineHeight - font.ascender + font.descender;
//    CTParagraphStyleSetting paragraphSettings[1] = { kCTParagraphStyleSpecifierLineBreakMode, sizeof (CGFloat), &leading };
//    
//    CTParagraphStyleRef  paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 1);
//    CFRange textRange = CFRangeMake(0, self.length);
//    
//    //  Create an empty mutable string big enough to hold our test
//    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, self.length);
//    
//    //  Inject our text into it
//    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (CFStringRef) self);
//    
//    //  Apply our font and line spacing attributes over the span
//    CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, cfFont);
//    CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle);
//    
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
//    
//    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSizeMake(width, DBL_MAX), nil);
//    
//    CFRelease(paragraphStyle);
//    CFRelease(string);
//    CFRelease(cfFont);
//    CFRelease(framesetter);
//    
//    return size;
//}

//计算单行文本宽度和高度，返回值与UIFont.lineHeight一致，支持开头空格计算。包含emoji表情符的文本行高返回值有较大偏差。
- (CGSize)singleLineSizeWithText:(UIFont *)font{
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}


- (NSURL *)urlScheme:(NSString *)scheme {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:self] resolvingAgainstBaseURL:NO];
    components.scheme = scheme;
    return [components URL];
}

+ (NSString *)formatCount:(NSInteger)count {
    if(count < 10000) {
        return [NSString stringWithFormat:@"%ld",(long)count];
    }else {
        return [NSString stringWithFormat:@"%.1fw",count/10000.0f];
    }
}

+(NSDictionary *)readJson2DicWithFileName:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dic;
}

+ (NSString *)currentTime {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time * 1000];
    return timeString;
}



@end
