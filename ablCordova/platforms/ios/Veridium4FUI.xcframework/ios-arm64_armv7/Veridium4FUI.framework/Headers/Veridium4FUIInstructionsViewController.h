//
//  Veridium4FUIIntroViewController.h
//

#ifndef Veridium4FUIIntroViewController_h
#define Veridium4FUIIntroViewController_h

#import <UIKit/UIKit.h>
@import VeridiumCore;
@import Veridium4FBiometrics;

@interface Veridium4FUIInstructionsViewController : UIViewController<UIAdaptivePresentationControllerDelegate>

@property voidBlock onGetStarted;

@property voidBlock onCancelIntro;

-(void) setCaptureMode:(VeridiumFourFCaptureMode) mode;

@end

#endif /* Veridium4FUIIntroViewController_h */
