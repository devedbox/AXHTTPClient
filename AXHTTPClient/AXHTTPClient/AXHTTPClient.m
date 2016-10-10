//
//  AXHTTPClient.m
//  AXHTTPClient
//
//  Created by devedbox on 16/8/19.
//  Copyright © 2016年 devedbox. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "AXHTTPClient.h"
#import "AXResponseObject.h"
#import <objc/runtime.h>
#import <AXAESCrypt/AESCrypt.h>
#import <CocoaSecurity/Base64.h>
#import <MJExtension/MJExtension.h>
#import <JYObjectModule/JYRLMObject.h>
#import <CocoaSecurity/CocoaSecurity.h>
#import <JYObjectModule/JYRealmManager.h>
#import <JYObjectModule/RLMObject+KeyValue.h>
#import <AXExtensions/NSString+AXExtensions.h>

NSString *const AXHTTPClientInfoBaseURLKey = @"AXHTTPClientInfoBaseURLKey";
NSString *const AXHTTPCompletionUserInfoDurationKey = @"AXHTTPCompletionUserInfoDurationKey";
NSString *const AXHTTPCompletionUserInfoStatusInfoKey = @"AXHTTPCompletionUserInfoStatusInfoKey";
NSString *const AXHTTPCompletionUserInfoStatusCodeKey = @"AXHTTPCompletionUserInfoStatusCodeKey";

@implementation AXHTTPClient
+ (instancetype)sharedClient {
    static AXHTTPClient *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = [self timeoutIntervalForRequest];
        NSDictionary *clientInfo = [NSDictionary dictionaryWithContentsOfFile:[self infoPlistPath]];
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:[clientInfo objectForKey:AXHTTPClientInfoBaseURLKey]] sessionConfiguration:configuration];
    });
    return _sharedInstance;
}

+ (NSString *)infoPlistPath {
    // Sample:
    return [[NSBundle bundleForClass:[AXHTTPClient class]] pathForResource:@"AXHTTPClient.bundle/AXHTTPClientInfoSample" ofType:@"plist"];
}

+ (NSTimeInterval)timeoutIntervalForRequest {
    return 30.0;
}

- (NSString *)tokenForSerializer {
    return @"token_sample";
}

- (NSString *)encryptForSerializer {
    return @"encypt_sample";
}

#pragma mark - Override
- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super GET:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)HEAD:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super HEAD:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super PUT:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super POST:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil]];
    /*
     [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"enctype"];
     if (!self.isSecure) {
     [self.requestSerializer setValue:[AXUserRealm defaultUserRealm].token forHTTPHeaderField:@"Authorization"];
     }
     */
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:block success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block progress:(void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil]];
    /*
     [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"enctype"];
     if (!self.isSecure) {
     [self.requestSerializer setValue:[AXUserRealm defaultUserRealm].token forHTTPHeaderField:@"Authorization"];
     }
     */
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super PATCH:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure
{
    [self setDefaultSerializer];
    return [super DELETE:URLString parameters:parameters success:success failure:failure];
}

#pragma mark - Public

