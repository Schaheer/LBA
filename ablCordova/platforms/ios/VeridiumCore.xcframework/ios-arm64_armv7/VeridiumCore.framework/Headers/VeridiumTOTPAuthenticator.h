//
//  VeridiumTOTPAuthenticator.h
//  VeridiumCore
//
//  Created by Vlad Hudea on 23/03/2020.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VeridiumBiometricsProtocols.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "VeridiumSDK.h"
#import "VeridiumTOTPAuthConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface VeridiumTOTPAuthenticator : NSObject <VeridiumBioAuthenticator>

@end

NS_ASSUME_NONNULL_END
