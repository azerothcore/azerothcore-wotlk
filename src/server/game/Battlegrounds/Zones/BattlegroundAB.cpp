/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: http://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "BattlegroundAB.h"
#include "World.h"
#include "WorldPacket.h"
#include "ObjectMgr.h"
#include "BattlegroundMgr.h"
#include "Creature.h"
#include "Language.h"
#include "Object.h"
#include "Player.h"
#include "Util.h"
#include "WorldSession.h"
#include "GameGraveyard.h"

BattlegroundAB::BattlegroundAB()
{
    m_BuffChange = true;
    BgObjects.resize(BG_AB_OBJECT_MAX);
    BgCreatures.resize(BG_AB_ALL_NODES_COUNT + BG_AB_DYNAMIC_NODES_COUNT); // xinef: +BG_AB_DYNAMIC_NODES_COUNT buff triggers

    _controlledPoints[TEAM_ALLIANCE] = 0;
    _controlledPoints[TEAM_HORDE] = 0;
    _teamScores500Disadvantage[TEAM_ALLIANCE] = false;
    _teamScores500Disadvantage[TEAM_HORDE] = false;
    _honorTics = 0;
    _reputationTics = 0;

    StartMessageIds[BG_STARTING_EVENT_FIRST]  = LANG_BG_AB_START_TWO_MINUTES;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_BG_AB_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD]  = LANG_BG_AB_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_BG_AB_HAS_BEGUN;
}

BattlegroundAB::~BattlegroundAB() = default;

void BattlegroundAB::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() == STATUS_IN_PROGRESS)
    {
        _bgEvents.Update(diff);
        while (uint32 eventId =_bgEvents.ExecuteEvent())
            switch (eventId)
            {
                case BG_AB_EVENT_UPDATE_BANNER_STABLE:
                case BG_AB_EVENT_UPDATE_BANNER_FARM:
                case BG_AB_EVENT_UPDATE_BANNER_BLACKSMITH:
                case BG_AB_EVENT_UPDATE_BANNER_LUMBERMILL:
                case BG_AB_EVENT_UPDATE_BANNER_GOLDMINE:
                    CreateBanner(eventId - BG_AB_EVENT_UPDATE_BANNER_STABLE, false);
                    break;
                case BG_AB_EVENT_CAPTURE_STABLE:
                case BG_AB_EVENT_CAPTURE_FARM:
                case BG_AB_EVENT_CAPTURE_BLACKSMITH:
                case BG_AB_EVENT_CAPTURE_LUMBERMILL:
                case BG_AB_EVENT_CAPTURE_GOLDMINE:
                {
                    uint8 node = eventId - BG_AB_EVENT_CAPTURE_STABLE;
                    TeamId teamId = _capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_CONTESTED ? TEAM_ALLIANCE : TEAM_HORDE;
                    DeleteBanner(node);
                    _capturePointInfo[node]._ownerTeamId = teamId;
                    _capturePointInfo[node]._state = teamId == TEAM_ALLIANCE ? BG_AB_NODE_STATE_ALLY_OCCUPIED : BG_AB_NODE_STATE_HORDE_OCCUPIED;
                    _capturePointInfo[node]._captured = true;

                    CreateBanner(node, false);
                    NodeOccupied(node);
                    SendNodeUpdate(node);

                    SendMessage2ToAll(LANG_BG_AB_NODE_TAKEN, teamId == TEAM_ALLIANCE ? CHAT_MSG_BG_SYSTEM_ALLIANCE : CHAT_MSG_BG_SYSTEM_HORDE, nullptr, teamId == TEAM_ALLIANCE ? LANG_BG_AB_ALLY : LANG_BG_AB_HORDE, LANG_BG_AB_NODE_STABLES + node);
                    PlaySoundToAll(teamId == TEAM_ALLIANCE ? BG_AB_SOUND_NODE_CAPTURED_ALLIANCE : BG_AB_SOUND_NODE_CAPTURED_HORDE);
                    break;
                }
                case BG_AB_EVENT_ALLIANCE_TICK:
                case BG_AB_EVENT_HORDE_TICK:
                {
                    auto teamId = TeamId(eventId - BG_AB_EVENT_ALLIANCE_TICK);
                    uint8 controlledPoints = _controlledPoints[teamId];
                    if (controlledPoints == 0)
                    {
                        _bgEvents.ScheduleEvent(eventId, 3000);
                        break;
                    }

                    auto honorRewards = uint8(m_TeamScores[teamId] / _honorTics);
                    auto reputationRewards = uint8(m_TeamScores[teamId] / _reputationTics);
                    auto information = uint8(m_TeamScores[teamId] / BG_AB_WARNING_NEAR_VICTORY_SCORE);
                    m_TeamScores[teamId] += BG_AB_TickPoints[controlledPoints];
                    if (m_TeamScores[teamId] > BG_AB_MAX_TEAM_SCORE)
                        m_TeamScores[teamId] = BG_AB_MAX_TEAM_SCORE;

                    if (honorRewards < uint8(m_TeamScores[teamId] / _honorTics))
                        RewardHonorToTeam(GetBonusHonorFromKill(1), teamId);
                    if (reputationRewards < uint8(m_TeamScores[teamId] / _reputationTics))
                        RewardReputationToTeam(teamId == TEAM_ALLIANCE ? 509 : 510, 10, teamId);
                    if (information < uint8(m_TeamScores[teamId] / BG_AB_WARNING_NEAR_VICTORY_SCORE))
                    {
                        SendMessageToAll(teamId == TEAM_ALLIANCE ? LANG_BG_AB_A_NEAR_VICTORY : LANG_BG_AB_H_NEAR_VICTORY, CHAT_MSG_BG_SYSTEM_NEUTRAL);
                        PlaySoundToAll(BG_AB_SOUND_NEAR_VICTORY);
                    }

                    UpdateWorldState(teamId == TEAM_ALLIANCE ? BG_AB_OP_RESOURCES_ALLY : BG_AB_OP_RESOURCES_HORDE, m_TeamScores[teamId]);
                    if (m_TeamScores[teamId] > m_TeamScores[GetOtherTeamId(teamId)] + 500)
                        _teamScores500Disadvantage[GetOtherTeamId(teamId)] = true;
                    if (m_TeamScores[teamId] >= BG_AB_MAX_TEAM_SCORE)
                        EndBattleground(teamId);

                    _bgEvents.ScheduleEvent(eventId, BG_AB_TickIntervals[controlledPoints]);
                    break;
                }
                default:
                    break;
            }
    }
}

