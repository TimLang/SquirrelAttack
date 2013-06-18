//
//  UILayer.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-31.
//  Copyright 2013年 Nothing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UILayer : CCLayer {
    BOOL isBeginCounting;
}

+(id) nodeWith:(CCLayer*)bind;

@end
