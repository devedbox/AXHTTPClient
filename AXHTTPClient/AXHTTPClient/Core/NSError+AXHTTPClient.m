//
//  AXError.m
//  AXaster
//
//  Created by ai on 15/11/5.
//  Copyright © 2015年 AiXing. All rights reserved.
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

#import "NSError+AXHTTPClient.h"
#import <objc/runtime.h>
#import <MJExtension/MJExtension.h>

/// User info keys.
///
/// NSUnderlyingErrorKey ------> 根本原因
/// NSLocalizedDescriptionKey ------> 错误描述
/// NSLocalizedFailureReasonErrorKey ------> 失败原因
/// NSLocalizedRecoverySuggestionErrorKey ------> 解决建议
/// NSLocalizedRecoveryOptionsErrorKey ------> 解决选项
/// NSRecoveryAttempterErrorKey ------> 解决调度
/// NSHelpAnchorErrorKey ------>
/// ...

NSString *const AXURLResponseErrorDomin = @"AXURLResponseErrorDomin";
NSString *const AXCocoaDataErrorDomin = @"AXCocoaDataErrorDomin";
NSString *const AXHTTPErrorDomain = @"AXHTTPErrorDomain";

NSString*  AXURLResponseStatusWithStatusCode(int64_t statusCode) {
    // Get the HTTP status code info plist.
    NSDictionary *statusInfo = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:NSClassFromString(@"AXHTTPClient")] pathForResource:@"AXHTTPClient.bundle/AXHTTPClientErrorCodes" ofType:@"plist"]];
    // Get the status message from status info plist.
    NSString *statusMessage = statusInfo[[NSString stringWithFormat:@"%@", @(statusCode)]];
    // Return the message.
    return statusMessage?:@"__unspecified";
}

NSString*  AXHTTPStatusWithStatusCode(int64_t statusCode) {
    // Get the HTTP status code info plist.
    NSDictionary *statusInfo = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle bundleForClass:NSClassFromString(@"AXHTTPClient")] pathForResource:@"AXHTTPClient.bundle/HTTPStatusCodes" ofType:@"plist"]];
    // Get the status message from status info plist.
    NSString *statusMessage = statusInfo[[NSString stringWithFormat:@"%@", @(statusCode)]];
    // Return the message.
    return statusMessage?:@"__unspecified";
}

@implementation NSError (AXHTTPClient)
@end