//
//  VeridiumPINCoordinator.h
//  VeridiumCore
//
//  Created by Erkut Demirhan on 9/9/20.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VeridiumBiometricsProtocols.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kVeridiumEngineNamePIN;

/*!
 Block that receives a pin (used by enrollers)
 @param pin the pin
 */
typedef void(^pinBlock)(NSString * _Nonnull pin);

#pragma mark - Veridium PIN Config

typedef NS_ENUM(NSInteger, PINEntryState) {
    PINEntryStateSet,
    PINEntryStateVerify
};

@interface VeridiumPINConfig : NSObject

@property NSInteger pinLength;
@property NSString *title;
@property NSString *subtitleSet;
@property NSString *subtitleConfirm;
@property NSString *pageDescription;
@property (nullable) NSString *warning;
@property PINEntryState pinEntryState;

-(instancetype _Nonnull) initWithPinLength:(NSInteger)pinLength
                                     title:(NSString *)title
                               subtitleSet:(NSString *)subtitleSet
                             pinEntryState:(PINEntryState)pinEntryState;

-(instancetype _Nonnull) initWithPinLength:(NSInteger)pinLength
                                     title:(NSString *)title
                               description:(NSString *)description
                               subtitleSet:(NSString *)subtitleSet
                           subtitleConfirm:(NSString *)subtitleConfirm
                             pinEntryState:(PINEntryState)pinEntryState;

-(instancetype _Nonnull) initWithEmptyConfig NS_SWIFT_NAME(emptyConfig());

@end

#pragma mark - Veridium PIN UI Delegate

@protocol VeridiumPINUIDelegate <NSObject>

- (void)setSuccessClosure:(pinBlock _Nonnull)success;
- (void)setCancelClosure:(voidBlock _Nonnull)cancel;
- (void)setErrorClosure:(errorBlock _Nonnull)error;
- (void)showWith:(VeridiumPINConfig * _Nonnull)config NS_SWIFT_NAME(showWith(config:));

@end

#pragma mark - Veridium PIN Coordinator

/*!
  This class coordinates enrollment and authentication with Veridium PIN
*/
@interface VeridiumPINCoordinator : NSObject <VeridiumBioEnroller, VeridiumBioAuthenticator>

@property (nonatomic, readonly) NSString *engineName;
@property (readonly) VeridiumPINConfig *pinConfig;
@property id<VeridiumPINUIDelegate> uiDelegate;

- (instancetype _Nonnull)configure:(VeridiumPINConfig *_Nonnull)config;

- (void)enroll:(pinBlock _Nonnull)onSuccess
        cancel:(voidBlock _Nonnull)onCancel
         error:(errorBlock _Nonnull)onError;

@end

NS_ASSUME_NONNULL_END
