//
//  GameScene.mm
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-19.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//

// Import the interfaces
#import "GameScene.h"
#import "WelcomeUI.h"
// Not included in "cocos2d.h"
#import "CCPhysicsSprite.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "GB2ShapeCache.h"
#import "CCParticleSystemQuad.h"
#import "constant.h"
#import "UILayer.h"
#import "MessageLayer.h"
#import "Helper.h"
#import "Enemy.h"
enum {
	kTagParentNode = 1,
};

#pragma mark - HelloWorldLayer

@interface GameScene()
//init methods
-(void) initPhysics;
-(void) initStatics;
-(void) attachArm;
-(void) preloadParticleEffects;
//update methods
-(void) locViewTo:(CGPoint)pos;
-(void) disposeContact;
//control
-(void) pauseGame;
-(void) resumeGame;
-(void) resetGame;
@end

@implementation GameScene
@synthesize groundBody,bulletCache,contactListener,isTouching;
static GameScene* instanceOfGameScene;
static CCScene* instanceOfScene;
+(CCScene *) scene
{
    
	instanceOfScene = [CCScene node];
	GameScene *game = [GameScene node];
	[instanceOfScene addChild: game z:1 tag:kLayerTagGame];
     UILayer* ui=[UILayer nodeWith:game];
    [instanceOfScene addChild:ui  z:2 tag:kLayerTagUI];
    MessageLayer* layer = [MessageLayer nodeWith:game];
    layer.visible=NO;
    [instanceOfScene addChild:layer z:3 tag:kLayerTagMsg];
	return instanceOfScene;
}

+(GameScene*) shareGameScene
{
    NSAssert(instanceOfGameScene!=nil, @"GameScene hasn't been init");
    return instanceOfGameScene;
}
+(CCScene*) shareScene
{
    NSAssert(instanceOfScene!=nil, @"Scene hasn't been init");
    return instanceOfScene;
}
-(id) init
{
	if( (self=[super init])) {
		instanceOfGameScene=self;
		// enable events
        self.isTouchEnabled = YES;
        self.isTouching=YES;
		
		self.isAccelerometerEnabled = YES;
        
		//CGSize s = [CCDirector sharedDirector].winSize;
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CatapultArt.plist"];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"SquirrelObjects.plist"];
        [self preloadParticleEffects];
		// init physics
		[self initPhysics];
		[self initStatics];
		[self scheduleUpdate];

	}
	return self;
}

-(void) dealloc
{

    [bulletCache release];
    bulletCache=nil;
    [objectSetup release];
    objectSetup=nil;
	[super dealloc];
    delete contactListener;
    contactListener=NULL;
	delete m_debugDraw;
	m_debugDraw = NULL;
    delete world;
	world = NULL;


}	

-(void) initStatics
{
    CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:@"bg_mainlevel"];
    sprite.anchorPoint = CGPointZero;
    [self addChild:sprite z:-1];
    sprite = [CCSprite spriteWithSpriteFrameName:@"bg_mainlevel_foreground"];
    sprite.anchorPoint = CGPointZero;
   [self addChild:sprite z:10];
    sprite = [CCSprite spriteWithSpriteFrameName:@"catapult_base_1"];
    sprite.anchorPoint = CGPointZero;
    sprite.position = CGPointMake(181.0f, FLOOR_HEIGHT);
    [self addChild:sprite z:0];
    sprite = [CCSprite spriteWithSpriteFrameName:@"catapult_base_2"];
    sprite.anchorPoint = CGPointZero;
    sprite.position = CGPointMake(181.0f, FLOOR_HEIGHT);
    [self addChild:sprite z:2];
    
    sprite = [CCSprite spriteWithSpriteFrameName:@"squirrel_1"];
    sprite.anchorPoint = CGPointZero;
    sprite.position = CGPointMake(11.0f, FLOOR_HEIGHT);
    [self addChild:sprite z:0];
    sprite = [CCSprite spriteWithSpriteFrameName:@"squirrel_2"];
    sprite.anchorPoint = CGPointZero;
    sprite.position = CGPointMake(240.0f, FLOOR_HEIGHT);
    [self addChild:sprite z:9];
}

