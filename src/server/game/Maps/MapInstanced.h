/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_MAP_INSTANCED_H
#define ACORE_MAP_INSTANCED_H

#include "DBCEnums.h"
#include "InstanceSaveMgr.h"
#include "Map.h"

class MapInstanced : public Map
{
    friend class MapManager;
public:
    typedef std::unordered_map< uint32, Map*> InstancedMaps;

    MapInstanced(uint32 id);
    ~MapInstanced() override {}

    // functions overwrite Map versions
    void Update(const uint32, const uint32, bool thread = true) override;
    void DelayedUpdate(const uint32 diff) override;
    //void RelocationNotify();
    void UnloadAll() override;
    bool CanEnter(Player* player, bool loginCheck = false) override;

    Map* CreateInstanceForPlayer(const uint32 mapId, Player* player);
    Map* FindInstanceMap(uint32 instanceId) const
    {
        InstancedMaps::const_iterator i = m_InstancedMaps.find(instanceId);
        return(i == m_InstancedMaps.end() ? nullptr : i->second);
    }
    bool DestroyInstance(InstancedMaps::iterator& itr);

    InstancedMaps& GetInstancedMaps() { return m_InstancedMaps; }
    void InitVisibilityDistance() override;

private:
    InstanceMap* CreateInstance(uint32 InstanceId, InstanceSave* save, Difficulty difficulty);
    BattlegroundMap* CreateBattleground(uint32 InstanceId, Battleground* bg);

    InstancedMaps m_InstancedMaps;
};
#endif
