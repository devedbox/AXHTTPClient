//
//  AXHTTPClient.h
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

#import <AFNetworking/AFNetworking.h>
#import <JYObjectModule/JYRLMObject.h>
#import <Realm/RLMObject.h>
#import "AXResponseObject.h"
#import "NSError+AXHTTPClient.h"

#ifndef kAXHTTPClient
#define kAXHTTPClient [AXHTTPClient sharedClient]
#endif
NS_ASSUME_NONNULL_BEGIN

/// Base URL key.
extern NSString *const AXHTTPClientInfoBaseURLKey;
/// Get double value.
extern NSString *const AXHTTPCompletionUserInfoDurationKey;
/// Get connection status info description.
extern NSString *const AXHTTPCompletionUserInfoStatusInfoKey;
/// Get http status code.
extern NSString *const AXHTTPCompletionUserInfoStatusCodeKey;
//
@class AXHTTPClientResponse, AXHTTPClientRequest;
//
/// HTTP request completion call back block.
///
/// @param response response object.
/// @param error    error info.
/// @param userInfo user info.
///
typedef void(^AXHTTPCompletion)(AXHTTPClientResponse *_Nullable response, __kindof NSError *_Nullable error, NSDictionary *_Nonnull userInfo);
/// Writing progress block.
///
/// @param bytesSent                bytes of data sent.
/// @param totalBytesSent           total bytes of data sent.
/// @param totalBytesExpectedToSend total bytes expected to send.
///
typedef void(^AXHTTPWritingProgress)(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend);

/// Status code of HTTP/HTTPS response. All the url response error code is larger than success code.
typedef NS_ENUM(int64_t, AXHTTPClientStatusCode) {
    /// HTTP status code success.
    AXHTTPClientStatusCodeSuccess = 2000
};

@interface AXHTTPClient : AFHTTPSessionManager
#pragma mark - Properties
/// Security enabled.
@property(assign, nonatomic, getter=isSecuriyEnabled) BOOL securityEnabled;
/// Writing progress block
@property(copy, nonatomic, nullable) AXHTTPWritingProgress writingProgress;
#pragma mark - Shared intance.
/// Get the shared client of http session manager.
///
/// @return a new http client.
+ (instancetype)sharedClient;
#pragma mark - Basic configuration
/// Get the info plist path of client.
///
/// @return a string object.
+ (NSString *)infoPlistPath;
/// Get time out interval for request. Default is 30.0s.
///
/// @return time out interval.
+ (NSTimeInterval)timeoutIntervalForRequest;
/// Token for request serializer.
///
- (NSString *)tokenForSerializer;
/// Encrypt key for request serializer.
///
- (NSString *)encryptForSerializer;
#pragma mark - Public
/// Set default serializer.
///
- (void)setDefaultSerializer;
/// Creates and runs an `NSURLSessionDataTask` with a `GET` request.
///
/// @param request The parameters and options to be encoded according to the client request serializer.
/// @param completion A block object to be executed when the task finishes successfully or unsuccessfully.
///
- (NSURLSessionDataTask *_Nullable)GET:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion;
/// Creates and runs an `NSURLSessionDataTask` with a `HEAD` request.
///
/// @param request The parameters and options to be encoded according to the client request serializer.
/// @param completion A block object to be executed when the task finishes successfully or unsuccessfully.
///
- (NSURLSessionDataTask *_Nullable)HEAD:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion;
/// Creates and runs an `NSURLSessionDataTask` with a `PUT` request.
///
/// @param request The parameters and options to be encoded according to the client request serializer.
/// @param completion A block object to be executed when the task finishes successfully or unsuccessfully.
///
- (NSURLSessionDataTask *_Nullable)PUT:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion;
/// Creates and runs an `NSURLSessionDataTask` with a `POST` request.
///
/// @param request The parameters and options to be encoded according to the client request serializer.
/// @param completion A block object to be executed when the task finishes successfully or unsuccessfully.
///
- (NSURLSessionDataTask *_Nullable)POST:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion;
/// Creates and runs an `NSURLSessionDataTask` with a multipart `POST` request.
///
/// @param request The parameters and options to be encoded according to the client request serializer.
/// @param block A block that takes a single argument and appends data to the HTTP body. The block argument is an object adopting the `AFMultipartFormData` protocol.
/// @param completion A block object to be executed when the task finishes successfully or unsuccessfully
///
- (NSURLSessionDataTask *_Nullable)POST:(AXHTTPClientRequest *_Nonnull)request constructingBodyWithBlock:(void (^ _Nullable)(id<AFMultipartFormData> _Nonnull))block completion:(AXHTTPCompletion _Nullable)completion;
/// Creates and runs an `NSURLSessionDataTask` with a `PATCH` request.
///
/// @param request The parameters and options to be encoded according to the client request serializer.
/// @param completion A block object to be executed when the task finishes successfully or unsuccessfully.
///
- (NSURLSessionDataTask *_Nullable)PATCH:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion;
/// Creates and runs an `NSURLSessionDataTask` with a `DELETE` request.
///
/// @param request The parameters and options to be encoded according to the client request serializer.
/// @param completion A block object to be executed when the task finishes successfully or unsuccessfully.
///
- (NSURLSessionDataTask *_Nullable)DELETE:(AXHTTPClientRequest *_Nonnull)request completion:(AXHTTPCompletion _Nullable)completion;
//
//
//
// For subclasses.
- (void)requestDidSuccess;
- (void)requestDidFailWithStatusCode:(int64_t)statusCode;
@end

@interface AXHTTPClientRequest : NSObject
/// URL string to request.
@property(copy, nonatomic) NSString *URLString;
/// Parameters of request.
@property(strong, nonatomic, nullable) id parameters;
/// Should save to database.
@property(assign, nonatomic) BOOL shouldStoreToRealm;
@end

AXHTTPClientRequest *_Nonnull AXHTTPClientStoredRequest(NSString *_Nonnull URLString, id _Nullable parameters);
AXHTTPClientRequest *_Nonnull AXHTTPClientUnstoredRequest(NSString *_Nonnull URLString, id _Nullable parameters);

NSString *_Nonnull AXHTTPClientRequestURLString(NSString *_Nonnull originalURLString, NSArray<NSDictionary *> *_Nullable parameters);

@interface AXHTTPClientResponse : NSObject
/// Object type.
@property(copy, nonatomic, nullable)   NSString *objType;
/// Response full object.
@property(strong, nonatomic, nonnull)  NSDictionary *response;
/// Realm results for object/list.
@property(strong, nonatomic, nullable) RLMResults *results;
/// Object of resposne for JYRLMObject and NSObject.
@property(strong, nonatomic, nullable) id object;
/// Objects array of response.
@property(strong, nonatomic, nullable) NSArray *objects;
@end
NS_ASSUME_NONNULL_END