void BattlegroundAB::StartingEventCloseDoors()
{

    for (uint32 obj = BG_AB_OBJECT_BANNER_NEUTRAL; obj < BG_AB_DYNAMIC_NODES_COUNT * BG_AB_OBJECTS_PER_NODE; ++obj)
        SpawnBGObject(obj, RESPAWN_ONE_DAY);
    for (uint32 i = 0; i < BG_AB_DYNAMIC_NODES_COUNT * 3; ++i)
        SpawnBGObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + i, RESPAWN_ONE_DAY);

    // Starting doors
    SpawnBGObject(BG_AB_OBJECT_GATE_A, RESPAWN_IMMEDIATELY);
    SpawnBGObject(BG_AB_OBJECT_GATE_H, RESPAWN_IMMEDIATELY);
    DoorClose(BG_AB_OBJECT_GATE_A);
    DoorClose(BG_AB_OBJECT_GATE_H);
}

void BattlegroundAB::StartingEventOpenDoors()
{
    for (uint32 banner = BG_AB_OBJECT_BANNER_NEUTRAL, i = 0; i < BG_AB_DYNAMIC_NODES_COUNT; banner += BG_AB_OBJECTS_PER_NODE, ++i)
        SpawnBGObject(banner, RESPAWN_IMMEDIATELY);

    for (uint32 i = 0; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
        SpawnBGObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + urand(0, 2) + i * 3, RESPAWN_IMMEDIATELY);

    DoorOpen(BG_AB_OBJECT_GATE_A);
    DoorOpen(BG_AB_OBJECT_GATE_H);
    StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, BG_AB_EVENT_START_BATTLE);
    _bgEvents.ScheduleEvent(BG_AB_EVENT_ALLIANCE_TICK, 3000);
    _bgEvents.ScheduleEvent(BG_AB_EVENT_HORDE_TICK, 3000);
}

