//
//  Arm.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-22.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"

@interface Arm : BodyNode<CCTargetedTouchDelegate> {
    b2World* _world;
    b2MouseJoint* touchJoint;
    BOOL isTouchEnabled_;
}
@property(nonatomic,assign) BOOL isTouchEnabled;
+(id) armWithPosition:(CGPoint)pos inWorld:(b2World*)world;
-(id) initWithPosition:(CGPoint)pos inWorld:(b2World*)world ;


@end
