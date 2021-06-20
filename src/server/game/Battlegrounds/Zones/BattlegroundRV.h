/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */
#ifndef __BATTLEGROUNDRV_H
#define __BATTLEGROUNDRV_H

#include "Battleground.h"

enum BattlegroundRVObjectTypes
{
    BG_RV_OBJECT_BUFF_1,
    BG_RV_OBJECT_BUFF_2,
    BG_RV_OBJECT_FIRE_1,
    BG_RV_OBJECT_FIRE_2,
    BG_RV_OBJECT_FIREDOOR_1,
    BG_RV_OBJECT_FIREDOOR_2,

    BG_RV_OBJECT_PILAR_1,
    BG_RV_OBJECT_PILAR_3,
    BG_RV_OBJECT_GEAR_1,
    BG_RV_OBJECT_GEAR_2,

    BG_RV_OBJECT_PILAR_2,
    BG_RV_OBJECT_PILAR_4,
    BG_RV_OBJECT_PULLEY_1,
    BG_RV_OBJECT_PULLEY_2,

    BG_RV_OBJECT_ELEVATOR_1,
    BG_RV_OBJECT_ELEVATOR_2,

    BG_RV_OBJECT_READY_MARKER_1,
    BG_RV_OBJECT_READY_MARKER_2,

    BG_RV_OBJECT_MAX,
};

enum BattlegroundRVObjects
{
    BG_RV_OBJECT_TYPE_BUFF_1                     = 184663,
    BG_RV_OBJECT_TYPE_BUFF_2                     = 184664,
    BG_RV_OBJECT_TYPE_FIRE_1                     = 192704,
    BG_RV_OBJECT_TYPE_FIRE_2                     = 192705,

    BG_RV_OBJECT_TYPE_FIREDOOR_2                 = 192387,
    BG_RV_OBJECT_TYPE_FIREDOOR_1                 = 192388,
    BG_RV_OBJECT_TYPE_PULLEY_1                   = 192389,
    BG_RV_OBJECT_TYPE_PULLEY_2                   = 192390,
    BG_RV_OBJECT_TYPE_GEAR_1                     = 192393,
    BG_RV_OBJECT_TYPE_GEAR_2                     = 192394,

    BG_RV_OBJECT_TYPE_ELEVATOR_1                 = 194582,
    BG_RV_OBJECT_TYPE_ELEVATOR_2                 = 194586,

    BG_RV_OBJECT_TYPE_PILAR_1                    = 194583, // axe
    BG_RV_OBJECT_TYPE_PILAR_2                    = 194584, // arena
    BG_RV_OBJECT_TYPE_PILAR_3                    = 194585, // lightning
    BG_RV_OBJECT_TYPE_PILAR_4                    = 194587, // ivory
};

enum BattlegroundRVData
{
    BG_RV_STATE_OPEN_FENCES,
    BG_RV_STATE_SWITCH_PILLARS,
    BG_RV_STATE_CLOSE_FIRE,

    BG_RV_PILLAR_SWITCH_TIMER                    = 25000,
    BG_RV_FIRE_TO_PILLAR_TIMER                   = 20000,
    BG_RV_CLOSE_FIRE_TIMER                       =  5000,
    BG_RV_FIRST_TIMER                            = 20500, // elevators rise in 20133ms
    BG_RV_WORLD_STATE_A                          = 0xe11,
    BG_RV_WORLD_STATE_H                          = 0xe10,
    BG_RV_WORLD_STATE                            = 0xe1a,
};

class BattlegroundRV : public Battleground
{
    public:
        BattlegroundRV();
        ~BattlegroundRV();

        /* inherited from BattlegroundClass */
        void AddPlayer(Player* player);
        void RemovePlayer(Player* player);
        void StartingEventCloseDoors();
        void StartingEventOpenDoors();
        void Init();
        void FillInitialWorldStates(WorldPacket &d);
        void UpdateArenaWorldState();
        void HandleAreaTrigger(Player* player, uint32 trigger);
        bool SetupBattleground();
        void HandleKillPlayer(Player* player, Player* killer);
        bool HandlePlayerUnderMap(Player* player);

        GameObject* GetPillarAtPosition(Position* p);

    private:
        uint32 Timer;
        uint32 State;
        uint16 CheckPlayersTimer;

        void PostUpdateImpl(uint32 diff);

    protected:
        uint32 getTimer() { return Timer; }
        void setTimer(uint32 timer) { Timer = timer; }
        uint32 getState() { return State; };
        void setState(uint32 state) { State = state; }

        void TeleportUnitToNewZ(Unit* unit, float newZ, bool casting);
        void CheckPositionForUnit(Unit* unit);
        void UpdatePillars();
        uint32 GetPillarIdForPos(Position* p);
};
#endif
