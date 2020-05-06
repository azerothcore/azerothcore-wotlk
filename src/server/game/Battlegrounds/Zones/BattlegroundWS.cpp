/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "BattlegroundWS.h"
#include "Creature.h"
#include "GameObject.h"
#include "Language.h"
#include "Object.h"
#include "ObjectMgr.h"
#include "BattlegroundMgr.h"
#include "Player.h"
#include "World.h"
#include "WorldPacket.h"
#include "GameGraveyard.h"

BattlegroundWS::BattlegroundWS()
{
    BgObjects.resize(BG_WS_OBJECT_MAX);
    BgCreatures.resize(BG_CREATURES_MAX_WS);

    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_BG_WS_START_TWO_MINUTES;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_BG_WS_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_BG_WS_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_BG_WS_HAS_BEGUN;

    _flagKeepers[TEAM_ALLIANCE] = 0;
    _flagKeepers[TEAM_HORDE] = 0;
    _droppedFlagGUID[TEAM_ALLIANCE] = 0;
    _droppedFlagGUID[TEAM_HORDE] = 0;
    _flagState[TEAM_ALLIANCE] = BG_WS_FLAG_STATE_ON_BASE;
    _flagState[TEAM_HORDE] = BG_WS_FLAG_STATE_ON_BASE;
    _lastFlagCaptureTeam = TEAM_NEUTRAL;
    _reputationCapture = 0;
    _honorWinKills = 0;
    _honorEndKills = 0;
}

BattlegroundWS::~BattlegroundWS()
{
}

void BattlegroundWS::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() == STATUS_IN_PROGRESS)
    {
        _bgEvents.Update(diff);
        switch (_bgEvents.ExecuteEvent())
        {
            case BG_WS_EVENT_UPDATE_GAME_TIME:
                UpdateWorldState(BG_WS_STATE_TIMER, GetMatchTime());
                _bgEvents.ScheduleEvent(BG_WS_EVENT_UPDATE_GAME_TIME, ((BG_WS_TOTAL_GAME_TIME - GetStartTime()) % (MINUTE*IN_MILLISECONDS)) + 1);
                break;
            case BG_WS_EVENT_NO_TIME_LEFT:
                if (GetTeamScore(TEAM_ALLIANCE) == GetTeamScore(TEAM_HORDE))
                    EndBattleground(_lastFlagCaptureTeam);
                else
                    EndBattleground(GetTeamScore(TEAM_HORDE) > GetTeamScore(TEAM_ALLIANCE) ? TEAM_HORDE : TEAM_ALLIANCE);
                break;
            case BG_WS_EVENT_RESPAWN_BOTH_FLAGS:
                SpawnBGObject(BG_WS_OBJECT_H_FLAG, RESPAWN_IMMEDIATELY);
                SpawnBGObject(BG_WS_OBJECT_A_FLAG, RESPAWN_IMMEDIATELY);
                SendMessageToAll(LANG_BG_WS_F_PLACED, CHAT_MSG_BG_SYSTEM_NEUTRAL);
                PlaySoundToAll(BG_WS_SOUND_FLAGS_RESPAWNED);
                break;
            case BG_WS_EVENT_ALLIANCE_DROP_FLAG:
                RespawnFlagAfterDrop(TEAM_ALLIANCE);
                break;
            case BG_WS_EVENT_HORDE_DROP_FLAG:
                RespawnFlagAfterDrop(TEAM_HORDE);
                break;
            case BG_WS_EVENT_BOTH_FLAGS_KEPT10:
                if (Player* player = ObjectAccessor::GetObjectInMap(GetFlagPickerGUID(TEAM_ALLIANCE), this->FindBgMap(), (Player*)NULL))
                    player->CastSpell(player, BG_WS_SPELL_FOCUSED_ASSAULT, true);
                if (Player* player = ObjectAccessor::GetObjectInMap(GetFlagPickerGUID(TEAM_HORDE), this->FindBgMap(), (Player*)NULL))
                    player->CastSpell(player, BG_WS_SPELL_FOCUSED_ASSAULT, true);
                break;
            case BG_WS_EVENT_BOTH_FLAGS_KEPT15:
                if (Player* player = ObjectAccessor::GetObjectInMap(GetFlagPickerGUID(TEAM_ALLIANCE), this->FindBgMap(), (Player*)NULL))
                {
                    player->RemoveAurasDueToSpell(BG_WS_SPELL_FOCUSED_ASSAULT);
                    player->CastSpell(player, BG_WS_SPELL_BRUTAL_ASSAULT, true);
                }
                if (Player* player = ObjectAccessor::GetObjectInMap(GetFlagPickerGUID(TEAM_HORDE), this->FindBgMap(), (Player*)NULL))
                {
                    player->RemoveAurasDueToSpell(BG_WS_SPELL_FOCUSED_ASSAULT);
                    player->CastSpell(player, BG_WS_SPELL_BRUTAL_ASSAULT, true);
                }
                break;
        }
    }
}

