//
//  Cryptor.h
//  xunjia
//
//  Created by Euan Chan on 13-4-12.
//  Copyright (c) 2013 cncn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cryptor : NSObject

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv;
+ (NSString *)decryptUseDES:(NSString *)decryptText key:(NSString *)key iv:(NSString *)iv;

@end
