//
//  NSData+AES256Cryptor.h
//  GFPropertyOwner
//
//  Created by ai on 16/4/12.
//  Copyright © 2016年 com.KEEPStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256Cryptor)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end