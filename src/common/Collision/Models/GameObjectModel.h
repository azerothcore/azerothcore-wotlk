/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _GAMEOBJECT_MODEL_H
#define _GAMEOBJECT_MODEL_H

#include "Define.h"
#include <G3D/Matrix3.h>
#include <G3D/Vector3.h>
#include <G3D/AABox.h>
#include <G3D/Ray.h>

namespace VMAP
{
    class WorldModel;
}

class GameObject;
struct GameObjectDisplayInfoEntry;

class GameObjectModelOwnerBase
{
public:
    virtual ~GameObjectModelOwnerBase() = default;

    virtual bool IsSpawned() const = 0;
    virtual uint32 GetDisplayId() const = 0;
    virtual uint32 GetPhaseMask() const = 0;
    virtual G3D::Vector3 GetPosition() const = 0;
    virtual float GetOrientation() const = 0;
    virtual float GetScale() const = 0;
    virtual void DebugVisualizeCorner(G3D::Vector3 const& /*corner*/) const = 0;
};

class GameObjectModel
{
    GameObjectModel() : phasemask(0), iInvScale(0), iScale(0), iModel(nullptr) { }

public:
    std::string name;

    [[nodiscard]] const G3D::AABox& getBounds() const { return iBound; }

    ~GameObjectModel();

    [[nodiscard]] const G3D::Vector3& getPosition() const { return iPos; }

    /** Enables\disables collision. */
    void disable() { phasemask = 0; }
    void enable(uint32 ph_mask) { phasemask = ph_mask; }

    [[nodiscard]] bool isEnabled() const { return phasemask != 0; }

    bool intersectRay(const G3D::Ray& Ray, float& MaxDist, bool StopAtFirstHit, uint32 ph_mask) const;

    static GameObjectModel* Create(std::unique_ptr<GameObjectModelOwnerBase> modelOwner, std::string const& dataPath);

    bool UpdatePosition();

private:
    bool initialize(std::unique_ptr<GameObjectModelOwnerBase> modelOwner, std::string const& dataPath);

    uint32 phasemask;
    G3D::AABox iBound;
    G3D::Matrix3 iInvRot;
    G3D::Vector3 iPos;
    float iInvScale;
    float iScale;
    VMAP::WorldModel* iModel;
    std::unique_ptr<GameObjectModelOwnerBase> owner;
};

void LoadGameObjectModelList(std::string const& dataPath);

#endif // _GAMEOBJECT_MODEL_H
