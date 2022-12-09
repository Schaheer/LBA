//
//  ObjCCFHelper.h
//  Hoyos1U
//
//  Created by razvan on 3/26/15.
//  Copyright (c) 2015 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VeridiumCore/VeridiumUtils.h>

@interface ObjCChallengeHelper : NSObject

+(NSURLCredential * _Nullable) handleServerTrustChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge pinnedPubKeyHashes:(NSArray<NSString*> * _Nonnull) pinnedPubKeyHashes;

+(NSURLCredential * _Nullable) handleClientCertChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge clientCert:(NSString* _Nonnull)clientCertB64 certPwd:(NSString* _Nonnull)clientCertPwd error:(NSError* _Nonnull __autoreleasing * _Nullable) error;

+(NSURLCredential * _Nullable) handleClientCertChallenge:(NSURLAuthenticationChallenge * _Nonnull)challenge clientCert:(NSString* _Nonnull)clientCertB64 certPwd:(NSString* _Nonnull)clientCertPwd;

@end
