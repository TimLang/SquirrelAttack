//
//  Arm.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-22.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "Arm.h"
#import "Helper.h"
#import "GameScene.h"
#import "constant.h"
@implementation Arm
+(id) armWithPosition:(CGPoint)pos inWorld:(b2World*)world
{
    return [[self alloc] initWithPosition:pos inWorld:world] ;
}
-(id) initWithPosition:(CGPoint)pos inWorld:(b2World*)world
{
    if (self = [super initWithShapeName:@"catapult_arm" inWorld:world]) {
        self.position = pos;
        _world=world;

        self.body->SetTransform([Helper toMeters:pos], 0);

    }
    [self scheduleUpdate];
    return self;
}
-(BOOL) isTouchEnabled
{
	return isTouchEnabled_;
}

-(void) setIsTouchEnabled:(BOOL)enabled
{
	if( isTouchEnabled_ != enabled ) {
		isTouchEnabled_ = enabled;
        CCDirector *director = [CCDirector sharedDirector];

			if( enabled )
				
                [[director touchDispatcher] addTargetedDelegate:self priority:INT_MIN swallowsTouches:YES];
			else {
				[[director touchDispatcher] removeDelegate:self];
			}
		
	}
}
- (CGRect)rect
{
    CGSize s = self.textureRect.size;
    return CGRectMake(0, 0, s.width, s.height);
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{


    CGPoint location = [Helper locationFromTouch:touch];
    CGPoint point =   [self convertTouchToNodeSpaceAR:touch];
    CGRect touchRect = CGRectMake(self.rect.origin.x-10, self.rect.origin.y, self.rect.size.width+20, self.rect.size.height);
    if ( !CGRectContainsPoint(touchRect, point))
    {
        return NO;
    }

    b2Vec2 pos=[Helper toMeters:location];
    GameScene* game = [GameScene shareGameScene];
    
    if (pos.x<body->GetWorldCenter().x) {
        b2MouseJointDef mjDef;
        mjDef.bodyA=game.groundBody;
        mjDef.bodyB=body;
        mjDef.target =pos ;
        mjDef.maxForce = 2000;
        touchJoint = (b2MouseJoint*)_world->CreateJoint(&mjDef);
    }
    return YES;
}
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [Helper locationFromTouch:touch];
    
    b2Vec2 pos=[Helper toMeters:location];
    if (touchJoint!=NULL&&pos.x<body->GetWorldCenter().x+50/PTM_RATIO) {
        touchJoint->SetTarget(pos);
    }

}
-(void ) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (touchJoint!=NULL) {
        
        _world->DestroyJoint(touchJoint);
        touchJoint=NULL;
        GameScene* game=[GameScene shareGameScene];
            if(game.bulletCache)
            {
                [game.bulletCache fire];

                game.contactListener->isBegin=true;
            }
   }
            
}
@end
