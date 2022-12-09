//
//  Veridium4FUIAlertViewController.h
//  Veridium4FUI
//
//  Created by Richard Tyson on 06/10/2020.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#ifndef Veridium4FUIAlertViewController_h
#define Veridium4FUIAlertViewController_h

#import <UIKit/UIKit.h>
@import VeridiumCore;

@interface Veridium4FUIAlertViewController : UIViewController

@property (nonatomic) UIImage* backgroundImageToUse;
@property (nonatomic) NSString* messageTextString;
@property (nonatomic) bool landscape;

@end

#endif /* Veridium4FUIAlertViewController_h */
