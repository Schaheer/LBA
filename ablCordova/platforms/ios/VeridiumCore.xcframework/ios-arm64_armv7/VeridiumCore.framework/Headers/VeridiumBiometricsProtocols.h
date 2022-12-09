//
//  BiometricsProtocols.h
//  VeridiumCore
//
//  Created by razvan on 11/23/15.
//
//

#import "VeridiumUtils.h"
#import "VeridiumBiometricVector.h"
#import "VeridiumLicenseStatus.h"

#pragma mark Biometric interface protocols

/*!
 @enum VeridiumAuthResult
 @abstract
 Constatnts for the authentication result.

 @constant VeridiumAuthResultAUTHENTICATED
 authentication was successful
 @constant VeridiumAuthResultFAILED
 authentication was failed
 @constant VeridiumAuthResultCANCELED
 authentication was canceled
 */
typedef NS_ENUM(NSUInteger,VeridiumAuthResult) {        // !! if updated, please update authResultString as well !!
  VeridiumAuthResultAUTHENTICATED = 0,
  VeridiumAuthResultFAILED,
  VeridiumAuthResultCANCELED,
  VeridiumAuthResultAUTHENTICATED_BY_ADMIN,
  VeridiumAuthResultTIMEOUT,
  VeridiumAuthResultON_GOING_ON_ANOTHER_DEVICE,
  VeridiumAuthResultNONE
};


/*!
 @enum VeridiumEnrollResult
 @abstract
 Constants for the enrollment result.

 @constant VeridiumEnrollResultSUCCESS
 enrollment was successful
 @constant VeridiumEnrollResultFAILED
 enrollment was failed
 @constant VeridiumEnrollResultCANCELED
 enrollment was canceled
 @constant VeridiumEnrollResultERROR
 an enrollment error occurred
 */
typedef NS_ENUM(NSUInteger,VeridiumEnrollResult) {
  VeridiumEnrollResultSUCCESS = 0,
  VeridiumEnrollResultFAILED,
  VeridiumEnrollResultCANCELED,
  VeridiumEnrollResultERROR,
};

/*!
 @enum VeridiumAuthSessionResult
 @abstract
 Constants for the authentication session result.
 
 @constant VeridiumAuthSessionResultAUTHENTICATED_BY_ADMIN
 session was authorized by the app admin
 @constant VeridiumAuthSessionResultCANCELED
 session was canceled
 @constant VeridiumAuthSessionResultTIMEOUT
 session timed out
 */

FOUNDATION_EXPORT NSString *const _Nonnull VeridiumAuthResultStringAUTHENTICATED;
FOUNDATION_EXPORT NSString *const _Nonnull VeridiumAuthResultStringFAILED;
FOUNDATION_EXPORT NSString *const _Nonnull VeridiumAuthResultStringCANCELED;
FOUNDATION_EXPORT NSString *const _Nonnull VeridiumAuthResultStringAUTHENTICATED_BY_ADMIN;
FOUNDATION_EXPORT NSString *const _Nonnull VeridiumAuthResultStringTIMEOUT;
FOUNDATION_EXPORT NSString *const _Nonnull VeridiumAuthResultStringON_GOING_ON_ANOTHER_DEVICE;
FOUNDATION_EXPORT NSString *const _Nonnull VeridiumAuthResultStringNONE;

FOUNDATION_EXPORT NSString* _Nonnull authResultString(VeridiumAuthResult res);

FOUNDATION_EXPORT NSString *const _Nonnull kBioLibConfig4FHand;
FOUNDATION_EXPORT NSString *const _Nonnull kBioLibConfig4FLiveness;
FOUNDATION_EXPORT NSString *const _Nonnull kBioLibConfigVFaceLiveness;

/*!
 Block that receives a full vector (used by enrollers)
 @param vector the vector
 */
typedef void(^biometricFullVectorBlock)(VeridiumBiometricFullVector* _Nonnull vector);

/*!
 Block that receives an arbitrary NSData* object, typically registered by integrators as a hook to access export data.
 @param data the export data
 */
typedef void(^VeridiumBiometricExternalHandlingBlock)(NSData* _Nonnull data);

/*!
 Block that receives an arbitrary NSData* object and must return a boolean, typically registered by integrators during enroll and export to access and check export data.
 @param data the export data
 */
typedef bool(^VeridiumBiometricExternalValidationBlock)(NSData* _Nonnull data);

/*!
 Block that receives a full vector and an arbitrary NSData* object. Used by custom enroll and export functionality which does not require the enroll system supplied with the SDK.
 @param vector the enrolled or auth vector
 @param data the export data
 */
typedef void(^VeridiumBiometricFullVectorAndExternalHandlingBlock)(VeridiumBiometricFullVector* _Nonnull vector, NSData* _Nonnull data);

/*!
 Block that receives an array of full vectors (used by aggregated enroller)
 @param  vectors the vectors
 */
typedef void(^biometricFullVectorsBlock)(NSArray<VeridiumBiometricFullVector*>* _Nonnull vectors);


/*!
  Block that receives a nullable vector
  @param vector the vector
 */