void BattlegroundAB::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundABScore(player);
}

void BattlegroundAB::RemovePlayer(Player* player)
{
    player->SetPhaseMask(1, false);
}

void BattlegroundAB::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 3948:                                          // Arathi Basin Alliance Exit.
            if (player->GetTeamId() != TEAM_ALLIANCE)
                player->GetSession()->SendAreaTriggerMessage("Only The Alliance can use that portal");
            else
                player->LeaveBattleground();
            break;
        case 3949:                                          // Arathi Basin Horde Exit.
            if (player->GetTeamId() != TEAM_HORDE)
                player->GetSession()->SendAreaTriggerMessage("Only The Horde can use that portal");
            else
                player->LeaveBattleground();
            break;
        case 3866:                                          // Stables
        case 3869:                                          // Gold Mine
        case 3867:                                          // Farm
        case 3868:                                          // Lumber Mill
        case 3870:                                          // Black Smith
        case 4020:                                          // Unk1
        case 4021:                                          // Unk2
            break;
        default:
            break;
    }
}

void BattlegroundAB::CreateBanner(uint8 node, bool delay)
{
    // Just put it into the queue
    if (delay)
    {
        _bgEvents.RescheduleEvent(BG_AB_EVENT_UPDATE_BANNER_STABLE+node, BG_AB_BANNER_UPDATE_TIME);
        return;
    }

    SpawnBGObject(node*BG_AB_OBJECTS_PER_NODE + _capturePointInfo[node]._state, RESPAWN_IMMEDIATELY);
    SpawnBGObject(node*BG_AB_OBJECTS_PER_NODE + BG_AB_OBJECT_AURA_ALLY + _capturePointInfo[node]._ownerTeamId, RESPAWN_IMMEDIATELY);
}

void BattlegroundAB::DeleteBanner(uint8 node)
{
    SpawnBGObject(node*BG_AB_OBJECTS_PER_NODE + _capturePointInfo[node]._state, RESPAWN_ONE_DAY);
    SpawnBGObject(node*BG_AB_OBJECTS_PER_NODE + BG_AB_OBJECT_AURA_ALLY + _capturePointInfo[node]._ownerTeamId, RESPAWN_ONE_DAY);
}

void BattlegroundAB::FillInitialWorldStates(WorldPacket& data)
{
    for (auto & node : _capturePointInfo)
    {
        if (node._state == BG_AB_NODE_STATE_NEUTRAL)
            data << uint32(node._iconNone) << uint32(1);

        for (uint8 i = BG_AB_NODE_STATE_ALLY_OCCUPIED; i <= BG_AB_NODE_STATE_HORDE_CONTESTED; ++i)
            data << uint32(node._iconCapture + i-1) << uint32(node._state == i);
    }

    data << uint32(BG_AB_OP_OCCUPIED_BASES_ALLY)  << uint32(_controlledPoints[TEAM_ALLIANCE]);
    data << uint32(BG_AB_OP_OCCUPIED_BASES_HORDE) << uint32(_controlledPoints[TEAM_HORDE]);
    data << uint32(BG_AB_OP_RESOURCES_MAX)      << uint32(BG_AB_MAX_TEAM_SCORE);
    data << uint32(BG_AB_OP_RESOURCES_WARNING)  << uint32(BG_AB_WARNING_NEAR_VICTORY_SCORE);
    data << uint32(BG_AB_OP_RESOURCES_ALLY)     << uint32(m_TeamScores[TEAM_ALLIANCE]);
    data << uint32(BG_AB_OP_RESOURCES_HORDE)    << uint32(m_TeamScores[TEAM_HORDE]);
    data << uint32(0x745) << uint32(0x2);           // 37 1861 unk
}

