//
//  WelcomeUI.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-2-10.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WelcomeUI : CCLayer {
    CCSprite* spriteStart;
    CCSprite* spriteStarted;
}
+(id) scene;
@end
