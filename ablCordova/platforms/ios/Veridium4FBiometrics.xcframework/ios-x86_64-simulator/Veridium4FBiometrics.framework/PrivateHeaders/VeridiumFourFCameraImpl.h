//
//  VeridiumFourFCameraImpl.h
//  VeridiumFourFCamera
//
//  Created by Lewis Carney on 19/07/2018.
//  Copyright © 2018 veridium. All rights reserved.
//

#ifndef VeridiumFourFCameraImpl_h
#define VeridiumFourFCameraImpl_h

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#include "libffid/IOSPlatformFourFCamera.h"

@interface VeridiumFourFCameraImpl : NSObject<IOSPlatformFourFCamera>

@property (nonatomic) float zDirectionGravityForCapture;
@property CMMotionManager* motionManager;

-(void) setPreviewHolder:(UIView *) previewHolder;

@end


#endif /* VeridiumFourFCameraImpl_h */
