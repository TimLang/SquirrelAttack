//
//  BodyNode.m
//  ChalkTest
//
//  Created by Bullet Hermit on 12-10-16.
//  Copyright 2012年 紫竹飞燕. All rights reserved.
//

#import "BodyNode.h"
#import "GB2ShapeCache.h"

@implementation BodyNode
@synthesize body;

-(id) initWithShapeName:(NSString *)name inWorld:(b2World *)world
{
    
    NSAssert(name!=nil, @"the shape or sprite name is null");
    NSAssert(world!=nil, @"there isn't the world you request");
    if(self = [super initWithSpriteFrameName:name])
    {
        
        b2BodyDef bodyDef;
        bodyDef.type=b2_dynamicBody;
        bodyDef.linearDamping=1.0f;
        bodyDef.angularDamping=1.0f;
        body=world->CreateBody(&bodyDef);
        body->SetUserData(self);
        [self setBodyShapeWithName:name];
    }
    return self;
}
-(void) setBodyShapeWithName:(NSString *)name
{
    b2Fixture* fixture;
    if((fixture=body->GetFixtureList()))
    {
        body->DestroyFixture(fixture);
    }
    if (name) {
        GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache];
        [ shapeCache addFixturesToBody:body forShapeName:name];
        self.anchorPoint = [shapeCache anchorPointForShape:name];
    }
    
}

-(void) dealloc
{

  

   body->GetWorld()->DestroyBody(body);
    
    [super dealloc];

    
}
@end
