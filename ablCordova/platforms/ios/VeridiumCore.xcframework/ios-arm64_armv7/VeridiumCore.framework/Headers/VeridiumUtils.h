//
//  CoreUtils.h
//  VeridiumCore
//
//  Created by razvan on 11/23/15.
//  Copyright © 2015 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VIDLog.h"

#define Local(STR) [[NSBundle mainBundle] localizedStringForKey:(STR) value:(STR) table:nil]

#define LocalF(STR,...) [NSString stringWithFormat:[[NSBundle mainBundle] localizedStringForKey:(STR) value:(STR) table:nil], ##__VA_ARGS__]


#define CORE_TR_TABLE @"CORESDKErrorMessages"

/*!
 Alias for blocks receiving a NSError* argument
 */
typedef void(^errorBlock)(NSError* _Nonnull error);

/*!
 Alias for blocks receiving a string argument. (Usually used for error/failure blocks)
 */
typedef void(^stringBlock)(NSString* _Nullable message);

/*!
 Alias for blocks receiving an int - string argument pair. (Usually used for error/failure blocks)
 */
typedef void(^intAndStringBlock)(NSInteger,NSString* _Nullable);

/*!
 Alias for void blocks
 */
typedef void(^voidBlock)(void);

/*!
 Alias for blocks receiving a float argument. (Usually used for conveing a progress update)
 */
typedef void(^floatBlock)(float value);

/*!
 Alias for blocks receiving a UIImage argument.
 */
typedef void(^pictureBlock)(UIImage* _Nonnull picture);

/*!
 Alias for blocks receiving a BOOL argument.
 */
typedef void(^boolBlock)(BOOL trueOrFalse);

/*!
 Alias for blocks returning a BOOL result.
 */
typedef BOOL(^boolResultBlock)(void);

/*!
 Alias for blocks receiving a NSData argument.
 */
typedef void(^dataBlock)(NSData* _Nullable data);

/*!
 Alias for blocks receiving a BOOL and a NSData argument.
 */
typedef void(^boolAndDataBlock)(BOOL trueOrFalse, NSData* _Nullable data);

/*!
 Alias for blocks receiving a strigs array argument.
 */
typedef void(^stringArrayBlock)(NSArray<NSString*>* _Nonnull stringsArray);

/*!
 Alias for blocks receiving any argument.
 */
typedef void(^idBlock)(id _Nullable anything);

/*!
 Alias for blocks receiving any argument and returning anything.
 */
typedef id _Nullable (^ididBlock)(id _Nullable anything);


/*!
 Alias for blocks receiving a NSDictionary argument.
 */
typedef void(^dictionaryBlock)(NSDictionary* _Nullable dictionary);

/*!
 Alias for blocks receiving a string-string NSDictionary argument.
 */
typedef void(^stringsDictionaryBlock)(NSDictionary<NSString*,NSString*>* _Nonnull stringsDictionary);


/*!
 Extends UIAlertController with some presenting helper methods
 */
@interface UIViewController (VeridiumUtils)

/*!
 Dismisses every ViewController presented above self in the view's hierarchy.

 @param flag animated flag
 @param completion callback called when everything is dismissed.
 */
-(void)dissmissAboveMeAnimated:(BOOL)flag completion:(voidBlock _Nullable)completion;

/*!
 Presents self in the topmost view controller in the view hierarchy (ie. the topmost modally presented)
 */
-(void) presentInTopmost;

/*!
 Presents self in the topmost view controller in the view hierarchy (ie. the topmost modally presented) with an optional completion block
 
 @param completionBlock option completion voidBlock
 */
-(void)presentInTopmostWithCompletion:(voidBlock _Nullable) completionBlock;


/*!
 Presents self in the topmost view controller in the view hierarchy (ie. the topmost modally presented) with an optional completion block
 
 @param completionBlock option completion voidBlock
 @param animated   boolean to decide if the modal will be animated or not
 */
-(void)presentInTopmostWithAnimation:(BOOL)animated completion:(voidBlock _Nullable) completionBlock;

/*!
 Presents self in the specified view controller
 
 @param container the host view controller
 */
-(void) presentIn:(UIViewController* _Nonnull) container;

@end


/*!
 Extends UIImage with utility methods
 */
@interface UIImage (VeridiumUtils)