typedef void(^biometricVectorUpdateBlock)(VeridiumBiometricVector* _Nullable vector);


/*!
 Block that receives an authentication result and the error if any occurred
 @param authResult  the authentication result
 @param error       the error
 */
typedef void(^_Nullable authResultBlock)(VeridiumAuthResult authResult, NSError* _Nullable error);

/*!
 The bimetric metching strategy protocol. If a non-standard matching stragety is needed, the MatchingStrategyClass has to implement this protocol.
 */
@protocol VeridiumBiometricMatchingStrategy <NSObject>

/*!
 This method is called after a VeridiumBiometricVector is extracted. This method should match the `probe` with the enrollemnt vector.

 @param probe       extracted VeridiumBiometricVector.
 @param doneBlock   doneBlock this BOOL block should be called with the authentication result(YES/NO) and an NSError is there is any.
 */
-(void) match:(VeridiumBiometricVector* _Nonnull)probe whenDone:(void(^ _Nonnull)(BOOL, NSError* _Nullable)) doneBlock;


/*!
 This property should store enrollment extra data (e.g. 4F specify enrolled hand).
 */
@property (readonly, nullable) NSDictionary* enrollExtraConfigData;

@end


/*!
 Protocol adopted by biometric engines to setup themselves with licenses
 */
@protocol VeridiumBioLibraryLoader <NSObject>

/*!
 The engine name property uniquely identifies biometric engines
 */
@property (readonly, nonatomic, nonnull) NSString* engineName;

- (nullable VeridiumLicenseStatus *) setupBioLibraryWith:(nonnull NSString *) license;

@end

/*!
 Protocol adopted by biometric engines to provide support for biometric enrollment
 
 Biometric engines usually implement also the BioAuthenticator protocol for handling authentication.
 
 However not all of them do, e.g. `TouchID` whose enrollment is handled by the system
 
 */
@protocol VeridiumBioEnroller <NSObject>


/*!
 The engine name property uniquely identifies biometric engines
 */
@property (readonly, nonatomic, nonnull) NSString* engineName;


///---------------------
/// @name Enrollment
///---------------------

@optional

/*!
 Ask the biometric engine to perform biometric enrollment
 
 @param onSuccess the success callback voidBlock
 @param onFail    the fail callback stringBlock; receives the failure reason
 @param onCancel  the cancell callback voidBlock
 @param onError   the error callback stringBlock; receives the error message
 */
-(void) enroll:(biometricFullVectorBlock _Nonnull) onSuccess
        onFail:(voidBlock _Nonnull) onFail
      onCancel:(voidBlock _Nonnull) onCancel
       onError:(errorBlock _Nonnull) onError;

/*!
 Ask the biometric engine to perform biometric enrollment, using one block callback.
 
 @param completion completion the callback contaning the error if any occurred and the extracted `VeridiumBiometricFullVector`.
 */
-(void) enrollWithCompletion:(void(^ _Nonnull)(VeridiumBiometricFullVector* _Nullable vector, NSError* _Nullable error)) completion;

@end


/*!
 Protocol adopted by biometric engines to provide authentication support
 
 Biometric engines usually implement also the BioAuthenticator protocol for handling authentication.
 
 However not all of them do, e.g. `TouchID` whose enrollment is handled by the system
 */
@protocol VeridiumBioAuthenticator <NSObject>

/*!
 The engine name property uniquely identifies biometric engines
 */
@property (readonly, nonatomic, nonnull) NSString* engineName;

@property authResultBlock authResultBlock;


/*!
 Tell the engine to abort current authentication operation if in progress
 
 @param authenticationResult the desired result for the aborted authentication.
 */

-(void) abortRunningAuthenticationWithAuthenticationResult:(VeridiumAuthResult) authenticationResult;

/*!
 Ask the biometric engine to perform the biometric authentication, using one block callback.

 @param reason the authentication reason
 @param completion the callback contaning the error if any occurred and the `VeridiumAuthResult`.
 */
-(void) authenticate:(NSString * _Nonnull) reason
      withCompletion:(void(^ _Nonnull)(VeridiumAuthResult authStatus, NSError* _Nullable error)) completion;

/*!
 Configure the matching strategy for the next authentication

 @param matchingStrategy the configured matching strategy
 */
-(void) configureMatchingStrategy:(id<VeridiumBiometricMatchingStrategy> _Nonnull) matchingStrategy;

@optional

/*!
 Ask the engine to produce a local only matching strategy configured for a provided enrollment vector and a
 
 @param vector the enrollment vector
 @param vectorUpdateBlock optional update block (to be used by caller to store the vector after matching
 @return the configured strategy
 */
+(id<VeridiumBiometricMatchingStrategy> _Nonnull) createFullLocalMatchingStrategyWithVector:(VeridiumBiometricFullVector* _Nonnull) vector andVectorUpdateBlock:(biometricFullVectorBlock _Nullable) vectorUpdateBlock;

/*!
 Updates configuration for the authenticatior
 
 @param configDict dictionary including authenticator configuration
 */
- (void) updateConfig:(nonnull NSDictionary *) configDict;

/*!
  Extra parameters comes with the authentictaion result
 */
