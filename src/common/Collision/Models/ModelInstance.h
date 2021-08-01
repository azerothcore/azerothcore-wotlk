/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _MODELINSTANCE_H_
#define _MODELINSTANCE_H_

#include "Define.h"
#include <G3D/AABox.h>
#include <G3D/Matrix3.h>
#include <G3D/Ray.h>
#include <G3D/Vector3.h>

namespace VMAP
{
    class WorldModel;
    struct AreaInfo;
    struct LocationInfo;

    enum ModelFlags
    {
        MOD_M2 = 1,
        MOD_WORLDSPAWN = 1 << 1,
        MOD_HAS_BOUND = 1 << 2
    };

    class ModelSpawn
    {
    public:
        //mapID, tileX, tileY, Flags, ID, Pos, Rot, Scale, Bound_lo, Bound_hi, name
        uint32 flags;
        uint16 adtId;
        uint32 ID;
        G3D::Vector3 iPos;
        G3D::Vector3 iRot;
        float iScale;
        G3D::AABox iBound;
        std::string name;
        bool operator==(const ModelSpawn& other) const { return ID == other.ID; }
        //uint32 hashCode() const { return ID; }
        // temp?
        [[nodiscard]] const G3D::AABox& GetBounds() const { return iBound; }

        static bool readFromFile(FILE* rf, ModelSpawn& spawn);
        static bool writeToFile(FILE* rw, const ModelSpawn& spawn);
    };

    class ModelInstance: public ModelSpawn
    {
    public:
        ModelInstance() { }
        ModelInstance(const ModelSpawn& spawn, WorldModel* model);
        void setUnloaded() { iModel = nullptr; }
        bool intersectRay(const G3D::Ray& pRay, float& pMaxDist, bool StopAtFirstHit) const;
        void intersectPoint(const G3D::Vector3& p, AreaInfo& info) const;
        bool GetLocationInfo(const G3D::Vector3& p, LocationInfo& info) const;
        bool GetLiquidLevel(const G3D::Vector3& p, LocationInfo& info, float& liqHeight) const;
        WorldModel* getWorldModel() { return iModel; }
    protected:
        G3D::Matrix3 iInvRot;
        float iInvScale{0.0f};
        WorldModel* iModel{nullptr};
    };
} // namespace VMAP

#endif // _MODELINSTANCE
