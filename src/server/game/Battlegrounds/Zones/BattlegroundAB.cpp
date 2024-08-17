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

#include "BattlegroundAB.h"
#include "BattlegroundMgr.h"
#include "Creature.h"
#include "GameGraveyard.h"
#include "Player.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

//npcbot
#include "botdatamgr.h"
#include "botmgr.h"
//end npcbot

void BattlegroundABScore::BuildObjectivesBlock(WorldPacket& data)
{
    data << uint32(2);
    data << uint32(BasesAssaulted);
    data << uint32(BasesDefended);
}

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
}

BattlegroundAB::~BattlegroundAB() = default;

void BattlegroundAB::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() == STATUS_IN_PROGRESS)
    {
        _bgEvents.Update(diff);
        while (uint32 eventId = _bgEvents.ExecuteEvent())
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

                        if (teamId == TEAM_ALLIANCE)
                        {
                            SendBroadcastText(ABNodes[node].TextAllianceTaken, CHAT_MSG_BG_SYSTEM_ALLIANCE);
                            PlaySoundToAll(BG_AB_SOUND_NODE_CAPTURED_ALLIANCE);
                        }
                        else
                        {
                            SendBroadcastText(ABNodes[node].TextHordeTaken, CHAT_MSG_BG_SYSTEM_HORDE);
                            PlaySoundToAll(BG_AB_SOUND_NODE_CAPTURED_HORDE);
                        }

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
                            if (teamId == TEAM_ALLIANCE)
                            {
                                SendBroadcastText(BG_AB_TEXT_ALLIANCE_NEAR_VICTORY, CHAT_MSG_BG_SYSTEM_NEUTRAL);
                                PlaySoundToAll(BG_AB_SOUND_NEAR_VICTORY_ALLIANCE);
                            }
                            else
                            {
                                SendBroadcastText(BG_AB_TEXT_HORDE_NEAR_VICTORY, CHAT_MSG_BG_SYSTEM_NEUTRAL);
                                PlaySoundToAll(BG_AB_SOUND_NEAR_VICTORY_HORDE);
                            }
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
    for (uint32 obj = BG_AB_OBJECT_BANNER_NEUTRAL; obj < static_cast<uint8>(BG_AB_DYNAMIC_NODES_COUNT) * BG_AB_OBJECTS_PER_NODE; ++obj)
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
    PlayerScores.emplace(player->GetGUID().GetCounter(), new BattlegroundABScore(player->GetGUID()));
}

//npcbot
void BattlegroundAB::AddBot(Creature* bot)
{
    bool const isInBattleground = IsPlayerInBattleground(bot->GetGUID());
    Battleground::AddBot(bot);
    if (!isInBattleground)
        BotScores[bot->GetEntry()] = new BattlegroundABScore(bot->GetGUID());
}
//end npcbot

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
        _bgEvents.RescheduleEvent(BG_AB_EVENT_UPDATE_BANNER_STABLE + node, BG_AB_BANNER_UPDATE_TIME);
        return;
    }

    SpawnBGObject(node * BG_AB_OBJECTS_PER_NODE + _capturePointInfo[node]._state, RESPAWN_IMMEDIATELY);
    SpawnBGObject(node * BG_AB_OBJECTS_PER_NODE + BG_AB_OBJECT_AURA_ALLY + _capturePointInfo[node]._ownerTeamId, RESPAWN_IMMEDIATELY);
}

void BattlegroundAB::DeleteBanner(uint8 node)
{
    SpawnBGObject(node * BG_AB_OBJECTS_PER_NODE + _capturePointInfo[node]._state, RESPAWN_ONE_DAY);
    SpawnBGObject(node * BG_AB_OBJECTS_PER_NODE + BG_AB_OBJECT_AURA_ALLY + _capturePointInfo[node]._ownerTeamId, RESPAWN_ONE_DAY);
}

