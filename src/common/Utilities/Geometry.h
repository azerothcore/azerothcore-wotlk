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
    auto a = (startX * destX + startY * destY + startZ * destZ);
    auto b = sqrt(pow(startX,2.0f) + pow(startY,2.0f) + pow(startZ, 2.0f));
    auto c = sqrt(pow(destX,2.0f) + pow(destY,2.0f) + pow(destZ, 2.0f));

    auto ang = acos(a / (b * c));

    if (isnan(ang))
    {
        return 0.0f;
    }

    return ang;
}

inline float getSlopeAngleAbs(float startX, float startY, float startZ, float destX, float destY, float destZ)
{
    return abs(getSlopeAngle(startX, startY, startZ, destX, destY, destZ));
}

#endif