void BattlegroundWS::StartingEventCloseDoors()
{
    for (uint32 i = BG_WS_OBJECT_DOOR_A_1; i <= BG_WS_OBJECT_DOOR_H_4; ++i)
    {
        DoorClose(i);
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);
    }
    for (uint32 i = BG_WS_OBJECT_A_FLAG; i <= BG_WS_OBJECT_BERSERKBUFF_2; ++i)
        SpawnBGObject(i, RESPAWN_ONE_DAY);
}

void BattlegroundWS::StartingEventOpenDoors()
{
    for (uint32 i = BG_WS_OBJECT_DOOR_A_1; i <= BG_WS_OBJECT_DOOR_A_6; ++i)
        DoorOpen(i);
    for (uint32 i = BG_WS_OBJECT_DOOR_H_1; i <= BG_WS_OBJECT_DOOR_H_4; ++i)
        DoorOpen(i);

    for (uint32 i = BG_WS_OBJECT_A_FLAG; i <= BG_WS_OBJECT_BERSERKBUFF_2; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    SpawnBGObject(BG_WS_OBJECT_DOOR_A_5, RESPAWN_ONE_DAY);
    SpawnBGObject(BG_WS_OBJECT_DOOR_A_6, RESPAWN_ONE_DAY);
    SpawnBGObject(BG_WS_OBJECT_DOOR_H_3, RESPAWN_ONE_DAY);
    SpawnBGObject(BG_WS_OBJECT_DOOR_H_4, RESPAWN_ONE_DAY);

    StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, WS_EVENT_START_BATTLE);
    UpdateWorldState(BG_WS_STATE_TIMER_ACTIVE, 1);
    _bgEvents.ScheduleEvent(BG_WS_EVENT_UPDATE_GAME_TIME, 0);
    _bgEvents.ScheduleEvent(BG_WS_EVENT_NO_TIME_LEFT, BG_WS_TOTAL_GAME_TIME - 2*MINUTE*IN_MILLISECONDS); // 27 - 2 = 25 minutes
}

void BattlegroundWS::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundWGScore(player);
}

void BattlegroundWS::RespawnFlagAfterDrop(TeamId teamId)
{
    if (GetStatus() != STATUS_IN_PROGRESS || GetFlagState(teamId) != BG_WS_FLAG_STATE_ON_GROUND)
        return;

    UpdateFlagState(teamId, BG_WS_FLAG_STATE_ON_BASE);
    SpawnBGObject(teamId == TEAM_ALLIANCE ? BG_WS_OBJECT_A_FLAG : BG_WS_OBJECT_H_FLAG, RESPAWN_IMMEDIATELY);
    SendMessageToAll(teamId == TEAM_ALLIANCE ? LANG_BG_WS_ALLIANCE_FLAG_RESPAWNED : LANG_BG_WS_HORDE_FLAG_RESPAWNED, CHAT_MSG_BG_SYSTEM_NEUTRAL);
    PlaySoundToAll(BG_WS_SOUND_FLAGS_RESPAWNED);

    if (GameObject* flag = GetBgMap()->GetGameObject(GetDroppedFlagGUID(teamId)))
        flag->Delete();

    SetDroppedFlagGUID(0, teamId);
    _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT10);
    _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT15);
    RemoveAssaultAuras();
}

