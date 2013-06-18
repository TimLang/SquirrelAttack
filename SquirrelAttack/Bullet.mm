//
//  Bullet.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-24.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "Bullet.h"
#import "Helper.h"
@interface Bullet(PrivateMethods)
-(id) initWithType:(BulletType)type position:(CGPoint)pos inWorld:(b2World *)world;
@end

@implementation Bullet
+(id) bulletWithType:(BulletType)type position:(CGPoint)pos inWorld:(b2World *)world
{
    return [[[self alloc] initWithType:type position:pos inWorld:world] autorelease];
}
-(id) initWithType:(BulletType)type position:(CGPoint)pos inWorld:(b2World *)world
{
    
    if (self= [super initWithShapeName:@"acorn" inWorld:world]) {
        self.body->SetBullet(YES);
        self.body->SetTransform([Helper toMeters:pos], 0);
    }
    return self;
}
-(void) setLocation:(CGPoint)loc
{
    self.body->SetTransform([Helper toMeters:loc], 0);
    self.position = loc;
}
@end
