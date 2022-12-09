//
//  VeridiumDecrypt.h
//  VeridiumDecrypt
//
//  Created by razvan on 11/25/15.
//  Copyright © 2015 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VeridiumCore/VeridiumCore.h>

/*!
 Certificate helper class
 */
@interface VeridiumCertHelper : NSObject
/*!
 Generates a X509 CSR
 
 @return the generated CSR parts in PEM format
 */
+(NSArray<NSString*>*) gen_X509Req;

/*!
 Generates a X509 CSR
 
 @return the generated CSR parts in PEM format
 */
+(NSArray<NSString*>*) gen_X509ReqWithCountry:(NSString*)country
                                     province:(NSString*)province
                                         city:(NSString*)city
                                 organization:(NSString*)organization
                                       common:(NSString*)common
                                        email:(NSString*)email
                                       userId:(NSString*)userId;

/*!
 Generates a P12 from PEM parts
 
 @param pKeyPEM public key PEM
 @param certPEM certificate PEM
 @param pass    certificate password
 
 @return Base64 representation of the generated certificate
 */
+(NSString*) generateP12FromPKey:(NSString*)pKeyPEM andCert:(NSString*)certPEM pass:(NSString*)pass;



/*!
 Static helper reads a P12 from a Base64 encoded string.
 
 @param p12B64  the p12 in Base64 string
 @param pass    certificate password.
 @return certificate data and key data if any, `nil` otherwise.
 */
+(NSArray<NSData*>*)readP12FromB64String:(NSString*)p12B64 withPass:(NSString*)pass;

/*!
 Returns the value of certificate subject field from the Base64 encoded P12
 
 @param p12Base64 the P12 in Base64 string
 @param password  certificate password
 @param fieldName abbreviation of the certificate's subject field. Possible values are: O, OU, CN, C, ST, L, UID
 
 @return subject value for the corresponding field specified by the `fieldName` parameter
 */
+(NSString*) getSubjectFieldValueFromP12:(NSString *)p12Base64 pass:(NSString *)password fieldName:(NSString *)fieldName;

/*!
 Generates a CSR using a keypair generated with secure enclave
 
 Uses 256-bit elliptic curve algorithm for key generation due to limitation from Secure Enclave. After CSR string is prepared, the public
 key is removed from the keychain in order to prevent identity conflict with the certificate signed with this CSR.
 
 @param publicKeyTag   application tag used for identifying the public key
 @param privateKeyTag  application tag used for identifying the private key
 @param country        country (C) domain field value of CSR
 @param province       province (ST) domain field value for CSR
 @param city           city (L) domain field value for CSR
 @param organization   organization (O) domain field value for CSR
 @param commonName     commonName (CN) domain field value for CSR
 @param email          email domain field value for CSR
 @param userId         user id (UID) domain field value for CSR
 @param error          address of an error object. If an error occurs, this is set to point to an error instance describing failure
 
 @return csr string in PEM format
 */
+(NSString* _Nullable) generateSecureEnclaveCSRwith:(NSString * _Nonnull)publicKeyTag
                                       privateKeyTag:(NSString * _Nonnull)privateKeyTag
                                             country:(NSString * _Nonnull)country
                                            province:(NSString * _Nonnull)province
                                                city:(NSString * _Nonnull)city
                                        organization:(NSString * _Nonnull)organization
                                          commonName:(NSString * _Nonnull)commonName
                                               email:(NSString * _Nonnull)email
                                              userId:(NSString * _Nonnull)userId
                                               error:(NSError *_Nullable*_Nullable)error API_AVAILABLE(ios(11));

/*!
 Adds PEM certificate to keychain
 
 @param pemCertificate    certificate to be added to keychain
 @param certificateLabel  label for identifying the certificate in keychain
 
 @return YES for successful add, NO otherwise.
 */
+(BOOL) addPEMCertificate:(NSString * _Nonnull)pemCertificate
           toKeyChainWith:(NSString * _Nonnull)certificateLabel;

/*!
 Removes certificate from keychain
 
 @param certificateLabel label for identifying the certificate in keychain
 
 @return YES for successful removal, NO otherwise.
 */
+(BOOL) removeCertificate:(NSString * _Nonnull)certificateLabel;

/*!
 Removes key from keychain
 
 @param applicationTag application tag identifying the key in keychain
 
 @return YES for successful removal, NO otherwise.
 */
+(BOOL) removeKey:(NSString * _Nonnull)applicationTag;

/*!
 Prepares a NSURLCredential object using the label of the certificate that is added to device's keychain
 
 @param certificateLabel  label of the certificate that is available in device's keychain
 
 @return NSURLCredential instance if successful, NULL otherwise.
 */
+(NSURLCredential * _Nullable) prepareURLCredentialUsing:(NSString * _Nonnull)certificateLabel;

@end
