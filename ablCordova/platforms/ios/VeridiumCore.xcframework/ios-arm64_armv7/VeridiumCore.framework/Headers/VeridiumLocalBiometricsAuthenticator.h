//
//  BiometricsTouchIDAuthenticator.h
//  VeridiumCore
//
//  Created by razvan on 11/25/15.
//  Copyright © 2015 HoyosLabs. All rights reserved.
//

#import "VeridiumBiometricsProtocols.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "VeridiumSDK.h"

#define kVeridiumBiometricEngineNameTouchID @"TOUCHID"
/**
 *  BiometricsAuthenticatorProtocol implementation for TouchID
 */
@interface VeridiumLocalBiometricsAuthenticator: NSObject<VeridiumBioAuthenticator>

/*!
 Whether the user is allowed to enter device passcode after multiple TouchID failed attempts (defaults to NO).
 */
@property BOOL allowFallbackRecovery;

/*!
 Fallback button title when the TouchID authentication fails.
 This property should be set only when `allowFallbackRecovery` is true, otherwise it will not work.
 */
@property (nonatomic, nonnull) NSString* localizedFallbackTitle;

@end


/*!
 Data class holding information about LAStatus
 */
@interface VeridiumLAStatus : NSObject


/*!
  Returns true if TouchID can be authenticated, false otherwise.
 */
@property (readonly) BOOL localBiometricsCanBeAttempted;

/*!
  Returns true if the device has TouchID sensor, false otherwise.
 */
@property (readonly) BOOL localBiometricsAvailable;


/*!
 Returns true if TouchID is enrolled, false otherwise.
 */
@property (readonly) BOOL localBiometricsEnrolled;

/*!
 Returns is biometric is FaceID
*/
@property (readonly) BOOL isLocalBiometricFaceID;


/*!
 Returns true if the device has a passcode set, false otherwise.
 */
@property (readonly) BOOL devicePasscodeSet;

/*!
 Returns true if TouchID is locked out, false otherwise.
 */
@property (readonly) BOOL localBiometricsLockedOut;


/*!
 Returns the maximum protection level for Transaction Signing, see `VeridiumTXSigningProtection`
 */
@property (readonly) VeridiumTXSigningProtection maximumPossibleProtectionLevel;


/*!
 Returns the maximum protection for device's current settings
 */
@property (readonly) VeridiumTXSigningProtection maximumPossibleProtectionLevelWithCurrentConfig;

@end


/*!
 VeridiumSDK TouchID additions
 */
@interface VeridiumSDK (TouchIDAdditions)


/*!
 Property storing a `VeridiumTouchIDAuthenticator` instance
 */
@property (readonly, nonnull) VeridiumLocalBiometricsAuthenticator* localBiometricsAuthenticator;


/*!
 Property storing a `VeridiumLAStatus` instance
 */
@property (readonly, nonnull) VeridiumLAStatus* laStatus;

@end


FOUNDATION_EXPORT NSString *const _Nonnull VeridiumTouchIDErrorDomain;