void BattlegroundWS::EventPlayerCapturedFlag(Player* player)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);
    RemoveAssaultAuras();

    AddPoints(player->GetTeamId(), 1);
    SetFlagPicker(0, GetOtherTeamId(player->GetTeamId()));
    UpdateFlagState(GetOtherTeamId(player->GetTeamId()), BG_WS_FLAG_STATE_ON_BASE);
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        player->RemoveAurasDueToSpell(BG_WS_SPELL_WARSONG_FLAG);
        PlaySoundToAll(BG_WS_SOUND_FLAG_CAPTURED_ALLIANCE);
        SendMessageToAll(LANG_BG_WS_CAPTURED_HF, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
        RewardReputationToTeam(890, _reputationCapture, TEAM_ALLIANCE);
    }
    else
    {
        player->RemoveAurasDueToSpell(BG_WS_SPELL_SILVERWING_FLAG);
        PlaySoundToAll(BG_WS_SOUND_FLAG_CAPTURED_HORDE);
        SendMessageToAll(LANG_BG_WS_CAPTURED_AF, CHAT_MSG_BG_SYSTEM_HORDE, player);
        RewardReputationToTeam(889, _reputationCapture, TEAM_HORDE);
    }

    SpawnBGObject(BG_WS_OBJECT_H_FLAG, BG_WS_FLAG_RESPAWN_TIME);
    SpawnBGObject(BG_WS_OBJECT_A_FLAG, BG_WS_FLAG_RESPAWN_TIME);

    UpdateWorldState(player->GetTeamId() == TEAM_ALLIANCE ? BG_WS_FLAG_CAPTURES_ALLIANCE : BG_WS_FLAG_CAPTURES_HORDE, GetTeamScore(player->GetTeamId()));
    UpdatePlayerScore(player, SCORE_FLAG_CAPTURES, 1);      // +1 flag captures
    _lastFlagCaptureTeam = player->GetTeamId();

    RewardHonorToTeam(GetBonusHonorFromKill(2), player->GetTeamId());

    if (GetTeamScore(TEAM_ALLIANCE) == BG_WS_MAX_TEAM_SCORE || GetTeamScore(TEAM_HORDE) == BG_WS_MAX_TEAM_SCORE)
    {
        UpdateWorldState(BG_WS_STATE_TIMER_ACTIVE, 0);
        EndBattleground(GetTeamScore(TEAM_HORDE) == BG_WS_MAX_TEAM_SCORE ? TEAM_HORDE : TEAM_ALLIANCE);
    }
    else
        _bgEvents.ScheduleEvent(BG_WS_EVENT_RESPAWN_BOTH_FLAGS, BG_WS_FLAG_RESPAWN_TIME);

    _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT10);
    _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT15);
}

