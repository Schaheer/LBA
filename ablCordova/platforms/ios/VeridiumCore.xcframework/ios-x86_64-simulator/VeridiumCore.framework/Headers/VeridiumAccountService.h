//
//  VeridiumAccountService.h
//  VeridiumCore
//
//  Created by Alex ILIE on 16/04/2019.
//  Copyright © 2019 Veridium IP Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VeridiumCore/RegistrationModeDefinitionData.h>
#import "VeridiumUtils.h"
#import "VeridiumAccount.h"

@interface VeridiumAccountService : NSObject

/*!
 Registers an account with BOPS, with single completion block callback.
 
 @param vectors                   an array of enrolled biometric vectors
 @param integration               the business integration (from BOPS admin console)
 @param registrationMode          the integration's registration mode (from the integration's specs)
 @param loginData                 registration login data (integration specific)
 @param txSignProtectionLevel     the protection level for the Transaction Singning keys(generated as part of the registration process for all biometric engines corresponding to the provided biometric vectors)
 @param completion                the callback contaning the error if any occurred and the newly created Bops account.
 */
-(void) registerWithVectors:(NSArray<VeridiumBiometricFullVector*>* _Nullable) vectors
                integration:(IntegrationDefinition* _Nonnull) integration
           registrationMode:(NSString* _Nonnull) registrationMode
                  loginData:(NSDictionary* _Nonnull) loginData
      txSignProtectionLevel:(VeridiumTXSigningProtection) txSignProtectionLevel
             withCompletion:( void(^_Nonnull)(VeridiumAccount* _Nullable account, RegistrationModeDefinitionData* _Nullable nextStep, NSError* _Nullable error)) completion;

/*!
 Property storing the active VeridiumLocalAccount
 */
@property (readonly, nullable, nonatomic) VeridiumAccount* activeAccount;

/*!
 Property returning all registered VeridiumLocalAccounts
 */
@property (readonly, nonnull) NSArray<VeridiumAccount*>* registeredAccounts;

/*!
 Removes a registered VeridiumLocalAccount and wipes all its data.
 
 @param account the VeridiumLocalAccount to be removed.
 */
-(void) unregisterAccount:(VeridiumAccount* _Nonnull) account;


/*!
 Removes all the registered accounts and their associated data.
 */
-(void) unregisterAllAccounts;


@end