- (void)setDefaultSerializer
{
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    self.requestSerializer = requestSerializer;
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    if (_securityEnabled) {
        NSString *token = [self tokenForSerializer];
        NSAssert(token, @"Token cannnot be nil, or the request will fail.");
        if (token && token.length > 0) {
            [self.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
        }
        NSString *AESKey = [self encryptForSerializer];
        NSAssert(AESKey, @"AESKey to encrypt signature cannot be nil");
        if (!(AESKey && AESKey.length > 0)) {
            return;
        }
        
        NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
        NSArray *uuidCompnents = [uuid componentsSeparatedByString:@"-"];
        NSMutableString *_uuid = [[NSMutableString alloc] init];
        for (NSInteger i = 0; i < uuidCompnents.count; i ++) {
            [_uuid appendString:uuidCompnents[i]];
        }
        uuid = [_uuid copy];
        NSString *randomString = [self getRandomStringWithBit:32 isLower:NO];
        
        NSString *originalString = [NSString stringWithFormat:@"%@#%@", uuid, randomString];
        
        NSString *signature = [[[originalString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:AESKey] base64EncodedString];
#if kAXAuthorization_t
        NSMutableArray *signatures = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            NSString *uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
            NSArray *uuidCompnents = [uuid componentsSeparatedByString:@"-"];
            NSMutableString *_uuid = [[NSMutableString alloc] init];
            for (NSInteger i = 0; i < uuidCompnents.count; i ++) {
                [_uuid appendString:uuidCompnents[i]];
            }
            uuid = [_uuid copy];
            NSString *randomString = [NSString getRandomStringWithBit:32 isLower:NO];
            
            NSString *originalString = [NSString stringWithFormat:@"%@#%@", uuid, randomString];
            
            NSString *signature = [[[originalString dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:AESKey] base64EncodedString];
            
            [signatures addObject:signature];
        }
        NSLog(@"%@",token);
        for (NSString *signature in signatures) {
            NSLog(@"\n%@\n", signature);
        }
#endif
        
        [self.requestSerializer setValue:signature forHTTPHeaderField:@"Content-Signature"];
    }
}

- (NSURLSessionDataTask *_Nullable)GET:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion
{
    objc_setAssociatedObject(self, _cmd, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self GET:request.URLString parameters:request.parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                [self handleRequestSuccessWithResponseObject:responseObject shouldStoreToRealm:request.shouldStoreToRealm requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] compltion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                [self handleRequestFailureWithTask:task error:error requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] completion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
}
- (NSURLSessionDataTask *_Nullable)HEAD:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion
{
    objc_setAssociatedObject(self, _cmd, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self HEAD:request.URLString parameters:request.parameters success:^(NSURLSessionDataTask * _Nonnull task) {
        [self handleRequestSuccessWithResponseObject:nil shouldStoreToRealm:request.shouldStoreToRealm requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] compltion:completion];
        objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self handleRequestFailureWithTask:task error:error requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] completion:completion];
        objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }];
}
- (NSURLSessionDataTask *_Nullable)PUT:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion
{
    objc_setAssociatedObject(self, _cmd, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self PUT:request.URLString parameters:request.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
            {
                [self handleRequestSuccessWithResponseObject:responseObject shouldStoreToRealm:request.shouldStoreToRealm requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] compltion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                [self handleRequestFailureWithTask:task error:error requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] completion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
}
- (NSURLSessionDataTask *_Nullable)POST:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion
{
    objc_setAssociatedObject(self, _cmd, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self POST:request.URLString parameters:request.parameters progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                [self handleRequestSuccessWithResponseObject:responseObject shouldStoreToRealm:request.shouldStoreToRealm requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] compltion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
            {
                [self handleRequestFailureWithTask:task error:error requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] completion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
}
- (NSURLSessionDataTask *_Nullable)POST:(AXHTTPClientRequest *_Nonnull)request constructingBodyWithBlock:(void (^ _Nullable)(id<AFMultipartFormData> _Nonnull))block completion:(AXHTTPCompletion _Nullable)completion
{
    objc_setAssociatedObject(self, _cmd, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self POST:request.URLString parameters:request.parameters constructingBodyWithBlock:block progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
            {
                [self handleRequestSuccessWithResponseObject:responseObject shouldStoreToRealm:request.shouldStoreToRealm requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] compltion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestFailureWithTask:task error:error requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] completion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
}
- (NSURLSessionDataTask *_Nullable)PATCH:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion
{
    objc_setAssociatedObject(self, _cmd, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self PATCH:request.URLString parameters:request.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
            {
                [self handleRequestSuccessWithResponseObject:responseObject shouldStoreToRealm:request.shouldStoreToRealm requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] compltion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                [self handleRequestFailureWithTask:task error:error requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] completion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
}
- (NSURLSessionDataTask *_Nullable)DELETE:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion
{
    objc_setAssociatedObject(self, _cmd, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self DELETE:request.URLString parameters:request.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
            {
                [self handleRequestSuccessWithResponseObject:responseObject shouldStoreToRealm:request.shouldStoreToRealm requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] compltion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                [self handleRequestFailureWithTask:task error:error requestDuration:[[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(self, _cmd)] completion:completion];
                objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }];
}

- (void)handleRequestSuccessWithResponseObject:(id)object shouldStoreToRealm:(BOOL)storeToRealm requestDuration:(NSTimeInterval)duration compltion:(AXHTTPCompletion)completion
{
    NSMutableDictionary *userInfo = [@{AXHTTPCompletionUserInfoDurationKey:@(duration)} mutableCopy];
    
    if (object == nil) {
        if (completion) {
            completion(nil, nil, userInfo);
        }
        return;
    }
    
    AXResponseObject *response = [AXResponseObject mj_objectWithKeyValues:object];
    
    AXHTTPClientResponse *clientResp = [AXHTTPClientResponse new];
    
    userInfo[AXHTTPCompletionUserInfoStatusCodeKey] = clientResp.response[@"code"]?:@"__Unknown";
    
    NSDictionary *resp;
    if ([object isKindOfClass:NSDictionary.class]) {
        resp = object;
    } else {
        resp = [object mj_JSONObject];
    }
    clientResp.response = resp;
    
    // JSON data convert failed.
    if (!response) {
        NSError *error = [NSError errorWithDomain:AXCocoaDataErrorDomin code:AXCocoaDataErrorJSONConvertingFailed userInfo:@{NSLocalizedDescriptionKey:@"JSON数据转换结果为空."}];
        // @(((NSHTTPURLResponse *)task.response).statusCode)
        if (completion) completion(clientResp, error, userInfo);
        return;
    }
    // Set object type string of respose object.
    clientResp.objType = JYResponseTypesWithObjectTypeString(response.object);
    
    // Get status code of response.
    int64_t statusCode = [response code];
    
    // Json convert success.
    if (statusCode == AXHTTPClientStatusCodeSuccess) {// Response successfully.
        [self requestDidSuccess];
        
        // Check the object type of response object data.
        //
        // Get the class of object.
        Class cls = JYResponseClassWithObjectTypeString(response.object);
        //
        if ([clientResp.objType isEqualToString:JYResponseTypeNull]) {// None of data.
            // No object needed to be handled.
            if (completion) {
                completion(clientResp, nil, userInfo);
            }
        } else if ([clientResp.objType isEqualToString:JYResponseTypeObject]) {// Single object of data.
            // Handle single object.
            //
            NSDictionary *responseData;
            if ([response.data isKindOfClass:[NSString class]]) {
                responseData = [response.data mj_JSONObject];
            } else {
                responseData = response.data;
            }
            //
            JYRLMObject *responseObject = [self RLMObjectWithKeyValue:responseData class:JYResponseClassWithObjectTypeString(response.object)];
            //
            if (responseObject && storeToRealm && [cls shouldStoreToRealm]) {// Find the shouldStoreToRealm of JYRLMObject.
                NSError *error;
                RLMRealm *realm = JY_Realm;
                
                [realm beginWriteTransaction];
                [realm addOrUpdateObject:responseObject];
                [realm commitWriteTransaction:&error];
                
                // Handler error.
                if (error) {
                    clientResp.object = responseObject;
                    if (completion) {
                        completion(clientResp, error, userInfo);
                    }
                } else {
                    [realm refresh];
                    // Is main thread.
                    BOOL mainThread = [NSThread isMainThread];
                    if (mainThread) {
                        clientResp.object = [cls objectInRealm:realm forPrimaryKey:[responseObject valueForKey:@"objectId"]];
                        
                        if (completion) {
                            completion(clientResp, nil, userInfo);
                        }
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            clientResp.object = [cls objectInRealm:realm forPrimaryKey:[responseObject valueForKey:@"objectId"]];
                            if (completion) {
                                completion(clientResp, nil, userInfo);
                            }
                        });
                    }
                }
            } else {// Do not store to realm since the request/JYRLMObject don't want us to do so.
                clientResp.object = responseObject;
                if (completion) {
                    completion(clientResp, nil, userInfo);
                }
            }
        } else if ([clientResp.objType isEqualToString:JYResponseTypeList]) {// List object of data.
            // Get the object array of response data.
            //
            NSMutableArray *responseObjects = [NSMutableArray array];
            //
            NSArray *responseData;
            if ([response.data isKindOfClass:[NSString class]]) {
                responseData = [response.data mj_JSONObject];
            } else {
                responseData = response.data;
            }
            //
            for (int i = 0; i < responseData.count; i++) {
                id data = responseData[i];
                // Get the response RLMObject for the data array.
                JYRLMObject *responseObject = [self RLMObjectWithKeyValue:data class:cls];
                // Add to array.
                if (responseObject) {
                    [responseObjects addObject:responseObject];
                }
            }
            // Set the page to the client resp object.
            clientResp.page = response.page;
            //
            if (responseObjects.count && storeToRealm && [cls shouldStoreToRealm]) {
                NSError *error;
                RLMRealm *realm = JY_Realm;
                
                [realm beginWriteTransaction];
                [realm addOrUpdateObjectsFromArray:responseObjects];
                [realm commitWriteTransaction:&error];
                
                // Handle with error object.
                if (error) {
                    clientResp.objects = responseObjects;
                    if (completion) {
                        completion(clientResp, error, userInfo);
                    }
                } else {
                    [realm refresh];
                    
                    // Is main thread.
                    BOOL mainThread = [NSThread isMainThread];
                    if (mainThread) {
                        clientResp.results = [cls allObjectsInRealm:realm];
                        
                        if (completion) {
                            completion(clientResp, nil, userInfo);
                        }
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            clientResp.results = [cls allObjectsInRealm:realm];
                            if (completion) {
                                completion(clientResp, nil, userInfo);
                            }
                        });
                    }
                }
            } else {
                clientResp.objects = responseObjects;
                if (completion) {
                    completion(clientResp, nil, userInfo);
                }
            }
        } else {// Not specificed.
            if (completion) completion(clientResp, nil, userInfo);
        }
    } else {
        // Handle failure.
        [self requestDidFailWithStatusCode:statusCode];
        // Handle faild response and call the callback block.
        NSError *error = [NSError errorWithDomain:AXURLResponseErrorDomin code:(int)statusCode userInfo:@{NSLocalizedDescriptionKey:AXURLResponseStatusWithStatusCode(statusCode)}];
        //
        if (completion) completion(clientResp, error, userInfo);
    }
}
- (void)handleRequestFailureWithTask:(NSURLSessionDataTask *)task error:(NSError *)error requestDuration:(NSTimeInterval)duration completion:(AXHTTPCompletion)completion
{
    // Get the status code of failure response.
    int64_t statusCode = ((NSHTTPURLResponse *)task.response).statusCode;
    // Initialize a user info object.
    NSDictionary *userInfo = @{AXHTTPCompletionUserInfoDurationKey:@(duration), AXHTTPCompletionUserInfoStatusCodeKey:@(statusCode)};
    // Call the callback if state of task is canceling.
    if (!task || task.state == NSURLSessionTaskStateCanceling) {
        if (completion) completion(nil, error, userInfo);
    } else {
        [self requestDidFailWithStatusCode:statusCode];
        // Log the error info.
        NSData *data = [[error userInfo] objectForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#if DEBUG
        NSLog(@"HTTP error:\n%@\n\nwith data: %@", error, string);
#endif
        if (completion) completion(nil, error, userInfo);
    }
}

- (void)requestDidSuccess {
}

- (void)requestDidFailWithStatusCode:(int64_t)statusCode {
}
#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
    [super URLSession:session didBecomeInvalidWithError:error];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    [super URLSession:session didReceiveChallenge:challenge completionHandler:completionHandler];
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest *))completionHandler
{
    [super URLSession:session task:task willPerformHTTPRedirection:response newRequest:request completionHandler:completionHandler];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    [super URLSession:session task:task didReceiveChallenge:challenge completionHandler:completionHandler];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream *bodyStream))completionHandler
{
    [super URLSession:session task:task needNewBodyStream:completionHandler];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    if (_writingProgress) {
        _writingProgress(bytesSent, totalBytesSent, totalBytesExpectedToSend);
    }
    [super URLSession:session task:task didSendBodyData:bytesSent totalBytesSent:totalBytesSent totalBytesExpectedToSend:totalBytesExpectedToSend];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [super URLSession:session task:task didCompleteWithError:error];
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    [super URLSession:session dataTask:dataTask didReceiveResponse:response completionHandler:completionHandler];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    [super URLSession:session dataTask:dataTask didBecomeDownloadTask:downloadTask];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [super URLSession:session dataTask:dataTask didReceiveData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler
{
    [super URLSession:session dataTask:dataTask willCacheResponse:proposedResponse completionHandler:completionHandler];
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    [super URLSessionDidFinishEventsForBackgroundURLSession:session];
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    [super URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    [super URLSession:session downloadTask:downloadTask didWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    [super URLSession:session downloadTask:downloadTask didResumeAtOffset:fileOffset expectedTotalBytes:expectedTotalBytes];
}

#pragma mark - Private
- (NSString *)getRandomStringWithBit:(NSInteger)bit isLower:(BOOL)isLower {
    char data[bit];
    char begin;
    if (isLower) {
        begin = 'a';
    } else {
        begin = 'A';
    }
    for (NSInteger i = 0; i < bit; i++) {
        data[i] =  (char)(begin + (arc4random_uniform(26)));
    }
    return [[NSString alloc] initWithBytes:data length:bit encoding:NSUTF8StringEncoding];
}

- (JYRLMObject *)RLMObjectWithKeyValue:(id)object class:(Class)cls {
    NSDictionary *responseObject;
    if ([object isKindOfClass:[NSString class]]) {
        // Handle json string object.
        //
        responseObject = [object mj_JSONObject];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        // Handle json object.
        //
        responseObject = object;
    }
    // Handle with response object.
    
    return cls == NULL ? nil : [cls objectWithKeyValue:responseObject];
}
@end

@implementation AXHTTPClientResponse
@end

@implementation AXHTTPClientRequest
@end

AXHTTPClientRequest *_Nonnull AXHTTPClientStoredRequest(NSString *_Nonnull URLString, id _Nullable parameters) {
    AXHTTPClientRequest *request = [AXHTTPClientRequest new];
    request.URLString = URLString;
    request.parameters = parameters;
    request.shouldStoreToRealm = YES;
    return request;
}

AXHTTPClientRequest *_Nonnull AXHTTPClientUnstoredRequest(NSString *_Nonnull URLString, id _Nullable parameters) {
    AXHTTPClientRequest *request = [AXHTTPClientRequest new];
    request.URLString = URLString;
    request.parameters = parameters;
    request.shouldStoreToRealm = NO;
    return request;
}

NSString *_Nonnull AXHTTPClientRequestURLString(NSString *_Nonnull originalURLString, NSArray<NSDictionary *> *_Nullable parameters) {
    NSMutableString *paramString = [@"" mutableCopy];
    // Get params from parameters.
    for (int i = 0; i < parameters.count; i++) {
        NSDictionary *param = parameters[i];
        if (param.count != 1) {
            [NSException raise:@"AXHTTPClientRequestURLStringException" format:@"Param dictionary of the URLString should be only one single key-value object. For current is %@", param];
        }
        // Get key and value of params.
        //
        NSString *key = [[param allKeys] firstObject];
        NSString *value = [[param allValues] firstObject];
        
        paramString = [[paramString stringByAppendingPathComponent:[key encodeToPercentEscapeString]] mutableCopy];
        paramString = [[paramString stringByAppendingPathComponent:[value encodeToPercentEscapeString]] mutableCopy];;
    }
    
    NSString *URLString = [originalURLString stringByAppendingPathComponent:paramString];
    return URLString;
}
