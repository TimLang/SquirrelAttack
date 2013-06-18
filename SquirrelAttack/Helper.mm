//
//  Helper.m
//  ChalkTest
//
//  Created by Bullet Hermit on 12-10-17.
//  Copyright 2012年 紫竹飞燕. All rights reserved.
//

#import "Helper.h"
#import "constant.h"

@implementation Helper
+(b2Vec2) toMeters:(CGPoint)point
{
    return b2Vec2(point.x/PTM_RATIO, point.y/PTM_RATIO);
}
+(CGPoint) toPixels:(b2Vec2)vec
{
    return ccp(vec.x *PTM_RATIO,vec.y *PTM_RATIO);
}
+(CGPoint) locationFromTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:location];
}
+(CGPoint) locationFromTouches:(NSSet *)touches
{
    return [self locationFromTouch:[touches anyObject]];
}
+(CGPoint) screenCenter
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint p = ccp(winSize.width*0.5,winSize.height*0.5);
    return p;
}
@end
