/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_MODULE_STAT_MODIFIERS_H
#define __AB_MODULE_STAT_MODIFIERS_H

#include "DataMap.h"

class AutoBalanceStatModifiers : public DataMap::Base
{
public:
    AutoBalanceStatModifiers() {}
    AutoBalanceStatModifiers(float global, float health, float mana, float armor, float damage, float ccduration) :
        global(global), health(health), mana(mana), armor(armor), damage(damage), ccduration(ccduration) {}

    float global     = 1.0;
    float health     = 1.0;
    float mana       = 1.0;
    float armor      = 1.0;
    float damage     = 1.0;
    float ccduration = 1.0;
};

#endif
