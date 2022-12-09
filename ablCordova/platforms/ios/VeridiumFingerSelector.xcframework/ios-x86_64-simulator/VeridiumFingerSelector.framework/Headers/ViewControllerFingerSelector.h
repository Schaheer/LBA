//
//  ViewControllerIndividual.h
//  VeridiumTouchlessShowcase
//
//  Created by Lewis Carney on 27/09/2017.
//  Copyright © 2018 Veridium Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Veridium4FBiometrics;

@class ViewControllerFingerSelector;

@protocol ViewControllerFingerSelectorDelegate <NSObject>
- (void)viewControllerFingerSelectorDidFinish:(ViewControllerFingerSelector *)controller
                                withSelection:(NSMutableSet *)fingers andWasComplete:(bool)complete;
@end

@interface ViewControllerFingerSelector: UIViewController

@property (nonatomic, weak) id <ViewControllerFingerSelectorDelegate> delegate;
@property (nonatomic) VeridiumFourFCaptureConfig* exportConfig;
@property (nonatomic) bool captureThumb;
@property (nonatomic) bool captureIndex;
@property (nonatomic) bool captureMiddle;
@property (nonatomic) bool captureRing;
@property (nonatomic) bool captureLittle;
@property (nonatomic) bool isRightHand;

+(UIImage*) colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor;
+(UIImage*) imageByName:(NSString*)imageName withBundleIndentifier:(NSString *)bundleID;
+(instancetype) initiate;

@end