/*!
 Returns a copy of the image scaled to the specified size (disregarding the aspect ratio, thus the image might look wierd if you specify a size with a different aspect ratio)

 @param size the new size
 @return the resized image
 */
-(UIImage* _Nonnull) scaledToSize:(CGSize)size;


/*
 Returns a copy of the image cropped to a square of the specified size

 @param size the new size
 @return the cropped image
 */
-(UIImage* _Nonnull) cropToSquare:(NSInteger) size;


/*!
 Returns a copy of the image saled to specified size.

 @param size tha new size
 @return the scaled image
 */
-(UIImage* _Nonnull) scaledToMaxSize:(NSInteger) size;

@end

/*!
 Extends NSArray with utility methods
 */
@interface NSArray (VeridiumUtils)

/*!
 returns the JSON representation of the array as string
 */
@property (readonly, nullable) NSString* JSONString;

/*!
 returns the JSON representation of the array as binary data
 */
@property (readonly, nullable) NSData* JSONData;

/*!
 Merges the array with another array
 
 The result will contain all elements from the caller and all elements from the other array that are not found in the caller
 
 **_Note_** The comparison is shallow (i.e. won't work for nested elements)
 
 @param other the other array
 
 @return the merged array
 */
-(NSArray* _Nonnull) merge:(NSArray* _Nullable) other;

/*!
 Searches for string case insensitive
 
 @param toSearch string to be searched
 
 @return boolean if the element was found
 */
-(BOOL) containsStringCaseInsensitive:(NSString* _Nonnull) toSearch;

/*!
 returns a new strings array with all the elements uppercased
 */
@property (readonly, nullable) NSArray<NSString*>* uppercase;

@end

/*!
 Extends NSDictionary with utility methods
 */
@interface NSDictionary (VeridiumUtils)

/*!
 returns the JSON representation of the array as string
 */
@property (readonly, nullable) NSString* JSONString;

/*!
 returns the JSON representation of the array as binary data
 */
@property (readonly, nullable) NSData* JSONData;

/*!
 Merges the array with another dictionary
 
 The result will contain all keys from the caller and all keys from the other dictionary that are not found in the caller
 
 **_Note_** The comparison is shallow (i.e. won't work for nested elements)
 
 @param other the other dictionary
 
 @return the merged dictionary
 */
-(NSDictionary* _Nonnull) merge:(NSDictionary* _Nullable) other;



/*!
 Returns a copy with the objects for the supplied keys removed (by safely ignoring inexistent keys
 
 @param keys the keys to be removed

 @return the 'trimmed' copy
 */
-(NSDictionary* _Nonnull) dictionaryByRemovingKeys:(NSArray<NSString*>* _Nonnull) keys;

@end

/*!
 Extends NSData with utility methods
 */
@interface NSData (VeridiumUtils)
/*!
 returns a SHA1 hash from self as a hexadecimal string
 */
@property (readonly, nonnull) NSString* SHA1HEX;

/*!
 returns a SHA256 hash from self as a hexadecimal string
 */
@property (readonly, nonnull) NSString* SHA256HEX;

/*!
 returns a SHA1 hash from self as raw bytes (NSData)
 */
@property (readonly, nonnull) NSData* SHA1Raw;

/*!
 returns a SHA256 hash from self as raw bytes (NSData)
 */
@property (readonly, nonnull) NSData* SHA256Raw;

/*!
 returns a SHA1 hash from self as a hexadecimal string and trims the leading zero
 */
@property (readonly, nonnull) NSString* SHA1HEXTrimmedLeadingZero;

/*!
 returns a base64 string representation of self using NSUTF8StringEncoding
 */
@property (readonly, nonnull) NSString* base64String;

/*!
 returns a string representation of self using NSUTF8StringEncoding
 */
@property (readonly, nonnull) NSString* toString;

@end


/*!
 Extends NSString with utility methods
 */
@interface NSString (VeridiumUtils)

/*!
 returns a SHA1 hash from self as a hexadecimal string
 */
@property (readonly, nonnull) NSString* SHA1HEX;

/*!
 returns a SHA1 hash from self as raw bytes (NSData)
 */
@property (readonly, nonnull) NSData* SHA1Raw;

/*!
 returns a SHA256 hash from self as raw bytes (NSData)
 */
@property (readonly, nonnull) NSData* SHA256Raw;

/*!
 returns a SHA256 hash from self as a hexadecimal string
 */
@property (readonly, nonnull) NSString* SHA256HEX;

