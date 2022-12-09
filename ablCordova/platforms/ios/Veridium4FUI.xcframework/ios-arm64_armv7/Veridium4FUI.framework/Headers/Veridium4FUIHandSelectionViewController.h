//
//  Veridium4FUIHandSelectionViewController.h
//  Veridium4FUI
//
//  Created by Veridium on 23/09/2019.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@import VeridiumCore;
@import Veridium4FBiometrics;

@interface Veridium4FUIHandSelectionViewController : UIViewController<UIAdaptivePresentationControllerDelegate>

typedef void (^handChoiceBlock)(VeridiumFourFHandChoice);

+(instancetype) initiate;

@property handChoiceBlock onHandChosen;
@property voidBlock onCancel;

@end

