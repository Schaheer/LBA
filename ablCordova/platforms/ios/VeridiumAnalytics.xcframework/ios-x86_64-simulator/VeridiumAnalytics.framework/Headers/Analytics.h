//
//  Analytics.h
//  VeridiumAnalytics
//
//  Created by Lewis Carney on 08/08/2017.
//  Copyright © 2017 veridium. All rights reserved.
//


#import <UIKit/UIKit.h>

// Levels of verbosity. Set a level using "analyticsCurrentVerbosity"
// Messages wiuth Levels below this are not tracked
typedef enum analyticsVerbosity
{
    VERBOSE,
    DDEBUG,
    INFO,
    ERROR
} Verbosity;

/* Label messages with components. You can add to the bottom of this list
   Converted to a string in Analytics.m
 */
typedef enum analyticsComponent {
  FOURF,
  VFACE,
  NATIVE_BIO,
  SERVER,
  CORE,
  UBA
} Component;

extern NSString * const ComponentType_toString[]; // convert component enum to string ID

/*
 Categories of message
 */
typedef enum analyticsCategory
{
    C_INFO,
    C_SUCCESS,
    C_FAILED,
    C_ERROR,
    C_UEXCEPTION,  // unhandled
    C_EXCEPTION
} Category;

typedef enum analyticsLabel
{
  L_DEVICE, // hardware related
  L_CAMERA, // specifically the camera
  L_CONFIG,   // set configurations
  L_SEQUENCE, // program flow
  L_LICENCE,
  L_EXPORT,
  L_AUTH,
  L_ENROL,
  L_ENROL_EXPORT,
  L_LIVENESS
} Label;

typedef void(^voidBlock)(void);

extern NSString * const CategoryType_toString[];  // Convert category enum to string

@interface Analytics : NSObject

+siAnalytics;

+(NSString *) NSStringFromVerbosity:(Verbosity) verbosity;

+(void)track:(Verbosity)verbosityLevel andComponent:(Component)component
              andCategory:(Category)category andLabel:(Label)label andEvent:(NSString *)event;

+(void)v:(Component)component andCategory:(Category)category andLabel:(Label)label andEvent:(NSString *)event;     // verbose shortcut

+(void)d:(Component)component andCategory:(Category)category andLabel:(Label)label andEvent:(NSString *)event;     // debug shortcut

+(void)i:(Component)component andCategory:(Category)category andLabel:(Label)label andEvent:(NSString *)event;     // info shortcut

+(void)e:(Component)component andCategory:(Category)category andLabel:(Label)label andEvent:(NSString *)event;     // error shortcut

+(void)sendAnalyticsDataWithVerbosity:(Verbosity) verbosityLevel andData:(NSData *) data andTag:(NSString*) tag andMessage:(NSString*) message;

+(void)provideServerCredentialsWithServerID:(NSString*) serverID andPassword:(NSString*) serverPassword;

+(void)logAnalyticsFileData:(Verbosity) verbosityLevel andTag:(NSString*) tag andMessage:(NSString*) message;

+(void)forceFilesToBeSentToServerOnComplete:(voidBlock)completionBlock withViewController:(UIViewController*) controller;

+(void)sendDeviceInfo:(Component)component;

@end