void BattlegroundAB::SendNodeUpdate(uint8 node)
{
    UpdateWorldState(_capturePointInfo[node]._iconNone, 0);
    for (uint8 i = BG_AB_NODE_STATE_ALLY_OCCUPIED; i <= BG_AB_NODE_STATE_HORDE_CONTESTED; ++i)
        UpdateWorldState(_capturePointInfo[node]._iconCapture + i-1, _capturePointInfo[node]._state == i);

    UpdateWorldState(BG_AB_OP_OCCUPIED_BASES_ALLY, _controlledPoints[TEAM_ALLIANCE]);
    UpdateWorldState(BG_AB_OP_OCCUPIED_BASES_HORDE, _controlledPoints[TEAM_HORDE]);
}

void BattlegroundAB::NodeOccupied(uint8 node)
{
    ApplyPhaseMask();
    AddSpiritGuide(node, BG_AB_SpiritGuidePos[node][0], BG_AB_SpiritGuidePos[node][1], BG_AB_SpiritGuidePos[node][2], BG_AB_SpiritGuidePos[node][3], _capturePointInfo[node]._ownerTeamId);

    ++_controlledPoints[_capturePointInfo[node]._ownerTeamId];
    if (_controlledPoints[_capturePointInfo[node]._ownerTeamId] >= 5)
        CastSpellOnTeam(SPELL_AB_QUEST_REWARD_5_BASES, _capturePointInfo[node]._ownerTeamId);
    if (_controlledPoints[_capturePointInfo[node]._ownerTeamId] >= 4)
        CastSpellOnTeam(SPELL_AB_QUEST_REWARD_4_BASES, _capturePointInfo[node]._ownerTeamId);

    Creature* trigger = GetBgMap()->GetCreature(BgCreatures[BG_AB_ALL_NODES_COUNT + node]);
    if (!trigger)
        trigger = AddCreature(WORLD_TRIGGER, BG_AB_ALL_NODES_COUNT + node, BG_AB_NodePositions[node][0], BG_AB_NodePositions[node][1], BG_AB_NodePositions[node][2], BG_AB_NodePositions[node][3]);

    if (trigger)
    {
        trigger->setFaction(_capturePointInfo[node]._ownerTeamId == TEAM_ALLIANCE ? 84 : 83);
        trigger->CastSpell(trigger, SPELL_HONORABLE_DEFENDER_25Y, false);
    }
}

void BattlegroundAB::NodeDeoccupied(uint8 node)
{
    --_controlledPoints[_capturePointInfo[node]._ownerTeamId];

    _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;
    RelocateDeadPlayers(BgCreatures[node]);

    DelCreature(node); // Delete spirit healer
    DelCreature(BG_AB_ALL_NODES_COUNT + node); // Delete aura trigger
}

