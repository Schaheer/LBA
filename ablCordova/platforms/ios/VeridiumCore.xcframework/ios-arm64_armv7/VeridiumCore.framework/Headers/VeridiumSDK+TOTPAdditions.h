//
//  VeridiumSDK+TOTPAdditions.h
//  VeridiumCore
//
//  Created by Vlad Hudea on 23/03/2020.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "VeridiumSDK.h"
#import "VeridiumTOTPEnroller.h"
#import "VeridiumTOTPAuthenticator.h"
#import "VeridiumTOTPAuthConfig.h"

@interface VeridiumSDK (TOTPAdditions)

/*!
 Helper method for grabbing the registered TOTP enroller
 
 @return the registered TOTP enroller (or nil if not registered)
 */
@property (readonly, nullable) VeridiumTOTPEnroller *enrollerTOTP;

/*!
 Helper method for grabbing the registered TOTP authenticator
 
 @return the registered TOTP authenticator (or nil if not registered)
 */
@property (readonly, nullable) VeridiumTOTPAuthenticator *authenticatorTOTP;

/*!
 Register a TOTP authenticator with a custom UI
 
 */
- (void)registerTOTPAuthenticator;

/*!
 Register a TOTP enroller with a custom UI
 
 @param uiDelegate the TOTPUIDelegate implementation
 */
- (void)registerTOTPEnroller:(nonnull id<TOTPUIDelegate>)uiDelegate;

/*!
 Helper method to configure the registered TOTP enroller
 
 @param config the config
 */
- (void)configureTOTPEnroller:(nonnull VeridiumTOTPUIConfig *)config;


/*!
 Helper method to configure the registered TOTP authenticator
 
 @param config the config
 */
- (void)configureTOTPAuthenticator:(nonnull VeridiumTOTPAuthConfig *)config;

@end
