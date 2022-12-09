//
//  IntegrationDefinition.h
//  VeridiumCore
//
//  Created by Alex ILIE on 19/04/2019.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//
#import "VeridiumAbstractData.h"

/*!
 Defines the BOPS authentication side
 */
typedef enum : NSUInteger {
    BOPSAuthenticatorTypeUnknown,
    BOPSAuthenticatorTypeServerSplit,
    BOPSAuthenticatorTypeClientSplit,
    BOPSAuthenticatorTypeServerFull,
    BOPSAuthenticatorTypeClientFull,
} BOPSAuthenticatorType;

@interface IntegrationDefinition : VeridiumAbstractData

/*!
 The business integration unique internal identifier (a UUID)
 */
@property (readonly, nonnull) NSString* integrationId;

/*!
 The business integration external identifier
 
 This is usually a string (e.g. 'DemoIntegration', 'ACMEIntegration') and is used at account registratration to specify which integration to register the account for
 @see [VeridiumBOPSAccountService registerAccount:onSuccess:onFail:onCancel:]
 */
@property (readonly, nonnull) NSString* externalId;

/*!
 The business integration name
 */
@property (readonly, nonnull) NSString* name;

/*!
 The business integration description
 */
@property (readonly, nullable) NSString* integrationDescription;

/*!
 The business integration required biometric authentication methods
 
 __this setting is specific to each business integration and is configured via the BOPS admin console__
 */
@property (readonly, nullable) NSArray<NSString*>* biometricMethods;

/*!
 The business integration available biometric enrollment methods
 
 __this setting is specific to each business integration and is configured via the BOPS admin console__
 */
@property (readonly, nullable) NSArray<NSString*>* availableBiometricMethods;

/*!
 The side of the bimetric authentication enforced for all accounts registered for this business integration
 
 __this setting is specific to each business integration and is configured via the BOPS admin console__
 */
@property (readonly) BOPSAuthenticatorType authenticatorType;

@end
