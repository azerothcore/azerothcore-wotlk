/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef __AB_INFLECTION_POINT_SETTINGS_H
#define __AB_INFLECTION_POINT_SETTINGS_H

#include "DataMap.h"

class AutoBalanceInflectionPointSettings : public DataMap::Base
{
public:
    AutoBalanceInflectionPointSettings() {}
    AutoBalanceInflectionPointSettings(float value, float curveFloor, float curveCeiling) :
        value(value), curveFloor(curveFloor), curveCeiling(curveCeiling) {}

    float value        = 0.5;
    float curveFloor   = 0.0;
    float curveCeiling = 1.0;
};

#endif