void BattlegroundWS::EventPlayerDroppedFlag(Player* player)
{
    if (GetFlagPickerGUID(TEAM_HORDE) != player->GetGUID() && GetFlagPickerGUID(TEAM_ALLIANCE) != player->GetGUID())
        return;

    SetFlagPicker(0, GetOtherTeamId(player->GetTeamId()));
    player->RemoveAurasDueToSpell(BG_WS_SPELL_WARSONG_FLAG);
    player->RemoveAurasDueToSpell(BG_WS_SPELL_FOCUSED_ASSAULT);
    player->RemoveAurasDueToSpell(BG_WS_SPELL_BRUTAL_ASSAULT);

    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    player->CastSpell(player, SPELL_RECENTLY_DROPPED_FLAG, true);
    if (player->GetTeamId() == TEAM_ALLIANCE)
    {
        UpdateFlagState(TEAM_HORDE, BG_WS_FLAG_STATE_ON_GROUND);
        player->CastSpell(player, BG_WS_SPELL_WARSONG_FLAG_DROPPED, true);
        SendMessageToAll(LANG_BG_WS_DROPPED_HF, CHAT_MSG_BG_SYSTEM_HORDE, player);
        _bgEvents.RescheduleEvent(BG_WS_EVENT_HORDE_DROP_FLAG, BG_WS_FLAG_DROP_TIME);
    }
    else
    {
        UpdateFlagState(TEAM_ALLIANCE, BG_WS_FLAG_STATE_ON_GROUND);
        player->CastSpell(player, BG_WS_SPELL_SILVERWING_FLAG_DROPPED, true);
        SendMessageToAll(LANG_BG_WS_DROPPED_AF, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
        _bgEvents.RescheduleEvent(BG_WS_EVENT_ALLIANCE_DROP_FLAG, BG_WS_FLAG_DROP_TIME);
    }
}

void BattlegroundWS::EventPlayerClickedOnFlag(Player* player, GameObject* gameObject)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);

    // Alliance Flag picked up from base
    if (player->GetTeamId() == TEAM_HORDE && GetFlagState(TEAM_ALLIANCE) == BG_WS_FLAG_STATE_ON_BASE && BgObjects[BG_WS_OBJECT_A_FLAG] == gameObject->GetGUID())
    {
        SpawnBGObject(BG_WS_OBJECT_A_FLAG, RESPAWN_ONE_DAY);
        SetFlagPicker(player->GetGUID(), TEAM_ALLIANCE);
        UpdateFlagState(TEAM_ALLIANCE, BG_WS_FLAG_STATE_ON_PLAYER);
        player->CastSpell(player, BG_WS_SPELL_SILVERWING_FLAG, true);
        player->StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_SPELL_TARGET, BG_WS_SPELL_SILVERWING_FLAG_PICKED);

        PlaySoundToAll(BG_WS_SOUND_ALLIANCE_FLAG_PICKED_UP);
        SendMessageToAll(LANG_BG_WS_PICKEDUP_AF, CHAT_MSG_BG_SYSTEM_HORDE, player);

        if (GetFlagState(TEAM_HORDE) != BG_WS_FLAG_STATE_ON_BASE)
        {
            _bgEvents.RescheduleEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT10, BG_WS_SPELL_FORCE_TIME);
            _bgEvents.RescheduleEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT15, BG_WS_SPELL_BRUTAL_TIME);
        }
        return;
    }

    // Horde Flag picked up from base
    if (player->GetTeamId() == TEAM_ALLIANCE && GetFlagState(TEAM_HORDE) == BG_WS_FLAG_STATE_ON_BASE && BgObjects[BG_WS_OBJECT_H_FLAG] == gameObject->GetGUID())
    {
        SpawnBGObject(BG_WS_OBJECT_H_FLAG, RESPAWN_ONE_DAY);
        SetFlagPicker(player->GetGUID(), TEAM_HORDE);
        UpdateFlagState(TEAM_HORDE, BG_WS_FLAG_STATE_ON_PLAYER);
        player->CastSpell(player, BG_WS_SPELL_WARSONG_FLAG, true);
        player->StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_SPELL_TARGET, BG_WS_SPELL_WARSONG_FLAG_PICKED);

        PlaySoundToAll(BG_WS_SOUND_HORDE_FLAG_PICKED_UP);
        SendMessageToAll(LANG_BG_WS_PICKEDUP_HF, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);

        if (GetFlagState(TEAM_ALLIANCE) != BG_WS_FLAG_STATE_ON_BASE)
        {
            _bgEvents.RescheduleEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT10, BG_WS_SPELL_FORCE_TIME);
            _bgEvents.RescheduleEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT15, BG_WS_SPELL_BRUTAL_TIME);
        }
        return;
    }
    if (player->IsMounted())
    {
        player->Dismount();
        player->RemoveAurasByType(SPELL_AURA_MOUNTED);
    }
    // Alliance Flag on ground
    if (GetFlagState(TEAM_ALLIANCE) == BG_WS_FLAG_STATE_ON_GROUND && player->IsWithinDistInMap(gameObject, 10.0f) && gameObject->GetEntry() == BG_OBJECT_A_FLAG_GROUND_WS_ENTRY)
    {
        SetDroppedFlagGUID(0, TEAM_ALLIANCE);
        if (player->GetTeamId() == TEAM_ALLIANCE)
        {
            UpdateFlagState(TEAM_ALLIANCE, BG_WS_FLAG_STATE_ON_BASE);
            SpawnBGObject(BG_WS_OBJECT_A_FLAG, RESPAWN_IMMEDIATELY);
            UpdatePlayerScore(player, SCORE_FLAG_RETURNS, 1);

            PlaySoundToAll(BG_WS_SOUND_FLAG_RETURNED);
            SendMessageToAll(LANG_BG_WS_RETURNED_AF, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
            _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT10);
            _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT15);
            RemoveAssaultAuras();
            return;
        }
        else
        {
            SetFlagPicker(player->GetGUID(), TEAM_ALLIANCE);
            UpdateFlagState(TEAM_ALLIANCE, BG_WS_FLAG_STATE_ON_PLAYER);
            player->CastSpell(player, BG_WS_SPELL_SILVERWING_FLAG, true);
            if (uint32 assaultSpellId = GetAssaultSpellId())
              player->CastSpell(player, assaultSpellId, true);

            PlaySoundToAll(BG_WS_SOUND_ALLIANCE_FLAG_PICKED_UP);
            SendMessageToAll(LANG_BG_WS_PICKEDUP_AF, CHAT_MSG_BG_SYSTEM_HORDE, player);
            return;
        }
    }

    // Horde Flag on ground
    if (GetFlagState(TEAM_HORDE) == BG_WS_FLAG_STATE_ON_GROUND && player->IsWithinDistInMap(gameObject, 10.0f) && gameObject->GetEntry() == BG_OBJECT_H_FLAG_GROUND_WS_ENTRY)
    {
        SetDroppedFlagGUID(0, TEAM_HORDE);
        if (player->GetTeamId() == TEAM_HORDE)
        {
            UpdateFlagState(TEAM_HORDE, BG_WS_FLAG_STATE_ON_BASE);
            SpawnBGObject(BG_WS_OBJECT_H_FLAG, RESPAWN_IMMEDIATELY);
            UpdatePlayerScore(player, SCORE_FLAG_RETURNS, 1);

            PlaySoundToAll(BG_WS_SOUND_FLAG_RETURNED);
            SendMessageToAll(LANG_BG_WS_RETURNED_HF, CHAT_MSG_BG_SYSTEM_HORDE, player);
            _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT10);
            _bgEvents.CancelEvent(BG_WS_EVENT_BOTH_FLAGS_KEPT15);
            RemoveAssaultAuras();
            return;
        }
        else
        {
            SetFlagPicker(player->GetGUID(), TEAM_HORDE);
            UpdateFlagState(TEAM_HORDE, BG_WS_FLAG_STATE_ON_PLAYER);
            player->CastSpell(player, BG_WS_SPELL_WARSONG_FLAG, true);
            if (uint32 assaultSpellId = GetAssaultSpellId())
              player->CastSpell(player, assaultSpellId, true);

            PlaySoundToAll(BG_WS_SOUND_HORDE_FLAG_PICKED_UP);
            SendMessageToAll(LANG_BG_WS_PICKEDUP_HF, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
            return;
        }
    }
}

