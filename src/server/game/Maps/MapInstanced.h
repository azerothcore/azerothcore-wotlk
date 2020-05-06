/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_MAP_INSTANCED_H
#define ACORE_MAP_INSTANCED_H

#include "Map.h"
#include "InstanceSaveMgr.h"
#include "DBCEnums.h"

class MapInstanced : public Map
{
    friend class MapManager;
    public:
        typedef std::unordered_map< uint32, Map*> InstancedMaps;

        MapInstanced(uint32 id);
        ~MapInstanced() {}

        // functions overwrite Map versions
        void Update(const uint32, const uint32, bool thread = true);
        void DelayedUpdate(const uint32 diff);
        //void RelocationNotify();
        void UnloadAll();
        bool CanEnter(Player* player, bool loginCheck = false);

        Map* CreateInstanceForPlayer(const uint32 mapId, Player* player);
        Map* FindInstanceMap(uint32 instanceId) const
        {
            InstancedMaps::const_iterator i = m_InstancedMaps.find(instanceId);
            return(i == m_InstancedMaps.end() ? NULL : i->second);
        }
        bool DestroyInstance(InstancedMaps::iterator &itr);

        InstancedMaps &GetInstancedMaps() { return m_InstancedMaps; }
        virtual void InitVisibilityDistance();

    private:
        InstanceMap* CreateInstance(uint32 InstanceId, InstanceSave* save, Difficulty difficulty);
        BattlegroundMap* CreateBattleground(uint32 InstanceId, Battleground* bg);

        InstancedMaps m_InstancedMaps;
};
#endif
