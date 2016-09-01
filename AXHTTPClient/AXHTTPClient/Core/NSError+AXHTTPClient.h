//
//  AXError.h
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

#import <Foundation/Foundation.h>
#import "AXHTTPStatusCodes.h"
NS_ASSUME_NONNULL_BEGIN
/// Domain of `AXURLErrorDomain`.
///
/// Using the domain to locate the domain of error when server errors occured.
FOUNDATION_EXPORT NSString *const AXURLResponseErrorDomin;
/// Get the defined error user info dictionary in `AXURLErrorDomin` with a specific
/// error code under the domain.
///
/// @param errorCode defined error code under the `AXURLErrorDomin` domain.
///
/// @return a defined user info.
NSString* _Nonnull AXURLResponseStatusWithStatusCode(int64_t statusCode);
/// Domain of `AXDataErrorDomin`.
///
/// Using the domain to locate the domain of error when client data errors occured.
FOUNDATION_EXPORT NSString *const AXCocoaDataErrorDomin;
/// The error code of `AXDataErrorDomin`.
///
/// Using these codes to locate the error information when
/// any errors occured on client data handling.
enum {
    /// JSON data from remote server converting failed.
    AXCocoaDataErrorJSONConvertingFailed = -1001,
    /// `NSException` error.
    AXCocoaDataErrorException = -1002
};
/// Domain of `AXHTTPErrorDomain`.
///
/// Using the domain to locate the domain of error when client data errors occured on HTTP.
FOUNDATION_EXPORT NSString *const AXHTTPErrorDomain;
/// Get the defined error user info dictionary in `AXHTTPErrorDomain` with a specific
/// error code under the domain.
///
/// @param errorCode defined error code under the `AXHTTPErrorDomain` domain.
///
/// @return a defined user info.
NSString* _Nonnull AXHTTPStatusWithStatusCode(int64_t statusCode);

@interface NSError (AXHTTPClient)
@end
NS_ASSUME_NONNULL_END