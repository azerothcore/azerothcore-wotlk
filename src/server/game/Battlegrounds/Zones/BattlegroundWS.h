/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#ifndef __BATTLEGROUNDWS_H
#define __BATTLEGROUNDWS_H

#include "Battleground.h"

enum BG_WS_Events
{
    BG_WS_EVENT_UPDATE_GAME_TIME    = 1,
    BG_WS_EVENT_NO_TIME_LEFT        = 2,
    BG_WS_EVENT_RESPAWN_BOTH_FLAGS  = 3,
    BG_WS_EVENT_ALLIANCE_DROP_FLAG  = 4,
    BG_WS_EVENT_HORDE_DROP_FLAG     = 5,
    BG_WS_EVENT_BOTH_FLAGS_KEPT10   = 6,
    BG_WS_EVENT_BOTH_FLAGS_KEPT15   = 7
};

enum BG_WS_TimerOrScore
{
    BG_WS_MAX_TEAM_SCORE            = 3,

    BG_WS_TOTAL_GAME_TIME           = 27*MINUTE*IN_MILLISECONDS,
    BG_WS_FLAG_RESPAWN_TIME         = 23*IN_MILLISECONDS,
    BG_WS_FLAG_DROP_TIME            = 10*IN_MILLISECONDS,
    BG_WS_SPELL_FORCE_TIME          = 10*MINUTE*IN_MILLISECONDS,
    BG_WS_SPELL_BRUTAL_TIME         = 15*MINUTE*IN_MILLISECONDS
};

enum BG_WS_Sound
{
    BG_WS_SOUND_FLAG_CAPTURED_ALLIANCE  = 8173,
    BG_WS_SOUND_FLAG_CAPTURED_HORDE     = 8213,
    BG_WS_SOUND_FLAG_PLACED             = 8232,
    BG_WS_SOUND_FLAG_RETURNED           = 8192,
    BG_WS_SOUND_HORDE_FLAG_PICKED_UP    = 8212,
    BG_WS_SOUND_ALLIANCE_FLAG_PICKED_UP = 8174,
    BG_WS_SOUND_FLAGS_RESPAWNED         = 8232
};

enum BG_WS_SpellId
{
    BG_WS_SPELL_WARSONG_FLAG            = 23333,
    BG_WS_SPELL_WARSONG_FLAG_DROPPED    = 23334,
    BG_WS_SPELL_WARSONG_FLAG_PICKED     = 61266,    // fake spell, does not exist but used as timer start event
    BG_WS_SPELL_SILVERWING_FLAG         = 23335,
    BG_WS_SPELL_SILVERWING_FLAG_DROPPED = 23336,
    BG_WS_SPELL_SILVERWING_FLAG_PICKED  = 61265,    // fake spell, does not exist but used as timer start event
    BG_WS_SPELL_FOCUSED_ASSAULT         = 46392,
    BG_WS_SPELL_BRUTAL_ASSAULT          = 46393
};

enum BG_WS_WorldStates
{
    BG_WS_FLAG_CAPTURES_ALLIANCE  = 1581,
    BG_WS_FLAG_CAPTURES_HORDE     = 1582,
    BG_WS_FLAG_CAPTURES_MAX       = 1601,
    BG_WS_FLAG_STATE_HORDE        = 2338,
    BG_WS_FLAG_STATE_ALLIANCE     = 2339,
    BG_WS_STATE_TIMER             = 4248,
    BG_WS_STATE_TIMER_ACTIVE      = 4247
};

enum BG_WS_ObjectTypes
{
    BG_WS_OBJECT_DOOR_A_1       = 0,
    BG_WS_OBJECT_DOOR_A_2       = 1,
    BG_WS_OBJECT_DOOR_A_3       = 2,
    BG_WS_OBJECT_DOOR_A_4       = 3,
    BG_WS_OBJECT_DOOR_A_5       = 4,
    BG_WS_OBJECT_DOOR_A_6       = 5,
    BG_WS_OBJECT_DOOR_H_1       = 6,
    BG_WS_OBJECT_DOOR_H_2       = 7,
    BG_WS_OBJECT_DOOR_H_3       = 8,
    BG_WS_OBJECT_DOOR_H_4       = 9,
    BG_WS_OBJECT_A_FLAG         = 10,
    BG_WS_OBJECT_H_FLAG         = 11,
    BG_WS_OBJECT_SPEEDBUFF_1    = 12,
    BG_WS_OBJECT_SPEEDBUFF_2    = 13,
    BG_WS_OBJECT_REGENBUFF_1    = 14,
    BG_WS_OBJECT_REGENBUFF_2    = 15,
    BG_WS_OBJECT_BERSERKBUFF_1  = 16,
    BG_WS_OBJECT_BERSERKBUFF_2  = 17,
    BG_WS_OBJECT_MAX            = 18
};