void BattlegroundAB::FillInitialWorldStates(WorldPacket& data)
{
    for (auto& node : _capturePointInfo)
    {
        if (node._state == BG_AB_NODE_STATE_NEUTRAL)
            data << uint32(node._iconNone) << uint32(1);

        for (uint8 i = BG_AB_NODE_STATE_ALLY_OCCUPIED; i <= BG_AB_NODE_STATE_HORDE_CONTESTED; ++i)
            data << uint32(node._iconCapture + i - 1) << uint32(node._state == i);
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
        UpdateWorldState(_capturePointInfo[node]._iconCapture + i - 1, _capturePointInfo[node]._state == i);

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
        trigger->SetFaction(_capturePointInfo[node]._ownerTeamId == TEAM_ALLIANCE ? FACTION_ALLIANCE_GENERIC : FACTION_HORDE_GENERIC);
        trigger->CastSpell(trigger, SPELL_HONORABLE_DEFENDER_25Y, false);
    }
}

void BattlegroundAB::NodeDeoccupied(uint8 node)
{
    --_controlledPoints[_capturePointInfo[node]._ownerTeamId];

    _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;

    _reviveEvents.AddEventAtOffset([this, node]()
    {
        RelocateDeadPlayers(BgCreatures[node]);
        DelCreature(node); // Delete spirit healer
    }, 500ms);

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
    TeamId teamid = player->GetTeamId();

    DeleteBanner(node);
    CreateBanner(node, true);

    if (_capturePointInfo[node]._state == BG_AB_NODE_STATE_NEUTRAL)
    {
        player->KilledMonsterCredit(BG_AB_QUEST_CREDIT_BASE + node);
        UpdatePlayerScore(player, SCORE_BASES_ASSAULTED, 1);
        _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_CONTESTED) + player->GetTeamId();
        _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;
        _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);
        sound = BG_AB_SOUND_NODE_CLAIMED;

        if (teamid == TEAM_ALLIANCE)
        {
            SendBroadcastText(ABNodes[node].TextAllianceClaims, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
        }
        else
        {
            SendBroadcastText(ABNodes[node].TextHordeClaims, CHAT_MSG_BG_SYSTEM_HORDE, player);
        }
    }
    else if (_capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_CONTESTED || _capturePointInfo[node]._state == BG_AB_NODE_STATE_HORDE_CONTESTED)
    {
        if (!_capturePointInfo[node]._captured)
        {
            player->KilledMonsterCredit(BG_AB_QUEST_CREDIT_BASE + node);
            UpdatePlayerScore(player, SCORE_BASES_ASSAULTED, 1);
            _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_CONTESTED) + player->GetTeamId();
            _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;
            _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);

            if (teamid == TEAM_ALLIANCE)
            {
                SendBroadcastText(ABNodes[node].TextAllianceAssaulted, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
            }
            else
            {
                SendBroadcastText(ABNodes[node].TextHordeAssaulted, CHAT_MSG_BG_SYSTEM_HORDE, player);
            }
        }
        else
        {
            UpdatePlayerScore(player, SCORE_BASES_DEFENDED, 1);
            _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_OCCUPIED) + player->GetTeamId();
            _capturePointInfo[node]._ownerTeamId = player->GetTeamId();
            _bgEvents.CancelEvent(BG_AB_EVENT_CAPTURE_STABLE + node);
            NodeOccupied(node); // after setting team owner

            if (teamid == TEAM_ALLIANCE)
            {
                SendBroadcastText(ABNodes[node].TextAllianceDefended, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
            }
            else
            {
                SendBroadcastText(ABNodes[node].TextHordeDefended, CHAT_MSG_BG_SYSTEM_HORDE, player);
            }
        }

        sound = player->GetTeamId() == TEAM_ALLIANCE ? BG_AB_SOUND_NODE_ASSAULTED_ALLIANCE : BG_AB_SOUND_NODE_ASSAULTED_HORDE;
    }
    else
    {
        player->KilledMonsterCredit(BG_AB_QUEST_CREDIT_BASE + node);
        UpdatePlayerScore(player, SCORE_BASES_ASSAULTED, 1);
        NodeDeoccupied(node); // before setting team owner to neutral

        _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_CONTESTED) + player->GetTeamId();

        ApplyPhaseMask();
        _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);
        sound = player->GetTeamId() == TEAM_ALLIANCE ? BG_AB_SOUND_NODE_ASSAULTED_ALLIANCE : BG_AB_SOUND_NODE_ASSAULTED_HORDE;

        if (teamid == TEAM_ALLIANCE)
        {
            SendBroadcastText(ABNodes[node].TextAllianceAssaulted, CHAT_MSG_BG_SYSTEM_ALLIANCE, player);
        }
        else
        {
            SendBroadcastText(ABNodes[node].TextHordeAssaulted, CHAT_MSG_BG_SYSTEM_HORDE, player);
        }
    }

    SendNodeUpdate(node);
    PlaySoundToAll(sound);
}

