//
//  JLNetWorking.h
//  ZhongCaoJi
//
//  Created by Alan on 2018/4/10.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLNetWorking : NSObject

//单例
//+(instancetype)sharedNetWorking;

/**
 GET请求
 
 @param Url 请求地址
 @param param 参数
 @param httpSuccess 成功后回调
 @param httpFailed 失败后回调
 */
+(void)GET:(NSString *)Url parameters:(NSDictionary *)param httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed;

/**
 POST请求
 
 @param Url 请求地址
 @param param 参数
 @param httpSuccess 成功后回调
 @param httpFailed 失败后回调
 */
+(void)POST:(NSString *)Url parameters:(NSDictionary *)param httpSuccess:(void (^)(NSDictionary *dict))httpSuccess httpFailed:(void (^)(NSString *error))httpFailed;

/**
 图片上传
 
 @param Url 请求地址
 @param param 参数
 @param imageData 上传的数据
 @param progress 上传进度
 @param httpSuccess 成功后回调
 @param httpFailed 失败后回调
 */
+(void)uploadImage:(NSString *)Url parameters:(NSDictionary *)param imageData:(NSData *)imageData progress:(void(^)(NSProgress *uploadProgress))progress httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed;


//视频上传
+(void)uploadVideo:(NSString *)Url parameters:(NSDictionary *)param videoData:(NSData *)videoData progress:(void(^)(NSProgress *uploadProgress))progress httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed;

/**
 文件下载
 */
+(void)downloadWithUrl:(NSURL *)url progress:(void(^)(NSProgress * downloadProgress))progress destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse * response,NSURL * filePath,NSError * error))completionHandler;

//获取页面GET请求
+(void)GETHTML:(NSString *)Url parameters:(NSDictionary *)param httpSuccess:(void(^)(NSString * htmlString))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed;



+(void)uploadImageArrURL:(NSString *)Url parameters:(NSDictionary *)param imageDataArr:(NSArray *)imageDataArr progress:(void(^)(NSProgress *uploadProgress))progress httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed;

@end
