//
//  BodyNode.h
//  ChalkTest
//
//  Created by Bullet Hermit on 12-10-16.
//  Copyright 2012年 紫竹飞燕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
@interface BodyNode : CCSprite {
    b2Body* body;

}
@property (nonatomic,readonly) CGRect rect;
@property (nonatomic,readonly) b2Body* body;
-(id) initWithShapeName:(NSString*)name inWorld:(b2World*)world;
-(void) setBodyShapeWithName:(NSString*)name;

@end
