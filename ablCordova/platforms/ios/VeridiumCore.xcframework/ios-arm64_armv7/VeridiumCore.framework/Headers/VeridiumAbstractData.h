//
//  VeridiumBOPSAbstractData.h
//  VeridiumBOPS
//
//  Created by razvan on 8/9/16.
//  Copyright © 2016 Veridium. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 Utility abstract class which serves as base for all the data classes.
 It uses a disctionary as a storage and implements some basic parsing/serializing methods
 */
@interface VeridiumAbstractData : NSObject

/*!
 Conveninence static initializer for creating an empty instance
 
 This is used internally by parseMultiple:
 The intended usage in combination with parse is `[[AbstractDataSubclass create] parse:someExternalDictionary]`

 @return the newly created instance
 
 */
+(instancetype _Nonnull) create;

/*!
 Provides read-only access to the NSDictionary data storage
 */
@property (readonly, nonnull) NSMutableDictionary* serialize;

/*!
 Basically a setter for the inner data storage
 
 @param dict the new data source
 
 @return the current instance initialized with the new data source
 */
-(instancetype _Nonnull)parse:(NSDictionary* _Nonnull) dict;

/*!
 Serializes an array of AbstractData (or subclass) instances into a NSDictionary array
 
 @param source the array of AbstractData instances
 
 @return the array of NSDictionaries
 */
+(NSArray<NSDictionary*>* _Nonnull) serializeMultiple:(NSArray<VeridiumAbstractData*>* _Nonnull)source;

/*!
 Converts an array of dictionaries into an array of concrete BOPSAbstractData instances
 
 The inverse of [serializeMutiple:]([AbstractData serializeMultiple:])
 
 @param source the array of NSDictionaries
 
 @return the array of AbstractData instances
 */
+(NSArray<VeridiumAbstractData*>* _Nonnull) parseMultiple:(NSArray<NSDictionary*>* _Nonnull)source;
@end
