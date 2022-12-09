//
//  Licensing.h
//  LicensingFramework
//
//  Created by Rizwan Awan on 01/01/2019.
//  Copyright © 2019 Unikrew Solutions Private Limited. All rights reserved.
//

#ifndef Licensing_h
#define Licensing_h

#import <Foundation/Foundation.h>

@interface Licensing : NSObject

- (NSString *) doAuthAction : (NSString *) publicKey : (NSString *) packageName : (NSString *) uuid : (NSString *) timestamp;

- (NSString *) readLicense: (NSString *) key : (NSString *) cipher;

// - (void) freeString: (NSString *) str;
- (NSString *) generateISO2 : (NSInteger) imageHeight: (NSInteger) imageWidth : (NSString *) rawImage;

@end


#endif /* Licensing_h */
