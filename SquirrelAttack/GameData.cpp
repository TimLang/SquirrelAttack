//
//  GameData.cpp
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-31.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#include "GameData.h"
GameData::GameData():bulletData(0),enemyData(0),star(0)
{
    
}
GameData::GameData(int b,int e,int s):bulletData(b),enemyData(e),star(s)
{
    
}
GameData::~GameData()
{
}