//
//  VeridiumBiometricsFourFCommon.h
//  VeridiumFourFBiometrics
//
//  Created by Lewis Carney on 18/07/2018.
//  Copyright © 2018 veridium. All rights reserved.
//

#ifndef VeridiumBiometricsFourFCommon_h
#define VeridiumBiometricsFourFCommon_h

@import VeridiumCore;
#import <UIKit/UIKit.h>
#include "IOSPlatformFourFGui.h"
#include "Constants.h"

typedef enum FourFUIDismissReason
{
    SUCCESS_ENROLL,
    SUCCESS_AUTHENTICATE,
    SUCCESS_EXPORT,
    FAIL_ENROLL,
    FAIL_AUTHENTICATE,
    FAIL_EXPORT,
    FAIL_LIVENESS,
    CANCEL,
    TIMEOUT,
    ERROR
} DismissReason;

/*!
 The VeridiumFourFEnrollerUIDelegate subprotocol with UI delegate methods & props specific to FourF enrollment
 */
@protocol VeridiumFourFUIDelegate<IOSPlatformFourFGui>
/*!
 Ask the UI to present itself and waits for completion
 
 @param doneBlock the completion callback voidBlock
 */
-(void) show:(voidBlock _Nonnull) doneBlock withIntroScreen:(BOOL) showIntroScreen;

-(UIView *_Nonnull) getPreviewHolder;

-(void) dismiss:(voidBlock _Nonnull) doneBlock withReason:(DismissReason) reason;

@optional

/*!
 Ask UI to promt the user to decide the hand configuration for enrolment.
 
 @param handChoiceBlock callback for when the user decides to pick hand for enrolment
 @param cancelBlock     callback for when the user decides to cancel the enrollment
 */
-(void) showHandSelectionScreenForEnrollment:(void (^_Nonnull)(VeridiumFourFHandChoice)) handChoiceBlock cancel:(voidBlock _Nonnull) cancelBlock;

@end

@interface VeridiumFourFViewController : UIViewController

//Do not override these methods
/*!
   @brief  Request to cancel the current operation. If accepted, the UI will then receive a dismiss() with
    reason DismissReason.CANCEL. It is possible for a cancel call to be ignored. For example, if the system is
    already processing a capture then dismiss() could be called with success.
*/
-(void) requestCancel;

/*!
   @brief  Request to pause the operation and show a help screen. The UI will then receive a blocking
      instruction to display help.
*/
-(void) requestHelp;

/*!
   @brief Request to switch hands. Call this if the user has indicated they wish to change hands.
      The current configuration must allow hand switching for this to be functional.
       A call to configureUI() will then be triggered in order to prompt to update the
       UI.
*/
-(void) requestSwitchHand;

/*!
   @brief  Indicate the result of a blocking instruction.
   @param userAction the action the user wishes to perform following a blocking instruction.
*/
-(void) releaseBlockingUI:(VeridiumFourFIOSBlockingUserAction)userAction;


@end

#endif /* VeridiumBiometricsFourFCommon_h */
