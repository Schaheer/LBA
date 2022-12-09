//
//  UIViews+Localization.h
//  VeridiumCore
//
//  Created by Erkut Demirhan on 8/17/20.
//  Copyright © 2020 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Localization.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Localization)

@property (nonatomic) IBInspectable NSString *localizedKey;

@end

@interface UIButton (Localization)

@property (nonatomic) IBInspectable NSString *localizedKey;

@end

NS_ASSUME_NONNULL_END
