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
}

class GameObject;
struct GameObjectDisplayInfoEntry;

class GameObjectModelOwnerBase
{
public:
    virtual ~GameObjectModelOwnerBase() = default;

    [[nodiscard]] virtual auto IsSpawned() const -> bool = 0;
    [[nodiscard]] virtual auto GetDisplayId() const -> uint32 = 0;
    [[nodiscard]] virtual auto GetPhaseMask() const -> uint32 = 0;
    [[nodiscard]] virtual auto GetPosition() const -> G3D::Vector3 = 0;
    [[nodiscard]] virtual auto GetOrientation() const -> float = 0;
    [[nodiscard]] virtual auto GetScale() const -> float = 0;
    virtual void DebugVisualizeCorner(G3D::Vector3 const& /*corner*/) const = 0;
};

class GameObjectModel
{
    GameObjectModel()  = default;

public:
    std::string name;

    [[nodiscard]] auto GetBounds() const -> const G3D::AABox& { return iBound; }

    ~GameObjectModel();

    [[nodiscard]] auto GetPosition() const -> const G3D::Vector3& { return iPos; }

    /** Enables\disables collision. */
    void disable() { phasemask = 0; }
    void enable(uint32 ph_mask) { phasemask = ph_mask; }

    [[nodiscard]] auto isEnabled() const -> bool { return phasemask != 0; }
    [[nodiscard]] auto IsMapObject() const -> bool { return isWmo; }

    auto intersectRay(const G3D::Ray& Ray, float& MaxDist, bool StopAtFirstHit, uint32 ph_mask) const -> bool;
    void IntersectPoint(G3D::Vector3 const& point, VMAP::AreaInfo& info, uint32 ph_mask) const;
    auto GetLocationInfo(G3D::Vector3 const& point, VMAP::LocationInfo& info, uint32 ph_mask) const -> bool;
    auto GetLiquidLevel(G3D::Vector3 const& point, VMAP::LocationInfo& info, float& liqHeight) const -> bool;

    static auto Create(std::unique_ptr<GameObjectModelOwnerBase> modelOwner, std::string const& dataPath) -> GameObjectModel*;

    auto UpdatePosition() -> bool;

private:
    auto initialize(std::unique_ptr<GameObjectModelOwnerBase> modelOwner, std::string const& dataPath) -> bool;

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
