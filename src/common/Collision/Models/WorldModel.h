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

#ifndef _WORLDMODEL_H
#define _WORLDMODEL_H

#include "BoundingIntervalHierarchy.h"
#include "Define.h"
#include <G3D/AABox.h>
#include <G3D/Ray.h>
#include <G3D/Vector3.h>

namespace VMAP
{
    class TreeNode;
    struct AreaInfo;
    struct LocationInfo;
    enum class ModelIgnoreFlags : uint32;

    class MeshTriangle
    {
    public:
        MeshTriangle()  { }
        MeshTriangle(uint32 na, uint32 nb, uint32 nc): idx0(na), idx1(nb), idx2(nc) { }

        uint32 idx0{0};
        uint32 idx1{0};
        uint32 idx2{0};
    };

    class WmoLiquid
    {
    public:
        WmoLiquid(uint32 width, uint32 height, const G3D::Vector3& corner, uint32 type);
        WmoLiquid(const WmoLiquid& other);
        ~WmoLiquid();
        WmoLiquid& operator=(const WmoLiquid& other);
        bool GetLiquidHeight(const G3D::Vector3& pos, float& liqHeight) const;
        [[nodiscard]] uint32 GetType() const { return iType; }
        float* GetHeightStorage() { return iHeight; }
        uint8* GetFlagsStorage() { return iFlags; }
        uint32 GetFileSize();
        bool writeToFile(FILE* wf);
        static bool readFromFile(FILE* rf, WmoLiquid*& liquid);
        void GetPosInfo(uint32& tilesX, uint32& tilesY, G3D::Vector3& corner) const;
    private:
        WmoLiquid() { }
        uint32 iTilesX{0};       //!< number of tiles in x direction, each
        uint32 iTilesY{0};
        G3D::Vector3 iCorner;    //!< the lower corner
        uint32 iType{0};         //!< liquid type
        float* iHeight{nullptr}; //!< (tilesX + 1)*(tilesY + 1) height values
        uint8* iFlags{nullptr};  //!< info if liquid tile is used
    };

    /*! holding additional info for WMO group files */
    class GroupModel
    {
    public:
        GroupModel() { }
        GroupModel(const GroupModel& other);
        GroupModel(uint32 mogpFlags, uint32 groupWMOID, const G3D::AABox& bound):
            iBound(bound), iMogpFlags(mogpFlags), iGroupWMOID(groupWMOID), iLiquid(nullptr) { }
        ~GroupModel() { delete iLiquid; }

        //! pass mesh data to object and create BIH. Passed vectors get get swapped with old geometry!
        void setMeshData(std::vector<G3D::Vector3>& vert, std::vector<MeshTriangle>& tri);
        void setLiquidData(WmoLiquid*& liquid) { iLiquid = liquid; liquid = nullptr; }
        bool IntersectRay(const G3D::Ray& ray, float& distance, bool stopAtFirstHit) const;
        bool IsInsideObject(const G3D::Vector3& pos, const G3D::Vector3& down, float& z_dist) const;
        bool GetLiquidLevel(const G3D::Vector3& pos, float& liqHeight) const;
        [[nodiscard]] uint32 GetLiquidType() const;
        bool writeToFile(FILE* wf);
        bool readFromFile(FILE* rf);
        [[nodiscard]] const G3D::AABox& GetBound() const { return iBound; }
        [[nodiscard]] uint32 GetMogpFlags() const { return iMogpFlags; }
        [[nodiscard]] uint32 GetWmoID() const { return iGroupWMOID; }
        void GetMeshData(std::vector<G3D::Vector3>& outVertices, std::vector<MeshTriangle>& outTriangles, WmoLiquid*& liquid);
    protected:
        G3D::AABox iBound;
        uint32 iMogpFlags{0};// 0x8 outdor; 0x2000 indoor
        uint32 iGroupWMOID{0};
        std::vector<G3D::Vector3> vertices;
        std::vector<MeshTriangle> triangles;
        BIH meshTree;
        WmoLiquid* iLiquid{nullptr};
    };
    /*! Holds a model (converted M2 or WMO) in its original coordinate space */
    class WorldModel
    {
    public:
        WorldModel() { }

        //! pass group models to WorldModel and create BIH. Passed vector is swapped with old geometry!
        void setGroupModels(std::vector<GroupModel>& models);
        void setRootWmoID(uint32 id) { RootWMOID = id; }
        bool IntersectRay(const G3D::Ray& ray, float& distance, bool stopAtFirstHit, ModelIgnoreFlags ignoreFlags) const;
        bool IntersectPoint(const G3D::Vector3& p, const G3D::Vector3& down, float& dist, AreaInfo& info) const;
        bool GetLocationInfo(const G3D::Vector3& p, const G3D::Vector3& down, float& dist, LocationInfo& info) const;
        bool writeFile(const std::string& filename);
        bool readFile(const std::string& filename);
        void GetGroupModels(std::vector<GroupModel>& outGroupModels);
        uint32 Flags;
    protected:
        uint32 RootWMOID{0};
        std::vector<GroupModel> groupModels;
        BIH groupTree;
    };
} // namespace VMAP

#endif // _WORLDMODEL_H
