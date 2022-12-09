//
//  VeridiumSDK+4FUI.h
//
//  Created by Lewis Carney on 18/07/2018.
//  Copyright © 2018 veridium. All rights reserved.
//

#ifndef VeridiumSDK_4FUI_h
#define VeridiumSDK_4FUI_h

@import VeridiumCore;
@import Veridium4FBiometrics;

/*!
 SDK  4F UI additions
 */
@interface VeridiumSDK (Veridium4FUIAdditions)

/*!
 Method which registers the  4F UI and VeridiumBiometrics4FAuthenticator
 */
-(void) register4FUIAuthenticator;

/*!
 Method which registers the  4F UI and VeridiumBiometrics4FEnroller
 */
-(void) register4FUIEnroller;

/*!
 Method which registers the  4F UI and VeridiumBiometrics4FExporter
 */
-(void) register4FUIExporter;

@end


#endif /* VeridiumSDK_4FUI_h */
