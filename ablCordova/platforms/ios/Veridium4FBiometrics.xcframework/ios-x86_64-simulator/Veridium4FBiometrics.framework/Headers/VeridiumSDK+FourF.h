//
//  VeridiumSDK+FourF.h
//  VeridiumFourFBiometrics
//
//  Created by Lewis Carney on 18/07/2018.
//  Copyright © 2018 veridium. All rights reserved.
//

#ifndef VeridiumSDK_FourF_h
#define VeridiumSDK_FourF_h
@import VeridiumCore;
#import "Constants.h"
#import "VeridiumBiometricsFourFCapturer.h"
#import "VeridiumBiometricsFourFUI.h"

/*!
 SDK 4F additions
 */
@interface VeridiumSDK (FourFAdditions)

/*!
 Property returning FourF Library version as NSString
 */
@property (readonly, nonnull) NSString* lib4FVersion;

/*!
 4F Library setup

 @param licence the licence
 @return the setup status.
 */
-(Veridium4FLicenseStatus* _Nonnull)setupLib4FWithLicense:(NSString* _Nonnull)licence;

/*!
 Helper method which prints in the DebugConsole the version of the FourF Library
 */
-(void)logFourFBiometricsVersion;

/*!
 Register a FourF authenticator with a custom UI
 
 @param ui the custom UI
 */
-(void)registerFourFAuthenticator:(id<VeridiumFourFUIDelegate> _Nonnull)ui;

/*!
 Register a FourF enroller with a custom UI
 
 @param ui the custom UI
 */
-(void) registerFourFEnroller:(id<VeridiumFourFUIDelegate> _Nonnull)ui;

/*!
 Register a FourF exporter with a custom UI
 
 @param ui the custom UI
 */
-(void) registerFourFExporter:(id<VeridiumFourFUIDelegate> _Nonnull)ui;

/*!
 Helper method to configure the registered FourF enroller
 
 @param config the config
 */
-(void)configureFourFEnroler:(VeridiumFourFCaptureConfig * _Nonnull)config;


/*!
 Helper method to configure the registered FourF authenticator
 
 @param config the config
 */
-(void)configureFourFAuthenticator:(VeridiumFourFCaptureConfig * _Nonnull)config;


/*!
 Helper method to configure the registered FourF exporter
 
 @param config the config
 */
-(void)configureFourFExporter:(VeridiumFourFCaptureConfig * _Nonnull)config;



/*!
 Helper method for grabbing the registered FourF enroller
 
 @return the registered FourF enroller (or nil if not registered)
 */
@property (readonly, nullable) VeridiumBiometricsFourFCapturer* enrollerFourF;


/*!
 Helper method for grabbing the registered FourF authenticator
 
 @return the registered FourF authenticator (or nil if not registered)
 */
@property (readonly, nullable) VeridiumBiometricsFourFCapturer* authenticatorFourF;

/*!
 Helper method for grabbing the registered FourF exporter
 
 @return the registered FourF exporter (or nil if not registered)
 */
@property (readonly, nullable) VeridiumBiometricsFourFCapturer* exporterFourF;


@end

#endif /* VeridiumSDK_FourF_h */