@property (nonatomic, nullable) NSDictionary* extraParams;

@end


/*
 Protocol for export configuration options.
 */
@protocol VeridiumBiometricExportConfig <NSObject>
@property (nonatomic, nonnull) NSString* engineName;
@end


/*!
 Protocol adopted by biometric engines to provide support for biometric export
 */
@protocol VeridiumBioExporter <NSObject>


/*!
 The engine name property uniquely identifies biometric engines
 */
@property (readonly, nonatomic, nonnull) NSString* engineName;


///---------------------
/// @name Export
///---------------------

/*!
 Ask the biometric engine to export a biometric in a configurable format.
 
 @param settings  an object containing configuration options.
 @param onSuccess the success callback VeridiumBiometricFullVectorAndExternalHandlingBlock
 @param onFail    the fail callback stringBlock; receives the failure reason
 @param onCancel  the cancell callback voidBlock
 @param onError   the error callback stringBlock; receives the error message
 */
-(void) export:(id<VeridiumBiometricExportConfig> _Nonnull) settings
                         onSuccess:(VeridiumBiometricFullVectorAndExternalHandlingBlock _Nonnull) onSuccess
                            onFail:(voidBlock _Nonnull) onFail
                          onCancel:(voidBlock _Nonnull) onCancel
                           onError:(errorBlock _Nonnull) onError;

@end


#pragma mark UI Delegate protocols

/*!
 Base protocol used to connect the biometric engine and it's hangling UI implementation.
 
 It specifies the contract for common UI traits shared by all biometric engine types. This protocol is extended by each biometric implementation that adds specific UI methods specs.
 */
@protocol VeridiumBiometricsUIDelegate <NSObject>

/*!
 Ask the UI to present itself and waits for completion
 
 @param doneBlock the completion callback voidBlock
 */
-(void) show:(voidBlock _Nonnull) doneBlock;

/*!
 Ask the UI to handle the successful outcome of the auth/enroll operation (e.g. show message and remove itself from the UI stack) and waits for completion
 
 @param doneBlock the completion callback voidBlock
 */
-(void) handleSuccess:(voidBlock _Nonnull)doneBlock;

/*!
 Ask the UI to handle the failure of the auth/enroll operation (e.g. show that authentication has failed and remove itself from the UI stack) and waits for completion
 
 @param doneBlock the completion callback voidBlock
 */
-(void) handleFail:(voidBlock _Nonnull)doneBlock;

/*!
 Ask the UI to handle the successful outcome of the auth/enroll operation (e.g. remove itself from the UI stack) and waits for completion
 
 @param doneBlock the completion callback voidBlock
 */
-(void) handleCancel:(voidBlock _Nonnull)doneBlock;

/*!
 Ask the UI to handle the erroneous outcome of the auth/enroll operation (e.g. show the error message and remove itself from the UI stack) and waits for completion
 
 @param error the error
 @param doneBlock the completion callback voidBlock
 */
-(void) handleError:(NSError* _Nonnull) error whenDone:(voidBlock _Nonnull)doneBlock;

@optional

/*!
 By calling this function the engine provides a block to be called by the UI when the user initiates a cancel action (e.g. when the user hits a cancel button).
 
 The block is to be stored by the implementor of the protocol and used later when the user initiates the cancel action.
 
 The engine will do all the internal operations pertaining to the cancel procedure (ie. turn off camera, release allocated resources,etc..) and then call the cancel the handleCancel: method of the delegate to allow the UI to peform its post cancel UI actions
 
 @param cancelActionBlock The cancel callback action block to be stored and called by the delegate when the user initiates a cancel action
 */
-(void) connectCancelAction:(voidBlock _Nonnull) cancelActionBlock;
-(void) connectPauseAction:(boolResultBlock _Nonnull) pauseActionBlock;
-(void) connectResumeAction:(voidBlock _Nonnull) resumeActionBlock;

/*!
 Ask the UI to handle the state in which the engine is waiting for the user to manually start the operation
 
 You can skip the implementation of this method if you always configure the engine to start automatically
 
 Usually this method makes available to the user a start button (or a tap recognizer) to manually start the operation and calls the callback block in the UI handler of the tap event.
 
 Calling the callback block begins the enroll/auth operation and starts the timeout timer
 
 @param manualStartBlock the manual start callback voidBlock
 */
-(void) handleWaitingForManualStart:(voidBlock _Nonnull) manualStartBlock;

/*!
 Ask UI to handle the overall progress update.
 The UI usually uses the passed value to update a progress bar or a label displaying the progress
 
 @param progressPercent progress value between 0 and 1 (1 = 100%)
 */
-(void) handleNormalizedProgressUpdate:(float) progressPercent;

/*!
 Ask UI to handle the progress update with exact seconds passeed out of total seconds
 
 The UI usually uses the passed values to display a countdown or a x/y seconds
 
 @param progressPassedSeconds the passed seconds
 @param totalSeconds the total number of seconds until operation times out
 */
-(void) handleProgressUpdateWithPassedSeconds:(float) progressPassedSeconds outOfTotalSeconds:(float) totalSeconds;


@end
