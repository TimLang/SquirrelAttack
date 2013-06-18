//
//  Enemy.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-28.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "Enemy.h"
#import "Helper.h"

@implementation Enemy

+(id) enemyWithType:(EnemyType)type position:(CGPoint)pos inWorld:(b2World *)world
{
    return [[[self alloc] initWithType:type position:pos inWorld:world] autorelease];
}
-(id) initWithType:(EnemyType)type position:(CGPoint)pos inWorld:(b2World *)world
{
    switch (type) {
        case EnemyTypeCat:
            self=[super initWithShapeName:@"head_cat" inWorld:world];
            break;
        case EnemyTypeDog:
            self=[super initWithShapeName:@"head_dog" inWorld:world];
            break;
        default:
            CCLOGWARN(@"there is not this type");
            break;
    }
    self.body->SetTransform([Helper toMeters:pos], 0);
    self.position = pos;
    self.body->SetType(b2_dynamicBody);
    self.body->GetFixtureList()->SetUserData((void*)10);
    return self;
    
}

@end
