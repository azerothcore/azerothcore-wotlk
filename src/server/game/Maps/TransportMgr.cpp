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

#include "TransportMgr.h"
#include "InstanceScript.h"
#include "MapMgr.h"
#include "MoveSpline.h"
#include "QueryResult.h"
#include "Transport.h"

TransportTemplate::~TransportTemplate()
{
    // Collect shared pointers into a set to avoid deleting the same memory more than once
    std::set<TransportSpline*> splines;
    for (std::size_t i = 0; i < keyFrames.size(); ++i)
        splines.insert(keyFrames[i].Spline);

    for (std::set<TransportSpline*>::iterator itr = splines.begin(); itr != splines.end(); ++itr)
        delete *itr;
}

TransportMgr::TransportMgr() { }

TransportMgr::~TransportMgr() { }

TransportMgr* TransportMgr::instance()
{
    static TransportMgr instance;
    return &instance;
}

void TransportMgr::Unload()
{
    _transportTemplates.clear();
}

void TransportMgr::LoadTransportTemplates()
{
    uint32 oldMSTime = getMSTime();

    QueryResult result = WorldDatabase.Query("SELECT entry FROM gameobject_template WHERE type = 15 ORDER BY entry ASC");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 transport templates. DB table `gameobject_template` has no transports!");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();
        uint32 entry = fields[0].Get<uint32>();
        GameObjectTemplate const* goInfo = sObjectMgr->GetGameObjectTemplate(entry);
        if (!goInfo)
        {
            LOG_ERROR("entities.transport", "Transport {} has no associated GameObjectTemplate from `gameobject_template` , skipped.", entry);
            continue;
        }

        if (goInfo->moTransport.taxiPathId >= sTaxiPathNodesByPath.size())
        {
            LOG_ERROR("entities.transport", "Transport {} (name: {}) has an invalid path specified in `gameobject_template`.`data0` ({}) field, skipped.", entry, goInfo->name, goInfo->moTransport.taxiPathId);
            continue;
        }

        // paths are generated per template, saves us from generating it again in case of instanced transports
        TransportTemplate& transport = _transportTemplates[entry];
        transport.entry = entry;
        GeneratePath(goInfo, &transport);

        // transports in instance are only on one map
        if (transport.inInstance)
            _instanceTransports[*transport.mapsUsed.begin()].insert(entry);

        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} Transport Templates in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

class SplineRawInitializer
{
public:
    SplineRawInitializer(Movement::PointsArray& points) : _points(points) { }

    void operator()(uint8& mode, bool& cyclic, Movement::PointsArray& points, int& lo, int& hi) const
    {
        mode = Movement::SplineBase::ModeCatmullrom;
        cyclic = false;
        points.assign(_points.begin(), _points.end());
        lo = 1;
        hi = points.size() - 2;
    }

    Movement::PointsArray& _points;
};