/*!
 returns a parsed NSArray from self if self contains a valid JSON array string, `nil` otherwise
 */
@property (readonly, nullable) NSArray* JSONArray;

/*!
 returns a parsed NSMutableArray from self if self contains a valid JSON array string, `nil` otherwise
 */
@property (readonly, nullable) NSMutableArray* JSONMutableArray;

/*!
 returns a parsed NSDictionary from self if self contains a valid JSON object string, `nil` otherwise
 */
@property (readonly, nullable) NSDictionary* JSONDictionary;

/*!
 returns a parsed NSMutableDictionary from self if self contains a valid JSON object string, `nil` otherwise
 */
@property (readonly, nullable) NSMutableDictionary* JSONMutableDictionary;

/*!
 returns true if self is a valid email string
 */
@property (readonly) BOOL isEmail;

/*!
 returns a NSData constructed from self (when self is a base64 string) using NSUTF8StringEncoding
 */
@property (readonly, nullable) NSData* base64ToData;


/*!
 returns a NSData from self using NSUTF8StringEncoding
 */
@property (readonly, nonnull) NSData* toData;

/*!
 Helper method which returns matching regex tokens
 
 @param pattern regular expression pattern
 @return replaced string if succeded nil otherwise
 */
-(NSArray<NSTextCheckingResult *> * _Nullable)matches:(NSString * _Nonnull)pattern;

/*!
 Helper method which apllies a regular expression and replacing occurrences with a template

 @param pattern regular expression pattern
 @param withTemplate the template
 @return replaced string if succeded nil otherwise
 */
-(NSString * _Nullable)stringByRegexReplacePattern:(NSString * _Nonnull)pattern withTemplate:(NSString * _Nonnull)withTemplate;

@end

/*!
 Utility data class that encapsulates data used by [VeridiumUtils customAlertWithMultipleTextFields:title:fields:okHandler:] to build an alert with multiple textfield
 */
@interface VeridiumAlertTextFieldConfig : NSObject

/*!
 The field name
 
 It is used later as a key for the user's input for the corresponding created text field
 */
@property (nonnull) NSString* fieldName;

/*!
 The field title
 
 It is used as placeholder for the textfield
 */
@property (nonnull) NSString* fieldTitle;

/*!
 The keyboard type
 
 By default it is initialized with UIKeyboardTypeEmailAddress
 */
@property UIKeyboardType keyboardType;

/*!
 The text autocapitalization type
 
 By default it is initialized with UITextAutocapitalizationTypeNone
 */
@property UITextAutocapitalizationType textAutocapitalizationType;

/*!
 Whether the texfield should display a password mask
 
 By default is initialized with NO;
 */
@property BOOL isPassword;

/*!
 Helper static initializer
 
 @param name  the field name
 @param title the field title
 
 @return an initialized VeridiumAlertTextFieldConfig instance
 */
+(instancetype _Nonnull) newWithName:(NSString* _Nonnull)name title:(NSString* _Nonnull)title;

/*!
 Helper static initializer
 
 @param name  the field name
 @param title the field title (used as placeholder)
 @param keyboardType the UIKeyboardType value
 @param textAutocapitalization the UITextAutocapitalizationType value
 @param isPassword   pass `true` if you wish to make the textfield protected (displays password mask)
 
 @return an initialized VeridiumAlertTextFieldConfig instance
 */
+(instancetype _Nonnull) newWithName:(NSString* _Nonnull)name title:(NSString* _Nonnull)title keyboardType:(UIKeyboardType) keyboardType textAutocapitalization:(UITextAutocapitalizationType) textAutocapitalization isPassword:(BOOL) isPassword;
@end

/*!
 Utility class that groups static helper methods for general purpose use
 */
@interface VeridiumUtils : NSObject

///---------------------
/// @name Blocks helper methods
///---------------------

static inline bool sandbox_integrity_compromised(void) __attribute__((always_inline));
static inline bool symbolic_linking_check(void) __attribute__((always_inline));
static inline bool dyld_check(void) __attribute__((always_inline));

/*
 * check all above
 */
+ (bool) areYouOk;

/*!
 Helper method that performs block after a specified delay. Can be used to perform delayed operations asyncronously.
 
 @param delay   delay time in seconds.
 @param closure the callback block to be executed after the specified delay.
 */
+ (void) delay:(NSTimeInterval) delay  block:(voidBlock _Nonnull) closure;

