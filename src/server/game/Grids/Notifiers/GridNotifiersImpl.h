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

#ifndef ACORE_GRIDNOTIFIERSIMPL_H
#define ACORE_GRIDNOTIFIERSIMPL_H

#include "Corpse.h"
#include "CreatureAI.h"
#include "GridNotifiers.h"
#include "Object.h"
#include "Opcodes.h"
#include "Player.h"
#include "SpellAuras.h"
#include "UpdateData.h"
#include "WorldPacket.h"
#include "WorldSession.h"

template<class T>
inline void Acore::VisibleNotifier::Visit(GridRefMgr<T>& m)
{
    // Xinef: Update gameobjects only
    if (i_gobjOnly)
    {
        return;
    }

    for (typename GridRefMgr<T>::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        if (i_largeOnly != iter->GetSource()->IsVisibilityOverridden())
        {
            continue;
        }

        vis_guids.erase(iter->GetSource()->GetGUID());
        i_player.UpdateVisibilityOf(iter->GetSource(), i_data, i_visibleNow);
    }
}

// SEARCHERS & LIST SEARCHERS & WORKERS

// WorldObject searchers & workers

template<class Check>
void Acore::WorldObjectSearcher<Check>::Visit(GameObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
    {
        return;
    }

    // already found
    if (i_object)
    {
        return;
    }

    for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::WorldObjectSearcher<Check>::Visit(PlayerMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
    {
        return;
    }

    // already found
    if (i_object)
    {
        return;
    }

    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::WorldObjectSearcher<Check>::Visit(CreatureMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
    {
        return;
    }

    // already found
    if (i_object)
    {
        return;
    }

    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::WorldObjectSearcher<Check>::Visit(CorpseMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
    {
        return;
    }

    // already found
    if (i_object)
    {
        return;
    }

    for (CorpseMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::WorldObjectSearcher<Check>::Visit(DynamicObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
    {
        return;
    }

    // already found
    if (i_object)
    {
        return;
    }

    for (DynamicObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::WorldObjectLastSearcher<Check>::Visit(GameObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
    {
        return;
    }

    for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::WorldObjectLastSearcher<Check>::Visit(PlayerMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
    {
        return;
    }

    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::WorldObjectLastSearcher<Check>::Visit(CreatureMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
    {
        return;
    }

    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::WorldObjectLastSearcher<Check>::Visit(CorpseMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
    {
        return;
    }

    for (CorpseMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::WorldObjectLastSearcher<Check>::Visit(DynamicObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
    {
        return;
    }

    for (DynamicObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::WorldObjectListSearcher<Check>::Visit(PlayerMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
    {
        return;
    }

    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
        {
            i_objects.push_back(itr->GetSource());
        }
}

template<class Check>
void Acore::WorldObjectListSearcher<Check>::Visit(CreatureMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
    {
        return;
    }

    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
        {
            i_objects.push_back(itr->GetSource());
        }
}

template<class Check>
void Acore::WorldObjectListSearcher<Check>::Visit(CorpseMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
    {
        return;
    }

    for (CorpseMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
        {
            i_objects.push_back(itr->GetSource());
        }
}

template<class Check>
void Acore::WorldObjectListSearcher<Check>::Visit(GameObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
    {
        return;
    }

    for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
        {
            i_objects.push_back(itr->GetSource());
        }
}

template<class Check>
void Acore::WorldObjectListSearcher<Check>::Visit(DynamicObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
    {
        return;
    }

    for (DynamicObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
        {
            i_objects.push_back(itr->GetSource());
        }
}

// Gameobject searchers

template<class Check>
void Acore::GameObjectSearcher<Check>::Visit(GameObjectMapType& m)
{
    // already found
    if (i_object)
    {
        return;
    }

    for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::GameObjectLastSearcher<Check>::Visit(GameObjectMapType& m)
{
    for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::GameObjectListSearcher<Check>::Visit(GameObjectMapType& m)
{
    for (GameObjectMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
            {
                i_objects.push_back(itr->GetSource());
            }
}

// Unit searchers

template<class Check>
void Acore::UnitSearcher<Check>::Visit(CreatureMapType& m)
{
    // already found
    if (i_object)
    {
        return;
    }

    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::UnitSearcher<Check>::Visit(PlayerMapType& m)
{
    // already found
    if (i_object)
    {
        return;
    }

    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::UnitLastSearcher<Check>::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::UnitLastSearcher<Check>::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::UnitListSearcher<Check>::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
            {
                i_objects.push_back(itr->GetSource());
            }
}

template<class Check>
void Acore::UnitListSearcher<Check>::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
            {
                i_objects.push_back(itr->GetSource());
            }
}

// Creature searchers

template<class Check>
void Acore::CreatureSearcher<Check>::Visit(CreatureMapType& m)
{
    // already found
    if (i_object)
    {
        return;
    }

    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::CreatureLastSearcher<Check>::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Check>
void Acore::CreatureListSearcher<Check>::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
            {
                i_objects.push_back(itr->GetSource());
            }
}

template<class Check>
void Acore::PlayerListSearcher<Check>::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
            {
                i_objects.push_back(itr->GetSource());
            }
}

template<class Check>
void Acore::PlayerListSearcherWithSharedVision<Check>::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource(), true))
            {
                i_objects.push_back(itr->GetSource());
            }
}

template<class Check>
void Acore::PlayerListSearcherWithSharedVision<Check>::Visit(CreatureMapType& m)
{
    for (CreatureMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask) && itr->GetSource()->HasSharedVision())
            for (SharedVisionList::const_iterator i = itr->GetSource()->GetSharedVisionList().begin(); i != itr->GetSource()->GetSharedVisionList().end(); ++i)
                if (i_check(*i, false))
                {
                    i_objects.push_back(*i);
                }
}

template<class Check>
void Acore::PlayerSearcher<Check>::Visit(PlayerMapType& m)
{
    // already found
    if (i_object)
    {
        return;
    }

    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void Acore::PlayerLastSearcher<Check>::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
        {
            continue;
        }

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
        }
    }
}

template<class Builder>
void Acore::LocalizedPacketDo<Builder>::operator()(Player* p)
{
    LocaleConstant loc_idx = p->GetSession()->GetSessionDbLocaleIndex();
    uint32 cache_idx = loc_idx + 1;
    WorldPacket* data;

    // create if not cached yet
    if (i_data_cache.size() < cache_idx + 1 || !i_data_cache[cache_idx])
    {
        if (i_data_cache.size() < cache_idx + 1)
        {
            i_data_cache.resize(cache_idx + 1);
        }

        data = new WorldPacket();

        i_builder(*data, loc_idx);

        i_data_cache[cache_idx] = data;
    }
    else
    {
        data = i_data_cache[cache_idx];
    }

    p->SendDirectMessage(data);
}

template<class Builder>
void Acore::LocalizedPacketListDo<Builder>::operator()(Player* p)
{
    LocaleConstant loc_idx = p->GetSession()->GetSessionDbLocaleIndex();
    uint32 cache_idx = loc_idx + 1;
    WorldPacketList* data_list;

    // create if not cached yet
    if (i_data_cache.size() < cache_idx + 1 || i_data_cache[cache_idx].empty())
    {
        if (i_data_cache.size() < cache_idx + 1)
        {
            i_data_cache.resize(cache_idx + 1);
        }

        data_list = &i_data_cache[cache_idx];

        i_builder(*data_list, loc_idx);
    }
    else
    {
        data_list = &i_data_cache[cache_idx];
    }

    for (size_t i = 0; i < data_list->size(); ++i)
    {
        p->SendDirectMessage((*data_list)[i]);
    }
}

template<class Do>
AC_GAME_API void Acore::WorldObjectWorker<Do>::Visit(GameObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
    {
        return;
    }

    for (auto const& gridGO : m)
    {
        if (gridGO.GetSource()->InSamePhase(i_phaseMask))
        {
            i_do(gridGO.GetSource());
        }
    }
}

template<class Do>
AC_GAME_API void Acore::WorldObjectWorker<Do>::Visit(PlayerMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
    {
        return;
    }

    for (auto const& object : m)
    {
        if (object.GetSource()->InSamePhase(i_phaseMask))
        {
            i_do(object.GetSource());
        }
    }
}

template<class Do>
AC_GAME_API void Acore::WorldObjectWorker<Do>::Visit(CreatureMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
    {
        return;
    }

    for (auto const& gridCreature : m)
    {
        if (gridCreature.GetSource()->InSamePhase(i_phaseMask))
        {
            i_do(gridCreature.GetSource());
        }
    }
}

template<class Do>
AC_GAME_API void Acore::WorldObjectWorker<Do>::Visit(CorpseMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
    {
        return;
    }

    for (auto const& gridCorpse : m)
    {
        if (gridCorpse.GetSource()->InSamePhase(i_phaseMask))
        {
            i_do(gridCorpse.GetSource());
        }
    }
}

template<class Do>
AC_GAME_API void Acore::WorldObjectWorker<Do>::Visit(DynamicObjectMapType& m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
    {
        return;
    }

    for (auto const& gridDynamicObject : m)
    {
        if (gridDynamicObject.GetSource()->InSamePhase(i_phaseMask))
        {
            i_do(gridDynamicObject.GetSource());
        }
    }
}

template<class Functor>
void Acore::GameObjectWorker<Functor>::Visit(GameObjectMapType& m)
{
    for (auto const& gridGO : m)
    {
        if (gridGO.GetSource()->InSamePhase(_phaseMask))
        {
            _func(gridGO.GetSource());
        }
    }
}

template<class Do>
void Acore::CreatureWorker<Do>::Visit(CreatureMapType& m)
{
    for (auto const& gridCreature : m)
    {
        if (gridCreature.GetSource()->InSamePhase(i_phaseMask))
        {
            i_do(gridCreature.GetSource());
        }
    }
}

template<class Do>
void Acore::PlayerWorker<Do>::Visit(PlayerMapType& m)
{
    for (auto const& gridPlayer : m)
    {
        if (gridPlayer.GetSource()->InSamePhase(i_phaseMask))
        {
            i_do(gridPlayer.GetSource());
        }
    }
}

template<class Do>
void Acore::PlayerDistWorker<Do>::Visit(PlayerMapType& m)
{
    for (auto const& gridPlayer : m)
    {
        if (gridPlayer.GetSource()->InSamePhase(i_searcher) && gridPlayer.GetSource()->IsWithinDist(i_searcher, i_dist))
        {
            i_do(gridPlayer.GetSource());
        }
    }
}

#endif                                                      // ACORE_GRIDNOTIFIERSIMPL_H