void TransportMgr::GeneratePath(GameObjectTemplate const* goInfo, TransportTemplate* transport)
{
    uint32 pathId = goInfo->moTransport.taxiPathId;
    TaxiPathNodeList const& path = sTaxiPathNodesByPath[pathId];
    std::vector<KeyFrame>& keyFrames = transport->keyFrames;
    Movement::PointsArray splinePath, allPoints;
    bool mapChange = false;
    for (std::size_t i = 0; i < path.size(); ++i)
        allPoints.push_back(G3D::Vector3(path[i]->x, path[i]->y, path[i]->z));

    // Add extra points to allow derivative calculations for all path nodes
    allPoints.insert(allPoints.begin(), allPoints.front().lerp(allPoints[1], -0.2f));
    allPoints.push_back(allPoints.back().lerp(allPoints[allPoints.size() - 2], -0.2f));
    allPoints.push_back(allPoints.back().lerp(allPoints[allPoints.size() - 2], -1.0f));

    SplineRawInitializer initer(allPoints);
    TransportSpline orientationSpline;
    orientationSpline.init_spline_custom(initer);
    orientationSpline.initLengths();

    for (std::size_t i = 0; i < path.size(); ++i)
    {
        if (!mapChange)
        {
            TaxiPathNodeEntry const* node_i = path[i];
            if (i != path.size() - 1 && (node_i->actionFlag & 1 || node_i->mapid != path[i + 1]->mapid))
            {
                keyFrames.back().Teleport = true;
                mapChange = true;
            }
            else
            {
                KeyFrame k(node_i);
                G3D::Vector3 h;
                orientationSpline.evaluate_derivative(i + 1, 0.0f, h);
                k.InitialOrientation = Position::NormalizeOrientation(std::atan2(h.y, h.x) + M_PI);

                keyFrames.push_back(k);
                splinePath.push_back(G3D::Vector3(node_i->x, node_i->y, node_i->z));
                transport->mapsUsed.insert(k.Node->mapid);
            }
        }
        else
            mapChange = false;
    }

    if (splinePath.size() >= 2)
    {
        // Remove special catmull-rom spline points
        //if (!keyFrames.front().IsStopFrame() && !keyFrames.front().Node->arrivalEventID && !keyFrames.front().Node->departureEventID)
        {
            splinePath.erase(splinePath.begin());
            keyFrames.erase(keyFrames.begin());
        }
        //if (!keyFrames.back().IsStopFrame() && !keyFrames.back().Node->arrivalEventID && !keyFrames.back().Node->departureEventID)
        {
            splinePath.pop_back();
            keyFrames.pop_back();
        }
    }

    ASSERT(!keyFrames.empty());

    if (transport->mapsUsed.size() > 1)
    {
        for (std::set<uint32>::const_iterator itr = transport->mapsUsed.begin(); itr != transport->mapsUsed.end(); ++itr)
            ASSERT(!sMapStore.LookupEntry(*itr)->Instanceable());

        transport->inInstance = false;
    }
    else
        transport->inInstance = sMapStore.LookupEntry(*transport->mapsUsed.begin())->Instanceable();

    // last to first is always "teleport", even for closed paths
    keyFrames.back().Teleport = true;

    const float speed = float(goInfo->moTransport.moveSpeed);
    const float accel = float(goInfo->moTransport.accelRate);
    const float accel_dist = 0.5f * speed * speed / accel;

    transport->accelTime = speed / accel;
    transport->accelDist = accel_dist;

    int32 firstStop = -1;
    int32 lastStop = -1;

    // first cell is arrived at by teleportation :S
    keyFrames[0].DistFromPrev = 0;
    keyFrames[0].Index = 1;
    if (keyFrames[0].IsStopFrame())
    {
        firstStop = 0;
        lastStop = 0;
    }

    // find the rest of the distances between key points
    // Every path segment has its own spline
    std::size_t start = 0;
    for (std::size_t i = 1; i < keyFrames.size(); ++i)
    {
        if (keyFrames[i - 1].Teleport || i + 1 == keyFrames.size())
        {
            std::size_t extra = !keyFrames[i - 1].Teleport ? 1 : 0;
            TransportSpline* spline = new TransportSpline();
            spline->init_spline(&splinePath[start], i - start + extra, Movement::SplineBase::ModeCatmullrom);
            spline->initLengths();
            for (std::size_t j = start; j < i + extra; ++j)
            {
                keyFrames[j].Index = j - start + 1;
                keyFrames[j].DistFromPrev = spline->length(j - start, j + 1 - start);
                if (j > 0)
                    keyFrames[j - 1].NextDistFromPrev = keyFrames[j].DistFromPrev;
                keyFrames[j].Spline = spline;
            }

            if (keyFrames[i - 1].Teleport)
            {
                keyFrames[i].Index = i - start + 1;
                keyFrames[i].DistFromPrev = 0.0f;
                keyFrames[i - 1].NextDistFromPrev = 0.0f;
                keyFrames[i].Spline = spline;
            }

            start = i;
        }

        if (keyFrames[i].IsStopFrame())
        {
            // remember first stop frame
            if (firstStop == -1)
                firstStop = i;
            lastStop = i;
        }
    }

    keyFrames.back().NextDistFromPrev = keyFrames.front().DistFromPrev;

    if (firstStop == -1 || lastStop == -1)
        firstStop = lastStop = 0;

    // at stopping keyframes, we define distSinceStop == 0,
    // and distUntilStop is to the next stopping keyframe.
    // this is required to properly handle cases of two stopping frames in a row (yes they do exist)
    float tmpDist = 0.0f;
    for (std::size_t i = 0; i < keyFrames.size(); ++i)
    {
        int32 j = (i + lastStop) % keyFrames.size();
        if (keyFrames[j].IsStopFrame() || j == lastStop)
            tmpDist = 0.0f;
        else
            tmpDist += keyFrames[j].DistFromPrev;
        keyFrames[j].DistSinceStop = tmpDist;
    }

    tmpDist = 0.0f;
    for (int32 i = int32(keyFrames.size()) - 1; i >= 0; i--)
    {
        int32 j = (i + firstStop) % keyFrames.size();
        tmpDist += keyFrames[(j + 1) % keyFrames.size()].DistFromPrev;
        keyFrames[j].DistUntilStop = tmpDist;
        if (keyFrames[j].IsStopFrame() || j == firstStop)
            tmpDist = 0.0f;
    }

    for (std::size_t i = 0; i < keyFrames.size(); ++i)
    {
        float total_dist = keyFrames[i].DistSinceStop + keyFrames[i].DistUntilStop;
        if (total_dist < 2 * accel_dist) // won't reach full speed
        {
            if (keyFrames[i].DistSinceStop < keyFrames[i].DistUntilStop) // is still accelerating
            {
                // calculate accel+brake time for this short segment
                float segment_time = 2.0f * std::sqrt((keyFrames[i].DistUntilStop + keyFrames[i].DistSinceStop) / accel);
                // substract acceleration time
                keyFrames[i].TimeTo = segment_time - std::sqrt(2 * keyFrames[i].DistSinceStop / accel);
            }
            else // slowing down
                keyFrames[i].TimeTo = std::sqrt(2 * keyFrames[i].DistUntilStop / accel);
        }
        else if (keyFrames[i].DistSinceStop < accel_dist) // still accelerating (but will reach full speed)
        {
            // calculate accel + cruise + brake time for this long segment
            float segment_time = (keyFrames[i].DistUntilStop + keyFrames[i].DistSinceStop) / speed + (speed / accel);
            // substract acceleration time
            keyFrames[i].TimeTo = segment_time - std::sqrt(2 * keyFrames[i].DistSinceStop / accel);
        }
        else if (keyFrames[i].DistUntilStop < accel_dist) // already slowing down (but reached full speed)
            keyFrames[i].TimeTo = std::sqrt(2 * keyFrames[i].DistUntilStop / accel);
        else // at full speed
            keyFrames[i].TimeTo = (keyFrames[i].DistUntilStop / speed) + (0.5f * speed / accel);
    }

    // calculate tFrom times from tTo times
    float segmentTime = 0.0f;
    for (std::size_t i = 0; i < keyFrames.size(); ++i)
    {
        int32 j = (i + lastStop) % keyFrames.size();
        if (keyFrames[j].IsStopFrame() || j == lastStop)
            segmentTime = keyFrames[j].TimeTo;
        keyFrames[j].TimeFrom = segmentTime - keyFrames[j].TimeTo;
    }

    // calculate path times
    keyFrames[0].ArriveTime = 0;
    float curPathTime = 0.0f;
    if (keyFrames[0].IsStopFrame())
    {
        curPathTime = float(keyFrames[0].Node->delay);
        keyFrames[0].DepartureTime = uint32(curPathTime * IN_MILLISECONDS);
    }

    for (std::size_t i = 1; i < keyFrames.size(); ++i)
    {
        curPathTime += keyFrames[i - 1].TimeTo;
        if (keyFrames[i].IsStopFrame())
        {
            keyFrames[i].ArriveTime = uint32(curPathTime * IN_MILLISECONDS);
            keyFrames[i - 1].NextArriveTime = keyFrames[i].ArriveTime;
            curPathTime += float(keyFrames[i].Node->delay);
            keyFrames[i].DepartureTime = uint32(curPathTime * IN_MILLISECONDS);
        }
        else
        {
            curPathTime -= keyFrames[i].TimeTo;
            keyFrames[i].ArriveTime = uint32(curPathTime * IN_MILLISECONDS);
            keyFrames[i - 1].NextArriveTime = keyFrames[i].ArriveTime;
            keyFrames[i].DepartureTime = keyFrames[i].ArriveTime;
        }
    }

    keyFrames.back().NextArriveTime = keyFrames.back().DepartureTime;

    transport->pathTime = keyFrames.back().DepartureTime;
}

