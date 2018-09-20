//
//  Cryptor.m
//  xunjia
//
//  Created by Euan Chan on 13-4-12.
//  Copyright (c) 2013 cncn. All rights reserved.
//

#import "Cryptor.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation Cryptor

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key iv:(NSString *)iv
{
    NSString *ciphertext = @"";
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = strlen(textBytes);
    
    // 计算机密后长度
    size_t numBytesEncrypted = 0;
    CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding, [key UTF8String], kCCKeySizeDES, [iv UTF8String], textBytes, dataLength, nil, 0, &numBytesEncrypted);
    
    unsigned char buffer[numBytesEncrypted];
    memset(buffer, 0, sizeof(char));
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding, [key UTF8String], kCCKeySizeDES, [iv UTF8String], textBytes, dataLength, buffer, numBytesEncrypted, &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        // 将 memory byte "0x27 0x4a 0x23 0x4b" 转化成 text"274A234B"
        for (size_t i = 0; i != numBytesEncrypted; ++i) {
            ciphertext = [ciphertext stringByAppendingFormat:@"%02X", buffer[i]];
        }
    }
    
    return ciphertext;
}

+ (NSString *)decryptUseDES:(NSString *)decryptText key:(NSString *)key iv:(NSString *)iv
{
    size_t decryptTextLen = [decryptText length];
    if (decryptTextLen == 0 || decryptTextLen % 2 != 0)
        return @"";
    
    size_t dataInLen = decryptTextLen / 2;    
    char *dataIn = (char *)malloc(dataInLen);
    memset(dataIn, 0, dataInLen * sizeof(char));
    
    // 将text"274A234B" 转化为 memory byte "0x27 0x4a 0x23 0x4b". 
    for (size_t i = 0; i < decryptTextLen; i += 2) {
        char tmpChar[3];
        memset(tmpChar, 0, 3);
        tmpChar[0] = (char)[decryptText characterAtIndex:i];
        tmpChar[1] = (char)[decryptText characterAtIndex:i + 1];
        
        char tmpByte[2];
        sprintf(tmpByte, "%c", (char)strtol(tmpChar, 0, 16));
        dataIn[i/2] = tmpByte[0];
    }
    
    // 此处使用dataInLen作为buffer长度，不先计算numBytesDecrypted，因dataInLen始终大于numBytesDecrypted
    unsigned char buffer[dataInLen];
    memset(buffer, 0, sizeof(unsigned char) * dataInLen);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          [iv UTF8String],
                                          dataIn,
                                          dataInLen,
                                          buffer,
                                          dataInLen,
                                          &numBytesDecrypted);

    unsigned char fixBuffer[numBytesDecrypted + 1];
    memset(fixBuffer, 0, sizeof(unsigned char) * (numBytesDecrypted + 1));
    memcpy(fixBuffer, buffer, sizeof(unsigned char) * numBytesDecrypted);

    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess)
        plainText = [NSString stringWithFormat:@"%s", fixBuffer];

    free(dataIn);
    return plainText;
}

@end
