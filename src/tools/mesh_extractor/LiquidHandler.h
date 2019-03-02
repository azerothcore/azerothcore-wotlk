/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef LIQUID_H
#define LIQUID_H
#include "ADT.h"
#include "Utils.h"
#include "Define.h"

#include <vector>

class LiquidHandler
{
public:
    LiquidHandler(ADT* adt);

    ADT* Source;
    std::vector<Vector3> Vertices;
    std::vector<Triangle<uint32> > Triangles;
    std::vector<MCNKLiquidData> MCNKData;
private:
    void HandleNewLiquid();
};
#endif