void TransportMgr::AddPathNodeToTransport(uint32 transportEntry, uint32 timeSeg, TransportAnimationEntry const* node)
{
    TransportAnimation& animNode = _transportAnimations[transportEntry];
    if (animNode.TotalTime < timeSeg)
        animNode.TotalTime = timeSeg;

    animNode.Path[timeSeg] = node;
}

MotionTransport* TransportMgr::CreateTransport(uint32 entry, ObjectGuid::LowType guid /*= 0*/, Map* map /*= nullptr*/)
{
    // instance case, execute GetGameObjectEntry hook
    if (map)
    {
        // SetZoneScript() is called after adding to map, so fetch the script using map
        if (map->IsDungeon())
            if (InstanceScript* instance = static_cast<InstanceMap*>(map)->GetInstanceScript())
                entry = instance->GetGameObjectEntry(0, entry);

        if (!entry)
            return nullptr;
    }

    TransportTemplate const* tInfo = GetTransportTemplate(entry);
    if (!tInfo)
    {
        LOG_ERROR("entities.transport", "Transport {} will not be loaded, `transport_template` missing", entry);
        return nullptr;
    }

    // create transport...
    MotionTransport* trans = new MotionTransport();

    // ...at first waypoint
    TaxiPathNodeEntry const* startNode = tInfo->keyFrames.begin()->Node;
    uint32 mapId = startNode->mapid;
    float x = startNode->x;
    float y = startNode->y;
    float z = startNode->z;
    float o = tInfo->keyFrames.begin()->InitialOrientation;

    // initialize the gameobject base
    ObjectGuid::LowType guidLow = guid ? guid : sObjectMgr->GetGenerator<HighGuid::Mo_Transport>().Generate();

    if (!trans->CreateMoTrans(guidLow, entry, mapId, x, y, z, o, 255))
    {
        delete trans;
        return nullptr;
    }

    if (MapEntry const* mapEntry = sMapStore.LookupEntry(mapId))
    {
        if (mapEntry->Instanceable() != tInfo->inInstance)
        {
            LOG_ERROR("entities.transport", "Transport {} (name: {}) attempted creation in instance map (id: {}) but it is not an instanced transport!", entry, trans->GetName(), mapId);
            delete trans;
            return nullptr;
        }
    }

    // use preset map for instances (need to know which instance)
    trans->SetMap(map ? map : sMapMgr->CreateMap(mapId, nullptr));
    if (map && map->IsDungeon())
        trans->m_zoneScript = map->ToInstanceMap()->GetInstanceScript();

    // xinef: transports are active so passengers can be relocated (grids must be loaded)
    trans->setActive(true);
    HashMapHolder<MotionTransport>::Insert(trans);
    trans->GetMap()->AddToMap<MotionTransport>(trans);
    return trans;
}

