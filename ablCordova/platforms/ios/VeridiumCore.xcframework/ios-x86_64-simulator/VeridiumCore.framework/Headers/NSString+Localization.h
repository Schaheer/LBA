//
//  NSString+Localization.h
//  VeridiumCore
//
//  Created by Erkut Demirhan on 8/17/20.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const _Nonnull VeridiumStringsTableName;

@interface NSString (Localization)

- (nonnull NSString *)localized;

- (nonnull NSString *)localizedWithComment:(nullable NSString *)comment;

@end

NS_ASSUME_NONNULL_END
