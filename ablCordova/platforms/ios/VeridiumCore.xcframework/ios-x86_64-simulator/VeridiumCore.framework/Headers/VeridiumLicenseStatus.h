//
//  VeridiumLicenseStatus.h
//  VeridiumCore
//
//  Created by Paul Paul on 2/5/18.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VeridiumLicenseStatus : NSObject

/*!
 Initialisation was successful.
 */
@property (readonly) BOOL initSuccess;

/*!
 Libraries were successfully initialised, but in grace period.
 */
@property (readonly) BOOL isInGracePeriod;

/*!
 Setup process aggregated error if any, nil otherwise. The error, if any, contains specific failure error code and proper description.
 */
@property (readonly, nullable) NSError* aggregatedError;

/*!
 server cert hashes
 */
@property (readonly) NSArray<NSString*> * _Nullable  serverCertHashes;

@end
