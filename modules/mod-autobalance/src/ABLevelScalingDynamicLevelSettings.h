/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_LEVEL_SCALING_DYNAMIC_LEVEL_SETTINGS_H
#define __AB_LEVEL_SCALING_DYNAMIC_LEVEL_SETTINGS_H

#include "DataMap.h"

class AutoBalanceLevelScalingDynamicLevelSettings : public DataMap::Base
{
public:
    AutoBalanceLevelScalingDynamicLevelSettings() {}
    AutoBalanceLevelScalingDynamicLevelSettings(int skipHigher, int skipLower, int ceiling, int floor) :
        skipHigher(skipHigher), skipLower(skipLower), ceiling(ceiling), floor(floor) {}

    int skipHigher = 0;
    int skipLower  = 0;
    int ceiling    = 1;
    int floor      = 1;
};

#endif
