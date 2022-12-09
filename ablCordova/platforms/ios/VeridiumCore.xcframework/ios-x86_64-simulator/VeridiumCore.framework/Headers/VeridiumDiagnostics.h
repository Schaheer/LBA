//
//  VeridiumDiagnostics.h
//  VeridiumCore
//
//  Created by razvan on 12/20/16.
//  Copyright © 2016 HoyosLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VeridiumDiagnosticTiming : NSObject

-(void) stop;
@property (readonly) BOOL isStopped;
@property (readonly, nonnull) NSDate* started;
@property (readonly, nullable) NSDate* ended;
@property (readonly) NSTimeInterval durationInSeconds;

@property (readonly, nullable) NSDictionary* JSONDictionary;

@end

@interface VeridiumDiagnosticSession : NSObject

@property (readonly, nullable) NSDictionary* JSONDictionary;
@property (readonly, nonnull) NSString* name;

- (void) add:(NSString* _Nonnull)diagMessage info:(NSDictionary* _Nullable) info;
- (void) startTiming:(NSString* _Nonnull) name;
- (void) stopTiming:(NSString* _Nonnull) name;

- (void) endWithMessage:(NSString* _Nullable)message;

- (id _Nullable)objectForKeyedSubscript:(NSString* _Nonnull)key;
- (void) setObject:(id _Nullable)obj forKeyedSubscript:(NSString* _Nonnull)key;

@end




@protocol VeridiumDiagnosticStorage <NSObject>

-(VeridiumDiagnosticSession* _Nonnull) createSessionWithName:(NSString* _Nonnull) name info:(NSDictionary* _Nullable) info;

@property (readonly, nonnull) NSArray* completedSessions;

-(void) store:(VeridiumDiagnosticSession* _Nonnull) session;

-(void) clear;

@end


@interface VeridiumDiagnosticNullStorage : NSObject<VeridiumDiagnosticStorage>

@end

@interface VeridiumDiagnosticMemoryStorage : NSObject<VeridiumDiagnosticStorage>

@end

@interface VeridiumDiagnosticDiscStorage : NSObject<VeridiumDiagnosticStorage>

@end

@interface VeridiumDiagnosticUserDefaultsStorage : NSObject<VeridiumDiagnosticStorage>

@end
