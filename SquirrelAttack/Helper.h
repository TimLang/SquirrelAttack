//
//  Helper.h
//  ChalkTest
//
//  Created by Bullet Hermit on 12-10-17.
//  Copyright 2012年 紫竹飞燕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
@interface Helper : NSObject {
    
}
+(b2Vec2) toMeters:(CGPoint) point;
+(CGPoint) toPixels:(b2Vec2) vec;
+(CGPoint) locationFromTouch:(UITouch*) touch;
+(CGPoint) locationFromTouches:(NSSet*) touches;
+(CGPoint) screenCenter;
@end
