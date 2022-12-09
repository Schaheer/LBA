//
//  VeridiumDefault4FExportUICustomization.h
//  VeridiumDefault4FExportUI
//
//  Copyright © 2018 Veridium IP Ltd. All rights reserved.
//

#ifndef VeridiumDefault4FExportUICustomization_h
#define VeridiumDefault4FExportUICustomization_h

@class VeridiumDefault4FExportUICustomization;


@interface VeridiumDefault4FExportUICustomization : NSObject
+ (UIImage *)getTopBarBackgroundImage;

+ (UIColor *)getTopBarColor;
+ (UIColor *)getTopBarTextColor;
+ (NSString *)getTopBarText;

+ (UIColor *)getScannerOverlayColor;;
+ (UIColor *)getScannerOverlayTextColor;

+ (UIColor *)getContainerBackgroundColor;
+ (UIColor *)getInstructionTextColor;
+ (NSString *)getInstructions;
+ (UIColor *)getButtonsBackgroundColor;
+ (UIColor *)getButtonsTextColor;
+ (NSString *)getButtonsText;
+ (UIColor *)getImagesColor;
+ (BOOL) getIsFullWidthButtons;
+ (NSString *)getGuidanceScreenButtonText;

+ (UIColor *)getDialogImageBackgroundColor;
+ (UIColor *)getDialogImageForegroundColor;
+ (UIColor *)getDialogBackgroundColor;
+ (UIColor *)getDialogTitleColor;
+ (UIColor *)getDialogMessageColor;
+ (UIColor *)getDialogButtonTextColor;
+ (UIColor *)getDialogButtonBackgroundColor;
+ (UIImage *)getDialogSuccessImage;
+ (UIImage *)getDialogRetryImage;
+ (UIImage *)getDialogSwitchHandImage;
+ (NSString *)getDialogSuccessTitle;
+ (NSString *)getDialogSuccessMessage;
+ (NSString *)getDialogSuccessButtonText;
+ (NSString *)getDialogSwitchHandTitle;
+ (NSString *)getDialogSwitchHandMessage;
+ (NSString *)getDialogSwitchHandButtonText;
+ (NSString *)getGuidanceScreenAnimation;
+ (UIImage *)getGuidanceScreenInstructionImage;
+ (NSString *)getDialogRetryTitle;
+ (UIImage *)getDialogTimeoutImage;
+ (NSString *)getDialogTimeoutTitle;
+ (NSString *)getDialogTimeoutMessage;
+ (NSString *)getDialogTimeoutButtonText;
+ (UIImage *)getDialogLivenessFailImage;
+ (NSString *)getDialogLivenessFailTitle;
+ (NSString *)getDialogLivenessFailMessage;
+ (NSString *)getDialogLivenessFailButtonText;

+ (NSString *)getCustomFontRegular;
+ (NSString *)getCustomFontSemiBold;
+ (NSString *)getCustomFontBold;


+ (UIColor *)defaultTopBarColor;
+ (UIColor *)defaultTopBarTextColor;
+ (UIColor *)defaultContainerBackgroundColor;
+ (UIColor *)defaultScannerOverlayColor;
+ (UIColor *)defaultScannerOverlayTextColor;
+ (UIColor *)defaultInstructionTextColor;
+ (UIColor *)defaultButtonsBackgroundColor;
+ (UIColor *)defaultButtonsTextColor;
+ (UIColor *)defaultImagesColor;
+ (UIColor *)defaultDialogImageBackgroundColor;
+ (UIColor *)defaultDialogImageForegroundColor;
+ (UIColor *)defaultDialogBackgroundColor;
+ (UIColor *)defaultDialogTitleColor;
+ (UIColor *)defaultDialogMessageColor;
+ (UIColor *)defaultDialogButtonTextColor;
+ (UIColor *)defaultDialogButtonBackgroundColor;


+ (void)setTopBarBackgroundImage                :(UIImage *)newImage;
+ (void)setTopBarColor                          :(UIColor *)newColor;
+ (void)setTopBarTextColor                      :(UIColor *)newColor;
+ (void)setTopBarText                           :(NSString *)text;
+ (void)setContainerBackgroundColor             :(UIColor *)newColor;
+ (void)setScannerOverlayColor                  :(UIColor *)newColor;
+ (void)setScannerOverlayTextColor              :(UIColor *)newColor;
+ (void)setInstructionTextColor                 :(UIColor *)newColor;
+ (void)setInstructions                           :(NSString *)text;
+ (void)setButtonsBackgroundColor               :(UIColor *)newColor;
+ (void)setButtonsTextColor                     :(UIColor *)newColor;
+ (void)setButtonsText                           :(NSString *)text;
+ (void)setImagesColor                          :(UIColor *)newColor;
+ (void)setIsFullWidthButtons                   :(BOOL)isFullWidth;
+ (void)setGuidanceScreenButtonText             :(NSString *)text;
+ (void)setDialogImageBackgroundColor           :(UIColor *)newColor;
+ (void)setDialogImageForegroundColor           :(UIColor *)newColor;
+ (void)setDialogBackgroundColor                :(UIColor *)newColor;
+ (void)setDialogTitleColor                     :(UIColor *)newColor;
+ (void)setDialogMessageColor                   :(UIColor *)newColor;
+ (void)setDialogButtonTextColor                :(UIColor *)newColor;
+ (void)setDialogButtonBackgroundColor          :(UIColor *)newColor;
+ (void)setDialogSuccessImage                   :(UIImage *)newImage;
+ (void)setDialogRetryImage                     :(UIImage *)newImage;
+ (void)setDialogSwitchHandImage                :(UIImage *)newImage;
+ (void)setCustomFont                           :(NSString *)regularPostScriptName :(NSString *)semiBoldPostScriptName :(NSString *)boldPostScriptName;
+ (void)setDialogSuccessTitle                          :(NSString *)text;
+ (void)setDialogSuccessMessage                        :(NSString *)text;
+ (void)setDialogSuccessButtonText                     :(NSString *)text;
+ (void)setDialogSwitchHandTitle                          :(NSString *)text;
+ (void)setDialogSwitchHandMessage                        :(NSString *)text;
+ (void)setDialogSwitchHandButtonText                     :(NSString *)text;

+ (void)setGuidanceScreenAnimation              :(NSString *)text;
+ (void)setGuidanceScreenInstructionImage       :(UIImage *)newImage;

+ (void)setDialogRetryTitle                          :(NSString *)text;

+ (void)setDialogTimeoutImage                     :(UIImage *)newImage;
+ (void)setDialogTimeoutTitle                          :(NSString *)text;
+ (void)setDialogTimeoutMessage                          :(NSString *)text;
+ (void)setDialogTimeoutButtonText                          :(NSString *)text;

+ (void)setDialogLivenessFailImage                     :(UIImage *)newImage;
+ (void)setDialogLivenessFailTitle                          :(NSString *)text;
+ (void)setDialogLivenessFailMessage                          :(NSString *)text;
+ (void)setDialogLivenessFailButtonText                          :(NSString *)text;

@end

#endif /* VeridiumDefault4FExportUICustomization_h */
