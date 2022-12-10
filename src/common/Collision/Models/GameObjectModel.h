/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _GAMEOBJECT_MODEL_H
#define _GAMEOBJECT_MODEL_H

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
    enum class ModelIgnoreFlags : uint32;
}

class GameObject;
struct GameObjectDisplayInfoEntry;

class GameObjectModelOwnerBase
{
public:
    virtual ~GameObjectModelOwnerBase() = default;

    [[nodiscard]] virtual bool IsSpawned() const = 0;
    [[nodiscard]] virtual uint32 GetDisplayId() const = 0;
    [[nodiscard]] virtual uint32 GetPhaseMask() const = 0;
    [[nodiscard]] virtual G3D::Vector3 GetPosition() const = 0;
    [[nodiscard]] virtual float GetOrientation() const = 0;
    [[nodiscard]] virtual float GetScale() const = 0;
    virtual void DebugVisualizeCorner(G3D::Vector3 const& /*corner*/) const = 0;
};

class GameObjectModel
{
    GameObjectModel()  = default;

public:
    std::string name;

    [[nodiscard]] const G3D::AABox& GetBounds() const { return iBound; }

    ~GameObjectModel();

    [[nodiscard]] const G3D::Vector3& GetPosition() const { return iPos; }

    /** Enables\disables collision. */
    void disable() { phasemask = 0; }
    void enable(uint32 ph_mask) { phasemask = ph_mask; }

    [[nodiscard]] bool isEnabled() const { return phasemask != 0; }
    [[nodiscard]] bool IsMapObject() const { return isWmo; }

    bool intersectRay(const G3D::Ray& Ray, float& MaxDist, bool StopAtFirstHit, uint32 ph_mask, VMAP::ModelIgnoreFlags ignoreFlags) const;
    void IntersectPoint(G3D::Vector3 const& point, VMAP::AreaInfo& info, uint32 ph_mask) const;
    bool GetLocationInfo(G3D::Vector3 const& point, VMAP::LocationInfo& info, uint32 ph_mask) const;
    bool GetLiquidLevel(G3D::Vector3 const& point, VMAP::LocationInfo& info, float& liqHeight) const;

    static GameObjectModel* Create(std::unique_ptr<GameObjectModelOwnerBase> modelOwner, std::string const& dataPath);

    bool UpdatePosition();

private:
    bool initialize(std::unique_ptr<GameObjectModelOwnerBase> modelOwner, std::string const& dataPath);

    uint32 phasemask{0};
    G3D::AABox iBound;
    G3D::Matrix3 iInvRot;
    G3D::Vector3 iPos;
    float iInvScale{0};
    float iScale{0};
    VMAP::WorldModel* iModel{nullptr};
    std::unique_ptr<GameObjectModelOwnerBase> owner;
    bool isWmo{false};
};

void LoadGameObjectModelList(std::string const& dataPath);

#endif // _GAMEOBJECT_MODEL_H
