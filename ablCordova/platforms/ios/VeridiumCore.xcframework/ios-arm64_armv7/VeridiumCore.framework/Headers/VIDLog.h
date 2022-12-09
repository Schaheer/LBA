//
//  VIDLog.h
//  VIDCore
//
//  Created by Radu Ionescu on 19/05/15.
//  Copyright (c) 2015 TimerCap. All rights reserved.
//

#ifndef VIDLog_h
#define VIDLog_h

#import <Foundation/Foundation.h>

#define kVIDMaxLogSize 300

#ifdef __cplusplus
extern "C" {
#endif
    
NS_ASSUME_NONNULL_BEGIN

static NSString* const SERVER_SETTING_ENABLE_DEBUG_BY_DEFAULT = @"enable-debug-by-default";
static NSString* const USER_SETTING_IS_DEBUG_ENABLED = @"isDebugEnabled";
static NSString* const SERVER_SETTING_LOCATION_ACCURACY = @"location-accuracy-threshold";
static NSString* const SERVER_SETTING_LOCATION_WAIT_TIME = @"location-wait-time";

//static long timespent = 0;
//static int recordCount = 0;
    
/**
 * This function has a similar usage to the NSLog function provided by the iOS framework.
 * Besides logging a message to the Apple System Log facility by calling NSLog, this function also stores the message in a cached variable managed by the TCLibrary.
 */
void VIDLog(NSString *format, ...);
/**
 * Clears the entire log stored in the cached variable managed by the TCLibrary which is specifically dedicated for storing the logs.
 */
void VIDClearLog(void);

/**
 * Exports the entire log stored in the cached variable managed by the TCLibrary as an NSString object.
 *
 * @return An NSString object with the console logs that are currently stored in the dedicated cached variable managed by the TCLibrary.
 */
NSString *VIDExportLog(void);

NS_ASSUME_NONNULL_END

#ifdef __cplusplus
}
#endif

#endif
