/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 */

#ifndef _ACORE_DETOUR_EXTENDED_H
#define _ACORE_DETOUR_EXTENDED_H

#include "DetourNavMeshQuery.h"

class dtQueryFilterExt: public dtQueryFilter
{
	float m_areaCost[DT_MAX_AREAS];		///< Cost per area type. (Used by default implementation.)
	unsigned short m_includeFlags;		///< Flags for polygons that can be visited. (Used by default implementation.)
	unsigned short m_excludeFlags;		///< Flags for polygons that should not be visted. (Used by default implementation.)

    public: 
	    dtQueryFilterExt();

        bool passFilter(const dtPolyRef ref,
                        const dtMeshTile* tile,
                        const dtPoly* poly) const override;

        float getCost(const float* pa, const float* pb,
                    const dtPolyRef prevRef, const dtMeshTile* prevTile, const dtPoly* prevPoly,
                    const dtPolyRef curRef, const dtMeshTile* curTile, const dtPoly* curPoly,
                    const dtPolyRef nextRef, const dtMeshTile* nextTile, const dtPoly* nextPoly) const override;
};

#endif // _ACORE_DETOUR_EXTENDED_H
