//
//  VeridiumSEKeysManager.h
//  VeridiumCore
//
//  Created by razvan on 3/22/17.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "VeridiumUtils.h"


/*!
 Secure enclave wrapper class.
 */
@interface VeridiumSecureEnclaveWrapper : NSObject

/*!
 Static method that checks if SE is present
 
 @return          true if SE is present
 */
+(BOOL)checkSecureEnclaveSupport:(NSError* _Nullable __autoreleasing *_Nullable) error;

/*!
 Static method that creates a new public-private key pair.

 @param tag       the tag
 @param acFlags   the access control flag
 @param error     error out parameter
 @return          the generated public key pair if success, `nil` otherwise.
 */
+(NSData* _Nullable) generateKeyPairForTag:(NSString* _Nonnull)tag withAccessControlFlags:(SecAccessControlCreateFlags) acFlags error:(NSError * _Nullable __autoreleasing *_Nullable) error;


/*!
 Static method that clears a public-private key pair for a tag.
 
 @param tag the tag
 */
+(void) clearKeysForTag:(NSString*_Nonnull)tag;


/*!
 Static helper method for clearing all key pairs.
 */
+(void) clearAllKeys;


/*!
 Static helper method for getting all the keys.
 
 @return all keys if any, nil otherwise.
 */
+(NSArray* _Nullable) allKeys;


/*!
 Static method for signing data with the private key for the specified tag.

 @param tag         the tag
 @param dataToSign  the raw data to sign
 @param context     the Local Authentication context
 @param doneBlock   the callback contaning the error if any occurred and the signed data if successful.
 */
+(void) signForTag:(NSString*_Nonnull)tag data:(NSData*_Nonnull)dataToSign usingContext:(LAContext* _Nullable) context whenDone:(void(^ _Nonnull)(NSData* _Nullable signedData, NSError* _Nullable error)) doneBlock;


/*!
 Static method for verifying data with the public key pertaining for the given tag.

 @param signature   the signature
 @param tag         the tag
 @param signedData  the unsigned data
 @param error       error out parameter if any
 */
+(void) verifySignature:(NSData* _Nonnull)signature forTag:(NSString* _Nonnull)tag signedData:(NSData*_Nonnull) signedData error:(NSError * _Nullable __autoreleasing *_Nullable) error;

+(void) encryptForTag:(NSString* _Nonnull)tag data:(NSData* _Nonnull)dataToEncrypt whenDone:(void(^ _Nonnull)(NSData* _Nullable encryptedData, NSError* _Nullable error)) doneBlock;

+(void) decryptForTag:(NSString* _Nonnull)tag data:(NSData* _Nonnull)dataToDecrypt whenDone:(void(^ _Nonnull)(NSData* _Nullable decryptedData, NSError* _Nullable error)) doneBlock;

@end