void TransportMgr::SpawnContinentTransports()
{
    if (_transportTemplates.empty())
        return;

    uint32 count = 0;
    uint32 oldMSTime = getMSTime();
    QueryResult result = WorldDatabase.Query("SELECT guid, entry FROM transports");

    if (sWorld->getBoolConfig(CONFIG_ENABLE_CONTINENT_TRANSPORT))
    {

        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                ObjectGuid::LowType guid = fields[0].Get<uint32>();
                uint32 entry = fields[1].Get<uint32>();

                if (TransportTemplate const* tInfo = GetTransportTemplate(entry))
                    if (!tInfo->inInstance)
                        if (CreateTransport(entry, guid))
                            ++count;

            } while (result->NextRow());
        }

        LOG_INFO("server.loading", ">> Spawned {} continent motion transports in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    }

    if (sWorld->getBoolConfig(CONFIG_ENABLE_CONTINENT_TRANSPORT_PRELOADING))
    {
        // pussywizard: preload grids for continent static transports
        QueryResult result2 = WorldDatabase.Query("SELECT map, position_x, position_y FROM gameobject g JOIN gameobject_template t ON g.id = t.entry WHERE t.type = 11");

        if (result2)
        {
            do
            {
                Field* fields = result2->Fetch();
                uint16 mapId = fields[0].Get<uint16>();
                float x = fields[1].Get<float>();
                float y = fields[2].Get<float>();

                MapEntry const* mapEntry = sMapStore.LookupEntry(mapId);
                if (mapEntry && !mapEntry->Instanceable())
                    if (Map* map = sMapMgr->CreateBaseMap(mapId))
                    {
                        map->LoadGrid(x, y);
                        ++count;
                    }
            } while (result2->NextRow());
        }

        LOG_INFO("server.loading", ">> Preloaded grids for {} continent static transports in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    }
}

void TransportMgr::CreateInstanceTransports(Map* map)
{
    TransportInstanceMap::const_iterator mapTransports = _instanceTransports.find(map->GetId());

    // no transports here
    if (mapTransports == _instanceTransports.end() || mapTransports->second.empty())
        return;

    // create transports
    for (std::set<uint32>::const_iterator itr = mapTransports->second.begin(); itr != mapTransports->second.end(); ++itr)
        CreateTransport(*itr, 0, map);
}

bool TransportAnimation::GetAnimNode(uint32 time, TransportAnimationEntry const*& curr, TransportAnimationEntry const*& next, float& percPos) const
{
    if (Path.empty())
        return false;

    for (TransportPathContainer::const_reverse_iterator itr = Path.rbegin(); itr != Path.rend(); ++itr)
        if (time >= itr->first)
        {
            curr = itr->second;
            ASSERT(itr != Path.rbegin());
            --itr;
            next = itr->second;
            percPos = float(time - curr->TimeSeg) / float(next->TimeSeg - curr->TimeSeg);
            return true;
        }

    return false;
}

void TransportAnimation::GetAnimRotation(uint32 time, G3D::Quat& curr, G3D::Quat& next, float& percRot) const
{
    if (Rotations.empty())
    {
        curr = G3D::Quat(0.0f, 0.0f, 0.0f, 1.0f);
        next = G3D::Quat(0.0f, 0.0f, 0.0f, 1.0f);
        percRot = 0.0f;
        return;
    }

    for (TransportPathRotationContainer::const_reverse_iterator itr = Rotations.rbegin(); itr != Rotations.rend(); ++itr)
        if (time >= itr->first)
        {
            uint32 currSeg = itr->second->TimeSeg, nextSeg;
            curr = G3D::Quat(itr->second->X, itr->second->Y, itr->second->Z, itr->second->W);
            if (itr != Rotations.rbegin())
            {
                --itr;
                next = G3D::Quat(itr->second->X, itr->second->Y, itr->second->Z, itr->second->W);
                nextSeg = itr->second->TimeSeg;
            }
            else
            {
                next = G3D::Quat(Rotations.begin()->second->X, Rotations.begin()->second->Y, Rotations.begin()->second->Z, Rotations.begin()->second->W);
                nextSeg = this->TotalTime;
            }
            percRot = float(time - currSeg) / float(nextSeg - currSeg);
            return;
        }

    curr = G3D::Quat(0.0f, 0.0f, 0.0f, 1.0f);
    next = G3D::Quat(0.0f, 0.0f, 0.0f, 1.0f);
    percRot = 0.0f;
}
