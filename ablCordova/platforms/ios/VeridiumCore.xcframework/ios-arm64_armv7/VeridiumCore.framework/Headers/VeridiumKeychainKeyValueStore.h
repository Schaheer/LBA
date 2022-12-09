//
//  VeridiumKeychainKeyValueStore.h
//  VeridiumCore
//
//  Created by razvan on 3/14/16.
//  Copyright © 2016 HoyosLabs. All rights reserved.
//

#import "VeridiumKeyValueStore.h"

/*!
 Keychain implementation of KeyValueStore protocol
 */
@interface VeridiumKeychainKeyValueStore: NSObject <VeridiumKeyValueStore>

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)alloc NS_UNAVAILABLE;
+ (nonnull instancetype)new NS_UNAVAILABLE;

/*!
 Designated initializer
 
 @param masterKey the master key of the instance (all values will be stored as sub keys of this key)
 */
- (nonnull instancetype)initWithEnvironmentKey:(nonnull NSString *)enviroment masterKey:(nonnull NSString *)masterKey NS_DESIGNATED_INITIALIZER;

///*!
// Static initializer
//
// @param masterKey the master key of the instance (all values will be stored as sub keys of this key)
// @return the initialized instance
// */
//+ (nonnull instancetype)newWithMasterKey:(nonnull NSString *)masterKey;

/*!
 Helper property for quick access to the global Veridium Keychain store
 */
@property (class, readonly, nonnull) VeridiumKeychainKeyValueStore* global;

/*!
 Key subscripting getter
 
 (redeclaration needed for swift visibility)
 For complex objects you will need to either deserialize yourself from the string value or you can use the coveninent [NSString JSONArray] and [NSString JSONDictionary] extensions declared in VeridiumUtils (if you used the same serialization when the value was stored
 
 @param key the key
 @return the stored value
 */
- (nonnull NSString *)objectForKeyedSubscript:(nonnull NSString *)key;

/*!
 Key subscripting setter
 
 (redeclaration needed for swift visibility)
 For complex objects you will need to store either your custom serialization into a string or you can use the coveninent [NSArray JSONString] and [NSDictionary JSONString] extensions declared in VeridiumUtils
 
 @param string the string to store (if `nil` the currently stored value - if existing - will be wiped)
 @param key the key
 */
- (void)setObject:(nullable NSString *)string forKeyedSubscript:(nonnull NSString *)key;

@end