/*!
 Helper method for safely calling a nullable voidBlock.
 
 It verifies first whether the passed callback block is not nil and if true calls the block.
 
 @param block the callback voidBlock
 */
+(void) safelyCallVoidBlock:(voidBlock _Nullable) block;

/*!
 Helper method for safely calling a nullable stringBlock.
 
 It verifies first whether the passed callback block is not nil and if true calls the block.
 
 @param block  the callback stringBlock.
 @param string The string message to be passed to the callback.
 */
+(void) safelyCallStringBlock:(stringBlock _Nullable) block withString:(NSString* _Nullable) string;

+(UIImage*) imageByName:(NSString*)imageName withBundleIndentifier:(NSString*)bundleID;

///---------------------
/// @name Alert helper methods
///---------------------

/*!
 Shows an alert with a message and no buttons.
 
 Can prove useful for showing a simple waiting overlay with a message for async operations
 
 @param message the message
 */
+(void) showWaitingAlert:(NSString* _Nullable) message;

/*!
 Hides the waiting alert
 
 It safe to call it repeatedly since it does nothing if the waiting alert has been dismissed already (or not presented)
 */
+(void) hideWaitingAlert;


/*!
  Hides the waiting alert and executes the passed callback block

 @param whenDone completion callback
 */
+(void) hideWaitingAlert:(voidBlock _Nullable) whenDone;

/*!
 Helper method that constructs a confirmation alert with Yes & No buttons with handler blocks
 
 **_Note_** this does NOT show the alert, it just returns it after is contructed.
 You'll have to present it yourself, eg. by using [UIViewController presentViewController:completion:] from a view controller or use the [UIAlertController(PresentUtils) presentInTopmost] or [UIAlertController(PresentUtils) presentIn:] provided by our  UIAlertController(PresentUtils) extension
 
 @param message  The alert message.
 @param title    The alert title.
 @param yesBlock Callback block to be invoked if user selects yes.
 @param noBlock  Callback block to be invoked if user selects no.
 
 @return the constructed confirm UIAlertController.
 */


+ (UIAlertController* _Nonnull) confirmYesNo:(NSString* _Nonnull)message title:(NSString* _Nullable)title yesHandler:(voidBlock _Nonnull) yesBlock noHandler:(voidBlock _Nonnull) noBlock;

/*!
 Helper method that constructs a confirmation alert from a UIAlertActions array
 
 **_Note_** this does NOT show the alert, it just returns it after is contructed.
 You'll have to present it yourself, eg. by using [UIViewController presentViewController:completion:] from a view controller or use the [UIAlertController(PresentUtils) presentInTopmost] or [UIAlertController(PresentUtils) presentIn:] provided by our  UIAlertController(PresentUtils) extension
 
 @param message  the alert message.
 @param title    the alert title.
 @param actions  array of UIAlertActions instances.
 
 @return the constructed confirm UIAlertController.
 */

+(UIAlertController* _Nonnull) customConfirm:(NSString* _Nonnull)message title:(NSString* _Nullable)title actions:(NSArray<UIAlertAction*>* _Nonnull)actions;

/*!
 Helper method that constructs an alert with one textfield (useful for getting a single text user input) + ok/cancel buttons
 
 **_Note_** this does NOT show the alert, it just returns it after is contructed.
 You'll have to present it yourself, eg. by using [UIViewController presentViewController:completion:] from a view controller or use the [UIAlertController(PresentUtils) presentInTopmost] or [UIAlertController(PresentUtils) presentIn:] provided by our  UIAlertController(PresentUtils) extension
 
 
 @param message  the alert message.
 @param title    the alert title.
 @param initialText the textfield's initial text
 @param okBlock     the ok callback stringBlock; recives the user's input
 
 @return the constructed confirm UIAlertController.
 */
+(UIAlertController* _Nonnull) customAlertWithTextField:(NSString* _Nonnull) message title:(NSString* _Nullable) title initialText:(NSString* _Nullable) initialText okHandler:(stringBlock _Nonnull) okBlock;

