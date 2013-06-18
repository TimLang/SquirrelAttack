//
//  GameScene.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-19.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Arm.h"
#import "BulletCache.h"
#import "ObjectSetup.h"
#import "ContactListener.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
typedef enum{
    kLayerTagGame=0,
    kLayerTagUI=1,
    kLayerTagMsg=2,
} kLayerTag;


// HelloWorldLayer
@interface GameScene : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CGPoint touchBeginPont;
    Arm* arm;//weak ref
    b2MouseJoint* touchJoint;//weak ref
	b2World* world;					// C++ strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
    b2Body* groundBody ;//C++ weak ref
    BulletCache* bulletCache;//strong ref
    ObjectSetup* objectSetup;//weak ref
    
    ContactListener* contactListener;//C++ strong ref

    
    
    BOOL isTouching;

    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
@property (nonatomic,readonly) BulletCache* bulletCache;
@property (nonatomic,readonly) b2Body* groundBody;
@property (nonatomic,readwrite) ContactListener* contactListener;
@property (nonatomic,readwrite) BOOL isTouching;
+(CCScene *) scene;
+(GameScene*) shareGameScene;
+(CCScene*) shareScene;

@end