enum BG_WS_ObjectEntry
{
    BG_OBJECT_DOOR_A_1_WS_ENTRY          = 179918,
    BG_OBJECT_DOOR_A_2_WS_ENTRY          = 179919,
    BG_OBJECT_DOOR_A_3_WS_ENTRY          = 179920,
    BG_OBJECT_DOOR_A_4_WS_ENTRY          = 179921,
    BG_OBJECT_DOOR_A_5_WS_ENTRY          = 180322,
    BG_OBJECT_DOOR_A_6_WS_ENTRY          = 180322,
    BG_OBJECT_DOOR_H_1_WS_ENTRY          = 179916,
    BG_OBJECT_DOOR_H_2_WS_ENTRY          = 179917,
    BG_OBJECT_DOOR_H_3_WS_ENTRY          = 180322,
    BG_OBJECT_DOOR_H_4_WS_ENTRY          = 180322,
    BG_OBJECT_A_FLAG_WS_ENTRY            = 179830,
    BG_OBJECT_H_FLAG_WS_ENTRY            = 179831,
    BG_OBJECT_A_FLAG_GROUND_WS_ENTRY     = 179785,
    BG_OBJECT_H_FLAG_GROUND_WS_ENTRY     = 179786
};

enum BG_WS_FlagState
{
    BG_WS_FLAG_STATE_ON_BASE      = 1,
    BG_WS_FLAG_STATE_ON_PLAYER    = 2,
    BG_WS_FLAG_STATE_ON_GROUND    = 3
};

enum BG_WS_Graveyards
{
    WS_GRAVEYARD_FLAGROOM_ALLIANCE = 769,
    WS_GRAVEYARD_FLAGROOM_HORDE    = 770,
    WS_GRAVEYARD_MAIN_ALLIANCE     = 771,
    WS_GRAVEYARD_MAIN_HORDE        = 772
};

enum BG_WS_CreatureTypes
{
    WS_SPIRIT_MAIN_ALLIANCE   = 0,
    WS_SPIRIT_MAIN_HORDE      = 1,

    BG_CREATURES_MAX_WS       = 2
};


enum BG_WS_Objectives
{
    WS_OBJECTIVE_CAPTURE_FLAG   = 42,
    WS_OBJECTIVE_RETURN_FLAG    = 44,

    WS_EVENT_START_BATTLE       = 8563
};

struct BattlegroundWGScore : public BattlegroundScore
{
    BattlegroundWGScore(Player* player): BattlegroundScore(player), FlagCaptures(0), FlagReturns(0) { }
    ~BattlegroundWGScore() { }
    uint32 FlagCaptures;
    uint32 FlagReturns;

    uint32 GetAttr1() const final override { return FlagCaptures; }
    uint32 GetAttr2() const final override { return FlagReturns; }
};

class BattlegroundWS : public Battleground
{
    public:
        /* Construction */
        BattlegroundWS();
        ~BattlegroundWS();

        /* inherited from BattlegroundClass */
        void AddPlayer(Player* player);
        void StartingEventCloseDoors();
        void StartingEventOpenDoors();

        /* BG Flags */
        uint64 GetFlagPickerGUID(TeamId teamId) const { return _flagKeepers[teamId];  }
        void SetFlagPicker(uint64 guid, TeamId teamId) { _flagKeepers[teamId] = guid; }
        void RespawnFlagAfterDrop(TeamId teamId);
        uint8 GetFlagState(TeamId teamId) const { return _flagState[teamId]; }

        /* Battleground Events */
        void EventPlayerDroppedFlag(Player* player);
        void EventPlayerClickedOnFlag(Player* player, GameObject* gameObject);
        void EventPlayerCapturedFlag(Player* player);

        void RemovePlayer(Player* player);
        void HandleAreaTrigger(Player* player, uint32 trigger);
        void HandleKillPlayer(Player* player, Player* killer);
        bool SetupBattleground();
        void Init();
        void EndBattleground(TeamId winnerTeamId);
        GraveyardStruct const* GetClosestGraveyard(Player* player);

        void UpdateFlagState(TeamId teamId, uint32 value);
        void UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor = true);
        void SetDroppedFlagGUID(uint64 guid, TeamId teamId) { _droppedFlagGUID[teamId] = guid; }
        uint64 GetDroppedFlagGUID(TeamId teamId) const { return _droppedFlagGUID[teamId];}
        void FillInitialWorldStates(WorldPacket& data);

        /* Scorekeeping */
        void AddPoints(TeamId teamId, uint32 points) { m_TeamScores[teamId] += points; }
        
        TeamId GetPrematureWinner();
        uint32 GetMatchTime() const { return 1 + (BG_WS_TOTAL_GAME_TIME - GetStartTime()) / (MINUTE*IN_MILLISECONDS); }
        uint32 GetAssaultSpellId() const;
        void RemoveAssaultAuras();

    private:
        EventMap _bgEvents;

        uint64 _flagKeepers[2];
        uint64 _droppedFlagGUID[2];
        uint8  _flagState[2];
        TeamId _lastFlagCaptureTeam;
        uint32 _reputationCapture;
        uint32 _honorWinKills;
        uint32 _honorEndKills;

        void PostUpdateImpl(uint32 diff);
};
#endif
