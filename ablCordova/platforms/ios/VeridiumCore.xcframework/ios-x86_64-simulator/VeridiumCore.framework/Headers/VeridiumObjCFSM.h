//
//  VeridiumObjCFSM.h
//  VeridiumCore
//
//  Created by razvan on 11/22/15.
//
//

#import <Foundation/Foundation.h>
#import "VeridiumUtils.h"



@interface VeridiumFSMState : NSObject

@property (nonatomic, strong) stringBlock onExit;
@property (nonatomic, strong) stringBlock onEnter;
@property (readonly) NSString* stateName;


@property (nonatomic) SEL onExitSelector;
@property (nonatomic) SEL onEnterSelector;


-(void) addTransition:(NSString*) transition to:(NSString*) to;

@end

@interface VeridiumObjCFSM : NSObject

@property (readonly) VeridiumFSMState* currentState;

-(instancetype) init:(NSString*)fsmID selectorContext:(NSObject*) context;
-(VeridiumFSMState*) addState:(NSString*) newState;
-(void) startFrom:(NSString*) state;
-(NSString*) transitionWith:(NSString*) transition;

@end
