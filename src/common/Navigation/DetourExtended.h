/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

#ifndef _ACORE_DETOUR_EXTENDED_H
#define _ACORE_DETOUR_EXTENDED_H

#include "DetourNavMeshQuery.h"

class dtQueryFilterExt: public dtQueryFilter
{
public:
    float getCost(const float* pa, const float* pb,
        const dtPolyRef prevRef, const dtMeshTile* prevTile, const dtPoly* prevPoly,
        const dtPolyRef curRef, const dtMeshTile* curTile, const dtPoly* curPoly,
        const dtPolyRef nextRef, const dtMeshTile* nextTile, const dtPoly* nextPoly) const override;
};

#endif // _ACORE_DETOUR_EXTENDED_H