//npcbot
void BattlegroundAB::EventBotClickedOnFlag(Creature* bot, GameObject* target_obj)
{
    if (GetStatus() != STATUS_IN_PROGRESS || !bot->IsWithinDistInMap(target_obj, 10.0f))
        return;

    TeamId teamId = GetBotTeamId(bot->GetGUID());

    uint8 node = BG_AB_NODE_STABLES;
    for (; node < BG_AB_DYNAMIC_NODES_COUNT; ++node)
        if (bot->GetDistance2d(BG_AB_NodePositions[node][0], BG_AB_NodePositions[node][1]) < 10.0f)
            break;

    if (node == BG_AB_DYNAMIC_NODES_COUNT || _capturePointInfo[node]._ownerTeamId == teamId ||
            (_capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_CONTESTED && teamId == TEAM_ALLIANCE) ||
            (_capturePointInfo[node]._state == BG_AB_NODE_STATE_HORDE_CONTESTED && teamId == TEAM_HORDE))
        return;

    bot->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);

    uint32 sound = 0;

    DeleteBanner(node);
    CreateBanner(node, true);

    if (_capturePointInfo[node]._state == BG_AB_NODE_STATE_NEUTRAL)
    {
        UpdateBotScore(bot, SCORE_BASES_ASSAULTED, 1);
        _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_CONTESTED) + teamId;
        _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;
        _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);
        sound = BG_AB_SOUND_NODE_CLAIMED;

        if (teamId == TEAM_ALLIANCE)
        {
            SendBroadcastText(ABNodes[node].TextAllianceClaims, CHAT_MSG_BG_SYSTEM_ALLIANCE, bot);
        }
        else
        {
            SendBroadcastText(ABNodes[node].TextHordeClaims, CHAT_MSG_BG_SYSTEM_HORDE, bot);
        }
    }
    else if (_capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_CONTESTED || _capturePointInfo[node]._state == BG_AB_NODE_STATE_HORDE_CONTESTED)
    {
        if (!_capturePointInfo[node]._captured)
        {
            UpdateBotScore(bot, SCORE_BASES_ASSAULTED, 1);
            _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_CONTESTED) + teamId;
            _capturePointInfo[node]._ownerTeamId = TEAM_NEUTRAL;
            _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);

            if (teamId == TEAM_ALLIANCE)
            {
                SendBroadcastText(ABNodes[node].TextAllianceAssaulted, CHAT_MSG_BG_SYSTEM_ALLIANCE, bot);
            }
            else
            {
                SendBroadcastText(ABNodes[node].TextHordeAssaulted, CHAT_MSG_BG_SYSTEM_HORDE, bot);
            }
        }
        else
        {
            UpdateBotScore(bot, SCORE_BASES_DEFENDED, 1);
            _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_OCCUPIED) + teamId;
            _capturePointInfo[node]._ownerTeamId = teamId;
            _bgEvents.CancelEvent(BG_AB_EVENT_CAPTURE_STABLE + node);
            NodeOccupied(node); // after setting team owner

            if (teamId == TEAM_ALLIANCE)
            {
                SendBroadcastText(ABNodes[node].TextAllianceDefended, CHAT_MSG_BG_SYSTEM_ALLIANCE, bot);
            }
            else
            {
                SendBroadcastText(ABNodes[node].TextHordeDefended, CHAT_MSG_BG_SYSTEM_HORDE, bot);
            }
        }

        sound = teamId == TEAM_ALLIANCE ? BG_AB_SOUND_NODE_ASSAULTED_ALLIANCE : BG_AB_SOUND_NODE_ASSAULTED_HORDE;
    }
    else
    {
        UpdateBotScore(bot, SCORE_BASES_ASSAULTED, 1);
        NodeDeoccupied(node); // before setting team owner to neutral

        _capturePointInfo[node]._state = static_cast<uint8>(BG_AB_NODE_STATE_ALLY_CONTESTED) + teamId;

        ApplyPhaseMask();
        _bgEvents.RescheduleEvent(BG_AB_EVENT_CAPTURE_STABLE + node, BG_AB_FLAG_CAPTURING_TIME);
        sound = teamId == TEAM_ALLIANCE ? BG_AB_SOUND_NODE_ASSAULTED_ALLIANCE : BG_AB_SOUND_NODE_ASSAULTED_HORDE;

        if (teamId == TEAM_ALLIANCE)
        {
            SendBroadcastText(ABNodes[node].TextAllianceAssaulted, CHAT_MSG_BG_SYSTEM_ALLIANCE, bot);
        }
        else
        {
            SendBroadcastText(ABNodes[node].TextHordeAssaulted, CHAT_MSG_BG_SYSTEM_HORDE, bot);
        }
    }

    SendNodeUpdate(node);
    PlaySoundToAll(sound);
}