void BattlegroundAB::EventPlayerClickedOnFlag(Player* player, GameObject* gameObject)
{
    if (GetStatus() != STATUS_IN_PROGRESS || !player->IsWithinDistInMap(gameObject, 10.0f))
        return;

    uint8 node = BG_AB_NODE_STABLES;
    for (; node < BG_AB_DYNAMIC_NODES_COUNT; ++node)
        if (player->GetDistance2d(BG_AB_NodePositions[node][0], BG_AB_NodePositions[node][1]) < 10.0f)
            break;

    if (node == BG_AB_DYNAMIC_NODES_COUNT || _capturePointInfo[node]._ownerTeamId == player->GetTeamId() || 
        (_capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_CONTESTED && player->GetTeamId() == TEAM_ALLIANCE) ||
        (_capturePointInfo[node]._state == BG_AB_NODE_STATE_HORDE_CONTESTED && player->GetTeamId() == TEAM_HORDE))
        return;

    player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);

    uint32 sound = 0;
    uint32 message = 0;
    uint32 message2 = 0;
    DeleteBanner(node);
    CreateBanner(node, true);

    if (_capturePointInfo[node]._state == BG_AB_NODE_STATE_NEUTRAL)
    {
        player->KilledMonsterCredit(BG_AB_QUEST_CREDIT_BASE + node, 0);
        UpdatePlayerScore(player, SCORE_BASES_ASSAULTED, 1);
        _capturePointInfo[node]._state = BG_AB_NODE_STATE_ALLY_CONTESTED + player->GetTeamId();
        _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;
        _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);
        sound = BG_AB_SOUND_NODE_CLAIMED;
        message = LANG_BG_AB_NODE_CLAIMED;
        message2 = player->GetTeamId() == TEAM_ALLIANCE ? LANG_BG_AB_ALLY : LANG_BG_AB_HORDE;
    }
    else if (_capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_CONTESTED || _capturePointInfo[node]._state == BG_AB_NODE_STATE_HORDE_CONTESTED)
    {
        if (!_capturePointInfo[node]._captured)
        {
            player->KilledMonsterCredit(BG_AB_QUEST_CREDIT_BASE + node, 0);
            UpdatePlayerScore(player, SCORE_BASES_ASSAULTED, 1);
            _capturePointInfo[node]._state = BG_AB_NODE_STATE_ALLY_CONTESTED + player->GetTeamId();
            _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;
            _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);
            message = LANG_BG_AB_NODE_ASSAULTED;
        }
        else
        {
            UpdatePlayerScore(player, SCORE_BASES_DEFENDED, 1);
            _capturePointInfo[node]._state = BG_AB_NODE_STATE_ALLY_OCCUPIED + player->GetTeamId();
            _capturePointInfo[node]._ownerTeamId = player->GetTeamId();
            _bgEvents.CancelEvent(BG_AB_EVENT_CAPTURE_STABLE + node);
            NodeOccupied(node); // after setting team owner
            message = LANG_BG_AB_NODE_DEFENDED;
        }
        sound = player->GetTeamId() == TEAM_ALLIANCE ? BG_AB_SOUND_NODE_ASSAULTED_ALLIANCE : BG_AB_SOUND_NODE_ASSAULTED_HORDE;
    }
    else
    {
        player->KilledMonsterCredit(BG_AB_QUEST_CREDIT_BASE + node, 0);
        UpdatePlayerScore(player, SCORE_BASES_ASSAULTED, 1);
        NodeDeoccupied(node); // before setting team owner to neutral

        _capturePointInfo[node]._state = BG_AB_NODE_STATE_ALLY_CONTESTED + player->GetTeamId();

        ApplyPhaseMask();
        _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);
        message = LANG_BG_AB_NODE_ASSAULTED;
        sound = player->GetTeamId() == TEAM_ALLIANCE ? BG_AB_SOUND_NODE_ASSAULTED_ALLIANCE : BG_AB_SOUND_NODE_ASSAULTED_HORDE;
    }

    SendNodeUpdate(node);
    PlaySoundToAll(sound);
    SendMessage2ToAll(message, player->GetTeamId() == TEAM_ALLIANCE ? CHAT_MSG_BG_SYSTEM_ALLIANCE : CHAT_MSG_BG_SYSTEM_HORDE, player, LANG_BG_AB_NODE_STABLES + node, message2);
}

TeamId BattlegroundAB::GetPrematureWinner()
{
    if (_controlledPoints[TEAM_ALLIANCE] > _controlledPoints[TEAM_HORDE])
        return TEAM_ALLIANCE;
    return _controlledPoints[TEAM_HORDE] > _controlledPoints[TEAM_ALLIANCE] ? TEAM_HORDE : Battleground::GetPrematureWinner();
}

