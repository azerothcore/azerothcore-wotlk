/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

/**
 *
 * Utility library to define some global function for simple physics calculations
 *
 */

#ifndef _ACORE_PHYSICS_H
#define _ACORE_PHYSICS_H

#include "Geometry.h"
#include <cmath>
#include <cstdlib>
#include <iostream>

using namespace std;

[[nodiscard]] inline float getWeight(float height, float width, float specificWeight)
{
    auto volume = getCylinderVolume(height, width / 2.0f);
    auto weight = volume * specificWeight;
    return weight;
}

/**
 * @brief Get the height immersed in water
 *
 * @param height
 * @param width
 * @param weight specific weight
 * @return float
 */
[[nodiscard]] inline float getOutOfWater(float width, float weight, float density)
{
    auto baseArea = getCircleAreaByRadius(width / 2.0f);
    return weight / (baseArea * density);
}

#endif // _ACORE_PHYSICS_H
