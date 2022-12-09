//
//  VeridiumTXSigning.h
//  VeridiumCore
//
//  Created by razvan on 3/20/17.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "VeridiumBiometricsProtocols.h"
#import "VeridiumSDK.h"


/*!
 Data class for holding the Transaction Signing data.
 */
@interface VeridiumAuthSignatureData : NSObject


/*!
 Static initializer which constructs an VeridiumAuthSignatureData.

 @param auth  the authenticator's string identifier (e.g. kVeridiumBiometricEngineName4F)
 @param data  the signed data
 @return self
 */
+(instancetype _Nonnull) newWithAuthenticator:(NSString* _Nonnull)auth
                                 andSignature:(NSData* _Nonnull)data;


/*!
 The name of the authenticator
 */
@property (readonly, nonnull) NSString* authenticator;

/*!
 The signed data as Base64 String
 */
@property (readonly, nonnull) NSString* signatureB64;

/*!
 Convenience property for getting the VeridiumAuthSignatureData with its metadata as a NSDictionary
 */
@property (readonly, nonnull) NSDictionary* asDictionary;

@end

/*!
 Alias for blocks receiving a VeridiumAuthSignatureData argument
 
 @param signatureData signatureData a `VeridiumAuthSignatureData`
*/
typedef void(^authSignatureDataBlock)(VeridiumAuthSignatureData* _Nonnull signatureData);


/*!
 Subprotocol of `VeridiumBioAuthenticator`, which is part of the VeridiumBiometricProtocols
 */
@protocol VeridiumTXSignAuthenticator <VeridiumBioAuthenticator>

/*!
 Sign without authentication
 
 @param keyRegistrationID the keyRegistrationID
 @param dataToSign        dataToSign the data to be signed
 @param authReason        reason the user is prompted to authenticate
 @param externalLAContext the external `LAContext`
 @param completion        completion block with the authentication result, authentication signature, & the error if any.
 */
-(void) txSignWithKeyRegistrationID:(NSString* _Nonnull) registrationID
                       dataToSign:(NSData* _Nonnull) dataToSign
                externalLAContext:(LAContext* _Nullable) externalLAContext
                       onComplete:(void (^ _Nonnull)(NSData * _Nullable, NSError * _Nullable))completion;


/*!
Ask the biometric engine to perform an Transaction Signing authentication.

 @param keyRegistrationID the keyRegistrationID
 @param dataToSign        dataToSign the data to be signed
 @param authReason        reason the user is prompted to authenticate
 @param externalLAContext the external `LAContext`
 @param completion        completion block with the authentication result, authentication signature, & the error if any.
 */
-(void) authenticateAndTXSignForKeyRegistrationID:(NSString* _Nonnull) registrationID
                          dataToSign:(NSData* _Nonnull) dataToSign
                          authReason:(NSString* _Nonnull) authReason
                   externalLAContext:(LAContext* _Nullable) externalLAContext
                          onComplete:(void(^ _Nonnull)(VeridiumAuthResult, VeridiumAuthSignatureData* _Nullable, NSError* _Nullable)) completion;

@end

/*!
  Helper class which aggregates any BioAuthenticator.
 */
@interface VeridiumTXSignAuthWrapper : NSObject <VeridiumTXSignAuthenticator>


/*!
 Class static initializer returning a new instance that wraps the provided authenticator with Transaction Signing capabilities

 @param authenticator the authenticator
 @return the wrapper instance
 */
+(instancetype _Nonnull)newWithAuthenticator:(id<VeridiumBioAuthenticator> _Nonnull) authenticator;

@end

/*!
 Data class for holding the reuslt of key pair generation.
 */
@interface VeridiumSigningKey: NSObject

/*!
 registration ID (recommanded to be a UUID)
 */
@property (readonly, nonnull) NSString* registrationID;

/*!
 key tag
 */
@property (readonly, nonnull) NSString* tag;

/*!
 Generated public key
 */
@property (readonly, nonnull) NSData* publicKey;

/*!
 Protection level for the key
 */
@property (readonly) VeridiumTXSigningProtection protectionLevel;

+(instancetype _Nonnull) newWithRegistrationID:(NSString* _Nonnull)registrationID
                                        keyTag:(NSString* _Nonnull)keyTag
                                     publicKey:(NSData* _Nonnull)publicKey
                               protectionLevel:(VeridiumTXSigningProtection)protectionLevel;

+(instancetype _Nullable) deserialize:(NSDictionary* _Nonnull) dic;

-(NSDictionary* _Nonnull) serialize;

@end

/*!
 Helper class for Transaction Signing key pairs management.
 */
@interface VeridiumTXSigningRegistry : NSObject


@property (nonnull) NSMutableDictionary<NSString*, VeridiumSigningKey*>* temporarySigningKeys;

///------------
/// @name Keys management
///------------

