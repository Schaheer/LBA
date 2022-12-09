// Copyright © Veridium IP Ltd., 2018. All rights reserved
// This source is the sole property of Veridium IP Ltd and should not be copied
// in full or in part.

#ifndef IOSPlatformGui_h
#define IOSPlatformGui_h

#include <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

/*!
   @brief Instructions to relay to the user as to the progress of a capture.
*/
typedef enum {
    FourFInstructionWait = 0,
    FourFInstructionOutOfFocus,
    FourFInstructionYes,
    FourFInstructionRoiTooBig,
    FourFInstructionRoiTooSmall,
    FourFInstructionFingersTooFarApart,
    FourFInstructionFingersHigh,
    FourFInstructionFingersLow,
    FourFInstructionFingersFarLeft,
    FourFInstructionFingersFarRight,
    FourFInstructionImageRequestedWaiting,
    FourFInstructionInvalidROIS,
    FourFInstructionImageTooDim,
    FourFInstructionWrongHand,
    FourFInstructionFingersHoldApart
    // Do not renumber or reorder
} VeridiumFourFIOSUserInstruction;

/*!
   @brief Types of blocking event for indicating specific events to a user
*/
typedef enum {
    FourFBlockingInstructionNONE = 0,
    FourFBlockingInstructionSWITCH_CAPTURE_TARGET,
    FourFBlockingInstructionENROLLMENT_STEP2_OF_2,
    FourFBlockingInstructionENROLLMENT_STEP2_OF_3,
    FourFBlockingInstructionENROLLMENT_STEP3_OF_3,
    FourFBlockingInstructionINTERNAL_MISMATCH,
    FourFBlockingInstructionDISPLAY_HELP
    // Do not renumber or reorder, or keep in sync with main FourF::Interface::BlockingUserInstruction
} VeridiumFourFIOSBlockingUserInstruction;

/*!
   @brief The distinct modes in which 4FingerID can capture fingerprint data.
*/
typedef enum {
    FourFCaptureModeHand = 0,
    FourFCaptureModeThumb,
    FourFCaptureModeFinger,
    FourFCaptureModeAgentHand,
} VeridiumFourFCaptureMode;

/*!
   @brief The current target for capture, either an individual finger, a thumb, or 4 fingers of a hand
*/
typedef enum {
    FourFPrintToCaptureINVALID = 0,
    FourFPrintToCaptureTHUMB_RIGHT,
    FourFPrintToCaptureINDEX_RIGHT,
    FourFPrintToCaptureMIDDLE_RIGHT,
    FourFPrintToCaptureRING_RIGHT,
    FourFPrintToCaptureLITTLE_RIGHT,
    FourFPrintToCaptureTHUMB_LEFT,
    FourFPrintToCaptureINDEX_LEFT,
    FourFPrintToCaptureMIDDLE_LEFT,
    FourFPrintToCaptureRING_LEFT,
    FourFPrintToCaptureLITTLE_LEFT,
    FourFPrintToCaptureHAND_RIGHT,
    FourFPrintToCaptureHAND_LEFT
} VeridiumFourFPrintToCapture;

/*!
   @brief Types of user actions.
*/
typedef enum {
    FourFBlockingUserActionNext = 0,
    FourFBlockingUserActionCancel
    // Do not renumber or reorder, or keep in sync with main FourF::Interface::BlockingUserAction
} VeridiumFourFIOSBlockingUserAction;

@protocol IOSPlatformFourFGui

/*!
    @brief Implement UI updates given an instruction
    @discussion These events do not halt progress of the capture
    so you should not expect user input. Newly received instructions should override previous ones.
    @param  instruction  instruction
 */
- (void)displayUserInstruction:(VeridiumFourFIOSUserInstruction)instruction;

/*!
   @brief Implement UI updates given an instruction that may require user input.
   @discussion These events halt progress of the capture in order to get user input if desired. Once handled, call
    releaseBlockingUI with a FourFBlockingUserAction to continue.
   @param  instruction instruction
*/
- (void)displayBlockingUserInstruction:(VeridiumFourFIOSBlockingUserInstruction)instruction;

/*!
   @brief Informs your UI of camera preview width and height, for example, to set aspect ratios.
   @discussion Informs your UI of camera preview width and height, for example, to set aspect ratios.
   @param width camera preview width (pixels)
   @param height camera preview height (pixels)
*/
- (void)setPreviewResolutionToWidth:(int)width andHeight:(int)height;