void BattlegroundWS::RemovePlayer(Player* player)
{
    if (GetFlagPickerGUID(TEAM_ALLIANCE) == player->GetGUID() || GetFlagPickerGUID(TEAM_HORDE) == player->GetGUID())
        EventPlayerDroppedFlag(player);
}

void BattlegroundWS::UpdateFlagState(TeamId teamId, uint32 value)
{
    _flagState[teamId] = value;
    UpdateWorldState(teamId == TEAM_ALLIANCE ? BG_WS_FLAG_STATE_HORDE : BG_WS_FLAG_STATE_ALLIANCE, value);
}

void BattlegroundWS::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS || !player->IsAlive())
        return;

    switch (trigger)
    {
        case 3646: // Alliance Flag spawn
            if (GetFlagState(TEAM_ALLIANCE) == BG_WS_FLAG_STATE_ON_BASE && GetFlagPickerGUID(TEAM_HORDE) == player->GetGUID())
                EventPlayerCapturedFlag(player);
            break;
        case 3647: // Horde Flag spawn
            if (GetFlagState(TEAM_HORDE) == BG_WS_FLAG_STATE_ON_BASE && GetFlagPickerGUID(TEAM_ALLIANCE) == player->GetGUID())
                EventPlayerCapturedFlag(player);
            break;
        case 3649: // Not used
        case 3688: // Not used
        case 4628: // Not used
        case 4629: // Not used
        case 3686: // Alliance elixir of speed spawn
        case 3687: // Horde elixir of speed spawn
        case 3706: // Alliance elixir of regeneration spawn
        case 3708: // Horde elixir of regeneration spawn
        case 3707: // Alliance elixir of berserk spawn
        case 3709: // Horde elixir of berserk spawn
            break;
    }
}

