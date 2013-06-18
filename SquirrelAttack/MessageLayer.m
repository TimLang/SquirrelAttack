//
//  MessageLayer.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-2-2.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "MessageLayer.h"


@implementation MessageLayer
+(id) nodeWith:(CCLayer *)bind
{
    return [[[self alloc] initWith:bind] autorelease];
}
-(id) initWith:(CCLayer*)bind
{
    if (self=[super init]) {
        CGSize screenSize=[[CCDirectorIOS sharedDirector] winSize];
        self.position= ccp(screenSize.width/2,screenSize.height/2);
        
        CCSprite* bg=[CCSprite spriteWithSpriteFrameName:@"bg_msg"];
        [self addChild:bg z:0];

        CCSprite* resume = [CCSprite spriteWithSpriteFrameName:@"button_play"];
        CCSprite* resumeSlct = [CCSprite spriteWithSpriteFrameName:@"button_play"];
        CCMenuItemSprite* resumeBtn = [CCMenuItemSprite itemWithNormalSprite:resume selectedSprite:resumeSlct target:bind selector:@selector(resumeGame)];
        
        CCSprite* backmenu = [CCSprite spriteWithSpriteFrameName:@"button_menu"];
        CCSprite* backmenuSlct = [CCSprite spriteWithSpriteFrameName:@"button_menu"];
        CCMenuItemSprite* backmenuBtn = [CCMenuItemSprite itemWithNormalSprite:backmenu selectedSprite:backmenuSlct target:bind selector:@selector(backToMenu)];
        CCMenu* menu= [CCMenu menuWithItems:resumeBtn, backmenuBtn,nil];
        [menu alignItemsHorizontallyWithPadding:30];
        menu.position = ccp(0,0);
        [self addChild:menu z:1];

    }
    return self;
}
@end