/*!
 Helper method that constructs an alert with multiple textfields (useful for getting user's input for simple form-like data) + ok/cancel buttons
 
 **_Note_** this does NOT show the alert, it just returns it after is contructed.
 You'll have to present it yourself, eg. by using [UIViewController presentViewController:completion:] from a view controller or use the [UIAlertController(PresentUtils) presentInTopmost] or [UIAlertController(PresentUtils) presentIn:] provided by our  UIAlertController(PresentUtils) extension
 
 @param message      the alert message
 @param title        the alert title
 @param fields  array of VeridiumAlertTextFieldConfig instances
 @param okBlock the ok callback stringsDictionaryBlock; received fieldName-inputValue pairs
 @param cancelBlock the cancel callback
 
 @return the constructed confirm UIAlertController.
 */
+(UIAlertController* _Nonnull) customAlertWithMultipleTextFields:(NSString* _Nonnull) message title:(NSString* _Nullable) title fields:(NSArray<VeridiumAlertTextFieldConfig*>* _Nonnull)fields okHandler:(stringsDictionaryBlock _Nonnull) okBlock cancelHandler:(voidBlock _Nullable) cancelBlock;

/*!
 Helper method for displaying the most common type of alert: a title, a message and an Ok button.
 
 @param message  The alert message.
 @param title    The alert title.
 */
+ (void)alert:(NSString* _Nullable)message title:(NSString* _Nullable) title;

/*!
 Helper method for displaying the most common type of alert: a title, a message and an Ok button with an optional ok handler
 
 @param message  The alert message.
 @param title    The alert title.
 @param okBlock  The ok handler block
 */
+ (void)alert:(NSString* _Nullable)message title:(NSString* _Nullable) title onOk:(voidBlock _Nullable) okBlock;

///---------------------
/// @name General purpose helper methods
///---------------------

/*!
 Helper method to generate a random integer number between a apecified minimum/maximum interval.
 
 @param min The mininum.
 @param max The maximum.
 
 @return a random number between your selected minimum and maximum.
 */
