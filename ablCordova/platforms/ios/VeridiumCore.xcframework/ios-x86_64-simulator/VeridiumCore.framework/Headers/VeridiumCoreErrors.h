//
//  VeridiumCoreErrors.h
//  VeridiumCore
//
//  Created by Erkut Demirhan on 13/07/2020.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const _Nonnull VeridiumCoreErrorDomain;

typedef NS_ERROR_ENUM(VeridiumCoreErrorDomain, VeridiumCoreLicensingError) {
    VeridiumCoreLicensingErrorExpiredLicense = -1,
    VeridiumCoreLicensingErrorInvalidLicenseType = -2,
    VeridiumCoreLicensingErrorInvalidJson = -3,
    VeridiumCoreLicensingErrorMissingContent = -4,
    VeridiumCoreLicensingErrorMissingField = -5,
    VeridiumCoreLicensingErrorMissingBundleId = -6,
    VeridiumCoreLicensingErrorNotYetValidLicense = -7
};

typedef NS_ERROR_ENUM(VeridiumCoreErrorDomain, VeridiumCoreAuthenticationError) {
    VeridiumCoreAuthenticationErrorInvalidAuthenticatorType = -1023,
    VeridiumCoreAuthenticationErrorNoAuthenticator = 1010,
    VeridiumCoreAuthenticationErrorUserChangedLocalBiometry = 1105,
    VeridiumCoreAuthenticationErrorSigningKeyNotFound = 1106
};

/*!
 Utility class to generate NSError instances for different scenarios
 */
@interface VeridiumCoreError: NSObject

+ (nonnull NSError *)createKeychainError:(OSStatus)status
             defaultLocalizedDescription:(nonnull NSString *)defaultLocalizedDescription
                    defaultFailureReason:(nonnull NSString *)defaultFailureReason;

@end



NS_ASSUME_NONNULL_END
