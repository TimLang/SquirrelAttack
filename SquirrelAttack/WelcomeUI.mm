//
//  WelcomeUI.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-2-10.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "WelcomeUI.h"
#import "GameScene.h"
#import "ChooseUI.h"
@implementation WelcomeUI
+(id) scene
{
    CCScene* scene = [CCScene node];
    WelcomeUI* ui=[WelcomeUI node];
    [scene addChild:ui z:0];
    return scene;
}
-(id) init
{
    if (self = [super init]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CatapultArt.plist"];
        
        
        CGSize screenSize = [CCDirectorIOS sharedDirector].winSize;
        CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"bg_title"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [self addChild:bg z:0];
        
        spriteStart=[CCSprite spriteWithSpriteFrameName:@"acorn_glow"];
        spriteStart.anchorPoint=ccp(0.5,0.5);
        spriteStart.scale=1.5f;
        spriteStarted=[CCSprite spriteWithSpriteFrameName:@"acorn"];
spriteStarted.anchorPoint=ccp(0.5,0.5);
        spriteStarted.scale=1.6f;
        
        CCMenuItemSprite* startItem = [CCMenuItemSprite itemWithNormalSprite:spriteStart selectedSprite:spriteStarted target:self selector:@selector(changeScene)];
        CCMenu* menu =[CCMenu menuWithItems:startItem, nil];
        menu.position = ccp(screenSize.width/2,screenSize.height/2-100);
        [self addChild:menu z:1];


    }
    return self;
}
-(void) changeScene
{
    [[CCDirectorIOS sharedDirector] replaceScene:[ChooseUI scene]];
}
@end
