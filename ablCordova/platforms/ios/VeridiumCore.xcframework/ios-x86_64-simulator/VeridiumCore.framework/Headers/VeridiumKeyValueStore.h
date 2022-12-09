//
//  VeridiumKeyValueStore.h
//  VeridiumCore
//
//  Created by razvan on 3/14/16.
//  Copyright © 2016 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Protocol abstracting a key-value storage
 */
@protocol VeridiumKeyValueStore <NSObject>

/*!
 Key subscripting getter
 
 For complex objects you will need to either deserialize yourself from the string value or you can use the coveninent [NSString JSONArray] and [NSString JSONDictionary] extensions declared in VeridiumUtils (if you used the same serialization when the value was stored
 
 @param key the key
 @return the stored value
 */
- (nullable NSString *)objectForKeyedSubscript:(nonnull NSString *)key;

/*!
 Key subscripting setter
 
 For complex objects you will need to store either your custom serialization into a string or you can use the coveninent [NSArray JSONString] and [NSDictionary JSONString] extensions declared in VeridiumUtils
 
 @param string the string to store (if `nil` the currently stored value - if existing - will be wiped)
 @param key the key
 */
- (void)setObject:(nullable NSString *)string forKeyedSubscript:(nonnull NSString *)key;

/*!
Clears all data from the store for a particular environment key
 
 @param string the string containig the environment key. N.A. on Keychain stores!

__Use with care!__
*/
- (void)clearDataForEnvironment:(nonnull NSString *)env;

/*!
 Clears all data from the store
 
 __Use with care!__
 */
- (void)clearAllData;

/*!
    Migrates data from single BOPS to multi BOPS env
*/
- (void)migrateData;

@end