bool BattlegroundWS::SetupBattleground()
{
    // flags
    AddObject(BG_WS_OBJECT_A_FLAG, BG_OBJECT_A_FLAG_WS_ENTRY, 1540.423f, 1481.325f, 351.8284f, 3.089233f, 0, 0, 0.9996573f, 0.02617699f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_H_FLAG, BG_OBJECT_H_FLAG_WS_ENTRY, 916.0226f, 1434.405f, 345.413f, 0.01745329f, 0, 0, 0.008726535f, 0.9999619f, RESPAWN_IMMEDIATELY);
        // buffs
    AddObject(BG_WS_OBJECT_SPEEDBUFF_1, BG_OBJECTID_SPEEDBUFF_ENTRY, 1449.93f, 1470.71f, 342.6346f, -1.64061f, 0, 0, 0.7313537f, -0.6819983f, BUFF_RESPAWN_TIME);
    AddObject(BG_WS_OBJECT_SPEEDBUFF_2, BG_OBJECTID_SPEEDBUFF_ENTRY, 1005.171f, 1447.946f, 335.9032f, 1.64061f, 0, 0, 0.7313537f, 0.6819984f, BUFF_RESPAWN_TIME);
    AddObject(BG_WS_OBJECT_REGENBUFF_1, BG_OBJECTID_REGENBUFF_ENTRY, 1317.506f, 1550.851f, 313.2344f, -0.2617996f, 0, 0, 0.1305263f, -0.9914448f, BUFF_RESPAWN_TIME);
    AddObject(BG_WS_OBJECT_REGENBUFF_2, BG_OBJECTID_REGENBUFF_ENTRY, 1110.451f, 1353.656f, 316.5181f, -0.6806787f, 0, 0, 0.333807f, -0.9426414f, BUFF_RESPAWN_TIME);
    AddObject(BG_WS_OBJECT_BERSERKBUFF_1, BG_OBJECTID_BERSERKERBUFF_ENTRY, 1320.09f, 1378.79f, 314.7532f, 1.186824f, 0, 0, 0.5591929f, 0.8290376f, BUFF_RESPAWN_TIME);
    AddObject(BG_WS_OBJECT_BERSERKBUFF_2, BG_OBJECTID_BERSERKERBUFF_ENTRY, 1139.688f, 1560.288f, 306.8432f, -2.443461f, 0, 0, 0.9396926f, -0.3420201f, BUFF_RESPAWN_TIME);
        // alliance gates
    AddObject(BG_WS_OBJECT_DOOR_A_1, BG_OBJECT_DOOR_A_1_WS_ENTRY, 1503.335f, 1493.466f, 352.1888f, 3.115414f, 0, 0, 0.9999143f, 0.01308903f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_A_2, BG_OBJECT_DOOR_A_2_WS_ENTRY, 1492.478f, 1457.912f, 342.9689f, 3.115414f, 0, 0, 0.9999143f, 0.01308903f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_A_3, BG_OBJECT_DOOR_A_3_WS_ENTRY, 1468.503f, 1494.357f, 351.8618f, 3.115414f, 0, 0, 0.9999143f, 0.01308903f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_A_4, BG_OBJECT_DOOR_A_4_WS_ENTRY, 1471.555f, 1458.778f, 362.6332f, 3.115414f, 0, 0, 0.9999143f, 0.01308903f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_A_5, BG_OBJECT_DOOR_A_5_WS_ENTRY, 1492.347f, 1458.34f, 342.3712f, -0.03490669f, 0, 0, 0.01745246f, -0.9998477f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_A_6, BG_OBJECT_DOOR_A_6_WS_ENTRY, 1503.466f, 1493.367f, 351.7352f, -0.03490669f, 0, 0, 0.01745246f, -0.9998477f, RESPAWN_IMMEDIATELY);
        // horde gates
    AddObject(BG_WS_OBJECT_DOOR_H_1, BG_OBJECT_DOOR_H_1_WS_ENTRY, 949.1663f, 1423.772f, 345.6241f, -0.5756807f, -0.01673368f, -0.004956111f, -0.2839723f, 0.9586737f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_H_2, BG_OBJECT_DOOR_H_2_WS_ENTRY, 953.0507f, 1459.842f, 340.6526f, -1.99662f, -0.1971825f, 0.1575096f, -0.8239487f, 0.5073641f, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_H_3, BG_OBJECT_DOOR_H_3_WS_ENTRY, 949.9523f, 1422.751f, 344.9273f, 0.0f, 0, 0, 0, 1, RESPAWN_IMMEDIATELY);
    AddObject(BG_WS_OBJECT_DOOR_H_4, BG_OBJECT_DOOR_H_4_WS_ENTRY, 950.7952f, 1459.583f, 342.1523f, 0.05235988f, 0, 0, 0.02617695f, 0.9996573f, RESPAWN_IMMEDIATELY);
    

    GraveyardStruct const* sg = sGraveyard->GetGraveyard(WS_GRAVEYARD_MAIN_ALLIANCE);
    AddSpiritGuide(WS_SPIRIT_MAIN_ALLIANCE, sg->x, sg->y, sg->z, 3.124139f, TEAM_ALLIANCE);

    sg = sGraveyard->GetGraveyard(WS_GRAVEYARD_MAIN_HORDE);
    AddSpiritGuide(WS_SPIRIT_MAIN_HORDE, sg->x, sg->y, sg->z, 3.193953f, TEAM_HORDE);

    for (uint32 i = BG_WS_OBJECT_DOOR_A_1; i < BG_WS_OBJECT_MAX; ++i)
        if (BgObjects[i] == 0)
        {
            sLog->outErrorDb("BatteGroundWS: Failed to spawn some object Battleground not created!");
            return false;
        }

    for (uint32 i = WS_SPIRIT_MAIN_ALLIANCE; i < BG_CREATURES_MAX_WS; ++i)
        if (BgCreatures[i] == 0)
        {
            sLog->outErrorDb("BatteGroundWS: Failed to spawn spirit guides Battleground not created!");
            return false;
        }

    return true;
}

