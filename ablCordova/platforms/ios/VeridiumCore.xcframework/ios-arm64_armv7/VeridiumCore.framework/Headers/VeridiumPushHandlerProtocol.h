//
//  VeridiumPushHandlerProtocol.h
//  VeridiumCore
//
//  Created by razvan on 12/20/15.
//  Copyright © 2015 HoyosLabs. All rights reserved.
//

/*!
 Protocol to be adopted by classes that want to register to VeridiumSDK as push notifications subscriber via the [VeridiumSDK registerPushHandler:] method.
 */
@protocol VeridiumPushHandlerProtocol <NSObject>

/*!
 VeridiumSDK calls this on all registered subscribers on all incoming notifications
 
 @param pushData a NSDictionary containing the push data.
 @param isAPNS   `true` if the notification came via Apple's APNS service or from BOPS notification polling (only on BOPS enabled apps).
 */
-(void) handlePush:(NSDictionary<NSString*,id>*) pushData isAPNS:(BOOL) isAPNS;

-(void) notifyPushesPending;

@end
