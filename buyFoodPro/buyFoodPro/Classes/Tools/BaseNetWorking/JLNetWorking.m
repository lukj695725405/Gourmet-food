//
//  JLNetWorking.m
//  ZhongCaoJi
//
//  Created by Alan on 2018/4/10.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "JLNetWorking.h"
#import <AFNetworking.h>

#define HOST @"http://www.wofeikuai.top:8096/"

#define __Fail @"请求失败,请稍后再试~"
@interface JLNetWorking ()

//请求管理session对象
@property (nonatomic,strong) AFHTTPSessionManager * sessionManager;
//请求站点
@property (nonatomic,strong) NSString * baseHost;

@end

@implementation JLNetWorking

//提供全局变量
static JLNetWorking *_instance;

//2.提供类方法
+(instancetype)sharedNetWorking{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(instancetype)init{
    
    if ([super init]) {
        
        _sessionManager = [AFHTTPSessionManager manager];
        
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 请求
        
        //超时时间
        [_sessionManager.requestSerializer setTimeoutInterval:60];
        
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/javascript", nil];
        
        //配置https
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        securityPolicy.allowInvalidCertificates = NO;
        securityPolicy.validatesDomainName = YES;
        
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
        
        if (cerPath) {
            
            NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
            NSSet *cerSet = [NSSet setWithObjects:cerData, nil];
            
            securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
            
            _sessionManager.securityPolicy = securityPolicy;
        }
        
        self.baseHost = HOST;
    }
    return self;
}

//GET请求
+(void)GET:(NSString *)Url parameters:(NSDictionary *)param httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed{
    
    Url = [Url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString * urlString = [[JLNetWorking sharedNetWorking].baseHost stringByAppendingPathComponent:Url];
    
    NSLog(@"GET请求发送的参数:%@==========地址:%@",param,urlString);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
    [[JLNetWorking sharedNetWorking].sessionManager GET:urlString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        JSONLOG(@"接口：%@-------GET响应的json数据----------%@",urlString,[self jsonStringWithObject:responseObject]);
        
        httpSuccess(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSLog(@"请求错误===========%@",error.localizedDescription);
        
        httpFailed(error.localizedDescription);
    }];
}

//POST请求
+(void)POST:(NSString *)Url parameters:(NSDictionary *)param httpSuccess:(void (^)(NSDictionary *dict))httpSuccess httpFailed:(void (^)(NSString *error))httpFailed{
    
    Url = [Url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString * urlString = [[JLNetWorking sharedNetWorking].baseHost stringByAppendingPathComponent:Url];
    
    NSLog(@"POST请求发送的参数:%@==========地址:%@",param,urlString);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });

    [[JLNetWorking sharedNetWorking].sessionManager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
 
        JSONLOG(@"接口：%@-------POST响应的json数据----------%@",urlString,[self jsonStringWithObject:responseObject]);
        
        httpSuccess(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"请求错误===========%@",error.localizedDescription);
        httpFailed(error.localizedDescription);
    }];
}

//图片上传
+(void)uploadImage:(NSString *)Url parameters:(NSDictionary *)param imageData:(NSData *)imageData progress:(void(^)(NSProgress *uploadProgress))progress httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed{
    
    Url = [Url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString * urlString = [[JLNetWorking sharedNetWorking].baseHost stringByAppendingPathComponent:Url];
    
    // [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [[JLNetWorking sharedNetWorking].sessionManager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:[NSDate date]]];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传的进度========%f",uploadProgress.fractionCompleted);
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        JSONLOG(@"响应的json数据----------%@",[self jsonStringWithObject:responseObject]);
        
        httpSuccess(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"图片上传请求错误===========%@",error.localizedDescription);
        httpFailed(error.localizedDescription);
    }];
}

