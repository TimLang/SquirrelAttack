//
//  UILayer.m
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-31.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import "UILayer.h"


@implementation UILayer

+(id) nodeWith:(CCLayer*)bind
{
   return  [[[self alloc] initWithLayer:bind] autorelease];
}
-(id) initWithLayer:(CCLayer*)bind
{
    if(self = [super init])
    {
        isBeginCounting=NO;
        CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:@"button_pause"];
        CCSprite* selected=[CCSprite spriteWithSpriteFrameName:@"button_pause"];
        selected.scale = 1.1f;
        CCMenuItemSprite* pause = [CCMenuItemSprite itemWithNormalSprite:sprite selectedSprite:selected target:bind selector:@selector(pauseGame)];
        pause.position=ccp(30,290);
        CCSprite* reset = [CCSprite spriteWithSpriteFrameName:@"button_reset"];
        CCSprite* resetSlct = [CCSprite spriteWithSpriteFrameName:@"button_reset"];
        resetSlct.scale=1.1f;
        CCMenuItemSprite* resetBtn = [CCMenuItemSprite itemWithNormalSprite:reset selectedSprite:resetSlct target:bind selector:@selector(resetGame)];
        resetBtn.position=ccp(450,290);
        CCMenu* menu= [CCMenu menuWithItems:pause,resetBtn, nil];

        menu.position = ccp(0,0);
        [self addChild:menu z:0];
        

        [self scheduleUpdate];
    }
    return self;
}

    

@end
