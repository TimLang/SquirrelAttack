//
//  BulletCache.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-23.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "BulletCache.h"
#import "Bullet.h"
#import "constant.h"
#import "GameScene.h"
#import "Arm.h"
#import "UILayer.h"
@interface BulletCache(PrivateMethods)
@end

@implementation BulletCache
@synthesize currentBullet,hasBullet;

-(id) initWithWorld:(b2World *)_world gun:(b2Body*)gunBody
{
    NSAssert(_world!=NULL, @"world is null");
    NSAssert(gunBody!=NULL, @"gun is null");

    if (self=[super init]) {
        //init member
        gun=gunBody;
        world=_world;
        currentNum=0;

        count = 4;
        hasBullet=YES;
        if (count>0) {
            bullets = [[NSMutableArray alloc] initWithCapacity:count];
            float startPos = 62;
            float endPos = 165.0f;
            CGFloat delta = (count > 1)?((endPos   - startPos - 30.0f) / (count - 1)):0.0f;
            float pos = 62.0f;
            for (int i=0; i<count; ++i,pos+=delta) {
                Bullet* bullet = [Bullet bulletWithType:BulletTypeNormal position:ccp(pos,FLOOR_HEIGHT ) inWorld:world];
                bullet.body->SetActive(false);
                [bullets addObject:[NSValue valueWithPointer:bullet]];
                [self addChild:bullet z:3];
            }
            currentBullet=(Bullet*)[[bullets objectAtIndex:0] pointerValue];
        }

    }

    return self;
}

-(void) reloading
{
    if (currentNum>=count) {
        hasBullet=NO;
    }
    if (currentNum<count&&!bulletJoint) {
        //get a free bullet
        currentBullet = (Bullet*)[[bullets objectAtIndex:currentNum] pointerValue];
        //currentBullet+=1
        ++currentNum;
        CCLOG(@"bullet num:%i",currentNum);
        b2Body* bulletBody = currentBullet.body;
        bulletBody->SetActive(true);
        bulletBody->SetTransform(b2Vec2(240.0f/PTM_RATIO,(140.0f+FLOOR_HEIGHT)/PTM_RATIO), 0);
        //pin to gun
        b2WeldJointDef bulletJointDef;
        bulletJointDef.Initialize(bulletBody, gun, b2Vec2(230.0f/PTM_RATIO,(140.0f+FLOOR_HEIGHT)/PTM_RATIO));
        bulletJointDef.collideConnected = true;
        bulletJoint=(b2WeldJoint*)world->CreateJoint(&bulletJointDef);
        Arm* arm=(Arm*)gun->GetUserData();
        arm.isTouchEnabled=YES;
        GameScene* game = [GameScene shareGameScene];
        game.isTouching=YES;

    }
    CCLOG(@"reloading");
}

-(void) reset
{
    [self unschedule:@selector(reloading)];
    currentNum=0;
    hasBullet=YES;
//destroy joint
    if (bulletJoint) {
        world->DestroyJoint(bulletJoint);
        bulletJoint=nil;
    }
    //destroy bullets
    if (bullets)
    {
        for (NSValue *bulletPointer in bullets)
        {
            Bullet *bullet = (Bullet*)[bulletPointer pointerValue];
            [self removeChild:bullet cleanup:YES];
        }

        [bullets removeAllObjects];
    }
    //reset bullets
    float startPos = 62;
    float endPos = 165.0f;
    CGFloat delta = (count > 1)?((endPos   - startPos - 30.0f) / (count - 1)):0.0f;
    float pos = 62.0f;
    for (int i=0; i<count; ++i,pos+=delta) {
        Bullet* bullet = [Bullet bulletWithType:BulletTypeNormal position:ccp(pos,FLOOR_HEIGHT ) inWorld:world];
        bullet.body->SetActive(false);
        [bullets addObject:[NSValue valueWithPointer:bullet]];

        [self addChild:bullet z:3];
    }
    //set current bullet
     currentBullet=(Bullet*)[[bullets objectAtIndex:0] pointerValue];
    
    [self reloading];


}
-(void) fire
{
    //break
    if (bulletJoint)
    {
       world->DestroyJoint(bulletJoint);
        bulletJoint=nil;
        CCLOG(@"fire");
        //[[[CCDirectorIOS sharedDirector] touchDispatcher] removeDelegate:(Arm*)gun->GetUserData()];
        Arm* arm=(Arm*)gun->GetUserData();
        arm.isTouchEnabled=NO;
        GameScene* game = [GameScene shareGameScene];
        game.isTouching=NO;
        [self scheduleOnce:@selector(reloading) delay:3];
       
    }
}



-(void) dealloc
{
    [bullets release];
    bullets =nil;

    [super dealloc];
    
}
@end
