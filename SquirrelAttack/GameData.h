//
//  GameData.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-31.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#ifndef SquirrelAttack_GameData_h
#define SquirrelAttack_GameData_h
class GameData
{
public:
    int bulletData;
    int enemyData;
    int star;
    GameData();
    GameData(int b,int e,int s);
    ~GameData();
};


#endif
