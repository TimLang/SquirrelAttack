//
//  Enemy.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-28.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"

typedef enum
{
    EnemyTypeCat=0,
    EnemyTypeDog=1,

}
EnemyType;
@interface Enemy : BodyNode{


}

+(id) enemyWithType:(EnemyType)type position:(CGPoint)pos inWorld:(b2World*)world;

@end
