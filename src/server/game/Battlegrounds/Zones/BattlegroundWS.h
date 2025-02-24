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

#ifndef __BATTLEGROUNDWS_H
#define __BATTLEGROUNDWS_H

#include "Battleground.h"
#include "BattlegroundScore.h"
#include "EventMap.h"

enum BG_WS_Events
{
    BG_WS_EVENT_UPDATE_GAME_TIME    = 1,
    BG_WS_EVENT_NO_TIME_LEFT        = 2,
    BG_WS_EVENT_RESPAWN_BOTH_FLAGS  = 3,
    BG_WS_EVENT_ALLIANCE_DROP_FLAG  = 4,
    BG_WS_EVENT_HORDE_DROP_FLAG     = 5,
    BG_WS_EVENT_BOTH_FLAGS_KEPT10   = 6,
    BG_WS_EVENT_BOTH_FLAGS_KEPT15   = 7,
    BG_WS_EVENT_DESPAWN_DOORS       = 8
};

enum BG_WS_TimerOrScore
{
    BG_WS_MAX_TEAM_SCORE            = 3,

    BG_WS_TOTAL_GAME_TIME           = 27 * MINUTE * IN_MILLISECONDS,
    BG_WS_FLAG_RESPAWN_TIME         = 23 * IN_MILLISECONDS,
    BG_WS_FLAG_DROP_TIME            = 10 * IN_MILLISECONDS,
    BG_WS_SPELL_FORCE_TIME          = 10 * MINUTE * IN_MILLISECONDS,
    BG_WS_SPELL_BRUTAL_TIME         = 15 * MINUTE * IN_MILLISECONDS,
    BG_WS_DOOR_DESPAWN_TIME         = 5 * IN_MILLISECONDS
};

enum BG_WS_BroadcastTexts
{
    BG_WS_TEXT_START_ONE_MINUTE         = 10015,
    BG_WS_TEXT_START_HALF_MINUTE        = 10016,
    BG_WS_TEXT_BATTLE_HAS_BEGUN         = 10014,

    BG_WS_TEXT_CAPTURED_HORDE_FLAG      = 9801,
    BG_WS_TEXT_CAPTURED_ALLIANCE_FLAG   = 9802,
    BG_WS_TEXT_FLAGS_PLACED             = 9803,
    BG_WS_TEXT_ALLIANCE_FLAG_PICKED_UP  = 9804,
    BG_WS_TEXT_ALLIANCE_FLAG_DROPPED    = 9805,
    BG_WS_TEXT_HORDE_FLAG_PICKED_UP     = 9807,
    BG_WS_TEXT_HORDE_FLAG_DROPPED       = 9806,
    BG_WS_TEXT_ALLIANCE_FLAG_RETURNED   = 9808,
    BG_WS_TEXT_HORDE_FLAG_RETURNED      = 9809,
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

enum BG_WS_Trigger
{
    BG_WS_TRIGGER_ALLIANCE_FLAG_SPAWN           = 3646,
    BG_WS_TRIGGER_HORDE_FLAG_SPAWN              = 3647,

    BG_WS_TRIGGER_ALLIANCE_ELIXIR_SPEED_SPAWN   = 3686,
    BG_WS_TRIGGER_HORDE_ELIXIR_SPEED_SPAWN      = 3687,

    BG_WS_TRIGGER_ALLIANCE_ELIXIR_REGEN_SPAWN   = 3706,
    BG_WS_TRIGGER_HORDE_ELIXIR_REGEN_SPAWN      = 3708,

    BG_WS_TRIGGER_ALLIANCE_ELIXIR_BERSERK_SPAWN = 3707,
    BG_WS_TRIGGER_HORDE_ELIXIR_BERSERK_SPAWN    = 3709,
};

struct BattlegroundWGScore final : public BattlegroundScore
{
    friend class BattlegroundWS;

protected:
    BattlegroundWGScore(ObjectGuid playerGuid) : BattlegroundScore(playerGuid) { }

    void UpdateScore(uint32 type, uint32 value) override
    {
        switch (type)
        {
        case SCORE_FLAG_CAPTURES:   // Flags captured
            FlagCaptures += value;
            break;
        case SCORE_FLAG_RETURNS:    // Flags returned
            FlagReturns += value;
            break;
        default:
            BattlegroundScore::UpdateScore(type, value);
            break;
        }
    }

    void BuildObjectivesBlock(WorldPacket& data) final;

    uint32 GetAttr1() const override { return FlagCaptures; }
    uint32 GetAttr2() const override { return FlagReturns; }

    uint32 FlagCaptures = 0;
    uint32 FlagReturns = 0;
};

class AC_GAME_API BattlegroundWS : public Battleground
{
public:
    /* Construction */
    BattlegroundWS();
    ~BattlegroundWS() override;

    /* inherited from BattlegroundClass */
    void AddPlayer(Player* player) override;
    void StartingEventCloseDoors() override;
    void StartingEventOpenDoors() override;

    /* BG Flags */
    ObjectGuid GetFlagPickerGUID(TeamId teamId) const override { return _flagKeepers[teamId];  }
    void SetFlagPicker(ObjectGuid guid, TeamId teamId) { _flagKeepers[teamId] = guid; }
    void RespawnFlagAfterDrop(TeamId teamId);
    uint8 GetFlagState(TeamId teamId) const { return _flagState[teamId]; }
    void CheckFlagKeeperInArea(TeamId teamId);

    /* Battleground Events */
    void EventPlayerDroppedFlag(Player* player) override;
    void EventPlayerClickedOnFlag(Player* player, GameObject* gameObject) override;
    void EventPlayerCapturedFlag(Player* player);

    void RemovePlayer(Player* player) override;
    void HandleAreaTrigger(Player* player, uint32 trigger) override;
    void HandleKillPlayer(Player* player, Player* killer) override;
    bool SetupBattleground() override;
    void Init() override;
    void EndBattleground(TeamId winnerTeamId) override;
    GraveyardStruct const* GetClosestGraveyard(Player* player) override;

    void UpdateFlagState(TeamId teamId, uint32 value);
    bool UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor = true) override;
    void SetDroppedFlagGUID(ObjectGuid guid, TeamId teamId) override { _droppedFlagGUID[teamId] = guid; }
    ObjectGuid GetDroppedFlagGUID(TeamId teamId) const { return _droppedFlagGUID[teamId];}
    void FillInitialWorldStates(WorldPackets::WorldState::InitWorldStates& packet) override;

    /* Scorekeeping */
    void AddPoints(TeamId teamId, uint32 points) { m_TeamScores[teamId] += points; }

    TeamId GetPrematureWinner() override;
    uint32 GetMatchTime() const { return 1 + (BG_WS_TOTAL_GAME_TIME - GetStartTime()) / (MINUTE * IN_MILLISECONDS); }
    uint32 GetAssaultSpellId() const;
    void RemoveAssaultAuras();

private:
    EventMap _bgEvents;

    ObjectGuid _flagKeepers[2];
    ObjectGuid _droppedFlagGUID[2];
    uint8  _flagState[2];
    TeamId _lastFlagCaptureTeam;
    uint32 _reputationCapture;
    uint32 _honorWinKills;
    uint32 _honorEndKills;

    void PostUpdateImpl(uint32 diff) override;
};

#endif