bool BattlegroundAB::IsNodeOccupied(uint8 node, TeamId teamId) const
{
    if (node < BG_AB_DYNAMIC_NODES_COUNT)
    {
        switch (teamId)
        {
            case TEAM_ALLIANCE:
                return _capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_OCCUPIED;
            case TEAM_HORDE:
                return _capturePointInfo[node]._state == BG_AB_NODE_STATE_HORDE_OCCUPIED;
            default:
                break;
        }
    }

    return false;
}
bool BattlegroundAB::IsNodeContested(uint8 node, TeamId teamId) const
{
    if (node < BG_AB_DYNAMIC_NODES_COUNT)
    {
        switch (teamId)
        {
            case TEAM_ALLIANCE:
                return _capturePointInfo[node]._state == BG_AB_NODE_STATE_ALLY_CONTESTED;
            case TEAM_HORDE:
                return _capturePointInfo[node]._state == BG_AB_NODE_STATE_HORDE_CONTESTED;
            default:
                break;
        }
    }

    return false;
}
//end npcbot

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
        AddObject(BG_AB_OBJECT_BANNER_NEUTRAL + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_NODE_BANNER_0 + i, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_ALLY + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_BANNER_A, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_HORDE + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_BANNER_H, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_CONT_A + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_BANNER_CONT_A, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_BANNER_CONT_H + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_BANNER_CONT_H, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_AURA_ALLY + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_AURA_A, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_AURA_HORDE + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_AURA_H, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_AURA_CONTESTED + BG_AB_OBJECTS_PER_NODE * i, BG_AB_OBJECTID_AURA_C, BG_AB_NodePositions[i][0], BG_AB_NodePositions[i][1], BG_AB_NodePositions[i][2], BG_AB_NodePositions[i][3], 0, 0, std::sin(BG_AB_NodePositions[i][3] / 2), cos(BG_AB_NodePositions[i][3] / 2), RESPAWN_ONE_DAY);
    }

    AddObject(BG_AB_OBJECT_GATE_A, BG_AB_OBJECTID_GATE_A, BG_AB_DoorPositions[0][0], BG_AB_DoorPositions[0][1], BG_AB_DoorPositions[0][2], BG_AB_DoorPositions[0][3], BG_AB_DoorPositions[0][4], BG_AB_DoorPositions[0][5], BG_AB_DoorPositions[0][6], BG_AB_DoorPositions[0][7], RESPAWN_IMMEDIATELY);
    AddObject(BG_AB_OBJECT_GATE_H, BG_AB_OBJECTID_GATE_H, BG_AB_DoorPositions[1][0], BG_AB_DoorPositions[1][1], BG_AB_DoorPositions[1][2], BG_AB_DoorPositions[1][3], BG_AB_DoorPositions[1][4], BG_AB_DoorPositions[1][5], BG_AB_DoorPositions[1][6], BG_AB_DoorPositions[1][7], RESPAWN_IMMEDIATELY);

    for (uint32 i = 0; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
    {
        AddObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + 3 * i, Buff_Entries[0], BG_AB_BuffPositions[i][0], BG_AB_BuffPositions[i][1], BG_AB_BuffPositions[i][2], BG_AB_BuffPositions[i][3], 0, 0, std::sin(BG_AB_BuffPositions[i][3] / 2), cos(BG_AB_BuffPositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + 3 * i + 1, Buff_Entries[1], BG_AB_BuffPositions[i][0], BG_AB_BuffPositions[i][1], BG_AB_BuffPositions[i][2], BG_AB_BuffPositions[i][3], 0, 0, std::sin(BG_AB_BuffPositions[i][3] / 2), cos(BG_AB_BuffPositions[i][3] / 2), RESPAWN_ONE_DAY);
        AddObject(BG_AB_OBJECT_SPEEDBUFF_STABLES + 3 * i + 2, Buff_Entries[2], BG_AB_BuffPositions[i][0], BG_AB_BuffPositions[i][1], BG_AB_BuffPositions[i][2], BG_AB_BuffPositions[i][3], 0, 0, std::sin(BG_AB_BuffPositions[i][3] / 2), cos(BG_AB_BuffPositions[i][3] / 2), RESPAWN_ONE_DAY);
    }

    AddSpiritGuide(BG_AB_SPIRIT_ALIANCE, BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][0], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][1], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][2], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_ALIANCE][3], TEAM_ALLIANCE);
    AddSpiritGuide(BG_AB_SPIRIT_HORDE, BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][0], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][1], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][2], BG_AB_SpiritGuidePos[BG_AB_SPIRIT_HORDE][3], TEAM_HORDE);

    for (uint32 i = BG_AB_OBJECT_BANNER_NEUTRAL; i < BG_AB_OBJECT_MAX; ++i)
        if (!BgObjects[i])
        {
            LOG_ERROR("sql.sql", "BatteGroundAB: Failed to spawn some object Battleground not created!");
            return false;
        }

    for (uint32 i = BG_AB_SPIRIT_ALIANCE; i <= BG_AB_SPIRIT_HORDE; ++i)
        if (!BgCreatures[i])
        {
            LOG_ERROR("sql.sql", "BatteGroundAB: Failed to spawn spirit guides Battleground not created!");
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
    GraveyardStruct const* entry = sGraveyard->GetGraveyard(BG_AB_GraveyardIds[static_cast<uint8>(BG_AB_SPIRIT_ALIANCE) + player->GetTeamId()]);
    GraveyardStruct const* nearestEntry = entry;

    float pX = player->GetPositionX();
    float pY = player->GetPositionY();
    float dist = (entry->x - pX) * (entry->x - pX) + (entry->y - pY) * (entry->y - pY);
    float minDist = dist;

    for (uint8 i = BG_AB_NODE_STABLES; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
        if (_capturePointInfo[i]._ownerTeamId == player->GetTeamId())
        {
            entry = sGraveyard->GetGraveyard(BG_AB_GraveyardIds[i]);
            dist = (entry->x - pX) * (entry->x - pX) + (entry->y - pY) * (entry->y - pY);
            if (dist < minDist)
            {
                minDist = dist;
                nearestEntry = entry;
            }
        }

    return nearestEntry;
}

//npcbot
GraveyardStruct const* BattlegroundAB::GetClosestGraveyardForBot(Creature* bot) const
{
    TeamId teamIndex = GetBotTeamId(bot->GetGUID());

    GraveyardStruct const* entry = sGraveyard->GetGraveyard(BG_AB_GraveyardIds[static_cast<uint8>(BG_AB_SPIRIT_ALIANCE) + teamIndex]);
    GraveyardStruct const* nearestEntry = entry;

    float pX = bot->GetPositionX();
    float pY = bot->GetPositionY();
    float dist = (entry->x - pX) * (entry->x - pX) + (entry->y - pY) * (entry->y - pY);
    float minDist = dist;

    for (uint8 i = BG_AB_NODE_STABLES; i < BG_AB_DYNAMIC_NODES_COUNT; ++i)
    {
        if (_capturePointInfo[i]._ownerTeamId == teamIndex)
        {
            entry = sGraveyard->GetGraveyard(BG_AB_GraveyardIds[i]);
            dist = (entry->x - pX) * (entry->x - pX) + (entry->y - pY) * (entry->y - pY);
            if (dist < minDist)
            {
                minDist = dist;
                nearestEntry = entry;
            }
        }
    }

    return nearestEntry;
}

void BattlegroundAB::RewardKillScore(TeamId teamId, uint32 amount)
{
    // Score feature
    m_TeamScores[teamId] += amount;
    if (m_TeamScores[teamId] > BG_AB_MAX_TEAM_SCORE)
        m_TeamScores[teamId] = BG_AB_MAX_TEAM_SCORE;
    UpdateWorldState(teamId == TEAM_ALLIANCE ? BG_AB_OP_RESOURCES_ALLY : BG_AB_OP_RESOURCES_HORDE, m_TeamScores[teamId]);
    if (m_TeamScores[teamId] >= BG_AB_MAX_TEAM_SCORE)
        EndBattleground(teamId);
}

void BattlegroundAB::HandleBotKillPlayer(Creature* killer, Player* victim)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleBotKillPlayer(killer, victim);
    //RewardKillScore(GetPlayerTeamId(killer->GetGUID()), BG_AB_TickPoints[1]);
}
void BattlegroundAB::HandleBotKillBot(Creature* killer, Creature* victim)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleBotKillBot(killer, victim);
    //RewardKillScore(GetPlayerTeamId(killer->GetGUID()), BG_AB_TickPoints[1]);
}
void BattlegroundAB::HandlePlayerKillBot(Creature* victim, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandlePlayerKillBot(victim, killer);
    //RewardKillScore(GetPlayerTeamId(killer->GetGUID()), BG_AB_TickPoints[1]);
}
//end npcbot

bool BattlegroundAB::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    if (!Battleground::UpdatePlayerScore(player, type, value, doAddHonor))
        return false;

    switch (type)
    {
        case SCORE_BASES_ASSAULTED:
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, BG_AB_OBJECTIVE_ASSAULT_BASE);
            break;
        case SCORE_BASES_DEFENDED:
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, BG_AB_OBJECTIVE_DEFEND_BASE);
            break;
        default:
            break;
    }

    return true;
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
            phaseMask |= 1 << (i * 2 + 1 + _capturePointInfo[i]._ownerTeamId);

    const BattlegroundPlayerMap& bgPlayerMap = GetPlayers();

    for (auto const& itr : bgPlayerMap)
    {
        itr.second->SetPhaseMask(phaseMask, false);
        itr.second->UpdateObjectVisibility(true, false);
    }
}
