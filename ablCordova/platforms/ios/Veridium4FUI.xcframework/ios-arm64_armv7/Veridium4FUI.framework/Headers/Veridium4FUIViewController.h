//
//  Veridium4FUIViewController.h
//
//  Created by Lewis Carney and Josiah Kane on 28/03/2019.
//  Copyright © 2019 veridium. All rights reserved.
//

#ifndef Veridium4FUIViewController_h
#define Veridium4FUIViewController_h

#import <UIKit/UIKit.h>
@import VeridiumCore;
@import Veridium4FBiometrics;

/*!
 The 4F enrollment View Controller.
 */
@interface Veridium4FUIViewController : VeridiumFourFViewController<VeridiumFourFUIDelegate, UIAdaptivePresentationControllerDelegate>


+(instancetype _Nullable) createFromStoryboard:(UIStoryboard* _Nullable)storyboard withIdentifier:(NSString* _Nullable)identifier;


+(instancetype _Nullable) createDefault;

@end

#endif /* Veridium4FUIViewController.h */

