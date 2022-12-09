//
//  VeridiumBiometricVector.h
//  VeridiumCore
//
//  Created by razvan on 5/11/16.
//  Copyright © 2016 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VeridiumKeyValueStore.h"

#define kVeridiumBiometricVectorFormatFullVector @"FULL"
#define kVeridiumBiometricVectorFormatLocalShadow @"LOCAL_SHADOW"
#define kVeridiumBiometricVectorFormatEncryptedVisualCrypto @"ENCRYPTED_VC"


/*!
 Data class for holding a biometric vector and its metadata.
 */
@interface VeridiumBiometricVector : NSObject

/*!
 Vector type - produced by the biometric engine (and is equal with the engine name)
 */
@property (readonly, nonnull) NSString* type;

/*!
 Vector version - produced by the biometric engine
 */
@property (readonly, nonnull) NSString* version;

/*!
 Vector format - custom string interpreted by the biometric engine
 */
@property (readonly, nonnull) NSString* format;

/*!
 The actual binary data of the biometric vector (encrypted)
 */
@property (readonly, nonnull) NSData* biometricData;

/*!
 Convenience property for getting the vector with its metadata in a JSON format
 */
@property (readonly, nonnull) NSString* asJSON;


/*!
 Extra meta data stored alongside with the raw biometric vector data
 */
@property (nullable) NSDictionary* extraData;

/*!
 Convenience property for getting the vector with its metadata as a NSDictionary
 */
@property (readonly, nonnull) NSDictionary<NSString*,id>* asDictionary;


/*!
 Call this to store the vector data into the provided KV store

 @param store the taget KV store
 */
-(void) storeInto:(id<VeridiumKeyValueStore> _Nonnull) store;


/*!
 Static initializer that loads the vector from the provided KV store

 @param store the source KV store
 @param key   the key under which the vector was stored (typically the engine name)

 @return the loaded vector if the load was successful, `nil` otherwise
 */
+(instancetype _Nullable) loadFrom:(id<VeridiumKeyValueStore> _Nonnull)store underKey:(NSString* _Nonnull) key;

/*!
 Designated initializer
 
 @param type                   type
 @param version                version
 @param format                 format
 @param encryptedBiometricData biometric data
 @param extraData              dictionary with any extra data to be stored 
 
 @return The initialized vector
 */
-(instancetype _Nonnull)initWithType:(NSString* _Nonnull) type
                             version:(NSString* _Nonnull) version
                              format:(NSString* _Nonnull) format
                       biometricData:(NSData* _Nonnull) encryptedBiometricData
                           extraData:(NSDictionary* _Nullable) extraData;

@end


/*!
 Veridium Public Biometric Vector class.
 */
@interface VeridiumBiometricPublicVector : VeridiumBiometricVector

/*!
 Class initializer

 @param type                    type
 @param version                 version
 @param encryptedBiometricData  biomectic data
 @param extraData               dictionary with any extra data to be stored
 @return The initialized vector
 */
-(instancetype _Nonnull)initWithType:(NSString * _Nonnull)type version:(NSString * _Nonnull)version biometricData:(NSData * _Nonnull)encryptedBiometricData extraData:(NSDictionary * _Nullable)extraData;
@end


/*!
 Veridium Private Biometric Vector class.
 */
@interface VeridiumBiometricPrivateVector : VeridiumBiometricVector

/*!
 Class initializer
 
 @param type                    type
 @param version                 version
 @param encryptedBiometricData  biomectic data
 @param extraData               dictionary with any extra data to be stored
 @return The initialized vector
 */
-(instancetype _Nonnull)initWithType:(NSString * _Nonnull)type version:(NSString * _Nonnull)version biometricData:(NSData * _Nonnull)encryptedBiometricData extraData:(NSDictionary * _Nullable)extraData;

/*!
 Vector's unique identifier.
 */
@property (readonly, nonnull) NSString* matchingPairTag;

@end

/*!
 Veridium Private Public pair Biometric Vector class.
 */
@class VeridiumBiometricPublicPrivateVectorPair;
@interface VeridiumBiometricFullVector : VeridiumBiometricVector


/*!
 Class initializer
 
 @param type                    type
 @param version                 version
 @param encryptedBiometricData  biomectic data
 @param extraData               dictionary with any extra data to be stored
 @return The initialized vector
 */
-(instancetype _Nonnull)initWithType:(NSString * _Nonnull)type version:(NSString * _Nonnull)version biometricData:(NSData * _Nonnull)encryptedBiometricData extraData:(NSDictionary * _Nullable)extraData;

/*!
 Splits the current VeridiumBiometricFullVector.

 @return The constructed instance.
 */
-(VeridiumBiometricPublicPrivateVectorPair* _Nonnull) split;


/*!
 Static initializer that constructs a VeridiumBiometricFullVector, from a public/private pair.

 @param pair the vector pair.
 @return The constructed instance if joining was successful, `nil` otherwise.
 */
+(instancetype _Nullable) newFromPair:(VeridiumBiometricPublicPrivateVectorPair* _Nonnull) pair;


/*!
 Static initializer that constructs a VeridiumBiometricFullVector, from a public vector and a private vector.

 @param   privateVector the private vector
 @param   publicVector the public vector
 @return The constructed instance if joining was successful, `nil` otherwise.
 */
+(instancetype _Nullable) newByJoiningPrivate:(VeridiumBiometricPrivateVector* _Nonnull) privateVector withPublic:(VeridiumBiometricPublicVector* _Nonnull) publicVector;


@end


/*!
 Utility class for managing split biometric vectors
 */
@interface VeridiumBiometricPublicPrivateVectorPair : NSObject


/*!
 
 Static initialzer that constructs an instance from a source full vector by splitting it into a public/private pair
 
 @param fullVector the source vector
 
 @return the constructed instance
 */
+(instancetype _Nonnull) newBySplitting:(VeridiumBiometricFullVector* _Nonnull) fullVector;


/*!
 Static initializer that constructs a VeridiumBiometricPublicPrivateVectorPair, from a public vector and a private vector.

 @param   privateVector the private vector
 @param   publicVector the public vector
 @return The constructed instance.
 */
+(instancetype _Nonnull) newWithPrivate:(VeridiumBiometricPrivateVector* _Nonnull)privateVector andPublic:(VeridiumBiometricPublicVector* _Nonnull) publicVector;

/*!
 Static initializer that constructs an instance from the 2 public/private vector parts
 
 @return the constructed instance if the decryption was successful, `nil` otherwise
 */
-(VeridiumBiometricFullVector* _Nullable) join;


/*!
 Getter for the public vector part
 */
@property (readonly, nonnull) VeridiumBiometricPublicVector* publicVector;


/*!
 Getter for the private vector part
 */
@property (readonly, nonnull) VeridiumBiometricPrivateVector* privateVector;

@end
