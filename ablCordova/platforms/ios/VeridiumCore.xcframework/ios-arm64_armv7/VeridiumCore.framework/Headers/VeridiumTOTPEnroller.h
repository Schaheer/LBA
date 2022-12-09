//
//  VeridiumTOTPEnroller.h
//  VeridiumCore
//
//  Created by Vlad Hudea on 23/03/2020.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VeridiumUtils.h"
#import "VeridiumBiometricsProtocols.h"
#import "VeridiumTOTPAuthConfig.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 Block that receives a pin (used by enrollers)
 @param pin the pin
 */
typedef void(^totpPinBlock)(NSString * _Nonnull pin);

typedef NS_ENUM(NSInteger, TOTPPinEntryState) {
    TOTPPinEntryStateSet,
    TOTPPinEntryStateVerify
};

@interface VeridiumTOTPUIConfig : NSObject

@property NSInteger pinLength;
@property NSString *title;
@property NSString *pageDescription;
@property NSString *subtitleSet;
@property NSString *subtitleConfirm;
@property (nullable) NSString *warning;
@property TOTPPinEntryState pinEntryState;

-(instancetype _Nonnull) initWithPinLength:(NSInteger)pinLength
                                     title:(NSString *)title
                               subtitleSet:(NSString *)subtitleSet
                             pinEntryState:(TOTPPinEntryState)pinEntryState;

-(instancetype _Nonnull) initWithPinLength:(NSInteger)pinLength
                                     title:(NSString *)title
                               description:(NSString *)description
                               subtitleSet:(NSString *)subtitleSet
                           subtitleConfirm:(NSString *)confirmPageDescription
                             pinEntryState:(TOTPPinEntryState)pinEntryState;

-(instancetype _Nonnull) initWithEmptyConfig NS_SWIFT_NAME(emptyConfig());

@end

@protocol TOTPUIDelegate <NSObject>

- (void)setSuccessClosure:(totpPinBlock _Nonnull)success;
- (void)setCancelClosure:(voidBlock _Nonnull)cancel;
- (void)showWith:(VeridiumTOTPUIConfig *_Nonnull)config NS_SWIFT_NAME(showWith(config:));

@end

@interface VeridiumTOTPEnroller : NSObject <VeridiumBioEnroller>

@property (nonatomic, readonly) NSString *engineName;
@property id<TOTPUIDelegate> uiDelegate;
@property (nonatomic) VeridiumTOTPUIConfig *config;

- (instancetype)initWithConfig:(VeridiumTOTPUIConfig *)config;

- (void)configure:(VeridiumTOTPUIConfig *)uiSettings;

- (void)enroll:(totpPinBlock _Nonnull)onSuccess
          fail:(voidBlock _Nonnull)failCompletion
        cancel:(voidBlock _Nonnull)cancelCompletion
         error:(errorBlock _Nonnull)onError;

@end

NS_ASSUME_NONNULL_END
