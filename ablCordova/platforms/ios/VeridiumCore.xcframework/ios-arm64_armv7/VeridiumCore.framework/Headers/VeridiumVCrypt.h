//
//  VeridiumVCrypt.h
//  hoyosvc
//
//  Created by razvan on 2/23/16.
//  Copyright © 2016 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Cryptographic utility class for visual crypto
 */
@interface VeridiumVCrypt : NSObject

/*!
 Visual crypto encryption
 
 @param inputData the input data
 
 @return the encrypted chunks or `nil` if data could not be encrypted
 */
+(NSArray<NSData*>* _Nullable) encrypt:(NSData* _Nonnull) inputData;

/*!
 Visual crypto decryption
 
 @param encryptedData the encrypted chunks
 
 @return the decrypted data or `nil` if chunks could not be decrypted
 */
+(NSData* _Nullable) decrypt:(NSArray<NSData*>* _Nonnull) encryptedData;

@end
