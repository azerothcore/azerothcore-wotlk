/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef _GEOMETRY_H
#define _GEOMETRY_H

#include <cmath>
#include <iostream>
#include <cstdlib>

using namespace std;

inline float getAngle(float startX, float startY, float destX, float destY)
{
    auto dx = destX - startX;
    auto dy = destY - startY;

    auto ang = atan2(dy, dx);
    ang = (ang >= 0) ? ang : 2 * M_PI + ang;
    return ang;
}

inline float getSlopeAngle(float startX, float startY, float startZ, float destX, float destY, float destZ)
{
    float floorDist = sqrt(pow(startY - destY, 2.0f) + pow(startX - destX,2.0f));
    return atan(abs(destZ - startZ) / abs(floorDist));
}

inline float getSlopeAngleAbs(float startX, float startY, float startZ, float destX, float destY, float destZ)
{
    return abs(getSlopeAngle(startX, startY, startZ, destX, destY, destZ));
}

#endif
