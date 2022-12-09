//
//  Constants.h
//  VeridiumFourFBiometrics
//
//  Created by Lewis Carney on 18/07/2018.
//  Copyright © 2018 veridium. All rights reserved.
//

#ifndef VeridiumFourFConstants_h
#define VeridiumFourFConstants_h

#import <Foundation/Foundation.h>
#import <VeridiumCore/VeridiumCore.h>

#define kVeridiumBiometricEngineName4F @"4F"

@interface Veridium4FLicenseStatus : VeridiumLicenseStatus

@end

// MARK: - Error definitions

FOUNDATION_EXPORT NSString *const _Nonnull VeridiumFourFBiometricsErrorDomain;

typedef NS_ERROR_ENUM(VeridiumFourFBiometricsErrorDomain, VeridiumFourFBiometricsLicenseError) {
    VeridiumFourFBiometricsLicenseErrorLicenseExpired = -1,
    VeridiumFourFBiometricsLicenseErrorDecodeFailed = -2,
    VeridiumFourFBiometricsLicenseErrorVersionMismatch = -3,
    VeridiumFourFBiometricsLicenseErrorOther = -4
};

typedef NS_ERROR_ENUM(VeridiumFourFBiometricsErrorDomain, VeridiumFourFBiometricsEnrolmentError) {
    VeridiumFourFBiometricsEnrolmentErrorBadConfiguration = -1,
    VeridiumFourFBiometricsEnrolmentErrorUnknown = -2,
    VeridiumFourFBiometricsEnrolmentErrorCancel = -3,
    VeridiumFourFBiometricsEnrolmentErrorFailed = -4
};

typedef NS_ERROR_ENUM(VeridiumFourFBiometricsErrorDomain, VeridiumFourFBiometricsAuthenticationError) {
    VeridiumFourFBiometricsAuthenticationErrorLivenessFailed = 1047,
    VeridiumFourFBiometricsAuthenticationErrorInternalMismatch = 1047,
    VeridiumFourFBiometricsAuthenticationErrorBadConfig = 1047,
    VeridiumFourFBiometricsAuthenticationErrorUnknown = 1047
};


// MARK: - Export constants and utility functions

typedef NS_ENUM(NSUInteger, VeridiumFourFExportTemplateFormat) {
    FORMAT_VERID = 0,
    FORMAT_NIST = 1,
    FORMAT_INTERPOL = 2,
    FORMAT_ZIP = 3,
    FORMAT_JSON = 4,
    FORMAT_ISO2005_2 = 5,
    FORMAT_ISO2005_4 = 6
};

typedef NS_ENUM(NSInteger, VeridiumFourFHandChoice) {
    VeridiumFourFHandChoiceForceLeftHandEnroll = 0,
    VeridiumFourFHandChoiceForceRightHandEnroll,
    VeridiumFourFHandChoiceEitherHandEnroll, // always left hand first
    VeridiumFourFHandChoiceBothHands, // always left hand first
    VeridiumFourFHandChoiceAllFingers // Left hand, left thumb, right hand, right thumb
};

typedef NS_ENUM(NSInteger, VeridiumFourFFingerChoice) {
    VeridiumFourFFingerChoiceTHUMB_RIGHT = 1,
    VeridiumFourFFingerChoiceINDEX_RIGHT = 2,
    VeridiumFourFFingerChoiceMIDDLE_RIGHT = 3,
    VeridiumFourFFingerChoiceRING_RIGHT = 4,
    VeridiumFourFFingerChoiceLITTLE_RIGHT = 5,
    VeridiumFourFFingerChoiceTHUMB_LEFT = 6,
    VeridiumFourFFingerChoiceINDEX_LEFT = 7,
    VeridiumFourFFingerChoiceMIDDLE_LEFT = 8,
    VeridiumFourFFingerChoiceRING_LEFT = 9,
    VeridiumFourFFingerChoiceLITTLE_LEFT = 10
};

typedef float WSQCompressRatio;
extern WSQCompressRatio const COMPRESS_15to1;
extern WSQCompressRatio const COMPRESS_10to1;
extern WSQCompressRatio const COMPRESS_5to1;
extern WSQCompressRatio const COMPRESS_2to1;

typedef int NistType;
extern NistType const Nist_type_T14_9;
extern NistType const Nist_type_T4_9;


NSString* _Nonnull getDefaultExtension(VeridiumFourFExportTemplateFormat format);
NSString* _Nonnull getDefaultFormatNames(VeridiumFourFExportTemplateFormat format);

#endif /* VeridiumFourFConstants_h */
