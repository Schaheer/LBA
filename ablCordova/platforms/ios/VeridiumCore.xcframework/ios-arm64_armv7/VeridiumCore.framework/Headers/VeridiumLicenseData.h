//
//  VeridiumLicense.h
//  VeridiumCore
//
//  Created by Paul Paul on 2/26/18.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kVeridiumLicenseTypeSDK @"SDK"
#define kVeridiumLicenseTypeBIOLIBS @"BIOLIBS"

@interface VeridiumLicenseData : NSObject

/*!
 Static initializer

 @param license the license JSON formated
 @return initalized Object
 */
+(instancetype _Nullable)newFomJSON:(NSString* _Nonnull)license;

/*!
 The type. BIOLIBS, SDK etc..
 */
@property (nonnull) NSString* type;

/*!
 The name. SDK, 4F etc...
 */
@property (nonnull) NSString* name;

/*!
 The license.
 */
@property (nonnull) NSString* license;

@end
