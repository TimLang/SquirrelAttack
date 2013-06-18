//
//  ObjectSetup.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-20.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface ObjectSetup : CCNode {
    b2World* _world;
    NSMutableArray* objects;
}
@property (nonatomic,readwrite,retain) NSMutableArray* objects;
+(id) objectSetupWithWorld:(b2World*)world ;
-(id) initWithWorld:(b2World*) world;

-(void) reset;
@end