/*!
 Generates a new key pair for the specified authenticator and unique registration identifier (usually mapped to a profile)

 @param   authenticator the authenticator to generate the key pair for
 @param   protectionLevel specifies the protection level for private key access (for signing)
 @param   registrationID a unique registration ID (UUID recommended) that may unite a series of keys together. Usually mapped with a profile unique identifier
 @param   error error out parameter
 @return  the keypair generation result with public public key
 */
-(VeridiumSigningKey* _Nonnull) generateKeyPairForAuthenticator:(id<VeridiumBioAuthenticator> _Nonnull) authenticator
                                                protectionLevel:(VeridiumTXSigningProtection) protectionLevel
                                                 registrationID:(NSString* _Nonnull) registrationID
                                                          error:(NSError* _Nullable __autoreleasing * _Nullable)error;

/*!
 Temporarily generates new key pair for the specified authenticator and a unique identifier (usually identifying a profile)
 
 @param   authenticator the authenticator to update the key pair for
 @param   protectionLevel specifies the protection level for private key access (for signing)
 @param   registrationID a unique registration ID that may unite a series of keys together. Usually mapped with a profile unique identifier
 @param   error error out parameter
 @return  the keypair generation result with public public key
 */
-(VeridiumSigningKey* _Nonnull) generateTemporaryKeyPairForAuthenticator:(id<VeridiumBioAuthenticator> _Nonnull) authenticator
                                                         protectionLevel:(VeridiumTXSigningProtection) protectionLevel
                                                          registrationID:(NSString* _Nonnull) registrationID
                                                                   error:(NSError* _Nullable __autoreleasing * _Nullable)error;

/*!
 Saves all of the temporarily generated key pairs in keychain and removes the previously generated ones
 */
-(void) persistAllTemporaryKeysInKeychain;

/*!
 Clear all temporary keys
 */
-(void) clearAllTemporaryKeys;

/*!
 Method which deletes a key pair for a specific `VeridiumBioAuthenticator` and UUID.
 
 @param authenticatorName the name of the authenticator
 @param registrationID a unique registration ID that may unite a series of keys together. Usually mapped with a profile unique identifier
 */
-(void) deleteKeyPairForAuthenticator:(NSString* _Nonnull) authenticatorName
                       registrationID:(NSString* _Nonnull) registrationID;

/*!
 Returns the names of authenticators associated with the registration id
 
 @param registrationID a unique registration ID that may unite a series of keys together. Usually mapped with a profile unique identifier
 @return array of names of authenticators. If there is not a signing key available, returns nil
 */
-(NSArray<NSString*> * _Nullable) getAuthenticatorNamesForRegistrationId:(NSString* _Nonnull) registrationID;

/*!
 Method which deletes all KeyPairs for a registered UUID.
 
 @param uuid the UUID
 */
-(void) deleteKeyPairsForRegistrationID:(NSString* _Nonnull)registrationID;


/*!
 Method which deletes all KeyPairs
 */
-(void) clearAllKeys;

///------------
/// @name Helper methods
///------------

/*!
 Wrapps an regular authenticator (non Transaction Signing enabled) by adding Transaction Signing capability.

 @param authenticator the authneticator instance
 @return a wrapped instance of the provided authenticator with Transation Signing capability
 */
-(VeridiumTXSignAuthWrapper* _Nonnull) wrapAuthenticator:(id<VeridiumBioAuthenticator> _Nonnull) authenticator;




/*!
 Helper method to get the protection level for a certain `VeridiumBioAuthenticator`.

 @param authenticator the `VeridiumBioAuthenticator`
 @param registrationID  the UUID for the key registration
 @return the protection level, see `VeridiumTXSigningProtection` enum
 */
-(VeridiumTXSigningProtection) protectionLevelForAuthenticator:(id<VeridiumBioAuthenticator> _Nonnull) authenticator
                                                registrationID:(NSString* _Nonnull) registrationID;

/*!
 Converts a VeridiumTXSigningProtection enum into a Security framework's SecAccessControlCreateFlags enum combination
 
 @param protectionLevel the protection level
 @return the converted value.
 */
+(SecAccessControlCreateFlags) secACFlagsForProtectionLevel:(VeridiumTXSigningProtection) protectionLevel;


/*!
 Creates a SecAccessControlRef instance from a VeridiumTXSigningProtection enum

 @param protectionLevel the protection level
 @param error error out parameter
 @return returns SecAccessControlRef if success, `nil` otherwise.
 */
+(SecAccessControlRef _Nullable) sacObjectForProtectionLevel:(VeridiumTXSigningProtection) protectionLevel error:(NSError* _Nullable __autoreleasing * _Nullable) error;


-(VeridiumSigningKey* _Nullable) getSigningKeyForAuthenticator:(NSString* _Nonnull)authenticatorName registrationID:(NSString* _Nonnull)registrationID;

@end

/*!
 VeridiumSDK Transaction Signing addition.
 */
@interface VeridiumSDK (TXSigning)


/*!
 Adds an read accessor for the SDK's Transaction Signing registry internal instance
 */
@property (readonly, nonnull) VeridiumTXSigningRegistry* txSigningRegistry;

@end
