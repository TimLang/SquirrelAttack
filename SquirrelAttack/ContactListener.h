//
//  ContactListener.h
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-28.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#ifndef SquirrelAttack_ContactListener_h
#define SquirrelAttack_ContactListener_h
#import "Box2D.h"
#import <set>
#import <algorithm>
class ContactListener: public b2ContactListener
{
public:
   ContactListener();
    ~ContactListener();
    std::set<b2Body*> contacts;
    bool isBegin;
    int goal;
    virtual void BeginContact(b2Contact* contact) ;
	virtual void EndContact(b2Contact* contact) ;
	virtual void PreSolve(b2Contact* contact, const b2Manifold* oldManifold);
	virtual void PostSolve(b2Contact* contact, const b2ContactImpulse* impulse);
};


#endif
