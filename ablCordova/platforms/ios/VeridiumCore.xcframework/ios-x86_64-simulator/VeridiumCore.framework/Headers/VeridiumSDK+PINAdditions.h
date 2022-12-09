//
//  VeridiumSDK+PINAdditions.h
//  VeridiumCore
//
//  Created by Erkut Demirhan on 9/9/20.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VeridiumSDK.h"
#import "VeridiumPINCoordinator.h"

NS_ASSUME_NONNULL_BEGIN

@interface VeridiumSDK (PINAdditions)

/*!
 Provides the registered PIN enroller, if exists
 */
@property (readonly, nullable) VeridiumPINCoordinator *enrollerPIN;

/*!
Provides the registered PIN authenticator, if exists
*/
@property (readonly, nullable) VeridiumPINCoordinator *authenticatorPIN;

/*!
 Registers a Veridium PIN enroller given the VeridiumPINUIDelegate implementation
 
 @param uiDelegate VeridiumPINUIDelegate implementation
*/
- (void)registerPINEnroller:(_Nonnull id<VeridiumPINUIDelegate>)uiDelegate;

/*!
 Registers a Veridium PIN authenticator given the VeridiumPINUIDelegate implementation
 
 @param uiDelegate VeridiumPINUIDelegate implementation
*/
- (void)registerPINAuthenticator:(_Nonnull id<VeridiumPINUIDelegate>)uiDelegate;

/*!
 Sets configuration for the registered PIN enroller
 
 @param config VeridiumPINConfig instance
*/
- (void)configPINEnroller:(VeridiumPINConfig * _Nonnull)config;

/*!
 Sets configuration for the registered PIN authenticator
 
 @param config VeridiumPINConfig instance
*/
- (void)configPINAuthenticator:(VeridiumPINConfig * _Nonnull)config;

@end

NS_ASSUME_NONNULL_END
