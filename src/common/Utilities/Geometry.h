/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

/**
 *
 * Utility library to define some global function for geometric calculations
 *
 */

#ifndef _ACORE_GEOMETRY_H
#define _ACORE_GEOMETRY_H

#include "Define.h"
#include <cstdlib>
#include <iostream>
#include <math.h>

[[nodiscard]] inline float getAngle(float startX, float startY, float destX, float destY)
{
    auto dx = destX - startX;
    auto dy = destY - startY;

    auto ang = atan2(dy, dx);
    ang = (ang >= 0) ? ang : 2 * float(M_PI) + ang;
    return ang;
}

[[nodiscard]] inline float getSlopeAngle(float startX, float startY, float startZ, float destX, float destY, float destZ)
{
    float floorDist = sqrt(pow(startY - destY, 2.0f) + pow(startX - destX, 2.0f));
    return atan(abs(destZ - startZ) / abs(floorDist));
}

[[nodiscard]] inline float getSlopeAngleAbs(float startX, float startY, float startZ, float destX, float destY, float destZ)
{
    return abs(getSlopeAngle(startX, startY, startZ, destX, destY, destZ));
}

[[nodiscard]] inline double getCircleAreaByRadius(double radius)
{
    return radius * radius * M_PI;
}

[[nodiscard]] inline double getCirclePerimeterByRadius(double radius)
{
    return radius * M_PI;
}

[[nodiscard]] inline double getCylinderVolume(double height, double radius)
{
    return height * getCircleAreaByRadius(radius);
}

#endif // _ACORE_GEOMETRY_H
