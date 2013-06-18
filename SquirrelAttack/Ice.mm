//
//  Ice.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-20.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "Ice.h"
#import "Helper.h"

@implementation Ice
+(id) iceWithType:(IceType)type position:(CGPoint)pos inWorld:(b2World *)world
{
    return [[[self alloc] initWithType:type position:pos inWorld:world] autorelease];
}
-(id) initWithType:(IceType)type position:(CGPoint)pos inWorld:(b2World *)world
{
    switch (type) {
        case IceTypeBase:
            self=[super initWithShapeName:@"brick_platform" inWorld:world];
            self.body->SetType(b2_staticBody);
            break;
        case IceTypeBlue:
            self=[super initWithShapeName:@"brick_3" inWorld:world];
            self.body->SetType(b2_dynamicBody);
            break;
        case IceTypeRed:
            self=[super initWithShapeName:@"brick_1" inWorld:world];
            self.body->SetType(b2_dynamicBody);
            break;
        case IceTypeYellow:
            self=[super initWithShapeName:@"brick_2" inWorld:world];
            self.body->SetType(b2_dynamicBody);
            break;
            
        default:
            CCLOGWARN(@"there is not this type");
            break;
    }
    if (self) {
        self.body->SetTransform([Helper toMeters:pos], 0);
        self.position = pos;
    }
    return self;
        
}
@end
