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

#include "ObjectGridLoader.h"
#include "CellImpl.h"
#include "Corpse.h"
#include "Creature.h"
#include "DynamicObject.h"
#include "GameObject.h"
#include "GridNotifiers.h"
#include "Transport.h"

template <class T>
void ObjectGridLoader::AddObjectHelper(Map* map, T* obj)
{
    CellCoord cellCoord = Acore::ComputeCellCoord(obj->GetPositionX(), obj->GetPositionY());
    Cell cell(cellCoord);

    map->AddToGrid(obj, cell);
    obj->AddToWorld();
    if (obj->isActiveObject())
        map->AddToActive(obj);
}

void ObjectGridLoader::LoadCreatures(CellGuidSet const& guid_set, Map* map)
{
    for (CellGuidSet::const_iterator i_guid = guid_set.begin(); i_guid != guid_set.end(); ++i_guid)
    {
        Creature* obj = new Creature();
        ObjectGuid::LowType guid = *i_guid;
        if (!obj->LoadFromDB(guid, map))
        {
            delete obj;
            continue;
        }

        AddObjectHelper<Creature>(map, obj);

        if (!obj->IsMoveInLineOfSightDisabled() && obj->GetDefaultMovementType() == IDLE_MOTION_TYPE && !obj->isNeedNotify(NOTIFY_VISIBILITY_CHANGED | NOTIFY_AI_RELOCATION))
        {
            if (obj->IsAlive() && !obj->HasUnitState(UNIT_STATE_SIGHTLESS) && obj->HasReactState(REACT_AGGRESSIVE) && !obj->IsImmuneToNPC())
            {
                // call MoveInLineOfSight for nearby grid creatures
                Acore::AIRelocationNotifier notifier(*obj);
                Cell::VisitGridObjects(obj, notifier, 60.f);
            }
        }
    }
}

void ObjectGridLoader::LoadGameObjects(CellGuidSet const& guid_set, Map* map)
{
    for (CellGuidSet::const_iterator i_guid = guid_set.begin(); i_guid != guid_set.end(); ++i_guid)
    {
        ObjectGuid::LowType guid = *i_guid;
        GameObjectData const* data = sObjectMgr->GetGameObjectData(guid);
        GameObject* obj = data && sObjectMgr->IsGameObjectStaticTransport(data->id) ? new StaticTransport() : new GameObject();

        if (!obj->LoadFromDB(guid, map))
        {
            delete obj;
            continue;
        }

        AddObjectHelper<GameObject>(map, obj);
    }
}

void ObjectGridLoader::LoadAllCellsInGrid()
{
    CellObjectGuids const& cell_guids = sObjectMgr->GetGridObjectGuids(i_map->GetId(), i_map->GetSpawnMode(), i_grid.GetGridId());
    LoadGameObjects(cell_guids.gameobjects, i_map);
    LoadCreatures(cell_guids.creatures, i_map);

    if (std::unordered_set<Corpse*> const* corpses = i_map->GetCorpsesInCell(i_grid.GetGridId()))
    {
        for (Corpse* corpse : *corpses)
        {
            if (corpse->IsInGrid())
                continue;

            CellCoord cellCoord = Acore::ComputeCellCoord(corpse->GetPositionX(), corpse->GetPositionY());
            Cell cell(cellCoord);

            if (corpse->IsWorldObject())
                i_grid.AddWorldObject(cell.CellX(), cell.CellY(), corpse);
            else
                i_grid.AddGridObject(cell.CellX(), cell.CellY(), corpse);
        }
    }
}

template<class T>
void ObjectGridUnloader::Visit(GridRefMgr<T>& m)
{
    while (!m.IsEmpty())
    {
        T* obj = m.getFirst()->GetSource();
        // if option set then object already saved at this moment
        //if (!sWorld->getBoolConfig(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY))
        //    obj->SaveRespawnTime();
        //Some creatures may summon other temp summons in CleanupsBeforeDelete()
        //So we need this even after cleaner (maybe we can remove cleaner)
        //Example: Flame Leviathan Turret 33139 is summoned when a creature is deleted
        //TODO: Check if that script has the correct logic. Do we really need to summons something before deleting?
        obj->CleanupsBeforeDelete();
        ///- object will get delinked from the manager when deleted
        delete obj;
    }
}

template<class T>
void ObjectGridCleaner::Visit(GridRefMgr<T>& m)
{
    for (typename GridRefMgr<T>::iterator iter = m.begin(); iter != m.end(); ++iter)
        iter->GetSource()->CleanupsBeforeDelete();
}

template void ObjectGridUnloader::Visit(CreatureMapType&);
template void ObjectGridUnloader::Visit(GameObjectMapType&);
template void ObjectGridUnloader::Visit(DynamicObjectMapType&);

template void ObjectGridCleaner::Visit(CreatureMapType&);
template void ObjectGridCleaner::Visit<GameObject>(GameObjectMapType&);
template void ObjectGridCleaner::Visit<DynamicObject>(DynamicObjectMapType&);
template void ObjectGridCleaner::Visit<Corpse>(CorpseMapType&);