/*!
   @brief Provides information about the *mode* 4 FingerID is currently in, where the hand / digit
   should be placed within the camera view, and if the user is able to decide to alter which
   hand they are capturing.
   @discussion configureUI() will be called whenever 4 FingerID indicates it would like to capture a
   particular print, and this may occur several times. For example, when configured to capture
   both the left and right hand `configureUI()` will be called twice; once at the start
   of left hand capture, and again after successful capture of the left hand to begin right hand capture.
   @param captureMode The mode that the UI should prepare capture for. You should layout your UI
                accordingly.
   @param PrintToCapture Which fingerprint, or prints, are about to be captured
   @param TargetRegion A rectangle indicating the region in the camera preview a user should
                            place their fingers within. You should use this region to position your
                            hand guide on screen. Values are normalised to the camera preview.
                            For example, an x value of 0.5 is the centre of the preview. A width
                            value of 0.25 is 25% the width of the preview. Note: this area will
                            differ between devices, so do not use a static positioning of UI
                            components.
    @param CanSwitchHand TRUE if the user is allowed to choose to switch hands during capture. If
                         TRUE you should provide a mechanism for the user to change hands (see
                         FourFUIIntegrationWrapper.requestSwitchHand()). If FALSE, disable any
                         UI for hand switching.
*/
- (void)configureUI:(VeridiumFourFCaptureMode)captureMode withPrintToCapture:(VeridiumFourFPrintToCapture)printToCapture andTargetRegion:(CGRect)targetRegion andCanSwitchHand:(BOOL)canSwitch;

/*!
   @brief Display realtime feedback.
   @discussion This includes "hand distance" relative to the
    optimal, and position of each finger.
   @param rois NSArray of CGRect values indicating the position of fingers; index, middle, ring, and little.
                Values are normalised to the camera preview. For example, an x value of 0.5 is the
                centre of the preview. A width value of 0.25 is 25% the width of the preview.
                You must account for how your UI has cropped and positioned the camera preview in
                order to display them correctly.
   @param handDistance the normalised distance of the hand from the optimal distance given in the
                    range [-2.5, 2.5], where values [-1.0, 1.0] are acceptable for capture.
*/
- (void)displayRealTimeInformation:(NSArray<NSValue*>*)rois andHandDistance:(float)handDistance;

/*!
   @brief Indicates the biometric is processing for a result following successful acceptance
   of a capture.  No other feedback is given until onPocessingStop is received. Use this, for
        example, to show a spinning progress wheel.
*/
- (void)onProcessingStart;

/*!
   @brief Indicates the biometric has finished processing for a result following successful acceptance
   of a capture. This is always paired with an onPocessingStart.
*/
- (void)onProcessingStop;

/*!
   @brief  The system is about to begin taking a high resolution picture. This is always paired with
    onTakePictureStop.
*/
- (void)onTakePictureStart;

/*!
   @brief  The system has finished taking a high resolution picture. This is always paired with
   onTakePictureStart.
*/
- (void)onTakePictureStop;

/*!
   @brief An image has been accepted as being of good quality. Processing will not begin until this
    has occurred. Once received a user can safely remove their hand from view.
*/
- (void)indicateImageAcceptance;

/*!
   @brief An image has been rejected because of poor quality. Processing will not begin, and another
    image may be requested.
*/
- (void)indicateImageRejection;

@end

// This is a promise that the FourF library will implement these functions.
#ifdef __cplusplus
extern "C" {
#endif

/*!
   @brief  Request to cancel the current operation. If accepted, the UI will then receive a dismiss() with
    reason DismissReason.CANCEL. It is possible for a cancel call to be ignored. For example, if the system is
    already processing a capture then dismiss() could be called with success.
*/
void libffid_ios_gui_requestCancel(void);

/*!
   @brief Request to switch hands. Call this if the user has indicated they wish to change hands.
      The current configuration must allow hand switching for this to be functional.
       A call to configureUI() will then be triggered in order to prompt to update the
       UI.
*/
void libffid_ios_gui_requestSwitchHand(void);

/*!
   @brief  Request to pause the operation and show a help screen. The UI will then receive a blocking
      instruction to display help.
*/
void libffid_ios_gui_requestHelp(void);

/*!
   @brief  Indicate the result of a blocking instruction.
   @param userAction the action the user wishes to perform following a blocking instruction.
*/
void libffid_ios_gui_handledBlockingUIInstructionWithAction(VeridiumFourFIOSBlockingUserAction userAction);
#ifdef __cplusplus
}
#endif

#endif  // IOSPlatformGui_h
