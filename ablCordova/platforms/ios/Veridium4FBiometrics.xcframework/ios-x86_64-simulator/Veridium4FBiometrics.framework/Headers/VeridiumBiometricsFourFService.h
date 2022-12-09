//
//  VeridiumBiometrics4FExService.h
//  Veridium4FExportBiometrics
//
//  Copyright © 2018 Veridium IP Ltd. All rights reserved.
//

#ifndef VeridiumBiometricsFourFService_h
#define VeridiumBiometricsFourFService_h

#import <Foundation/Foundation.h>

#import "Constants.h"
#import "VeridiumBiometricsFourFCapturer.h"

@interface VeridiumBiometricsFourFService : NSObject

/*!
 Exports data using the requested biometric export methods
 
 @param config       VeridiumExportConfig filled in with the export information
 @param successBlock success callback VeridiumBiometricExternalHandlingBlock
 @param failBlock    fail callback voidBlock
 @param cancelBlock  cancel callback
 @param errorBlock   error callback errorBlock; receives the error as an NSError
 */
+(void)exportTemplate:(VeridiumFourFCaptureConfig * _Nonnull)config
            onSuccess:(VeridiumBiometricExternalHandlingBlock _Nonnull) successBlock
               onFail:(voidBlock _Nonnull) failBlock
             onCancel:(voidBlock _Nullable) cancelBlock
              onError:(errorBlock _Nonnull) errorBlock;

+(void)exportAndEnrollTemplate:(VeridiumFourFCaptureConfig * _Nonnull)config
                     onSuccess:(VeridiumBiometricFullVectorAndExternalHandlingBlock _Nonnull) successBlock
                        onFail:(voidBlock _Nonnull) failBlock
                      onCancel:(voidBlock _Nullable) cancelBlock
                       onError:(errorBlock _Nonnull) errorBlock;


@end


#endif /* VeridiumBiometricsFourFService_h */