bool BattlegroundAB::SetupBattleground()
{
    for (uint32 i = 0; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
    {
        AddObject(BG_AB_OBJECT_BANNER_NEUTRAL + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_NODE_BANNER_0 + i, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_ALLY + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_BANNER_A, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_HORDE + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_BANNER_H, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_CONT_A + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_BANNER_CONT_A, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_CONT_H + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_BANNER_CONT_H, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_AURA_ALLY + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_AURA_A, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_AURA_HORDE + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_AURA_H, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_AURA_CONTESTED + BG_AB_OBJECTS_PER_NODE*i, BG_AB_OBJECTID_AURA_C, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, sin(BG_AB_NodePositions[i][3]/2), cos(BG_AB_NodePositions[i][3]/2), RESPAWN_ONE_DAY);
    }

    AddObject(BG_AB_OBJECT_GATE_A, BG_AB_OBJECTID_GATE_A, BG_AB_DoorPositions[0][0], BG_AB_DoorPositions[0][1], BG_AB_DoorPositions[0][2], BG_AB_DoorPositions[0][3], BG_AB_DoorPositions[0][4], BG_AB_DoorPositions[0][5], BG_AB_DoorPositions[0][6], BG_AB_DoorPositions[0][7], RESPAWN_IMMEDIATELY);
    AddObject(BG_AB_OBJECT_GATE_H, BG_AB_OBJECTID_GATE_H, BG_AB_DoorPositions[1][0], BG_AB_DoorPositions[1][1], BG_AB_DoorPositions[1][2], BG_AB_DoorPositions[1][3], BG_AB_DoorPositions[1][4], BG_AB_DoorPositions[1][5], BG_AB_DoorPositions[1][6], BG_AB_DoorPositions[1][7], RESPAWN_IMMEDIATELY);

    for (uint32 i = 0; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
    {
        AddObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + 3 * i, Buff_Entries[0], BG_AB_BuffPositions[i][0], BG_AB_BuffPositions[i][1], BG_AB_BuffPositions[i][2], BG_AB_BuffPositions[i][3], 0, 0, sin(BG_AB_BuffPositions[i][3]/2), cos(BG_AB_BuffPositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + 3 * i + 1, Buff_Entries[1], BG_AB_BuffPositions[i][0], BG_AB_BuffPositions[i][1], BG_AB_BuffPositions[i][2], BG_AB_BuffPositions[i][3], 0, 0, sin(BG_AB_BuffPositions[i][3]/2), cos(BG_AB_BuffPositions[i][3]/2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + 3 * i + 2, Buff_Entries[2], BG_AB_BuffPositions[i][0], BG_AB_BuffPositions[i][1], BG_AB_BuffPositions[i][2], BG_AB_BuffPositions[i][3], 0, 0, sin(BG_AB_BuffPositions[i][3]/2), cos(BG_AB_BuffPositions[i][3]/2), RESPAWN_ONE_DAY);
    }

    AddSpiritGuide(BG_AB_SPIRIT_ALIANCE, BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][0], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][1], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][2], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][3], TEAM_ALLIANCE);
    AddSpiritGuide(BG_AB_SPIRIT_HORDE, BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][0], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][1], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][2], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][3], TEAM_HORDE);

    for (uint32 i = BG_AB_OBJECT_BANNER_NEUTRAL; i < BG_AB_OBJECT_MAX; ++i)
        if (BgObjects[i] == 0)
        {
            sLog->outErrorDb("BatteGroundAB: Failed to spawn some object Battleground not created!");
            return false;
        }

    for (uint32 i = BG_AB_SPIRIT_ALIANCE; i <= BG_AB_SPIRIT_HORDE; ++i)
        if (BgCreatures[i] == 0)
        {
            sLog->outErrorDb("BatteGroundAB: Failed to spawn spirit guides Battleground not created!");
            return false;
        }

    return true;
}

