//
//  ContactListener.cpp
//  SquirrelAttack
//
//  Created by BulletHermit on 13-1-28.
//  Copyright (c) 2013年 Nothing. All rights reserved.
//

#include "ContactListener.h"
#import <Foundation/Foundation.h>
#include <iostream>
ContactListener::ContactListener()
{
    this->isBegin=false;
    this->goal=1;
}
ContactListener::~ContactListener()
{}
void ContactListener::BeginContact(b2Contact* contact)
{}
void ContactListener::EndContact(b2Contact* contact)
{}
void ContactListener::PreSolve(b2Contact* contact, const b2Manifold* impulse)
{
}
void ContactListener::PostSolve(b2Contact* contact, const b2ContactImpulse* impulse)
{

    if (!isBegin) {
        return;
    }
    bool isEnemyA = contact->GetFixtureA()->GetUserData()!=NULL;
    
    bool isEnemyB = contact->GetFixtureB()->GetUserData()!=NULL;
    if (isEnemyA || isEnemyB) {
        int count = contact->GetManifold()->pointCount;
        float32 imp=0.0f;
        for (int i=0; i!=count; ++i) {
            imp = b2Max(imp,impulse->normalImpulses[i]);
        }
        if (imp>1.0f) {
            if (isEnemyA) {
                contacts.insert(contact->GetFixtureA()->GetBody());
                this->goal--;
            }
            if (isEnemyB) {
                contacts.insert(contact->GetFixtureB()->GetBody());
                this->goal--;
            }
        }
    }

    
}