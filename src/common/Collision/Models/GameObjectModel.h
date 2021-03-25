/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _GAMEOBJECT_MODEL_H
#define _GAMEOBJECT_MODEL_H

#include <G3D/Matrix3.h>
#include <G3D/Vector3.h>
#include <G3D/AABox.h>
#include <G3D/Ray.h>

#include "Define.h"

namespace VMAP
{
    class WorldModel;
}

class GameObject;
struct GameObjectDisplayInfoEntry;

class GameObjectModel /*, public Intersectable*/
{
    uint32 phasemask{0};
    G3D::AABox iBound;
    G3D::Matrix3 iInvRot;
    G3D::Vector3 iPos;
    //G3D::Vector3 iRot;
    float iInvScale{0};
    float iScale{0};
    VMAP::WorldModel* iModel;
    GameObject const* owner;

    GameObjectModel() :  iModel(nullptr), owner(nullptr) { }
    bool initialize(const GameObject& go, const GameObjectDisplayInfoEntry& info);

public:
    std::string name;

    [[nodiscard]] const G3D::AABox& getBounds() const { return iBound; }

    ~GameObjectModel();

    [[nodiscard]] const G3D::Vector3& getPosition() const { return iPos;}

    /**    Enables\disables collision. */
    void disable() { phasemask = 0;}
    void enable(uint32 ph_mask) { phasemask = ph_mask;}

    [[nodiscard]] bool isEnabled() const {return phasemask != 0;}

    bool intersectRay(const G3D::Ray& Ray, float& MaxDist, bool StopAtFirstHit, uint32 ph_mask) const;

    static GameObjectModel* Create(const GameObject& go);

    bool UpdatePosition();
};

#endif // _GAMEOBJECT_MODEL_H