void BattlegroundWS::Init()
{
    //call parent's class reset
    Battleground::Init();

    _bgEvents.Reset();
    _flagKeepers[TEAM_ALLIANCE]     = 0;
    _flagKeepers[TEAM_HORDE]        = 0;
    _droppedFlagGUID[TEAM_ALLIANCE] = 0;
    _droppedFlagGUID[TEAM_HORDE]    = 0;
    _flagState[TEAM_ALLIANCE]       = BG_WS_FLAG_STATE_ON_BASE;
    _flagState[TEAM_HORDE]          = BG_WS_FLAG_STATE_ON_BASE;
    _lastFlagCaptureTeam            = TEAM_NEUTRAL;

    if (sBattlegroundMgr->IsBGWeekend(GetBgTypeID(true)))
    {
        _reputationCapture = 45;
        _honorWinKills = 3;
        _honorEndKills = 4;
    }
    else
    {
        _reputationCapture = 35;
        _honorWinKills = 1;
        _honorEndKills = 2;
    }
}

void BattlegroundWS::EndBattleground(TeamId winnerTeamId)
{
    // Win reward
    RewardHonorToTeam(GetBonusHonorFromKill(_honorWinKills), winnerTeamId);

    // Complete map_end rewards (even if no team wins)
    RewardHonorToTeam(GetBonusHonorFromKill(_honorEndKills), TEAM_ALLIANCE);
    RewardHonorToTeam(GetBonusHonorFromKill(_honorEndKills), TEAM_HORDE);

    Battleground::EndBattleground(winnerTeamId);
}

void BattlegroundWS::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    EventPlayerDroppedFlag(player);
    Battleground::HandleKillPlayer(player, killer);
}