+ (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max;

/*!
 Helper method to generate a random string of a specified length
 
 @param len the desired length
 
 @return the generated string
 */
+ (NSString * _Nonnull) randomStringLength: (int) len;

/*!
 Helper method to get the vendor identifier.
 
 @return the UUID value.
 */
+ (NSString* _Nonnull) getDeviceUUID;

/*!
 Helper method to get the device name set by the user in the phone preferences
 
 @return the device name, eg. John Doe's iPhone
 */
+ (NSString* _Nonnull) getDeviceName;

/*!
 Helper method to return preferred languages from the device settings
 
 @return the preferred langauge tags in BCP-47 format (e.g., "en-US"), comma concatenated
 */
+ (NSString *_Nonnull) getPreferredDeviceLanguages;

/*!
 Helper method to get the device os version. If the patch number is 0, systemVersion method skips it.
 This method keeps the Major.Minor.Patch format
 
 @return the device os version in a Major.Minor.Patch format, eg. 12.1.0
 */
+ (NSString* _Nonnull) getDeviceOsVersion;

/*!
 Helper method to get a human-readable device model e.g. iPhone 6
 
 @return device model as NSString
 */
+ (NSString* _Nonnull) getDeviceModel;

/*!
 Helper method to get the model identifier e.g.iPhone 6,2
 
 @return device model as NSString
 */
+ (NSString* _Nonnull) getDeviceModelIdentifier;

/*!
 Helper method that computes a device fingerprint from device model, platform, cpu count and memory.
 @return SHA-1 hash of the fingerprint
 */
+ (NSString* _Nonnull) getDeviceFingerprint;

/*!
 Helper method which calculates the current time stamp in miliseconds.

 @return NSNumber with the result.
 */
+ (CGFloat) currentTSMiliseconds;

/*!
 Helper method that resolves the top most view controller displayed by the running app.
 
 This can prove useful when you'd want to display a view controller from a a code outside of a view controller.
  
 @return the top most view controller.
 
 */
+(UIViewController* _Nonnull) topmostViewController;

/*!
 Helper method that iterates all UIViewControllers from the top most view controller displayed by the running app to UIWindow's `rootViewController` and and calls a block with the current UIViewController.
 Inside the block you should return whether a bool indicating whether the iteration should continue or not.
 
 @param block BOOL receiving block and UIViewController as argument.
 */
+(void)rootmostViewControllerWithBlock:(BOOL(^_Nonnull)(UIViewController * _Nullable controller))block;

/*!
 Helper method that resolves the top most view controller displayed by the running app (optionally) starting from an initial view controller to shorten the search).
 
 This can prove useful when you'd want to display a view controller from a a code outside of a view controller.
 
 @param startFrom optionally you can specify a view controller to start the search from to shorten the search. If this is nil, the search will start from the application window
 
 @return the top most view controller.
 
 */
+(UIViewController* _Nonnull) topmostViewControllerOf:(UIViewController*  _Nullable) startFrom;

/*!
 Helper method for formatting dates.
 
 @param date   The NSDate to be formatted.
 @param format The desired format, eg. yyyy-MM-dd HH:mm:ss will return 2016-01-24 23:14:00
 
 @return the formatted date string
 */
+(NSString* _Nullable) formattedDate:(NSDate* _Nonnull)date format:(NSString* _Nonnull)format;

/*!
 Generates and UIImage contating the initials from a given full name.
 @discussion
 If the given name is John Doe     the generated UIImage will have JD centered on both axis.
 If the given name is John         the generated UIImage will have J  centered on both axis.
 If the given name is John Q. Doe  the generated UIImage will have JQ centered on both axis.
 
 @code
 [VeridiumUtils generateImageFromFullName:@"John Doe"
                               withBounds:self.imageView.bounds
                          backgroundColor:nil
                           textAttributes:nil];
 @endcode

 @param name              the full name
 @param bounds            the bounds of the image
 @param color             the backgound color
 @param textAttributes    the text attributes
 @return the generated image
 */
+(UIImage* _Nonnull)generateImageFromFullName:(NSString * _Nonnull)name withBounds:(CGRect)bounds backgroundColor:(UIColor * _Nullable)color textAttributes:(NSDictionary * _Nullable)textAttributes;

/*!
 Whether the current device is an iPhone X or not.
 */
@property (class, readonly) BOOL isDeviceiPhoneX;

/*!
 The list with engines names of all methods that can be mobile authenticators
 */
@property (class, readonly) NSArray<NSString*>* _Nonnull allEnrollers;
@property (class, readonly) NSArray<NSString*>* _Nonnull allAuthenticators;


@end

@interface UITableView (VeridiumUtils)

/*!
 Centers the TableView cells within it's bounds.
 */
-(void)centerInFrame;

/*!
 Hides the separator lines on empty TableView cells.
 */
-(void)hideSeparatorLines;

@end

@interface UITableViewCell (VeridiumUtils)

/*!
 Performs shake animation on a TableView cell. 
 */
-(void)shake;

@end

@interface NSLayoutConstraint (VeridiumUtils)

/*!
 Creates a new constraint with the specified multiplier. The old constrait will be deactivated and the new one will be activated and returned.

 @param multiplier  the multiplier.
 @return the new constraint.
 */
-(NSLayoutConstraint* _Nonnull) addMultiplier:(CGFloat)multiplier;

@end


@interface UIDevice (ForIdentity)

- (NSUUID* _Nonnull) identifierForVendorWithKeyChain;

@end


@class VeridiumTimeoutTimer;
/*!
 Callback function that handles tick events for a VeridiumTimeoutTimer
 */
typedef void(^timerTickHandler)(VeridiumTimeoutTimer* _Nonnull timer, float value);

/*!
 Utility class that wraps a NSTimer
 
 Useful for rapidly integating a timeout timer in your app
 */
@interface VeridiumTimeoutTimer : NSObject

/*!
 Static initializer with all the configurations for the timer to function.
 
 @param timeoutSeconds Timeout in seconds (can be less than 1, eg. 0.5 will trigger the timeout block after half a second)
 @param block          Callback block that will be called if the timeout expires.
 @param tickSeconds    Seconds in between timeout check. Pass 0 for default tick interval
 @param tickBlock      Callback block that will be called on each timer tick.
 
 @return an instace configured and ready to be started.
 */
+(VeridiumTimeoutTimer* _Nonnull) timeoutTimerWithTimeoutAfter:(NSTimeInterval) timeoutSeconds onTimeout:(voidBlock _Nonnull) block tickInterval:(NSTimeInterval)tickSeconds onTick:(timerTickHandler _Nullable) tickBlock;
/*!
  Resets/starts the timer.
 */
-(void) reset;

/*!
 Stops the timer.
 */
-(void) stop;

/*!
 Pauses the timer.
 */
-(void) pause;

/*!
 Resumes the timer.
 */
-(void) resume;

/*!
 Check for timeout on tick
 */
-(void)checkTimeout:(NSTimer*_Nonnull) timer;

@end
