/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_GRIDNOTIFIERSIMPL_H
#define ACORE_GRIDNOTIFIERSIMPL_H

#include "GridNotifiers.h"
#include "WorldPacket.h"
#include "Corpse.h"
#include "Player.h"
#include "UpdateData.h"
#include "CreatureAI.h"
#include "SpellAuras.h"
#include "Opcodes.h"

template<class T>
inline void acore::VisibleNotifier::Visit(GridRefManager<T> &m)
{
    // Xinef: Update gameobjects only
    if (i_gobjOnly)
        return;

    for (typename GridRefManager<T>::iterator iter = m.begin(); iter != m.end(); ++iter)
    {
        if (i_largeOnly != iter->GetSource()->IsVisibilityOverridden())
            continue;
        vis_guids.erase(iter->GetSource()->GetGUID());
        i_player.UpdateVisibilityOf(iter->GetSource(), i_data, i_visibleNow);
    }
}

// SEARCHERS & LIST SEARCHERS & WORKERS

// WorldObject searchers & workers

template<class Check>
void acore::WorldObjectSearcher<Check>::Visit(GameObjectMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
        return;

    // already found
    if (i_object)
        return;

    for (GameObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::WorldObjectSearcher<Check>::Visit(PlayerMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
        return;

    // already found
    if (i_object)
        return;

    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::WorldObjectSearcher<Check>::Visit(CreatureMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
        return;

    // already found
    if (i_object)
        return;

    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::WorldObjectSearcher<Check>::Visit(CorpseMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
        return;

    // already found
    if (i_object)
        return;

    for (CorpseMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::WorldObjectSearcher<Check>::Visit(DynamicObjectMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
        return;

    // already found
    if (i_object)
        return;

    for (DynamicObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}


template<class Check>
void acore::WorldObjectLastSearcher<Check>::Visit(GameObjectMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
        return;

    for (GameObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::WorldObjectLastSearcher<Check>::Visit(PlayerMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
        return;

    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::WorldObjectLastSearcher<Check>::Visit(CreatureMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
        return;

    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::WorldObjectLastSearcher<Check>::Visit(CorpseMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
        return;

    for (CorpseMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::WorldObjectLastSearcher<Check>::Visit(DynamicObjectMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
        return;

    for (DynamicObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::WorldObjectListSearcher<Check>::Visit(PlayerMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_PLAYER))
        return;

    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
            i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::WorldObjectListSearcher<Check>::Visit(CreatureMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CREATURE))
        return;

    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
            i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::WorldObjectListSearcher<Check>::Visit(CorpseMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_CORPSE))
        return;

    for (CorpseMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
            i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::WorldObjectListSearcher<Check>::Visit(GameObjectMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_GAMEOBJECT))
        return;

    for (GameObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
            i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::WorldObjectListSearcher<Check>::Visit(DynamicObjectMapType &m)
{
    if (!(i_mapTypeMask & GRID_MAP_TYPE_MASK_DYNAMICOBJECT))
        return;

    for (DynamicObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (i_check(itr->GetSource()))
            i_objects.push_back(itr->GetSource());
}

// Gameobject searchers

template<class Check>
void acore::GameObjectSearcher<Check>::Visit(GameObjectMapType &m)
{
    // already found
    if (i_object)
        return;

    for (GameObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::GameObjectLastSearcher<Check>::Visit(GameObjectMapType &m)
{
    for (GameObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::GameObjectListSearcher<Check>::Visit(GameObjectMapType &m)
{
    for (GameObjectMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
                i_objects.push_back(itr->GetSource());
}

// Unit searchers

template<class Check>
void acore::UnitSearcher<Check>::Visit(CreatureMapType &m)
{
    // already found
    if (i_object)
        return;

    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::UnitSearcher<Check>::Visit(PlayerMapType &m)
{
    // already found
    if (i_object)
        return;

    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::UnitLastSearcher<Check>::Visit(CreatureMapType &m)
{
    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::UnitLastSearcher<Check>::Visit(PlayerMapType &m)
{
    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::UnitListSearcher<Check>::Visit(PlayerMapType &m)
{
    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
                i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::UnitListSearcher<Check>::Visit(CreatureMapType &m)
{
    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
                i_objects.push_back(itr->GetSource());
}

// Creature searchers

template<class Check>
void acore::CreatureSearcher<Check>::Visit(CreatureMapType &m)
{
    // already found
    if (i_object)
        return;

    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::CreatureLastSearcher<Check>::Visit(CreatureMapType &m)
{
    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Check>
void acore::CreatureListSearcher<Check>::Visit(CreatureMapType &m)
{
    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
                i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::PlayerListSearcher<Check>::Visit(PlayerMapType &m)
{
    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource()))
                i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::PlayerListSearcherWithSharedVision<Check>::Visit(PlayerMapType &m)
{
    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask))
            if (i_check(itr->GetSource(), true))
                i_objects.push_back(itr->GetSource());
}

template<class Check>
void acore::PlayerListSearcherWithSharedVision<Check>::Visit(CreatureMapType &m)
{
    for (CreatureMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
        if (itr->GetSource()->InSamePhase(i_phaseMask) && itr->GetSource()->HasSharedVision())
            for (SharedVisionList::const_iterator i = itr->GetSource()->GetSharedVisionList().begin(); i != itr->GetSource()->GetSharedVisionList().end(); ++i)
                if (i_check(*i, false))
                    i_objects.push_back(*i);
}

template<class Check>
void acore::PlayerSearcher<Check>::Visit(PlayerMapType &m)
{
    // already found
    if (i_object)
        return;

    for (PlayerMapType::iterator itr=m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
        {
            i_object = itr->GetSource();
            return;
        }
    }
}

template<class Check>
void acore::PlayerLastSearcher<Check>::Visit(PlayerMapType& m)
{
    for (PlayerMapType::iterator itr = m.begin(); itr != m.end(); ++itr)
    {
        if (!itr->GetSource()->InSamePhase(i_phaseMask))
            continue;

        if (i_check(itr->GetSource()))
            i_object = itr->GetSource();
    }
}

template<class Builder>
void acore::LocalizedPacketDo<Builder>::operator()(Player* p)
{
    LocaleConstant loc_idx = p->GetSession()->GetSessionDbLocaleIndex();
    uint32 cache_idx = loc_idx+1;
    WorldPacket* data;

    // create if not cached yet
    if (i_data_cache.size() < cache_idx + 1 || !i_data_cache[cache_idx])
    {
        if (i_data_cache.size() < cache_idx + 1)
            i_data_cache.resize(cache_idx + 1);

        data = new WorldPacket();

        i_builder(*data, loc_idx);

        ASSERT(data->GetOpcode() != MSG_NULL_ACTION);

        i_data_cache[cache_idx] = data;
    }
    else
        data = i_data_cache[cache_idx];

    p->SendDirectMessage(data);
}

template<class Builder>
void acore::LocalizedPacketListDo<Builder>::operator()(Player* p)
{
    LocaleConstant loc_idx = p->GetSession()->GetSessionDbLocaleIndex();
    uint32 cache_idx = loc_idx+1;
    WorldPacketList* data_list;

    // create if not cached yet
    if (i_data_cache.size() < cache_idx+1 || i_data_cache[cache_idx].empty())
    {
        if (i_data_cache.size() < cache_idx+1)
            i_data_cache.resize(cache_idx+1);

        data_list = &i_data_cache[cache_idx];

        i_builder(*data_list, loc_idx);
    }
    else
        data_list = &i_data_cache[cache_idx];

    for (size_t i = 0; i < data_list->size(); ++i)
        p->SendDirectMessage((*data_list)[i]);
}

#endif                                                      // ACORE_GRIDNOTIFIERSIMPL_H
