/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
#ifndef __BATTLEGROUNDRL_H
#define __BATTLEGROUNDRL_H

#include "Battleground.h"

enum BattlegroundRLObjectTypes
{
    BG_RL_OBJECT_DOOR_1         = 0,
    BG_RL_OBJECT_DOOR_2         = 1,
    BG_RL_OBJECT_BUFF_1         = 2,
    BG_RL_OBJECT_BUFF_2         = 3,
    BG_RL_OBJECT_READY_MARKER_1 = 4,
    BG_RL_OBJECT_READY_MARKER_2 = 5,
    BG_RL_OBJECT_MAX            = 6
};

enum BattlegroundRLObjects
{
    BG_RL_OBJECT_TYPE_DOOR_1    = 185918,
    BG_RL_OBJECT_TYPE_DOOR_2    = 185917,
    BG_RL_OBJECT_TYPE_BUFF_1    = 184663,
    BG_RL_OBJECT_TYPE_BUFF_2    = 184664
};

class BattlegroundRL : public Battleground
{
    public:
        BattlegroundRL();
        ~BattlegroundRL();

        /* inherited from BattlegroundClass */
        void AddPlayer(Player* player);
        void Init();
        void FillInitialWorldStates(WorldPacket &d);
        void StartingEventCloseDoors();
        void StartingEventOpenDoors();

        void RemovePlayer(Player* player);
        void HandleAreaTrigger(Player* player, uint32 trigger);
        bool SetupBattleground();
        void HandleKillPlayer(Player* player, Player* killer);
        bool HandlePlayerUnderMap(Player* player);
};
#endif
