//
//  ExportUIUtils.hpp
//  VeridiumDefault4FExportUI
//
//  Created by Richard Tyson on 15/11/2018.
//  Copyright © 2018 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface ExportUIUtils : NSObject

+(UIImage*) colorizeImage:(UIImage *)baseImage color:(UIColor *)theColor;

+(UIImage*) imageByName:(NSString*)imageName withBundleIndentifier:(NSString *)bundleID;

@end
