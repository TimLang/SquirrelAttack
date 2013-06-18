//
//  BulletCache.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-23.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "Bullet.h"
@interface BulletCache :CCNode{
    b2Body* gun;
    b2World* world;
    int count;
    int currentNum;
    BOOL hasBullet;
    NSMutableArray* bullets;//strong ref
    b2WeldJoint* bulletJoint;
    Bullet* currentBullet;
}
@property (nonatomic,readonly) Bullet* currentBullet;
@property (nonatomic,readonly) BOOL hasBullet;
-(id) initWithWorld:(b2World *)_world gun:(b2Body*)gunBody;
-(void) reloading;
-(void) reset;
-(void) fire;
@end
