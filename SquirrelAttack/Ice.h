//
//  Ice.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-20.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodyNode.h"
typedef enum
{
    IceTypeRed=0,
    IceTypeYellow=1,
    IceTypeBlue=2,
    IceTypeBase = 3,
}
IceType;
@interface Ice : BodyNode {
    
}
+(id) iceWithType:(IceType)type position:(CGPoint)pos inWorld:(b2World*)world;
-(id) initWithType:(IceType)type position:(CGPoint)pos inWorld:(b2World*)world ;
@end
