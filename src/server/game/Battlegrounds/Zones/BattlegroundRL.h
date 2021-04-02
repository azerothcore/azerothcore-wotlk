/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
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
    ~BattlegroundRL() override;

    /* inherited from BattlegroundClass */
    void AddPlayer(Player* player) override;
    void Init() override;
    void FillInitialWorldStates(WorldPacket& d) override;
    void StartingEventCloseDoors() override;
    void StartingEventOpenDoors() override;

    void RemovePlayer(Player* player) override;
    void HandleAreaTrigger(Player* player, uint32 trigger) override;
    bool SetupBattleground() override;
    void HandleKillPlayer(Player* player, Player* killer) override;
    bool HandlePlayerUnderMap(Player* player) override;
};
#endif
