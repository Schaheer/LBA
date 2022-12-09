//
//  AccountData.h
//  VeridiumCore
//
//  Created by razvan on 1/22/16.
//  Copyright © 2016 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VeridiumKeychainKeyValueStore.h"
#import "VeridiumUserDefaultsKeyValueStore.h"
#import "VeridiumUtils.h"
#import "VeridiumProfileData.h"
#import "VeridiumAggregationHelpers.h"
#import "IntegrationDefinition.h"
#import "VeridiumTOTPAuthenticator.h"
#import "RegistrationModeDefinitionData.h"

@class VeridiumAccountService;

/*!
 Groups all the information pertaining to a registered account.
 */
@interface VeridiumAccount : NSObject

-(instancetype _Nonnull) init NS_UNAVAILABLE;
-(instancetype _Nonnull) alloc NS_UNAVAILABLE;
+(instancetype _Nonnull) new NS_UNAVAILABLE;

/*!
 The account's unique identifier.
 */
@property (readonly, nonnull) NSString* accountId;

/*!
 The device unique identifier
 */
@property (nullable) NSString* deviceId;

/*!
 `true` if the account is a valid registered, `false` otherwise
 */
@property (readonly) BOOL isRegistered;

/*!
 enrolled authentication methods
 */
@property NSSet<NSString *>* enrolledAuthenticators;

/*!
 `true` if the account is locked, `false` otherwise
 
 @see [VeridiumBOPSAccount bopsUnlock:onSuccess:onError:]
 */
@property (readonly) BOOL isLocked;

/*!
 Account service that enables the operation for this user account
 */
@property (readonly, nonnull) VeridiumAccountService* accountService;

/*!
 The registered [profiles](VeridiumProfileData)
 */
@property (nonnull) NSArray<VeridiumProfileData*>* profiles;

/*!
 The registered profiles indexed by their profileId
 */
@property (readonly, nonnull) NSDictionary<NSString*, VeridiumProfileData*>* profilesById;

/*!
 The registered profiles indexed by their profileExternalId
 */
@property (readonly, nonnull) NSDictionary<NSString*, VeridiumProfileData*>* profilesByExternalId;

-(void) mergeProfiles:(nonnull NSArray<VeridiumProfileData *>*) remoteProfiles keepLocalNotOnServer:(BOOL) keepLocalNotOnServer;


/*!
 Enrolled hand
 */
@property (nonnull) NSString* enrolledHand;

@property (readonly) NSInteger privateProfilesCount;

/*!
 This property holds information about the authentication methods provided by account registration
 */
@property (nullable) NSDictionary* authenticationMethods;

/*!
 The Keychain KV Store attached to the account
 
 You can use this to store your app's specific secured data in the context of the account (once it's registered)
 */
@property (readonly, nonnull) VeridiumKeychainKeyValueStore* kcStore;

/*!
 The UserDefaults Store attached to the account
 
 You can use this to store your own data in the user preferences in the context of the account
 */
@property (readonly, nonnull) VeridiumUserDefaultsKeyValueStore* udStore;


/*!
 Designated initializer. It should not be called directly. It is used by the AccountService internally.
 
 @param accountId   The account unique identifier.
 
 @return the initialized AccountData object.
 */
- (instancetype _Nonnull)initWithAccountId:(NSString* _Nonnull) accountId
                                andService: (VeridiumAccountService* _Nonnull) service NS_DESIGNATED_INITIALIZER;

/*!
 Registers a new profile in this account's context, using one block callback.
 
 @param integration             the business integration
 @param registrationMode        the registration mode - one of the modes defined by the integration e.g. form, QR, etc.
 @param credentials             a dictionary containing the registration data (e.g. for AD would be something like username, password, domain)
 @param completion              the callback contaning the error if any occurred and the newly registered profile.
 */