void BattlegroundWS::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    BattlegroundScoreMap::iterator itr = PlayerScores.find(player->GetGUID());
    if (itr == PlayerScores.end())
        return;

    switch (type)
    {
        case SCORE_FLAG_CAPTURES:
            ((BattlegroundWGScore*)itr->second)->FlagCaptures += value;
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, WS_OBJECTIVE_CAPTURE_FLAG);
            break;
        case SCORE_FLAG_RETURNS:
            ((BattlegroundWGScore*)itr->second)->FlagReturns += value;
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, WS_OBJECTIVE_RETURN_FLAG);
            break;
        default:
            Battleground::UpdatePlayerScore(player, type, value, doAddHonor);
            break;
    }
}

GraveyardStruct const* BattlegroundWS::GetClosestGraveyard(Player* player)
{
    if (GetStatus() == STATUS_IN_PROGRESS)
        return sGraveyard->GetGraveyard(player->GetTeamId() == TEAM_ALLIANCE ? WS_GRAVEYARD_MAIN_ALLIANCE : WS_GRAVEYARD_MAIN_HORDE);
    else
        return sGraveyard->GetGraveyard(player->GetTeamId() == TEAM_ALLIANCE ? WS_GRAVEYARD_FLAGROOM_ALLIANCE : WS_GRAVEYARD_FLAGROOM_HORDE);
}

void BattlegroundWS::FillInitialWorldStates(WorldPacket& data)
{
    data << uint32(BG_WS_FLAG_CAPTURES_ALLIANCE) << uint32(GetTeamScore(TEAM_ALLIANCE));
    data << uint32(BG_WS_FLAG_CAPTURES_HORDE) << uint32(GetTeamScore(TEAM_HORDE));
    data << uint32(BG_WS_FLAG_CAPTURES_MAX) << uint32(BG_WS_MAX_TEAM_SCORE);

    data << uint32(BG_WS_STATE_TIMER_ACTIVE) << uint32(GetStatus() == STATUS_IN_PROGRESS);
    data << uint32(BG_WS_STATE_TIMER) << uint32(GetMatchTime());

    data << uint32(BG_WS_FLAG_STATE_HORDE) << uint32(GetFlagState(TEAM_HORDE));
    data << uint32(BG_WS_FLAG_STATE_ALLIANCE) << uint32(GetFlagState(TEAM_ALLIANCE));
}

TeamId BattlegroundWS::GetPrematureWinner()
{
    if (GetTeamScore(TEAM_ALLIANCE) > GetTeamScore(TEAM_HORDE))
        return TEAM_ALLIANCE;

    return GetTeamScore(TEAM_HORDE) > GetTeamScore(TEAM_ALLIANCE) ? TEAM_HORDE : Battleground::GetPrematureWinner();
}

uint32 BattlegroundWS::GetAssaultSpellId() const
{
    if ((GetFlagPickerGUID(TEAM_ALLIANCE) == 0 && GetFlagState(TEAM_ALLIANCE) != BG_WS_FLAG_STATE_ON_GROUND) || 
        (GetFlagPickerGUID(TEAM_HORDE) == 0 && GetFlagState(TEAM_HORDE) != BG_WS_FLAG_STATE_ON_GROUND) || 
        _bgEvents.GetNextEventTime(BG_WS_EVENT_BOTH_FLAGS_KEPT10) > 0)
        return 0;

    return _bgEvents.GetNextEventTime(BG_WS_EVENT_BOTH_FLAGS_KEPT15) > 0 ? BG_WS_SPELL_FOCUSED_ASSAULT : BG_WS_SPELL_BRUTAL_ASSAULT;
}

void BattlegroundWS::RemoveAssaultAuras()
{
    if (Player* player = ObjectAccessor::GetObjectInMap(GetFlagPickerGUID(TEAM_ALLIANCE), this->FindBgMap(), (Player*)NULL))
    {
        player->RemoveAurasDueToSpell(BG_WS_SPELL_FOCUSED_ASSAULT);
        player->RemoveAurasDueToSpell(BG_WS_SPELL_BRUTAL_ASSAULT);
    }
    if (Player* player = ObjectAccessor::GetObjectInMap(GetFlagPickerGUID(TEAM_HORDE), this->FindBgMap(), (Player*)NULL))
    {
        player->RemoveAurasDueToSpell(BG_WS_SPELL_FOCUSED_ASSAULT);
        player->RemoveAurasDueToSpell(BG_WS_SPELL_BRUTAL_ASSAULT);
    }
}
