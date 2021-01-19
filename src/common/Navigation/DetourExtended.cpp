/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 */

#include "DetourExtended.h"
#include "DetourCommon.h"
#include "Geometry.h"


float dtQueryFilterExt::getCost(const float* pa, const float* pb,
                const dtPolyRef /*prevRef*/, const dtMeshTile* /*prevTile*/, const dtPoly* /*prevPoly*/,
                const dtPolyRef /*curRef*/, const dtMeshTile* /*curTile*/, const dtPoly* curPoly,
                const dtPolyRef /*nextRef*/, const dtMeshTile* /*nextTile*/, const dtPoly* /*nextPoly*/) const
{
  float startX=pa[2], startY=pa[0], startZ=pa[1];
  float destX=pb[2], destY=pb[0], destZ=pb[1];
  float slopeAngle = getSlopeAngle(startX, startY, startZ, destX, destY, destZ);
  float slopeAngleDegree = (slopeAngle * 180.0f / M_PI);
  float cost = slopeAngleDegree > 0 ? 1.0f + (1.0f * (slopeAngleDegree/100)) : 1.0f;
  float dist = dtVdist(pa, pb);
  auto totalCost = dist * cost * getAreaCost(curPoly->getArea());
  return totalCost;
}
