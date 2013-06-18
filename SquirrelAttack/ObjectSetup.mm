//
//  ObjectSetup.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-20.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "ObjectSetup.h"
#import "BodyNode.h"
#import "Ice.h"
#import "Enemy.h"
#import "constant.h"

@interface ObjectSetup(PrivateMethods)
-(void) addTargets;
-(void) addEnemies;
@end

@implementation ObjectSetup
@synthesize objects;
+(id) objectSetupWithWorld:(b2World *)world
{
    return [[[self alloc] initWithWorld:world] autorelease];
    
}
-(id) initWithWorld:(b2World *)world
{
    if (self = [super init]) {
        objects=[[NSMutableArray alloc] init];
        _world=world;
        [self addTargets];
        [self addEnemies];
    }
    return self;
}


-(void) addEnemies
{

    float32 delta = 0;
    Enemy* enemy=[Enemy enemyWithType:EnemyTypeCat position:ccp(delta+680.0,FLOOR_HEIGHT+63.0f) inWorld:_world];
    [self addChild:enemy];
    [objects addObject:enemy];
    enemy=[Enemy enemyWithType:EnemyTypeCat position:ccp(delta+881.0,FLOOR_HEIGHT+28.0f) inWorld:_world];
    [self addChild:enemy];
    [objects addObject:enemy];

    enemy=[Enemy enemyWithType:EnemyTypeDog position:ccp(delta+707.0,FLOOR_HEIGHT) inWorld:_world];
    [self addChild:enemy];
    [objects addObject:enemy];
    enemy=[Enemy enemyWithType:EnemyTypeDog position:ccp(delta+740.0,FLOOR_HEIGHT+63.0f) inWorld:_world];
    [self addChild:enemy];
    [objects addObject:enemy];
    enemy=[Enemy enemyWithType:EnemyTypeDog position:ccp(delta+810.0,FLOOR_HEIGHT) inWorld:_world];
    [self addChild:enemy];
    [objects addObject:enemy];
    }
-(void) addTargets
{
    float32 delta = 0;
    //left
    Ice* ice=[Ice iceWithType:IceTypeYellow position:ccp(delta+741,FLOOR_HEIGHT) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeRed position:ccp(delta+675,FLOOR_HEIGHT) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeRed position:ccp(delta+675,FLOOR_HEIGHT+28.0f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeBlue position:ccp(delta+672,FLOOR_HEIGHT+50.25f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeRed position:ccp(delta+707,FLOOR_HEIGHT+67.25f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeRed position:ccp(delta+707,FLOOR_HEIGHT+94.25f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    //middle
    ice=[Ice iceWithType:IceTypeYellow position:ccp(delta+770,FLOOR_HEIGHT) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeYellow position:ccp(delta+770,FLOOR_HEIGHT+46.0f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    //right
    ice=[Ice iceWithType:IceTypeBase position:ccp(delta+839,FLOOR_HEIGHT) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeYellow position:ccp(delta+854,FLOOR_HEIGHT+28.0f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeYellow position:ccp(delta+854,FLOOR_HEIGHT+28.0f+46.0f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeYellow position:ccp(delta+909,FLOOR_HEIGHT+28.0f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeRed position:ccp(delta+909,FLOOR_HEIGHT+28.0f+46.0f) inWorld:_world];
    [self addChild:ice];
    [objects addObject:ice];
    ice=[Ice iceWithType:IceTypeRed position:ccp(delta+909,FLOOR_HEIGHT+28.0f+46.0f+23.0f) inWorld:_world];
    [self addChild:ice];

    [objects addObject:ice];



}

-(void) reset
{
    CCLOG(@"%i",[objects count]);
    for (int i=0; i!=[objects count]; ++i ) {
        BodyNode* bn=[objects objectAtIndex:i];
        [self removeChild:bn cleanup:YES];
    }

    [objects removeAllObjects];
    [self addTargets];
    [self addEnemies];
}
-(void) dealloc
{
    [objects release];
    objects = nil;
    [super dealloc];

    
}
@end