void BattlegroundAB::Init()
{
    //call parent's class reset
    Battleground::Init();

    _bgEvents.Reset();

    _honorTics = BattlegroundMgr::IsBGWeekend(GetBgTypeID(true)) ? BG_AB_HONOR_TICK_WEEKEND : BG_AB_HONOR_TICK_NORMAL;
    _reputationTics = BattlegroundMgr::IsBGWeekend(GetBgTypeID(true)) ? BG_AB_REP_TICK_WEEKEND : BG_AB_REP_TICK_NORMAL;

    _capturePointInfo[BG_AB_NODE_STABLES]._iconNone = BG_AB_OP_STABLE_ICON;
    _capturePointInfo[BG_AB_NODE_FARM]._iconNone = BG_AB_OP_FARM_ICON;
    _capturePointInfo[BG_AB_NODE_BLACKSMITH]._iconNone = BG_AB_OP_BLACKSMITH_ICON;
    _capturePointInfo[BG_AB_NODE_LUMBER_MILL]._iconNone = BG_AB_OP_LUMBERMILL_ICON;
    _capturePointInfo[BG_AB_NODE_GOLD_MINE]._iconNone = BG_AB_OP_GOLDMINE_ICON;
    _capturePointInfo[BG_AB_NODE_STABLES]._iconCapture = BG_AB_OP_STABLE_STATE_ALIENCE;
    _capturePointInfo[BG_AB_NODE_FARM]._iconCapture = BG_AB_OP_FARM_STATE_ALIENCE;
    _capturePointInfo[BG_AB_NODE_BLACKSMITH]._iconCapture = BG_AB_OP_BLACKSMITH_STATE_ALIENCE;
    _capturePointInfo[BG_AB_NODE_LUMBER_MILL]._iconCapture = BG_AB_OP_LUMBERMILL_STATE_ALIENCE;
    _capturePointInfo[BG_AB_NODE_GOLD_MINE]._iconCapture = BG_AB_OP_GOLDMINE_STATE_ALIENCE;
}

void BattlegroundAB::EndBattleground(TeamId winnerTeamId)
{
    RewardHonorToTeam(GetBonusHonorFromKill(1), winnerTeamId);
    RewardHonorToTeam(GetBonusHonorFromKill(1), TEAM_HORDE);
    RewardHonorToTeam(GetBonusHonorFromKill(1), TEAM_ALLIANCE);
    Battleground::EndBattleground(winnerTeamId);
    _bgEvents.Reset();
}

GraveyardStruct const* BattlegroundAB::GetClosestGraveyard(Player* player)
{
    GraveyardStruct const* entry = sGraveyard->GetGraveyard(BG_AB_GraveyardIds[BG_AB_SPIRIT_ALIANCE + player->GetTeamId()]);
    GraveyardStruct const* nearestEntry = entry;

    float pX = player->GetPositionX();
    float pY = player->GetPositionY();
    float dist = (entry->x - pX)*(entry->x - pX)+(entry->y - pY)*(entry->y - pY);
    float minDist = dist;

    for (uint8 i = BG_AB_NODE_STABLES; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
        if (_capturePointInfo[i]._ownerTeamId == player->GetTeamId())
        {
            entry = sGraveyard->GetGraveyard(BG_AB_GraveyardIds[i]);
            dist = (entry->x - pX)*(entry->x - pX) + (entry->y - pY)*(entry->y - pY);
            if (dist < minDist)
            {
                minDist = dist;
                nearestEntry = entry;
            }
        }

    return nearestEntry;
}

void BattlegroundAB::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    auto itr = PlayerScores.find(player->GetGUID());
    if (itr == PlayerScores.end())
        return;

    switch (type)
    {
        case SCORE_BASES_ASSAULTED:
            ((BattlegroundABScore*)itr->second)->BasesAssaulted += value;
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, BG_AB_OBJECTIVE_ASSAULT_BASE);
            break;
        case SCORE_BASES_DEFENDED:
            ((BattlegroundABScore*)itr->second)->BasesDefended += value;
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, BG_AB_OBJECTIVE_DEFEND_BASE);
            break;
        default:
            Battleground::UpdatePlayerScore(player, type, value, doAddHonor);
            break;
    }
}

bool BattlegroundAB::AllNodesConrolledByTeam(TeamId teamId) const
{
    return _controlledPoints[teamId] == BG_AB_DYNAMIC_NODES_COUNT;
}

void BattlegroundAB::ApplyPhaseMask()
{
    uint32 phaseMask = 1;
    for (uint32 i = BG_AB_NODE_STABLES; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
        if (_capturePointInfo[i]._ownerTeamId != TEAM_NEUTRAL)
            phaseMask |= 1 << (i*2+1 + _capturePointInfo[i]._ownerTeamId);

    const BattlegroundPlayerMap& bgPlayerMap = GetPlayers();
    for (auto itr : bgPlayerMap)
    {
        itr.second->SetPhaseMask(phaseMask, false);
        itr.second->UpdateObjectVisibility(true, false);
    }
}
