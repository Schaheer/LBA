//
//  VeridiumNullAuthenticator.h
//  VeridiumCore
//
//  Created by razvan on 4/11/17.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VeridiumBiometricsProtocols.h"
#import "VeridiumSDK.h"

#define kVeridiumBiometricEngineNameNull @"NULL"

/*!
 Veridium NULL authenticator. This authenticator implements the `VeridiumBioAuthenticator` protocol. This should be used when an successful authentication is needed with no biometrics.
 */
@interface VeridiumNullAuthenticator : NSObject <VeridiumBioAuthenticator>

@end

/*!
 VeridiumSDK Null Authenticator addition
 */
@interface VeridiumSDK (NullAuth)

/*!
 This property holds an instance of `VeridiumNullAuthenticator`.
 */
@property (readonly, nonnull) VeridiumNullAuthenticator* nullAuthenticator;

@end