-(void) initPhysics
{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
			flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);		
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;		
	
	// bottom
	
	groundBox.Set(b2Vec2(0,FLOOR_HEIGHT/PTM_RATIO), b2Vec2(s.width*2/PTM_RATIO,FLOOR_HEIGHT/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
    /*
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);*/
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width*2/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width*2/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
    
    //member init
    //contact listener
    contactListener = new ContactListener();
    
    world->SetContactListener(contactListener);
    //arm
    arm = [Arm armWithPosition:ccp(230, FLOOR_HEIGHT+10) inWorld:world];
    [self addChild:arm z:2];
    [self attachArm];
    //bullets
    bulletCache=[[BulletCache alloc] initWithWorld:world gun:arm.body];
    
    [bulletCache reloading];
    [self addChild:bulletCache];
    //objects
    objectSetup=[[ObjectSetup alloc] initWithWorld:world];
    //objectSetup=[ObjectSetup objectSetupWithWorld:world];
    [self addChild:objectSetup];
    [self moveViewFrom:ccp(960, 0)];

}
-(void) preloadParticleEffects
{
    
    [CCParticleSystemQuad particleWithFile:@"EnemyDeadPar.plist"];
}
-(void) attachArm
{
    b2RevoluteJointDef armJointDef;
    b2RevoluteJoint* joint;
    armJointDef.Initialize(groundBody, arm.body, [Helper toMeters:ccp(230, FLOOR_HEIGHT)]);
    armJointDef.enableLimit=true;
    armJointDef.enableMotor = true;
    armJointDef.lowerAngle=CC_DEGREES_TO_RADIANS( 7);
    armJointDef.upperAngle =CC_DEGREES_TO_RADIANS( 75);
    armJointDef.motorSpeed = -1000;
    armJointDef.maxMotorTorque = 2000;
    joint = (b2RevoluteJoint*)world->CreateJoint(&armJointDef);
    
}
-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();	
	
	kmGLPopMatrix();
}
-(void) locViewTo:(CGPoint)pos
{
    if (self.isTouching) {
        return;
    }
    CGPoint myPosition = self.position;
    CGSize screenSize = [[CCDirectorIOS sharedDirector] winSize];
    myPosition.x = -MIN(screenSize.width * 2.0f - screenSize.width, pos.x  - screenSize.width / 2.0f);
    if (myPosition.x>0) {
        return;
    }
    self.position = myPosition;
   
}
-(void) moveViewFrom:(CGPoint) pos
{
   // [self locViewTo:pos];
    [self runAction:[CCSequence actions:
                     [CCMoveTo actionWithDuration:1.5f position:CGPointMake(-480.0f, 0.0f)],
                     [CCDelayTime actionWithDuration:1.0f],
                     [CCMoveTo actionWithDuration:1.5f position:CGPointZero],
                     nil]];
    
}
-(void) disposeContact
{

    std::set<b2Body*>::iterator it;
    for (it =contactListener->contacts.begin(); it!=contactListener->contacts.end(); ++it) {
        b2Body* body = *it;
        CCNode* node = (CCNode*)body->GetUserData();

        
        CCParticleSystem* particleSystem=[CCParticleSystemQuad particleWithFile:@"EnemyDeadPar.plist"];
        particleSystem.autoRemoveOnFinish=YES;
        particleSystem.position = node.position;
        particleSystem.positionType = kCCPositionTypeFree;
        [self addChild:particleSystem z:4];
    
        [objectSetup removeChild:node cleanup:YES];
        [objectSetup.objects removeObject:(id)body->GetUserData()];

    }
    contactListener->contacts.clear();
}

-(void) update: (ccTime) dt
{
    for (b2Body* body = world->GetBodyList(); body; body=body->GetNext()) {
        CCSprite* sprite = (CCSprite*)body->GetUserData();
        sprite.position = [Helper toPixels:body->GetPosition()];
        sprite.rotation = CC_RADIANS_TO_DEGREES(body->GetAngle())*-1;
    }

    [self disposeContact];
    
    if (!bulletCache.hasBullet) {
        [self pauseGame];
    }
    
    
    [self locViewTo:bulletCache.currentBullet.position];

	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);


}
-(void) pauseGame
{
    [self pauseSchedulerAndActions];
    self.isTouchEnabled=NO;
    CCLayer* msg = (CCLayer*)[instanceOfScene getChildByTag:kLayerTagMsg];
    msg.visible=YES;
    
}
-(void) resumeGame
{
    [self resumeSchedulerAndActions];
    self.isTouchEnabled=YES;
    CCLayer* msg = (CCLayer*)[instanceOfScene getChildByTag:kLayerTagMsg];
    msg.visible=NO;
}
-(void) resetGame
{
    contactListener->isBegin=false;
    [bulletCache reset];
    [objectSetup reset];
    [self unscheduleAllSelectors];
    [self scheduleUpdate];
    contactListener->isBegin=true;

}
-(void) backToMenu
{
    [[CCDirectorIOS sharedDirector] replaceScene:[WelcomeUI scene]];
}
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"scene touch");
    for( UITouch *touch in touches ) {
		CGPoint location = [Helper locationFromTouch:touch];
        touchBeginPont=location;
	}
}
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for( UITouch *touch in touches ) {
		CGPoint location = [Helper locationFromTouch:touch];
        CGPoint myPosition = self.position;
        float32 deltaDistance = touchBeginPont.x-location.x;
       myPosition.x -=  deltaDistance;
        touchBeginPont = location;
        CGSize screenSize = [[CCDirectorIOS sharedDirector] winSize];
        myPosition.x =  MIN(0,myPosition.x);
       myPosition.x = MAX(-1.0*screenSize.width, myPosition.x);
        self.position = myPosition;
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
        if (touchJoint!=NULL) {
           //CCLOG(@" end");
        }
	}
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
