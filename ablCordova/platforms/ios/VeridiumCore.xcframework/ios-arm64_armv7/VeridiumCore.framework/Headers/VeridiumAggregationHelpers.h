//
//  SimpleAggregatedBioEnroller.h
//  VeridiumCore
//
//  Created by razvan on 5/11/16.
//  Copyright © 2016 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VeridiumBiometricsProtocols.h"
#import "VeridiumTXSigning.h"

/*!
 Subprotocol of VeridiumBioEnroller that adds to an enroller the ability to be skipped during an aggregated biometric enrollment
 
 Skippable enrollers will trigger an 'enroll next' action when the user cancels
 */
@protocol VeridiumSkippableEnrollerProtocol <VeridiumBioEnroller>

/*!
 Return `true` if you wish your enroller to be skippable or `false` if you it want to be mandatory
 */
@property (readonly) BOOL canBeSkipped;

@end

/*!
 The VeridiumSkippableEnrollerProtocol default implementation that wraps an existing enroller into a skippable implementation
 */
@interface VeridiumEnrollerSkippableWrapper : NSObject <VeridiumSkippableEnrollerProtocol>

/*!
 Designated initializer
 
 @param enroller     an existing enroller
 @param canBeSkipped pass `true` if the enroller can be skipped `false` otherwise
 */
-(instancetype _Nonnull)init:(id<VeridiumBioEnroller> _Nonnull)enroller skippable:(BOOL) canBeSkipped;

@end


/*!
 A VeridiumBioEnroller implementation that chains multiple enrollers into a single enrollment process
 */
@interface VeridiumAggregatedBioEnroller : NSObject


/*!
 Helper method that chains VeridiumBioEnroller(s).

 @param enrollers the enrollers
 @param completion a single completion callback containing the enrollment overall result, the VeridiumBiometricFullVector(s) and an error if any occurred.
 */
-(void) chainEnrollers:(NSArray<id<VeridiumBioEnroller>>* _Nonnull) enrollers
        withCompletion:(void(^ _Nonnull)(VeridiumEnrollResult overallResult, NSArray<VeridiumBiometricFullVector*>* _Nullable vectors, NSError* _Nullable error)) completion;
@end


/*!
 The VeridiumEngineAuthResult class.
 */
@interface VeridiumEngineAuthResult : NSObject


/*!
 Static mehod which will crate a new authentication result.
 
 @param   engineName the engine name
 @param   authResult the authentication result from the `VeridiumAuthResult` enum.
 @return  self
 */
+(instancetype _Nonnull)newWithEngineName:(NSString* _Nonnull)engineName
                            andAuthResult:(VeridiumAuthResult)authResult;


/*!
Static mehod which will crate a new authentication result.

@param   engineName the engine name
@param   extraParams extra info coming with the authentication result
@param   authResult the authentication result from the `VeridiumAuthResult` enum.
@return  self
*/
+(instancetype _Nonnull)newWithEngineName:(NSString* _Nonnull)engineName
                              extraParams:(NSDictionary* _Nonnull)extraParams
                            andAuthResult:(VeridiumAuthResult)authResult;

/*!
 The engine name.
 */
@property (readonly, nonnull) NSString* engineName;


/*!
 The authentication result.
 */
@property (readonly) VeridiumAuthResult authResult;

/*!
 Extra params coming with the authentication result
 */
@property (readonly, nullable) NSDictionary* extraParams;

@end


/*!
  VeridiumAggregatedAuthResult class which aggregates authentication results.
 */
@interface VeridiumAggregatedAuthResult : NSObject

/*!
 Class initializer which creates a new VeridiumAggregatedAuthResult.

 @param   overallResult the authentication result.
 @param   detailedResults an array of `VeridiumEngineAuthResult(s)`
 @return  self
 */
+(instancetype _Nonnull) newWithOverallResult:(VeridiumAuthResult) overallResult
                              detailedResults:(NSArray<VeridiumEngineAuthResult*>* _Nonnull) detailedResults;

/*!
 Class initializer which creates a new VeridiumAggregatedAuthResult without detailedResults.
 Usefull for general errors or canceled.
 
 @param   overallResult the authentication result.
 @return  self
 */
-(instancetype _Nonnull) initWithOverallResult:(VeridiumAuthResult) overallResult;

/*!
 The authentication detailed results.
 */
@property (readonly) NSArray<VeridiumEngineAuthResult*>* detailedResults;

/*
 The authentication result.
 */
@property (readonly) VeridiumAuthResult overallResult;

@end


/*!
 VeridiumAggregatedTXSignAuthResult which aggregates Transaction Signing authentication results.
 */
@interface VeridiumAggregatedTXSignAuthResult : VeridiumAggregatedAuthResult


/*!
 Class initializer which creates a new VeridiumAggregatedTXSignAuthResult.

 @param overallResult the authentication result
 @param detailedResults an array of `VeridiumEngineAuthResult(s)`
 @param signatures an array of `VeridiumAuthSignatureData(s)`
 @return self
 */
+(instancetype _Nonnull) newWithOverallResult:(VeridiumAuthResult) overallResult
                              detailedResults:(NSArray<VeridiumEngineAuthResult*>* _Nonnull) detailedResults
                                   signatures:(NSArray<VeridiumAuthSignatureData*>* _Nullable) signatures;

/*!
 The stored signatures.
 */
@property (readonly, nullable) NSArray<VeridiumAuthSignatureData*>* signatures;

@end

/*!
 A VeridiumBioAuthenticator implementation that chains multiple authenticators into a single authentication process
 */
@interface VeridiumAggregatedBioAuthenticator : NSObject


/*!
 VeridiumBioAuthenticator(s) chaining helper method.

 @param authenticators  array of `VeridiumBioAuthenticator(s)`
 @param reason the      reason the user is prompted to authenticate
 @param completion      completion the callback contaning the error if any occurred and the aggregated authentication (`VeridiumAggregatedAuthResult`) result.
 */
-(void) chainAuthenticators:(NSArray<id<VeridiumBioAuthenticator>>* _Nonnull) authenticators
                 authReason:(NSString* _Nonnull) reason
             withCompletion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;


/*!
 VeridiumBioAuthenticator(s) chaining helper method for Transaction Signing.
 
 @param authenticators    array of `VeridiumBioAuthenticator(s)`
 @param uuid              the UUID
 @param dataToSign        the data to be signed
 @param transactionText   the trasaction text
 @param completion        completion  the callback contaning the error if any occurred and the aggregated authentication Transaction Signing (`VeridiumAggregatedTXSignAuthResult`) result.
 */
-(void) chainTXSignAuthenticators:(NSArray<id<VeridiumBioAuthenticator>>* _Nonnull) authenticators
                keyRegistrationID:(NSString* _Nonnull) keyRegistrationID
                       dataToSign:(NSData* _Nonnull) dataToSign
isLocalBiometryChangeDetectionEnabled:(BOOL) isLocalBiometryChangeDetectionEnabled
                  transactionText:(NSString* _Nonnull) transactionText
                   withCompletion:(void(^ _Nonnull)(VeridiumAggregatedTXSignAuthResult* _Nullable result, NSError* _Nullable error)) completion;

-(void)abortRunningAuthenticationWithAuthenticationResult:(VeridiumAuthResult)result;


@end