-(void) registerProfile:(IntegrationDefinition* _Nonnull)integration
           registrationMode:(NSString* _Nonnull) registrationMode
                credentials:(NSDictionary* _Nonnull) credentials
      txSignProtectionLevel:(VeridiumTXSigningProtection) txSignProtectionLevel
             withCompletion:(void(^ _Nonnull)(VeridiumProfileData* _Nullable profileData, RegistrationModeDefinitionData* _Nullable nextStep, NSError* _Nullable error)) completion;

/*!
Re-enrolls a given profile

@param profile  the `VeridiumProfileData` instance
@param integration the business integration
@param registrationMode the registration mode - one of the modes defined by the integration e.g. form, QR, etc.
@param credentials a dictionary containing the registration data (e.g. for AD would be something like username, password, domain)
@param completion the callback contaning the error if any occurred and the newly registered profile.
*/
-(void) reEnrollProfile:(VeridiumProfileData* _Nonnull)profile
            integration:(IntegrationDefinition* _Nonnull)integration
       registrationMode:(NSString* _Nonnull) registrationMode
            credentials:(NSDictionary* _Nonnull)credentials
         withCompletion:(void(^ _Nonnull)(VeridiumProfileData* _Nullable profileData, RegistrationModeDefinitionData* _Nullable nextStep, NSError* _Nullable error)) completion;

/*!
 Clears all account data (everything stored in the keychain and user defaults in the account's context)
 */
-(void)clearAllData;


-(void)authenticateForProfile:(VeridiumProfileData* _Nonnull) profile
        andRegisterForSessionId:(NSString* _Nonnull) sessionId
                  extraValues:(NSDictionary* _Nullable) extraValues
                   completion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;

-(void)authenticateForProfileId:(NSString* _Nonnull) profileId
         onActiveSessionId:(NSString* _Nonnull) sessionId
                    completion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;

-(NSString* _Nullable)authenticateForProfileId:(NSString* _Nonnull) profileId
              serverChallenge:(NSString* _Nonnull) serverChallenge
                     completion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;

-(void)authenticateOfflineForProfile:(VeridiumProfileData* _Nonnull) profile exploiterDevice: (NSString* _Nullable) exploiterDevice
                                    completion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;

-(void)authenticateForUpdateForProfile:(VeridiumProfileData* _Nonnull) profile
                                    completion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;

-(void)authenticateAndRemoveForProfile:(VeridiumProfileData* _Nonnull) profile
                          completion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;

-(void)cancelSessionId:(NSString* _Nonnull) sessionId
            completion:(void(^ _Nonnull)(VeridiumAggregatedAuthResult* _Nonnull result, NSError* _Nullable error)) completion;

/*!
 Performs a client side authentication only.
 
 Available only for accounts for business integrations that have client side full authentication type.
 If this method is called for an account that is not based on such integration an error will be triggered (onError will be called)
 
 @param reason      the authentication reason
 @param profile     the profile to authenticate
 @param authType    the type of authentication set on account
 @param methods   authentication methods required by the client (these will be merged with what's configured on the server); pass an empty array if you wish to rely solely on the server configuration
 @param completion the callback containing the error if any occured and the aggregated authentication result
 */

-(void) authenticateClientSideOnly:(NSString* _Nonnull) reason
                         profile:(VeridiumProfileData* _Nonnull) profile
                          authType:(BOPSAuthenticatorType) authType
                       withMethods:(NSArray<NSString*>* _Nonnull) methods
                        onComplete:(void(^ _Nonnull)(VeridiumAggregatedAuthResult * _Nullable result, NSError * _Nullable error)) completion;
    
/*!
 Removes the current device from the serverside account and delete all its locally stored data, using one block callback.
 
 @param completion the callback contaning the error if any occurred.
 */
-(void) removeDeviceWithCompletion:(void(^ _Nonnull)(NSError* _Nullable error)) completion;

/*!
 Refreshes the registered profiles.
 
 It should be used in multi-device scenarios where profiles can be registered on the same account on another device
 
 All fetched data is merged with the data existing already and then stored
 
 After completion it can be accessed via the [VeridiumBOPSAccount profiles] property
 
 @param force       whether for force a full fetch or not (i.e. ignore the last update timestamps)
 @param completion  callback
 */
