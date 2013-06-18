//
//  ChooseUI.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-2-10.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "ChooseUI.h"
#import "GameScene.h"
#import "WelcomeUI.h"

@implementation ChooseUI
+(id) scene
{
    CCScene* scene = [CCScene node];
    ChooseUI* ui=[ChooseUI node];
    [scene addChild:ui z:0];
    return scene;
}
-(id) init
{
    if (self = [super init]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"CatapultArt.plist"];
        CGSize screenSize = [CCDirectorIOS sharedDirector].winSize;
        CCSprite* bg = [CCSprite spriteWithSpriteFrameName:@"bg_plain"];
        bg.position = ccp(screenSize.width/2,screenSize.height/2);
        [self addChild:bg z:0];
 
       CCSprite* spriteBack=[CCSprite spriteWithSpriteFrameName:@"button_back"];
        spriteBack.anchorPoint=ccp(0.5,0.5);
        
        CCSprite* spriteBacked=[CCSprite spriteWithSpriteFrameName:@"button_back"];
        spriteBacked.anchorPoint=ccp(0.5,0.5);
        spriteBacked.scale=1.1f;
        
        CCMenuItemSprite* backItem = [CCMenuItemSprite itemWithNormalSprite:spriteBack selectedSprite:spriteBacked target:self selector:@selector(backScene)];
        CCMenu* menu =[CCMenu menuWithItems:backItem, nil];
        menu.position=ccp(100 ,50);
        [self addChild:menu z:1];
     //-----------------------------------------
        
        CCSprite* spriteScene1=[CCSprite spriteWithFile:@"session.png"];
        
        spriteBack.anchorPoint=ccp(0.5,0.5);
        
        CCSprite* spriteScene1ed=[CCSprite spriteWithFile:@"session.png"];
        spriteBacked.anchorPoint=ccp(0.5,0.5);
        spriteBacked.scale=1.1f;
        
        CCMenuItemSprite* sceneItem1 = [CCMenuItemSprite itemWithNormalSprite:spriteScene1 selectedSprite:spriteScene1ed target:self selector:@selector(changeScene)];
        
        CCSprite* spriteScene2=[CCSprite spriteWithFile:@"session.png"];
        

        
        CCSprite* spriteScene2ed=[CCSprite spriteWithFile:@"session.png"];

        
        CCMenuItemSprite* sceneItem2 = [CCMenuItemSprite itemWithNormalSprite:spriteScene2 selectedSprite:spriteScene2ed target:self selector:@selector(changeScene)];
        CCMenu* menuChose =[CCMenu menuWithItems:sceneItem1,sceneItem2, nil];
        
        menuChose.position = ccp(240,250);
        [menuChose alignItemsHorizontally];
        [self addChild:menuChose z:1];
        
        
    }
    return self;
}
-(void) changeScene
{
    [[CCDirectorIOS sharedDirector] replaceScene:[GameScene scene]];
}
-(void) backScene
{
    [[CCDirectorIOS sharedDirector] replaceScene:[WelcomeUI scene]];
}
@end