//多图上传 数组为NSData类型
+(void)uploadImageArrURL:(NSString *)Url parameters:(NSDictionary *)param imageDataArr:(NSArray *)imageDataArr progress:(void(^)(NSProgress *uploadProgress))progress httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed{
    
    Url = [Url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString * urlString = [[JLNetWorking sharedNetWorking].baseHost stringByAppendingPathComponent:Url];
    
    // [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [[JLNetWorking sharedNetWorking].sessionManager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        for (int i = 0; i < imageDataArr.count; i++) {
           NSString *fileName = [NSString stringWithFormat:@"%@_%d.jpg",[formatter stringFromDate:[NSDate date]],i];
             [formData appendPartWithFileData:imageDataArr[i] name:@"file[]" fileName:fileName mimeType:@"image/jpeg"];
        }
      
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
       
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
//        JSONLOG(@"响应的json数据----------%@",[self jsonStringWithObject:responseObject]);
        
        httpSuccess(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"图片上传请求错误===========%@",error.localizedDescription);
        httpFailed(error.localizedDescription);
    }];
}




//视频上传
+(void)uploadVideo:(NSString *)Url parameters:(NSDictionary *)param videoData:(NSData *)videoData progress:(void(^)(NSProgress *uploadProgress))progress httpSuccess:(void(^)(NSDictionary *dict))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed{
    
    Url = [Url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString * urlString = [[JLNetWorking sharedNetWorking].baseHost stringByAppendingPathComponent:Url];
    
    // [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [[JLNetWorking sharedNetWorking].sessionManager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *fileName = [NSString stringWithFormat:@"%@.mp4",[formatter stringFromDate:[NSDate date]]];
        
        [formData appendPartWithFileData:videoData name:@"note_video" fileName:fileName mimeType:@"video/mp4"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传的进度========%f",uploadProgress.fractionCompleted);
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        JSONLOG(@"响应的json数据----------%@",[self jsonStringWithObject:responseObject]);
        
        httpSuccess(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"图片上传请求错误===========%@",error.localizedDescription);
        httpFailed(error.localizedDescription);
    }];
}

//文件下载
+(void)downloadWithUrl:(NSURL *)url progress:(void(^)(NSProgress * downloadProgress))progress destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination completionHandler:(void (^)(NSURLResponse * response,NSURL * filePath,NSError * error))completionHandler{

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];

    NSURLSessionDownloadTask * downloadTask = [[JLNetWorking sharedNetWorking].sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {

        progress(downloadProgress);

    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return destination(targetPath,response);

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        completionHandler(response,filePath,error);
    }];

    //开始下载
    [downloadTask resume];
}

//获取页面GET请求
+(void)GETHTML:(NSString *)Url parameters:(NSDictionary *)param httpSuccess:(void(^)(NSString * htmlString))httpSuccess httpFailed:(void(^)(NSString *error))httpFailed{
    
    Url = [Url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString * urlString = [[JLNetWorking sharedNetWorking].baseHost stringByAppendingPathComponent:Url];
    
    NSLog(@"GET请求发送的参数:%@==========地址:%@",param,urlString);
    
    [[JLNetWorking sharedNetWorking].sessionManager GET:urlString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * htmlString = [self jsonStringWithObject:responseObject];
        
        JSONLOG(@"GET响应的json数据----------%@",htmlString);
        
        httpSuccess(htmlString);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        httpFailed(error.localizedDescription);
        
    }];
}

//打印json串
+(NSString *)jsonStringWithObject:(id)jsonObj{
    
    NSString *jsonString = [[NSString alloc] initWithData:(NSData *)jsonObj encoding:NSUTF8StringEncoding];
    
    return [jsonString description];
}

//调用C语言的API来获得文件的MIMEType ，只能获取本地文件哦，无法获取网络请求来的文件
+(NSString *)getMIMETypeWithCAPIAtFilePath:(NSString *)path {
    
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        
        return @"application/octet-stream";
    }
    return (__bridge NSString *)(MIMEType);
}

@end