-(void) refreshProfilesWithForce:(BOOL)force
             completion:(void(^ _Nonnull)(NSError* _Nullable error)) completion;

/*!
 Updates a registered profile's data
 
 All arguments (except profileId obviously) are optional, meaning that if you only want to change one or two then you can leave the rest nil and they'll remain unchanged.
 
 @param profileId         the profile id
 @param credentials       a dictionary containing the registration data (e.g. for AD would be something like username, password, domain)
 @param registrationMode  the registration mode - one of the modes defined by the integration e.g. form, QR, etc.
 @param biometricMethods  the biometric methods that are to be the minimal set to be used on authentication
 @param extraValues       arbitrary data to be stored in the context of the profile
 @param completion        the callback contaning the error if any occurred and the updated profile.
 */
-(void) updateProfile:(NSString* _Nonnull) profileId
          credentials:(NSDictionary* _Nullable) credentials
     registrationMode:(NSString* _Nullable) registrationMode
     biometricMethods:(NSArray<NSString*>* _Nullable) biometricMethods
          extraValues:(NSDictionary* _Nullable) extraValues
       withCompletion:(void(^ _Nullable)(VeridiumProfileData* _Nullable profileData, NSError* _Nullable error)) completion;


/*!
 Fetch license, validate it and update it localy
 
 The license is read from the paired server and fed to all recepients (SDK, biometric libs, etc)
 
 @param force       whether for force a full fetch or not
 @param completion  callback
 */
-(void) fetchLicenseAndValidateWithForce: (BOOL)force
             completion:(void(^ _Nonnull)(NSError* _Nullable error)) completion;

/*!
 Refresh all data
 
 Contact server or refresh local cache for profiles, integrations, notifications, settings, etc.
 
 @param completion  callback
 */
-(void) refreshAllWithForce: (BOOL)force
                 completion:(void(^ _Nonnull)(NSDictionary* _Nullable response, NSError* _Nullable error)) completion;

/*!
 Fetches the notifications and if any, will trigger a call to all PushNotificationHandler instances registered to the VeridiumSDK for each notification, using one block callback.
 
 @param completion the callback contaning the error if any occurred.
 */
-(void) refreshNotificationsWithCompletion:(void(^ _Nonnull)(NSError* _Nullable error)) completion;

/*!
 Updates the push notification token on the server. The call needs to be done with MTLS
 
 @param completion the callback contaning the error if any occurred.
 */
-(void)registerPushNotificationToken:(void (^ _Nonnull)(NSError * _Nullable error))completion;

/*!
 Updates the biometric vectors, both public and private parts, based on the provided authenticator type.
 
 @param newVectors          the enrolled vectors
 @param authenticatorType   the authenticatorType
 @param completion          block containing the set biometrics error if any
 */
-(void)changeBiometrics:(NSArray<VeridiumBiometricFullVector*>* _Nonnull)newVectors
          authenticatorType:(BOPSAuthenticatorType)authenticatorType
             withCompletion:(void (^_Nonnull)(NSError * _Nullable error))completion;

/*!
Changes the public auth method the server, using one block callback.

@param profileId id of the profile to set the authentication method
@param params  request parameters
@param completion  the callback contaning the error if any occurred.
*/
- (void)setAuthenticationMethodForProfileId:(NSString * _Nonnull)profileId
                                     params:(NSDictionary* _Nonnull) params
                                 completion:(void (^_Nonnull)(NSError * _Nullable))completion;

/*!
 Unlocks the BOPS account, using one block callback.
 
 The `enablePushNotifications` param is intepreted as a "wish" because if the app cannot receive pushes and you pass `true` as argument, still `false` is gonna be sent to server.
 
 @param enablePushNotifications pass `true` if you wish to enable APNS push notifications on server for this account or `false` otherwise
 @param completion the callback contaning the error if any occurred.
 */
-(void) unlockWithAPNSEnabled:(BOOL) enablePushNotifications
                   withCompletion:(void(^ _Nonnull)(NSError* _Nullable error)) completion;
@end
