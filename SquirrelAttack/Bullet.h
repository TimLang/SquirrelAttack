//
//  Bullet.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-24.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"
typedef enum
{
    BulletTypeNormal=0,
}BulletType;
@interface Bullet : BodyNode {
    
}
+(id) bulletWithType:(BulletType)type position:(CGPoint)pos inWorld:(b2World*)world;
-(id) initWithType:(BulletType)type position:(CGPoint)pos inWorld:(b2World*)world ;
-(void) setLocation:(CGPoint)loc;
@end
