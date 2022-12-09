//
//  VeridiumBiometricsFourFAuthenticator.h
//  VeridiumFourFBiometrics
//
//  Created by Josiah Kane on 09/08/2018.
//  Copyright © 2018 veridium. All rights reserved.
//

#ifndef VeridiumBiometricsFourFCapturer_h
#define VeridiumBiometricsFourFCapturer_h

@import VeridiumCore;
#import "VeridiumBiometricsFourFUI.h"
#import "Constants.h"

typedef short int NumberOfRetries NS_TYPED_ENUM;
static NumberOfRetries const infinite = -1;
static NumberOfRetries const none = 0;

/*!
 Data class for holding the FourF config params
 */
@interface VeridiumFourFCaptureConfig : NSObject<VeridiumBiometricExportConfig>

/// True if we should create a 4F enrollment template.
@property BOOL do_enroll;
/// True if we should create a 4F authentication template.
@property BOOL do_auth;
/// True if we should capture a 4F image and export it in a standard fingerprint format.
@property BOOL do_export;
/// True if, as well as any of the above, we should package together and record the captured images.
@property BOOL do_debug;


/// Callback which will be used if set during enroll or auth.
/// This will be passed the exported data for external checking, such as against an external database. If it returns true, the enroll or auth will proceed as usual. If not it will fail.
@property VeridiumBiometricExternalValidationBlock _Nullable validate_export;

/// Callback which will be used if set during enroll or auth.
/// This will be passed the exported data, and could be used for tasks such as storing the export in an external database. It should not return any value.
@property VeridiumBiometricExternalHandlingBlock _Nullable process_export;

/// Callback which will be used if set during enroll or auth.
/// This will be passed the debug data. It should be used to store it for later analysis or reprocessing as needed. It should not return any value.
@property VeridiumBiometricExternalHandlingBlock _Nullable process_debug;

/// The order of execution of these callbacks for enroll is defined as follows:
//process_debug()
//validate_export(), fail if fail
//process_export()
//complete enroll

/// The order of execution of these callbacks for auth is defined as follows:
//process_debug()
//validate_export(), fail if fail
//run authentication match, fail if mismatch
//process_export()
//complete authentication success

/// True if we should show the instruction screen
@property BOOL show_instruction_screen;

/*!
 Whether that the engine is using 4F Liveness (defaults to FALSE) and difficulty factor (default 80)
 */
@property BOOL useLiveness;
@property int liveness_factor;

/*!
 Whether to show hand selector screen on UI or not (defaults to FALSE)
 */
@property BOOL showHandSelectorOnEnrolment;

/*!
 Whether to use the left or right hand (defaults to Veridium4FExExportHandDefaultLeft)
 */

/// Create a new config object, which will require further property changes to set up.
-(instancetype _Nonnull ) initForAdvancedConfiguration;
/// Convenience method for creating an enrollment configuration with sane defaults.
-(instancetype _Nonnull ) initForEnrollWithHand:(VeridiumFourFHandChoice)hand andLiveness:(BOOL)liveness;
/// Convenience method for creating an authentication configuration with sane defaults.
-(instancetype _Nonnull ) initForAuthWithHand:(VeridiumFourFHandChoice)hand andLiveness:(BOOL)liveness;

/// Convenience method for setting standard sets of fingers to capture, such as all four fingers on the left hand.
-(void) setHand:(VeridiumFourFHandChoice)chosenHand;
/// Advanced method for setting precise sets of fingers to capture, such as index and middle fingers on both hands. Parameter is a set of numbers between 1 and 10, where 1 is the right thumb and 10 is the left little finger.
-(void) setFingers:(NSSet<NSNumber*>*_Nonnull)chosenFingers;

/// This should not be set directly, use setFingers or setHand.
@property NSSet<NSNumber*>* _Nonnull chosenFingers;
/// Advanced flag indicating whether the user may change which hand is being captured at run time. This should almost always be false.
@property BOOL canSwitch;

-(void) configureTimeoutEnabled:(BOOL)new_timeout_enabled withTimeoutCanRestart:(BOOL)new_timeout_can_restart
               andTimoutSeconds:(int)new_timeout_time_seconds andAllowedRetries:(NumberOfRetries)new_allowed_retries;

@property BOOL timeout_enabled;
@property BOOL timeout_can_restart;
@property int timeout_time_seconds;
@property NumberOfRetries allowed_retries;

@property VeridiumFourFExportTemplateFormat exportFormat;

@property BOOL pack_wsq;
@property WSQCompressRatio wsq_compression_ratio;
@property BOOL pack_png;
@property BOOL pack_raw;
@property BOOL pack_bmp;

@property BOOL calculate_nfiq;
@property BOOL extra_scaled_image;
@property int fixed_print_width;
@property int fixed_print_height;
@property BOOL pack_audit_image;
@property NistType nist_type; // choose to output either Type-14 records or type-4 for NIST.
@property BOOL targetIndexFinger;
@property BOOL targetLittleFinger;
@property BOOL allowPartialEnrolment;
@property BOOL agentMode;
@property BOOL active_liveness_beta;

@end

/*!
 The FourF biometric authenticator.
 */
@interface VeridiumBiometricsFourFCapturer : NSObject<VeridiumBioAuthenticator, VeridiumBioEnroller, VeridiumBioExporter>
-(instancetype _Nonnull )configure:(VeridiumFourFCaptureConfig* _Nonnull)config;
@property id<VeridiumFourFUIDelegate> uiDelegate;
@property (readonly) VeridiumFourFCaptureConfig* config;
@end


#endif /* VeridiumBiometricsFourFAuthenticator_h */
