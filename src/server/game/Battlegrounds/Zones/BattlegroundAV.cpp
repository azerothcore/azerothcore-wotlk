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

#include "BattlegroundAV.h"
#include "CreatureTextMgr.h"
#include "Formulas.h"
#include "GameEventMgr.h"
#include "GameGraveyard.h"
#include "GameObject.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SpellAuras.h"
#include "WorldPacket.h"

//npcbot
#include "botdatamgr.h"
#include "botmgr.h"
//end npcbot

void BattlegroundAVScore::BuildObjectivesBlock(WorldPacket& data)
{
    data << uint32(5); // Objectives Count
    data << uint32(GraveyardsAssaulted);
    data << uint32(GraveyardsDefended);
    data << uint32(TowersAssaulted);
    data << uint32(TowersDefended);
    data << uint32(MinesCaptured);
}

BattlegroundAV::BattlegroundAV()
{
    BgObjects.resize(BG_AV_OBJECT_MAX);
    BgCreatures.resize(static_cast<uint16>(AV_CPLACE_MAX) + AV_STATICCPLACE_MAX);

    for (uint8 i = 0; i < 2; i++)
    {
        for (uint8 j = 0; j < 9; j++)
            m_Team_QuestStatus[i][j] = 0;
        m_Team_Scores[i] = 0;
        m_IsInformedNearVictory[i] = false;
        m_CaptainAlive[i] = true;
        m_CaptainBuffTimer[i] = 0;
        m_Mine_Owner[i] = TEAM_NEUTRAL;
        m_Mine_Reclaim_Timer[i] = 0;
    }

    m_Mine_Timer = 0;

    for (BG_AV_Nodes i = BG_AV_NODES_FIRSTAID_STATION; i < BG_AV_NODES_MAX; ++i)
        InitNode(i, TEAM_NEUTRAL, false);

    StartMessageIds[BG_STARTING_EVENT_SECOND] = BG_AV_TEXT_START_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_THIRD] = BG_AV_TEXT_START_HALF_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = BG_AV_TEXT_BATTLE_HAS_BEGUN;
}

void BattlegroundAV::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleKillPlayer(player, killer);
    UpdateScore(player->GetTeamId(), -1);
}

//npcbot
void BattlegroundAV::HandleBotKillPlayer(Creature* killer, Player* victim)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleBotKillPlayer(killer, victim);
    UpdateScore(victim->GetTeamId(), -1);
}
void BattlegroundAV::HandleBotKillBot(Creature* killer, Creature* victim)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandleBotKillBot(killer, victim);
    UpdateScore(GetBotTeamId(victim->GetGUID()), -1);
}
void BattlegroundAV::HandlePlayerKillBot(Creature* victim, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    Battleground::HandlePlayerKillBot(victim, killer);
    UpdateScore(GetBotTeamId(victim->GetGUID()), -1);
}
//end npcbot

void BattlegroundAV::HandleKillUnit(Creature* unit, Player* killer)
{
    LOG_DEBUG("bg.battleground", "bg_av HandleKillUnit {}", unit->GetEntry());
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;
    uint32 entry = unit->GetEntry();
    /*
    uint32 triggerSpawnID = 0;
    if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_CAPTAIN])
        triggerSpawnID = AV_CPLACE_TRIGGER16;
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_BOSS])
        triggerSpawnID = AV_CPLACE_TRIGGER17;
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_CAPTAIN])
        triggerSpawnID = AV_CPLACE_TRIGGER18;
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_BOSS])
        triggerSpawnID = AV_CPLACE_TRIGGER19;
    */
    if (entry == BG_AV_CreatureInfo[AV_NPC_A_BOSS])
    {
        CastSpellOnTeam(23658, TEAM_HORDE); //this is a spell which finishes a quest where a player has to kill the boss
        RewardReputationToTeam(729, BG_AV_REP_BOSS, TEAM_HORDE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_BOSS), TEAM_HORDE);
        EndBattleground(TEAM_HORDE);
        DelCreature(AV_CPLACE_TRIGGER17);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_H_BOSS])
    {
        CastSpellOnTeam(23658, TEAM_ALLIANCE); //this is a spell which finishes a quest where a player has to kill the boss
        RewardReputationToTeam(730, BG_AV_REP_BOSS, TEAM_ALLIANCE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_BOSS), TEAM_ALLIANCE);
        EndBattleground(TEAM_ALLIANCE);
        DelCreature(AV_CPLACE_TRIGGER19);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_A_CAPTAIN])
    {
        if (!m_CaptainAlive[0])
        {
            LOG_ERROR("bg.battleground", "Killed a Captain twice, please report this bug, if you haven't done \".respawn\"");
            return;
        }
        m_CaptainAlive[0] = false;
        RewardReputationToTeam(729, BG_AV_REP_CAPTAIN, TEAM_HORDE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_CAPTAIN), TEAM_HORDE);
        UpdateScore(TEAM_ALLIANCE, (-1)*BG_AV_RES_CAPTAIN);
        //spawn destroyed aura
        for (uint8 i = 0; i <= 9; i++)
            SpawnBGObject(BG_AV_OBJECT_BURN_BUILDING_ALLIANCE + i, RESPAWN_IMMEDIATELY);
        if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
            creature->AI()->Talk(AV_TEXT_HERALD_STORMPIKE_GENERAL_DEAD);
        DelCreature(AV_CPLACE_TRIGGER16);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_H_CAPTAIN])
    {
        if (!m_CaptainAlive[1])
        {
            LOG_ERROR("bg.battleground", "Killed a Captain twice, please report this bug, if you haven't done \".respawn\"");
            return;
        }
        m_CaptainAlive[1] = false;
        RewardReputationToTeam(730, BG_AV_REP_CAPTAIN, TEAM_ALLIANCE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_CAPTAIN), TEAM_ALLIANCE);
        UpdateScore(TEAM_HORDE, (-1)*BG_AV_RES_CAPTAIN);
        //spawn destroyed aura
        for (uint8 i = 0; i <= 9; i++)
            SpawnBGObject(BG_AV_OBJECT_BURN_BUILDING_HORDE + i, RESPAWN_IMMEDIATELY);
        if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
            creature->AI()->Talk(AV_TEXT_HERALD_FROSTWOLF_GENERAL_DEAD);
        DelCreature(AV_CPLACE_TRIGGER18);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_N_MINE_N_4] || entry == BG_AV_CreatureInfo[AV_NPC_N_MINE_A_4] || entry == BG_AV_CreatureInfo[AV_NPC_N_MINE_H_4])
    {
        ChangeMineOwner(AV_NORTH_MINE, killer->GetTeamId());
        UpdatePlayerScore(killer, SCORE_MINES_CAPTURED, 1);
        killer->KilledMonsterCredit(BG_AV_QUEST_CREDIT_MINE);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_S_MINE_N_4] || entry == BG_AV_CreatureInfo[AV_NPC_S_MINE_A_4] || entry == BG_AV_CreatureInfo[AV_NPC_S_MINE_H_4])
    {
        ChangeMineOwner(AV_SOUTH_MINE, killer->GetTeamId());
        UpdatePlayerScore(killer, SCORE_MINES_CAPTURED, 1);
        killer->KilledMonsterCredit(BG_AV_QUEST_CREDIT_MINE);
    }
}

//npcbot
void BattlegroundAV::HandleBotKillUnit(Creature* killer, Creature* victim)
{
    LOG_DEBUG("bg.battleground", "bg_av HandleKillUnit {}", victim->GetEntry());
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;
    uint32 entry = victim->GetEntry();
    /*
    uint32 triggerSpawnID = 0;
    if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_CAPTAIN])
        triggerSpawnID = AV_CPLACE_TRIGGER16;
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_BOSS])
        triggerSpawnID = AV_CPLACE_TRIGGER17;
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_CAPTAIN])
        triggerSpawnID = AV_CPLACE_TRIGGER18;
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_BOSS])
        triggerSpawnID = AV_CPLACE_TRIGGER19;
    */
    if (entry == BG_AV_CreatureInfo[AV_NPC_A_BOSS])
    {
        CastSpellOnTeam(23658, TEAM_HORDE); //this is a spell which finishes a quest where a player has to kill the boss
        RewardReputationToTeam(729, BG_AV_REP_BOSS, TEAM_HORDE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_BOSS), TEAM_HORDE);
        EndBattleground(TEAM_HORDE);
        DelCreature(AV_CPLACE_TRIGGER17);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_H_BOSS])
    {
        CastSpellOnTeam(23658, TEAM_ALLIANCE); //this is a spell which finishes a quest where a player has to kill the boss
        RewardReputationToTeam(730, BG_AV_REP_BOSS, TEAM_ALLIANCE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_BOSS), TEAM_ALLIANCE);
        EndBattleground(TEAM_ALLIANCE);
        DelCreature(AV_CPLACE_TRIGGER19);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_A_CAPTAIN])
    {
        if (!m_CaptainAlive[0])
        {
            LOG_ERROR("bg.battleground", "Killed a Captain twice, please report this bug, if you haven't done \".respawn\"");
            return;
        }
        m_CaptainAlive[0] = false;
        RewardReputationToTeam(729, BG_AV_REP_CAPTAIN, TEAM_HORDE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_CAPTAIN), TEAM_HORDE);
        UpdateScore(TEAM_ALLIANCE, (-1)*BG_AV_RES_CAPTAIN);
        //spawn destroyed aura
        for (uint8 i = 0; i <= 9; i++)
            SpawnBGObject(BG_AV_OBJECT_BURN_BUILDING_ALLIANCE + i, RESPAWN_IMMEDIATELY);
        if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
            creature->AI()->Talk(AV_TEXT_HERALD_STORMPIKE_GENERAL_DEAD);
        DelCreature(AV_CPLACE_TRIGGER16);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_H_CAPTAIN])
    {
        if (!m_CaptainAlive[1])
        {
            LOG_ERROR("bg.battleground", "Killed a Captain twice, please report this bug, if you haven't done \".respawn\"");
            return;
        }
        m_CaptainAlive[1] = false;
        RewardReputationToTeam(730, BG_AV_REP_CAPTAIN, TEAM_ALLIANCE);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_CAPTAIN), TEAM_ALLIANCE);
        UpdateScore(TEAM_HORDE, (-1)*BG_AV_RES_CAPTAIN);
        //spawn destroyed aura
        for (uint8 i = 0; i <= 9; i++)
            SpawnBGObject(BG_AV_OBJECT_BURN_BUILDING_HORDE + i, RESPAWN_IMMEDIATELY);
        if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
            creature->AI()->Talk(AV_TEXT_HERALD_FROSTWOLF_GENERAL_DEAD);
        DelCreature(AV_CPLACE_TRIGGER18);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_N_MINE_N_4] || entry == BG_AV_CreatureInfo[AV_NPC_N_MINE_A_4] || entry == BG_AV_CreatureInfo[AV_NPC_N_MINE_H_4])
    {
        ChangeMineOwner(AV_NORTH_MINE, GetBotTeamId(killer->GetGUID()));
        UpdateBotScore(killer, SCORE_MINES_CAPTURED, 1);
    }
    else if (entry == BG_AV_CreatureInfo[AV_NPC_S_MINE_N_4] || entry == BG_AV_CreatureInfo[AV_NPC_S_MINE_A_4] || entry == BG_AV_CreatureInfo[AV_NPC_S_MINE_H_4])
    {
        ChangeMineOwner(AV_SOUTH_MINE, GetBotTeamId(killer->GetGUID()));
        UpdateBotScore(killer, SCORE_MINES_CAPTURED, 1);
    }
}
//end npcbot

void BattlegroundAV::HandleQuestComplete(uint32 questid, Player* player)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;//maybe we should log this, cause this must be a cheater or a big bug
    TeamId teamId = player->GetTeamId();
    //TODO add reputation, events (including quest not available anymore, next quest availabe, go/npc de/spawning)and maybe honor
    LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed", questid);
    switch (questid)
    {
        case AV_QUEST_A_SCRAPS1:
        case AV_QUEST_A_SCRAPS2:
        case AV_QUEST_H_SCRAPS1:
        case AV_QUEST_H_SCRAPS2:
            m_Team_QuestStatus[teamId][0] += 20;
            if (m_Team_QuestStatus[teamId][0] == 500 || m_Team_QuestStatus[teamId][0] == 1000 || m_Team_QuestStatus[teamId][0] == 1500) //25, 50, 75 turn ins
            {
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed starting with unit upgrading..", questid);
                for (BG_AV_Nodes i = BG_AV_NODES_FIRSTAID_STATION; i <= BG_AV_NODES_FROSTWOLF_HUT; ++i)
                    if (m_Nodes[i].OwnerId == player->GetTeamId() && m_Nodes[i].State == POINT_CONTROLED)
                    {
                        DePopulateNode(i);
                        PopulateNode(i);
                        //maybe this is bad, because it will instantly respawn all creatures on every grave..
                    }
            }
            break;
        case AV_QUEST_A_COMMANDER1:
        case AV_QUEST_H_COMMANDER1:
            m_Team_QuestStatus[teamId][1]++;
            RewardReputationToTeam(teamId, 1, teamId);
            if (m_Team_QuestStatus[teamId][1] == 30)
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);
            break;
        case AV_QUEST_A_COMMANDER2:
        case AV_QUEST_H_COMMANDER2:
            m_Team_QuestStatus[teamId][2]++;
            RewardReputationToTeam(teamId, 1, teamId);
            if (m_Team_QuestStatus[teamId][2] == 60)
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);
            break;
        case AV_QUEST_A_COMMANDER3:
        case AV_QUEST_H_COMMANDER3:
            m_Team_QuestStatus[teamId][3]++;
            RewardReputationToTeam(teamId, 1, teamId);
            if (m_Team_QuestStatus[teamId][3] == 120)
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);
            break;
        case AV_QUEST_A_BOSS1:
        case AV_QUEST_H_BOSS1:
            m_Team_QuestStatus[teamId][4] += 9; //you can turn in 10 or 1 item..
            [[fallthrough]];
        case AV_QUEST_A_BOSS2:
        case AV_QUEST_H_BOSS2:
            m_Team_QuestStatus[teamId][4]++;
            if (m_Team_QuestStatus[teamId][4] >= 200)
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);
            break;
        case AV_QUEST_A_NEAR_MINE:
        case AV_QUEST_H_NEAR_MINE:
            m_Team_QuestStatus[teamId][5]++;
            if (m_Team_QuestStatus[teamId][5] == 28)
            {
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);

                if (m_Team_QuestStatus[teamId][6] == 7)
                    LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here - ground assault ready", questid);
            }
            break;
        case AV_QUEST_A_OTHER_MINE:
        case AV_QUEST_H_OTHER_MINE:
            m_Team_QuestStatus[teamId][6]++;
            if (m_Team_QuestStatus[teamId][6] == 7)
            {
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);

                if (m_Team_QuestStatus[teamId][5] == 20)
                    LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here - ground assault ready", questid);
            }
            break;
        case AV_QUEST_A_RIDER_HIDE:
        case AV_QUEST_H_RIDER_HIDE:
            m_Team_QuestStatus[teamId][7]++;
            if (m_Team_QuestStatus[teamId][7] == 25)
            {
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);

                if (m_Team_QuestStatus[teamId][8] == 25)
                    LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here - rider assault ready", questid);
            }
            break;
        case AV_QUEST_A_RIDER_TAME:
        case AV_QUEST_H_RIDER_TAME:
            m_Team_QuestStatus[teamId][8]++;
            if (m_Team_QuestStatus[teamId][8] == 25)
            {
                LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here", questid);

                if (m_Team_QuestStatus[teamId][7] == 25)
                    LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed (need to implement some events here - rider assault ready", questid);
            }
            break;
        default:
            LOG_DEBUG("bg.battleground", "BG_AV Quest {} completed but is not interesting at all", questid);
            return; //was no interesting quest at all
            break;
    }
}

void BattlegroundAV::UpdateScore(TeamId teamId, int16 points)
{
    //note: to remove reinforcementpoints points must be negative, for adding reinforcements points must be positive
    m_Team_Scores[teamId] += points;

    UpdateWorldState(((teamId == TEAM_HORDE) ? AV_Horde_Score : AV_Alliance_Score), m_Team_Scores[teamId]);
    if (points < 0)
    {
        if (m_Team_Scores[teamId] < 1)
        {
            m_Team_Scores[teamId] = 0;
            EndBattleground(GetOtherTeamId(teamId));
        }
        else if (!m_IsInformedNearVictory[teamId] && m_Team_Scores[teamId] < SEND_MSG_NEAR_LOSE)
        {
            if (teamId == TEAM_ALLIANCE)
            {
                SendBroadcastText(BG_AV_TEXT_ALLIANCE_NEAR_LOSE, CHAT_MSG_BG_SYSTEM_ALLIANCE);
            }
            else
            {
                SendBroadcastText(BG_AV_TEXT_HORDE_NEAR_LOSE, CHAT_MSG_BG_SYSTEM_HORDE);
            }

            PlaySoundToAll(AV_SOUND_NEAR_VICTORY);
            m_IsInformedNearVictory[teamId] = true;
        }
    }
}

Creature* BattlegroundAV::AddAVCreature(uint16 cinfoid, uint16 type)
{
    bool isStatic = false;
    Creature* creature = nullptr;
    ASSERT(type <= static_cast<uint16>(AV_CPLACE_MAX) + AV_STATICCPLACE_MAX);
    if (type >= AV_CPLACE_MAX) //static
    {
        type -= AV_CPLACE_MAX;
        cinfoid = uint16(BG_AV_StaticCreaturePos[type][4]);
        creature = AddCreature(BG_AV_StaticCreatureInfo[cinfoid],
                               type + AV_CPLACE_MAX,
                               BG_AV_StaticCreaturePos[type][0],
                               BG_AV_StaticCreaturePos[type][1],
                               BG_AV_StaticCreaturePos[type][2],
                               BG_AV_StaticCreaturePos[type][3]);
        isStatic = true;
    }
    else
    {
        creature = AddCreature(BG_AV_CreatureInfo[cinfoid],
                               type,
                               BG_AV_CreaturePos[type][0],
                               BG_AV_CreaturePos[type][1],
                               BG_AV_CreaturePos[type][2],
                               BG_AV_CreaturePos[type][3]);
    }
    if (!creature)
        return nullptr;
    if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_CAPTAIN] || creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_CAPTAIN])
        creature->SetRespawnDelay(RESPAWN_ONE_DAY); /// @todo: look if this can be done by database + also add this for the wingcommanders

    if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_TOWERDEFENSE] || creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_TOWERDEFENSE])
        creature->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);

    if ((isStatic && cinfoid >= 10 && cinfoid <= 14) || (!isStatic && ((cinfoid >= AV_NPC_A_GRAVEDEFENSE0 && cinfoid <= AV_NPC_A_GRAVEDEFENSE3) ||
            (cinfoid >= AV_NPC_H_GRAVEDEFENSE0 && cinfoid <= AV_NPC_H_GRAVEDEFENSE3))))
    {
        if (!isStatic && ((cinfoid >= AV_NPC_A_GRAVEDEFENSE0 && cinfoid <= AV_NPC_A_GRAVEDEFENSE3)
                          || (cinfoid >= AV_NPC_H_GRAVEDEFENSE0 && cinfoid <= AV_NPC_H_GRAVEDEFENSE3)))
        {
            CreatureData& data = sObjectMgr->NewOrExistCreatureData(creature->GetSpawnId());
            data.wander_distance = 5;
        }
        //else wander_distance will be 15, so creatures move maximum=10
        //creature->SetDefaultMovementType(RANDOM_MOTION_TYPE);
        creature->GetMotionMaster()->Initialize();
        creature->setDeathState(DeathState::JustDied);
        creature->Respawn();
        //TODO: find a way to add a motionmaster without killing the creature (i
        //just copied this code from a gm-command
    }

    uint32 triggerSpawnID = 0;
    uint32 newFaction = 0;
    if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_CAPTAIN])
    {
        triggerSpawnID = AV_CPLACE_TRIGGER16;
        newFaction = 84;
    }
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_A_BOSS])
    {
        triggerSpawnID = AV_CPLACE_TRIGGER17;
        newFaction = 84;
    }
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_CAPTAIN])
    {
        triggerSpawnID = AV_CPLACE_TRIGGER18;
        newFaction = 83;
    }
    else if (creature->GetEntry() == BG_AV_CreatureInfo[AV_NPC_H_BOSS])
    {
        triggerSpawnID = AV_CPLACE_TRIGGER19;
        newFaction = 83;
    }
    if (triggerSpawnID && newFaction)
    {
        if (Creature* trigger = AddCreature(WORLD_TRIGGER,
                                            triggerSpawnID,
                                            BG_AV_CreaturePos[triggerSpawnID][0],
                                            BG_AV_CreaturePos[triggerSpawnID][1],
                                            BG_AV_CreaturePos[triggerSpawnID][2],
                                            BG_AV_CreaturePos[triggerSpawnID][3]))
        {
            trigger->SetFaction(newFaction);
            trigger->CastSpell(trigger, SPELL_HONORABLE_DEFENDER_25Y, false);
        }
    }

    return creature;
}

void BattlegroundAV::PostUpdateImpl(uint32 diff)
{
    if (GetStatus() == STATUS_IN_PROGRESS)
    {
        for (uint8 i = 0; i <= 1; i++) //0=alliance, 1=horde
        {
            if (!m_CaptainAlive[i])
            {
                continue;
            }
            if (m_CaptainBuffTimer[i] > diff)
            {
                m_CaptainBuffTimer[i] -= diff;
            }
            else
            {
                if (i == 0)
                {
                    CastSpellOnTeam(AV_BUFF_A_CAPTAIN, TEAM_ALLIANCE);
                    Creature* creature = GetBGCreature(AV_CPLACE_MAX + 61);
                    if (creature)
                    {
                        std::string creatureText = sCreatureTextMgr->GetLocalizedChatString(creature->GetEntry(), creature->getGender(), 0, 0, DEFAULT_LOCALE);
                        YellToAll(creature, creatureText.c_str(), LANG_COMMON);
                    }
                }
                else
                {
                    CastSpellOnTeam(AV_BUFF_H_CAPTAIN, TEAM_HORDE);
                    Creature* creature = GetBGCreature(AV_CPLACE_MAX + 59); //TODO: make the captains a dynamic creature
                    if (creature)
                    {
                        std::string creatureText = sCreatureTextMgr->GetLocalizedChatString(creature->GetEntry(), creature->getGender(), 2, 0, DEFAULT_LOCALE);
                        YellToAll(creature, creatureText.c_str(), LANG_ORCISH);
                    }
                }
                m_CaptainBuffTimer[i] = 120000 + urand(0, 4) * 60000; //as far as i could see, the buff is randomly so i make 2minutes (thats the duration of the buff itself) + 0-4minutes TODO get the right times
            }
        }
        //add points from mine owning, and look if he neutral team wanrts to reclaim the mine
        m_Mine_Timer -= diff;
        for (uint8 mine = 0; mine < 2; mine++)
        {
            if (m_Mine_Owner[mine] == TEAM_ALLIANCE || m_Mine_Owner[mine] == TEAM_HORDE)
            {
                if (m_Mine_Timer <= 0)
                    UpdateScore(m_Mine_Owner[mine], 1);

                if (m_Mine_Reclaim_Timer[mine] > diff)
                    m_Mine_Reclaim_Timer[mine] -= diff;
                else  //we don't need to set this timer to 0 cause this codepart wont get called when this thing is 0
                {
                    ChangeMineOwner(mine, TEAM_NEUTRAL);
                }
            }
        }
        if (m_Mine_Timer <= 0)
            m_Mine_Timer = AV_MINE_TICK_TIMER; //this is at the end, cause we need to update both mines

        //looks for all timers of the nodes and destroy the building (for graveyards the building wont get destroyed, it goes just to the other team
        for (BG_AV_Nodes i = BG_AV_NODES_FIRSTAID_STATION; i < BG_AV_NODES_MAX; ++i)
            if (m_Nodes[i].State == POINT_ASSAULTED) //maybe remove this
            {
                if (m_Nodes[i].Timer > diff)
                    m_Nodes[i].Timer -= diff;
                else
                    EventPlayerDestroyedPoint(i);
            }
    }
}

void BattlegroundAV::StartingEventCloseDoors()
{
    SpawnBGObject(BG_AV_OBJECT_DOOR_A, RESPAWN_IMMEDIATELY);
    SpawnBGObject(BG_AV_OBJECT_DOOR_H, RESPAWN_IMMEDIATELY);

    DoorClose(BG_AV_OBJECT_DOOR_A);
    DoorClose(BG_AV_OBJECT_DOOR_H);
}

void BattlegroundAV::StartingEventOpenDoors()
{
    LOG_DEBUG("bg.battleground", "BG_AV: start spawning mine stuff");
    for (uint16 i = BG_AV_OBJECT_MINE_SUPPLY_N_MIN; i <= BG_AV_OBJECT_MINE_SUPPLY_N_MAX; i++)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY, 5 * MINUTE);
    for (uint16 i = BG_AV_OBJECT_MINE_SUPPLY_S_MIN; i <= BG_AV_OBJECT_MINE_SUPPLY_S_MAX; i++)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY, 5 * MINUTE);
    for (uint8 mine = AV_NORTH_MINE; mine <= AV_SOUTH_MINE; mine++) //mine population
        ChangeMineOwner(mine, TEAM_NEUTRAL, true);

    UpdateWorldState(AV_SHOW_H_SCORE, 1);
    UpdateWorldState(AV_SHOW_A_SCORE, 1);

    DoorOpen(BG_AV_OBJECT_DOOR_H);
    DoorOpen(BG_AV_OBJECT_DOOR_A);

    // Achievement: The Alterac Blitz
    StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, AV_EVENT_START_BATTLE);
}

void BattlegroundAV::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores.emplace(player->GetGUID().GetCounter(), new BattlegroundAVScore(player->GetGUID()));
}

//npcbot
void BattlegroundAV::AddBot(Creature* bot)
{
    bool const isInBattleground = IsPlayerInBattleground(bot->GetGUID());
    Battleground::AddBot(bot);
    if (!isInBattleground)
        BotScores[bot->GetEntry()] = new BattlegroundAVScore(bot->GetGUID());
}
//end npcbot

void BattlegroundAV::EndBattleground(TeamId winnerTeamId)
{
    //calculate bonuskills for both teams:
    //first towers:
    uint8 kills[2] = {0, 0}; // 0 = Alliance 1 = Horde
    uint8 rep[2] = {0, 0};   // 0 = Alliance 1 = Horde
    for (BG_AV_Nodes i = BG_AV_NODES_DUNBALDAR_SOUTH; i <= BG_AV_NODES_FROSTWOLF_WTOWER; ++i)
    {
        if (m_Nodes[i].State == POINT_CONTROLED)
        {
            if (m_Nodes[i].OwnerId == TEAM_ALLIANCE)
            {
                rep[0]   += BG_AV_REP_SURVIVING_TOWER;
                kills[0] += BG_AV_KILL_SURVIVING_TOWER;
            }
            else
            {
                rep[0]   += BG_AV_KILL_SURVIVING_TOWER;
                kills[1] += BG_AV_KILL_SURVIVING_TOWER;
            }
        }
    }

    for (TeamId iTeamId = TEAM_ALLIANCE; iTeamId <= TEAM_HORDE; iTeamId = TeamId(iTeamId + 1))
    {
        if (m_CaptainAlive[iTeamId])
        {
            kills[iTeamId] += BG_AV_KILL_SURVIVING_CAPTAIN;
            rep[iTeamId]   += BG_AV_REP_SURVIVING_CAPTAIN;
        }
        if (rep[iTeamId] != 0)
            RewardReputationToTeam(iTeamId == TEAM_ALLIANCE ? 730 : 729, rep[iTeamId], iTeamId);
        if (kills[iTeamId] != 0)
            RewardHonorToTeam(GetBonusHonorFromKill(kills[iTeamId]), iTeamId);
    }

    //TODO add enterevademode for all attacking creatures
    Battleground::EndBattleground(winnerTeamId);
}

void BattlegroundAV::RemovePlayer(Player* player)
{
    //TODO search more buffs
    player->RemoveAurasDueToSpell(AV_BUFF_ARMOR);
    player->RemoveAurasDueToSpell(AV_BUFF_A_CAPTAIN);
    player->RemoveAurasDueToSpell(AV_BUFF_H_CAPTAIN);
}

//npcbot
void BattlegroundAV::RemoveBot(ObjectGuid guid)
{
    if (Creature const* bot = BotDataMgr::FindBot(guid.GetEntry()))
    {
        const_cast<Creature*>(bot)->RemoveAurasDueToSpell(AV_BUFF_ARMOR);
        const_cast<Creature*>(bot)->RemoveAurasDueToSpell(AV_BUFF_A_CAPTAIN);
        const_cast<Creature*>(bot)->RemoveAurasDueToSpell(AV_BUFF_H_CAPTAIN);
    }
}
//end npcbot

void BattlegroundAV::HandleAreaTrigger(Player* player, uint32 trigger)
{
    // this is wrong way to implement these things. On official it done by gameobject spell cast.
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 95:
        case 2608:
            if (player->GetTeamId() != TEAM_ALLIANCE)
                player->GetSession()->SendAreaTriggerMessage("Only The Alliance can use that portal");
            else
                player->LeaveBattleground();
            break;
        case 2606:
            if (player->GetTeamId() != TEAM_HORDE)
                player->GetSession()->SendAreaTriggerMessage("Only The Horde can use that portal");
            else
                player->LeaveBattleground();
            break;
        case 3326:
        case 3327:
        case 3328:
        case 3329:
        case 3330:
        case 3331:
            //player->Unmount();
            break;
        default:
            break;
    }
}

bool BattlegroundAV::UpdatePlayerScore(Player* player, uint32 type, uint32 value, bool doAddHonor)
{
    if (!Battleground::UpdatePlayerScore(player, type, value, doAddHonor))
        return false;

    switch (type)
    {
        case SCORE_GRAVEYARDS_ASSAULTED:
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, AV_OBJECTIVE_ASSAULT_GRAVEYARD);
            break;
        case SCORE_GRAVEYARDS_DEFENDED:
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, AV_OBJECTIVE_DEFEND_GRAVEYARD);
            break;
        case SCORE_TOWERS_ASSAULTED:
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, AV_OBJECTIVE_ASSAULT_TOWER);
            break;
        case SCORE_TOWERS_DEFENDED:
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BG_OBJECTIVE_CAPTURE, AV_OBJECTIVE_DEFEND_TOWER);
            break;
        default:
            break;
    }

    return true;
}

void BattlegroundAV::EventPlayerDestroyedPoint(BG_AV_Nodes node)
{
    uint32 object = GetObjectThroughNode(node);
    LOG_DEBUG("bg.battleground", "bg_av: player destroyed point node {} object {}", node, object);

    //despawn banner
    SpawnBGObject(object, RESPAWN_ONE_DAY);
    DestroyNode(node);
    UpdateNodeWorldState(node);

    TeamId ownerId = m_Nodes[node].OwnerId;
    if (IsTower(node))
    {
        uint8 tmp = node - BG_AV_NODES_DUNBALDAR_SOUTH;
        //despawn marshal
        if (BgCreatures[AV_CPLACE_A_MARSHAL_SOUTH + tmp])
            DelCreature(AV_CPLACE_A_MARSHAL_SOUTH + tmp);
        else
            LOG_ERROR("bg.battleground", "BG_AV: playerdestroyedpoint: marshal {} doesn't exist", AV_CPLACE_A_MARSHAL_SOUTH + tmp);
        //spawn destroyed aura
        for (uint8 i = 0; i <= 9; i++)
            SpawnBGObject(BG_AV_OBJECT_BURN_DUNBALDAR_SOUTH + i + (tmp * 10), RESPAWN_IMMEDIATELY);

        UpdateScore((ownerId == TEAM_ALLIANCE) ? TEAM_HORDE : TEAM_ALLIANCE, -1 * BG_AV_RES_TOWER);
        RewardReputationToTeam(ownerId == TEAM_ALLIANCE ? 730 : 729, BG_AV_REP_TOWER, ownerId);
        RewardHonorToTeam(GetBonusHonorFromKill(BG_AV_KILL_TOWER), ownerId);

        SpawnBGObject(static_cast<uint8>(BG_AV_OBJECT_TAURA_A_DUNBALDAR_SOUTH) + ownerId + (2 * tmp), RESPAWN_ONE_DAY);
        SpawnBGObject(static_cast<uint8>(BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH) + ownerId + (2 * tmp), RESPAWN_ONE_DAY);
    }
    else
    {
        if (ownerId == TEAM_ALLIANCE)
            SpawnBGObject(object - 11, RESPAWN_IMMEDIATELY);
        else
            SpawnBGObject(object + 11, RESPAWN_IMMEDIATELY);
        SpawnBGObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + 3 * node, RESPAWN_ONE_DAY);
        SpawnBGObject(static_cast<uint8>(BG_AV_OBJECT_AURA_A_FIRSTAID_STATION) + ownerId + 3 * node, RESPAWN_IMMEDIATELY);
        PopulateNode(node);
        if (node == BG_AV_NODES_SNOWFALL_GRAVE) //snowfall eyecandy
        {
            for (uint8 i = 0; i < 4; i++)
            {
                SpawnBGObject(((ownerId == TEAM_ALLIANCE) ? BG_AV_OBJECT_SNOW_EYECANDY_PA : BG_AV_OBJECT_SNOW_EYECANDY_PH) + i, RESPAWN_ONE_DAY);
                SpawnBGObject(((ownerId == TEAM_ALLIANCE) ? BG_AV_OBJECT_SNOW_EYECANDY_A  : BG_AV_OBJECT_SNOW_EYECANDY_H) + i, RESPAWN_IMMEDIATELY);
            }
        }
    }

    if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
        creature->AI()->Talk(GetDefendString(node, ownerId));
}

void BattlegroundAV::ChangeMineOwner(uint8 mine, TeamId teamId, bool initial)
{
    // mine=0 northmine mine=1 southmin
    // changing the owner results in setting respawntim to infinite for current creatures,
    // spawning new mine owners creatures and changing the chest-objects so that the current owning team can use them

    ASSERT(mine == AV_NORTH_MINE || mine == AV_SOUTH_MINE);
    if (teamId == TEAM_ALLIANCE || teamId == TEAM_HORDE)
        PlaySoundToAll((teamId == TEAM_ALLIANCE) ? AV_SOUND_ALLIANCE_GOOD : AV_SOUND_HORDE_GOOD);

    if (m_Mine_Owner[mine] == teamId && !initial)
        return;
    m_Mine_Owner[mine] = teamId;

    if (!initial)
    {
        LOG_DEBUG("bg.battleground", "bg_av depopulating mine {} (0=north, 1=south)", mine);
        if (mine == AV_SOUTH_MINE)
            for (uint16 i = AV_CPLACE_MINE_S_S_MIN; i <= AV_CPLACE_MINE_S_S_MAX; i++)
                if (BgCreatures[i])
                    DelCreature(i); //TODO just set the respawntime to 999999
        for (uint16 i = ((mine == AV_NORTH_MINE) ? AV_CPLACE_MINE_N_1_MIN : AV_CPLACE_MINE_S_1_MIN); i <= ((mine == AV_NORTH_MINE) ? AV_CPLACE_MINE_N_3 : AV_CPLACE_MINE_S_3); i++)
            if (BgCreatures[i])
                DelCreature(i); //TODO here also
    }
    SendMineWorldStates(mine);

    LOG_DEBUG("bg.battleground", "bg_av populating mine {} (0=north, 1=south)", mine);
    uint16 miner;
    //also neutral team exists.. after a big time, the neutral team tries to conquer the mine
    if (mine == AV_NORTH_MINE)
    {
        if (teamId == TEAM_ALLIANCE)
            miner = AV_NPC_N_MINE_A_1;
        else if (teamId == TEAM_HORDE)
            miner = AV_NPC_N_MINE_H_1;
        else
            miner = AV_NPC_N_MINE_N_1;
    }
    else
    {
        uint16 cinfo;
        if (teamId == TEAM_ALLIANCE)
            miner = AV_NPC_S_MINE_A_1;
        else if (teamId == TEAM_HORDE)
            miner = AV_NPC_S_MINE_H_1;
        else
            miner = AV_NPC_S_MINE_N_1;
        //vermin
        LOG_DEBUG("bg.battleground", "spawning vermin");
        if (teamId == TEAM_ALLIANCE)
            cinfo = AV_NPC_S_MINE_A_3;
        else if (teamId == TEAM_HORDE)
            cinfo = AV_NPC_S_MINE_H_3;
        else
            cinfo = AV_NPC_S_MINE_N_S;
        for (uint16 i = AV_CPLACE_MINE_S_S_MIN; i <= AV_CPLACE_MINE_S_S_MAX; i++)
            AddAVCreature(cinfo, i);
    }
    for (uint16 i = ((mine == AV_NORTH_MINE) ? AV_CPLACE_MINE_N_1_MIN : AV_CPLACE_MINE_S_1_MIN); i <= ((mine == AV_NORTH_MINE) ? AV_CPLACE_MINE_N_1_MAX : AV_CPLACE_MINE_S_1_MAX); i++)
        AddAVCreature(miner, i);
    //the next chooses randomly between 2 cretures
    for (uint16 i = ((mine == AV_NORTH_MINE) ? AV_CPLACE_MINE_N_2_MIN : AV_CPLACE_MINE_S_2_MIN); i <= ((mine == AV_NORTH_MINE) ? AV_CPLACE_MINE_N_2_MAX : AV_CPLACE_MINE_S_2_MAX); i++)
        AddAVCreature(miner + (urand(1, 2)), i);
    AddAVCreature(miner + 3, (mine == AV_NORTH_MINE) ? AV_CPLACE_MINE_N_3 : AV_CPLACE_MINE_S_3);

    if (teamId == TEAM_ALLIANCE || teamId == TEAM_HORDE)
    {
        m_Mine_Reclaim_Timer[mine] = AV_MINE_RECLAIM_TIMER;
        if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
            creature->AI()->Talk(GetMineString(mine, teamId));
    }
    else
    {
        if (mine == AV_SOUTH_MINE) //i think this gets called all the time
        {
            if (Creature* creature = GetBGCreature(AV_CPLACE_MINE_S_3))
            {
                std::string creatureText = sCreatureTextMgr->GetLocalizedChatString(creature->GetEntry(), creature->getGender(), 0, 0, DEFAULT_LOCALE);
                YellToAll(creature, creatureText.c_str(), LANG_UNIVERSAL);
            }
        }
    }
}

bool BattlegroundAV::PlayerCanDoMineQuest(int32 GOId, TeamId teamId)
{
    if (GOId == BG_AV_OBJECTID_MINE_N)
        return (m_Mine_Owner[AV_NORTH_MINE] == teamId);
    if (GOId == BG_AV_OBJECTID_MINE_S)
        return (m_Mine_Owner[AV_SOUTH_MINE] == teamId);
    return true; //cause it's no mine'object it is ok if this is true
}

void BattlegroundAV::PopulateNode(BG_AV_Nodes node)
{
    TeamId ownerId = m_Nodes[node].OwnerId;

    uint32 c_place = AV_CPLACE_DEFENSE_STORM_AID + (4 * node);
    uint32 creatureid;
    if (IsTower(node))
        creatureid = (ownerId == TEAM_ALLIANCE) ? AV_NPC_A_TOWERDEFENSE : AV_NPC_H_TOWERDEFENSE;
    else
    {
        if (m_Team_QuestStatus[ownerId][0] < 500)
            creatureid = (ownerId == TEAM_ALLIANCE) ? AV_NPC_A_GRAVEDEFENSE0 : AV_NPC_H_GRAVEDEFENSE0;
        else if (m_Team_QuestStatus[ownerId][0] < 1000)
            creatureid = (ownerId == TEAM_ALLIANCE) ? AV_NPC_A_GRAVEDEFENSE1 : AV_NPC_H_GRAVEDEFENSE1;
        else if (m_Team_QuestStatus[ownerId][0] < 1500)
            creatureid = (ownerId == TEAM_ALLIANCE) ? AV_NPC_A_GRAVEDEFENSE2 : AV_NPC_H_GRAVEDEFENSE2;
        else
            creatureid = (ownerId == TEAM_ALLIANCE) ? AV_NPC_A_GRAVEDEFENSE3 : AV_NPC_H_GRAVEDEFENSE3;
        //spiritguide
        if (BgCreatures[node])
            DelCreature(node);
        if (!AddSpiritGuide(node, BG_AV_CreaturePos[node][0], BG_AV_CreaturePos[node][1], BG_AV_CreaturePos[node][2], BG_AV_CreaturePos[node][3], ownerId))
            LOG_ERROR("bg.battleground", "AV: couldn't spawn spiritguide at node {}", node);
    }
    for (uint8 i = 0; i < 4; i++)
        AddAVCreature(creatureid, c_place + i);

    if (node >= BG_AV_NODES_MAX)//fail safe
        return;
    Creature* trigger = GetBgMap()->GetCreature(BgCreatures[node + 302]);//0-302 other creatures
    if (!trigger)
    {
        trigger = AddCreature(WORLD_TRIGGER,
                              node + 302,
                              BG_AV_CreaturePos[node + 302][0],
                              BG_AV_CreaturePos[node + 302][1],
                              BG_AV_CreaturePos[node + 302][2],
                              BG_AV_CreaturePos[node + 302][3]);
    }

    //add bonus honor aura trigger creature when node is accupied
    //cast bonus aura (+50% honor in 25yards)
    //aura should only apply to players who have accupied the node, set correct faction for trigger
    if (trigger)
    {
        if (ownerId != TEAM_ALLIANCE && ownerId != TEAM_HORDE)//node can be neutral, remove trigger
        {
            DelCreature(node + 302);
            return;
        }
        trigger->SetFaction(ownerId == TEAM_ALLIANCE ? FACTION_ALLIANCE_GENERIC : FACTION_HORDE_GENERIC);
        trigger->CastSpell(trigger, SPELL_HONORABLE_DEFENDER_25Y, false);
    }
}
void BattlegroundAV::DePopulateNode(BG_AV_Nodes node, bool ignoreSpiritGuide)
{
    uint32 c_place = AV_CPLACE_DEFENSE_STORM_AID + (4 * node);
    for (uint8 i = 0; i < 4; i++)
    {
        if (BgCreatures[c_place + i])
        {
            DelCreature(c_place + i);
        }
    }

    //spiritguide
    if (!ignoreSpiritGuide && !IsTower(node))
    {
        DelCreature(node);
    }

    //remove bonus honor aura trigger creature when node is lost
    if (node < BG_AV_NODES_MAX)//fail safe
        DelCreature(node + 302);//nullptr checks are in DelCreature! 0-302 spirit guides
}

BG_AV_Nodes BattlegroundAV::GetNodeThroughObject(uint32 object)
{
    LOG_DEBUG("bg.battleground", "bg_AV getnodethroughobject {}", object);
    if (object <= BG_AV_OBJECT_FLAG_A_STONEHEART_BUNKER)
        return BG_AV_Nodes(object);
    if (object <= BG_AV_OBJECT_FLAG_C_A_FROSTWOLF_HUT)
        return BG_AV_Nodes(object - 11);
    if (object <= BG_AV_OBJECT_FLAG_C_A_FROSTWOLF_WTOWER)
        return BG_AV_Nodes(object - 7);
    if (object <= BG_AV_OBJECT_FLAG_C_H_STONEHEART_BUNKER)
        return BG_AV_Nodes(object - 22);
    if (object <= BG_AV_OBJECT_FLAG_H_FROSTWOLF_HUT)
        return BG_AV_Nodes(object - 33);
    if (object <= BG_AV_OBJECT_FLAG_H_FROSTWOLF_WTOWER)
        return BG_AV_Nodes(object - 29);
    if (object == BG_AV_OBJECT_FLAG_N_SNOWFALL_GRAVE)
        return BG_AV_NODES_SNOWFALL_GRAVE;
    LOG_ERROR("bg.battleground", "BattlegroundAV: ERROR! GetPlace got a wrong object :(");
    ABORT();
    return BG_AV_Nodes(0);
}

//npcbot
/*
//end npcbot
uint32 BattlegroundAV::GetObjectThroughNode(BG_AV_Nodes node)
//npcbot
*/
uint32 BattlegroundAV::GetObjectThroughNode(BG_AV_Nodes node, bool log) const
{
    //this function is the counterpart to GetNodeThroughObject()
    //npcbot
    if (log)
    //end npcbot
    LOG_DEBUG("bg.battleground", "bg_AV GetObjectThroughNode {}", node);
    if (m_Nodes[node].OwnerId == TEAM_ALLIANCE)
    {
        if (m_Nodes[node].State == POINT_ASSAULTED)
        {
            if (node <= BG_AV_NODES_FROSTWOLF_HUT)
                return node + 11;
            if (node >= BG_AV_NODES_ICEBLOOD_TOWER && node <= BG_AV_NODES_FROSTWOLF_WTOWER)
                return node + 7;
        }
        else if (m_Nodes[node].State == POINT_CONTROLED)
            if (node <= BG_AV_NODES_STONEHEART_BUNKER)
                return node;
    }
    else if (m_Nodes[node].OwnerId == TEAM_HORDE)
    {
        if (m_Nodes[node].State == POINT_ASSAULTED)
        {
            if (node <= BG_AV_NODES_STONEHEART_BUNKER)
                return node + 22;
        }
        else if (m_Nodes[node].State == POINT_CONTROLED)
        {
            if (node <= BG_AV_NODES_FROSTWOLF_HUT)
                return node + 33;
            if (node >= BG_AV_NODES_ICEBLOOD_TOWER && node <= BG_AV_NODES_FROSTWOLF_WTOWER)
                return node + 29;
        }
    }
    else if (m_Nodes[node].OwnerId == TEAM_NEUTRAL)
        return BG_AV_OBJECT_FLAG_N_SNOWFALL_GRAVE;
    LOG_ERROR("bg.battleground", "BattlegroundAV: Error! GetPlaceNode couldn't resolve node {}", node);
    ABORT();
    return 0;
}

//called when using banner

void BattlegroundAV::EventPlayerClickedOnFlag(Player* source, GameObject* gameObject)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;
    int32 object = GetObjectType(gameObject->GetGUID());
    if (object < 0)
        return;
    switch (gameObject->GetEntry())
    {
        case BG_AV_OBJECTID_BANNER_A:
        case BG_AV_OBJECTID_BANNER_A_B:
        case BG_AV_OBJECTID_BANNER_H:
        case BG_AV_OBJECTID_BANNER_H_B:
        case BG_AV_OBJECTID_BANNER_SNOWFALL_N:
            EventPlayerAssaultsPoint(source, object);
            break;
        case BG_AV_OBJECTID_BANNER_CONT_A:
        case BG_AV_OBJECTID_BANNER_CONT_A_B:
        case BG_AV_OBJECTID_BANNER_CONT_H:
        case BG_AV_OBJECTID_BANNER_CONT_H_B:
            EventPlayerDefendsPoint(source, object);
            break;
        default:
            break;
    }
}

//npcbot
void BattlegroundAV::EventBotClickedOnFlag(Creature* bot, GameObject* target_obj)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;
    int32 object = GetObjectType(target_obj->GetGUID());
    if (object < 0)
        return;
    switch (target_obj->GetEntry())
    {
        case BG_AV_OBJECTID_BANNER_A:
        case BG_AV_OBJECTID_BANNER_A_B:
        case BG_AV_OBJECTID_BANNER_H:
        case BG_AV_OBJECTID_BANNER_H_B:
        case BG_AV_OBJECTID_BANNER_SNOWFALL_N:
            EventBotAssaultsPoint(bot, object);
            break;
        case BG_AV_OBJECTID_BANNER_CONT_A:
        case BG_AV_OBJECTID_BANNER_CONT_A_B:
        case BG_AV_OBJECTID_BANNER_CONT_H:
        case BG_AV_OBJECTID_BANNER_CONT_H_B:
            EventBotDefendsPoint(bot, object);
            break;
        default:
            break;
    }
}
//end npcbot

void BattlegroundAV::EventPlayerDefendsPoint(Player* player, uint32 object)
{
    ASSERT(GetStatus() == STATUS_IN_PROGRESS);
    BG_AV_Nodes node = GetNodeThroughObject(object);

    TeamId ownerId = m_Nodes[node].OwnerId; //maybe should name it prevowner
    TeamId teamId = player->GetTeamId();

    if (ownerId == player->GetTeamId() || m_Nodes[node].State != POINT_ASSAULTED)
        return;
    if (m_Nodes[node].TotalOwnerId == TEAM_NEUTRAL)
    {
        //until snowfall doesn't belong to anyone it is better handled in assault-code
        ASSERT(node == BG_AV_NODES_SNOWFALL_GRAVE); //currently the only neutral grave
        EventPlayerAssaultsPoint(player, object);
        return;
    }
    LOG_DEBUG("bg.battleground", "player defends point object: {} node: {}", object, node);
    if (m_Nodes[node].PrevOwnerId != teamId)
    {
        LOG_ERROR("bg.battleground", "BG_AV: player defends point which doesn't belong to his team {}", node);
        return;
    }

    //spawn new go :)
    if (m_Nodes[node].OwnerId == TEAM_ALLIANCE)
        SpawnBGObject(object + 22, RESPAWN_IMMEDIATELY); //spawn horde banner
    else
        SpawnBGObject(object - 22, RESPAWN_IMMEDIATELY); //spawn alliance banner

    if (!IsTower(node))
    {
        SpawnBGObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + 3 * node, RESPAWN_ONE_DAY);
        SpawnBGObject(static_cast<uint8>(BG_AV_OBJECT_AURA_A_FIRSTAID_STATION) + teamId + 3 * node, RESPAWN_IMMEDIATELY);
    }
    // despawn old go
    SpawnBGObject(object, RESPAWN_ONE_DAY);

    DefendNode(node, teamId);
    PopulateNode(node);
    UpdateNodeWorldState(node);

    if (IsTower(node))
    {
        //spawn big flag+aura on top of tower
        SpawnBGObject(BG_AV_OBJECT_TAURA_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        SpawnBGObject(BG_AV_OBJECT_TAURA_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        SpawnBGObject(BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        SpawnBGObject(BG_AV_OBJECT_TFLAG_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
    }
    else if (node == BG_AV_NODES_SNOWFALL_GRAVE) //snowfall eyecandy
    {
        for (uint8 i = 0; i < 4; i++)
        {
            SpawnBGObject(((ownerId == TEAM_ALLIANCE) ? BG_AV_OBJECT_SNOW_EYECANDY_PA : BG_AV_OBJECT_SNOW_EYECANDY_PH) + i, RESPAWN_ONE_DAY);
            SpawnBGObject(((teamId == TEAM_ALLIANCE) ? BG_AV_OBJECT_SNOW_EYECANDY_A : BG_AV_OBJECT_SNOW_EYECANDY_H) + i, RESPAWN_IMMEDIATELY);
        }
    }

    if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
        creature->AI()->Talk(GetDefendString(node, teamId));

    //update the statistic for the defending player
    UpdatePlayerScore(player, (IsTower(node)) ? SCORE_TOWERS_DEFENDED : SCORE_GRAVEYARDS_DEFENDED, 1);
}

//npcbot
void BattlegroundAV::EventBotDefendsPoint(Creature* bot, uint32 object)
{
    ASSERT(GetStatus() == STATUS_IN_PROGRESS);
    BG_AV_Nodes node = GetNodeThroughObject(object);

    TeamId ownerId = m_Nodes[node].OwnerId; //maybe should name it prevowner
    TeamId teamId = GetBotTeamId(bot->GetGUID());

    if (ownerId == teamId || m_Nodes[node].State != POINT_ASSAULTED)
        return;
    if (m_Nodes[node].TotalOwnerId == TEAM_NEUTRAL)
    {
        //until snowfall doesn't belong to anyone it is better handled in assault-code
        ASSERT(node == BG_AV_NODES_SNOWFALL_GRAVE); //currently the only neutral grave
        EventBotAssaultsPoint(bot, object);
        return;
    }
    LOG_DEBUG("bg.battleground", "bot defends point object: {} node: {}", object, node);
    if (m_Nodes[node].PrevOwnerId != teamId)
    {
        LOG_ERROR("bg.battleground", "BG_AV: bot defends point which doesn't belong to his team {}", node);
        return;
    }

    //spawn new go :)
    if (m_Nodes[node].OwnerId == TEAM_ALLIANCE)
        SpawnBGObject(object + 22, RESPAWN_IMMEDIATELY); //spawn horde banner
    else
        SpawnBGObject(object - 22, RESPAWN_IMMEDIATELY); //spawn alliance banner

    if (!IsTower(node))
    {
        SpawnBGObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + 3 * node, RESPAWN_ONE_DAY);
        SpawnBGObject(static_cast<uint8>(BG_AV_OBJECT_AURA_A_FIRSTAID_STATION) + teamId + 3 * node, RESPAWN_IMMEDIATELY);
    }
    // despawn old go
    SpawnBGObject(object, RESPAWN_ONE_DAY);

    DefendNode(node, teamId);
    PopulateNode(node);
    UpdateNodeWorldState(node);

    if (IsTower(node))
    {
        //spawn big flag+aura on top of tower
        SpawnBGObject(BG_AV_OBJECT_TAURA_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        SpawnBGObject(BG_AV_OBJECT_TAURA_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        SpawnBGObject(BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        SpawnBGObject(BG_AV_OBJECT_TFLAG_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
    }
    else if (node == BG_AV_NODES_SNOWFALL_GRAVE) //snowfall eyecandy
    {
        for (uint8 i = 0; i < 4; i++)
        {
            SpawnBGObject(((ownerId == TEAM_ALLIANCE) ? BG_AV_OBJECT_SNOW_EYECANDY_PA : BG_AV_OBJECT_SNOW_EYECANDY_PH) + i, RESPAWN_ONE_DAY);
            SpawnBGObject(((teamId == TEAM_ALLIANCE) ? BG_AV_OBJECT_SNOW_EYECANDY_A : BG_AV_OBJECT_SNOW_EYECANDY_H) + i, RESPAWN_IMMEDIATELY);
        }
    }

    if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
        creature->AI()->Talk(GetDefendString(node, teamId));

    //update the statistic for the defending player
    UpdateBotScore(bot, (IsTower(node)) ? SCORE_TOWERS_DEFENDED : SCORE_GRAVEYARDS_DEFENDED, 1);
}

void BattlegroundAV::EventPlayerAssaultsPoint(Player* player, uint32 object)
{
    ASSERT(GetStatus() == STATUS_IN_PROGRESS);

    BG_AV_Nodes node = GetNodeThroughObject(object);
    TeamId prevOwnerId = m_Nodes[node].OwnerId;
    TeamId teamId  = player->GetTeamId();
    LOG_DEBUG("bg.battleground", "bg_av: player assaults point object {} node {}", object, node);
    if (prevOwnerId == teamId || teamId == m_Nodes[node].TotalOwnerId)
        return; //surely a gm used this object

    if (node == BG_AV_NODES_SNOWFALL_GRAVE) //snowfall is a bit special in capping + it gets eyecandy stuff
    {
        if (object == BG_AV_OBJECT_FLAG_N_SNOWFALL_GRAVE) //initial capping
        {
            if (!(prevOwnerId == TEAM_NEUTRAL && m_Nodes[node].TotalOwnerId == TEAM_NEUTRAL))
                return;

            if (teamId == TEAM_ALLIANCE)
                SpawnBGObject(BG_AV_OBJECT_FLAG_C_A_SNOWFALL_GRAVE, RESPAWN_IMMEDIATELY);
            else
                SpawnBGObject(BG_AV_OBJECT_FLAG_C_H_SNOWFALL_GRAVE, RESPAWN_IMMEDIATELY);
            SpawnBGObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + 3 * node, RESPAWN_IMMEDIATELY); //neutral aura spawn
        }
        else if (m_Nodes[node].TotalOwnerId == TEAM_NEUTRAL) //recapping, when no team owns this node realy
        {
            if (!(m_Nodes[node].State != POINT_CONTROLED))
                return;

            if (teamId == TEAM_ALLIANCE)
                SpawnBGObject(object - 11, RESPAWN_IMMEDIATELY);
            else
                SpawnBGObject(object + 11, RESPAWN_IMMEDIATELY);
        }
        //eyecandy
        uint32 spawn, despawn;
        if (teamId == TEAM_ALLIANCE)
        {
            despawn = (m_Nodes[node].State == POINT_ASSAULTED) ? BG_AV_OBJECT_SNOW_EYECANDY_PH : BG_AV_OBJECT_SNOW_EYECANDY_H;
            spawn = BG_AV_OBJECT_SNOW_EYECANDY_PA;
        }
        else
        {
            despawn = (m_Nodes[node].State == POINT_ASSAULTED) ? BG_AV_OBJECT_SNOW_EYECANDY_PA : BG_AV_OBJECT_SNOW_EYECANDY_A;
            spawn = BG_AV_OBJECT_SNOW_EYECANDY_PH;
        }
        for (uint8 i = 0; i < 4; i++)
        {
            SpawnBGObject(despawn + i, RESPAWN_ONE_DAY);
            SpawnBGObject(spawn + i, RESPAWN_IMMEDIATELY);
        }
    }

    // xinef: moved here, assure that no call to m_Nodes is used in IF statement bellow as it is modified
    AssaultNode(node, teamId);

    //if snowfall gots capped it can be handled like all other graveyards
    if (m_Nodes[node].TotalOwnerId != TEAM_NEUTRAL)
    {
        ASSERT(prevOwnerId != TEAM_NEUTRAL);
        if (teamId == TEAM_ALLIANCE)
            SpawnBGObject(object - 22, RESPAWN_IMMEDIATELY);
        else
            SpawnBGObject(object + 22, RESPAWN_IMMEDIATELY);

        bool ignoreSpiritGuide = false;
        if (IsTower(node))
        {
            //spawning/despawning of bigflag+aura
            SpawnBGObject(BG_AV_OBJECT_TAURA_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
            SpawnBGObject(BG_AV_OBJECT_TAURA_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
            SpawnBGObject(BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
            SpawnBGObject(BG_AV_OBJECT_TFLAG_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        }
        else
        {
            //spawning/despawning of aura
            SpawnBGObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + 3 * node, RESPAWN_IMMEDIATELY); //neutral aura spawn
            SpawnBGObject(static_cast<uint8>(BG_AV_OBJECT_AURA_A_FIRSTAID_STATION) + prevOwnerId + 3 * node, RESPAWN_ONE_DAY); //teeamaura despawn

            ignoreSpiritGuide = true;

            _reviveEvents.AddEventAtOffset([this, node]()
            {
                RelocateDeadPlayers(BgCreatures[node]);

                if (!IsTower(node))
                    DelCreature(node); // Delete spirit healer
            }, 500ms);
        }

        DePopulateNode(node, ignoreSpiritGuide);
    }

    SpawnBGObject(object, RESPAWN_ONE_DAY); //delete old banner
    // xinef: change here is too late, AssaultNode(node, team);
    UpdateNodeWorldState(node);

    if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
        creature->AI()->Talk(GetAttackString(node, teamId));

    //update the statistic for the assaulting player
    UpdatePlayerScore(player, (IsTower(node)) ? SCORE_TOWERS_ASSAULTED : SCORE_GRAVEYARDS_ASSAULTED, 1);

    player->KilledMonsterCredit((IsTower(node)) ? BG_AV_QUEST_CREDIT_TOWER : BG_AV_QUEST_CREDIT_GRAVEYARD);
}

void BattlegroundAV::EventBotAssaultsPoint(Creature* bot, uint32 object)
{
    ASSERT(GetStatus() == STATUS_IN_PROGRESS);

    BG_AV_Nodes node = GetNodeThroughObject(object);
    TeamId prevOwnerId = m_Nodes[node].OwnerId;
    TeamId teamId = GetBotTeamId(bot->GetGUID());
    LOG_DEBUG("bg.battleground", "bg_av: player assaults point object {} node {}", object, node);
    if (prevOwnerId == teamId || teamId == m_Nodes[node].TotalOwnerId)
        return; //surely a gm used this object

    if (node == BG_AV_NODES_SNOWFALL_GRAVE) //snowfall is a bit special in capping + it gets eyecandy stuff
    {
        if (object == BG_AV_OBJECT_FLAG_N_SNOWFALL_GRAVE) //initial capping
        {
            if (!(prevOwnerId == TEAM_NEUTRAL && m_Nodes[node].TotalOwnerId == TEAM_NEUTRAL))
                return;

            if (teamId == TEAM_ALLIANCE)
                SpawnBGObject(BG_AV_OBJECT_FLAG_C_A_SNOWFALL_GRAVE, RESPAWN_IMMEDIATELY);
            else
                SpawnBGObject(BG_AV_OBJECT_FLAG_C_H_SNOWFALL_GRAVE, RESPAWN_IMMEDIATELY);
            SpawnBGObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + 3 * node, RESPAWN_IMMEDIATELY); //neutral aura spawn
        }
        else if (m_Nodes[node].TotalOwnerId == TEAM_NEUTRAL) //recapping, when no team owns this node realy
        {
            if (!(m_Nodes[node].State != POINT_CONTROLED))
                return;

            if (teamId == TEAM_ALLIANCE)
                SpawnBGObject(object - 11, RESPAWN_IMMEDIATELY);
            else
                SpawnBGObject(object + 11, RESPAWN_IMMEDIATELY);
        }
        //eyecandy
        uint32 spawn, despawn;
        if (teamId == TEAM_ALLIANCE)
        {
            despawn = (m_Nodes[node].State == POINT_ASSAULTED) ? BG_AV_OBJECT_SNOW_EYECANDY_PH : BG_AV_OBJECT_SNOW_EYECANDY_H;
            spawn = BG_AV_OBJECT_SNOW_EYECANDY_PA;
        }
        else
        {
            despawn = (m_Nodes[node].State == POINT_ASSAULTED) ? BG_AV_OBJECT_SNOW_EYECANDY_PA : BG_AV_OBJECT_SNOW_EYECANDY_A;
            spawn = BG_AV_OBJECT_SNOW_EYECANDY_PH;
        }
        for (uint8 i = 0; i < 4; i++)
        {
            SpawnBGObject(despawn + i, RESPAWN_ONE_DAY);
            SpawnBGObject(spawn + i, RESPAWN_IMMEDIATELY);
        }
    }

    // xinef: moved here, assure that no call to m_Nodes is used in IF statement bellow as it is modified
    AssaultNode(node, teamId);

    //if snowfall gots capped it can be handled like all other graveyards
    if (m_Nodes[node].TotalOwnerId != TEAM_NEUTRAL)
    {
        ASSERT(prevOwnerId != TEAM_NEUTRAL);
        if (teamId == TEAM_ALLIANCE)
            SpawnBGObject(object - 22, RESPAWN_IMMEDIATELY);
        else
            SpawnBGObject(object + 22, RESPAWN_IMMEDIATELY);

        bool ignoreSpiritGuide = false;
        if (IsTower(node))
        {
            //spawning/despawning of bigflag+aura
            SpawnBGObject(BG_AV_OBJECT_TAURA_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
            SpawnBGObject(BG_AV_OBJECT_TAURA_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
            SpawnBGObject(BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_ALLIANCE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
            SpawnBGObject(BG_AV_OBJECT_TFLAG_H_DUNBALDAR_SOUTH + (2 * (node - BG_AV_NODES_DUNBALDAR_SOUTH)), (teamId == TEAM_HORDE) ? RESPAWN_IMMEDIATELY : RESPAWN_ONE_DAY);
        }
        else
        {
            //spawning/despawning of aura
            SpawnBGObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + 3 * node, RESPAWN_IMMEDIATELY); //neutral aura spawn
            SpawnBGObject(static_cast<uint8>(BG_AV_OBJECT_AURA_A_FIRSTAID_STATION) + prevOwnerId + 3 * node, RESPAWN_ONE_DAY); //teeamaura despawn

            ignoreSpiritGuide = true;

            _reviveEvents.AddEventAtOffset([this, node]()
            {
                RelocateDeadPlayers(BgCreatures[node]);

                if (!IsTower(node))
                    DelCreature(node); // Delete spirit healer
            }, 500ms);
        }

        DePopulateNode(node, ignoreSpiritGuide);
    }

    SpawnBGObject(object, RESPAWN_ONE_DAY); //delete old banner
    // xinef: change here is too late, AssaultNode(node, team);
    UpdateNodeWorldState(node);

    if (Creature* creature = GetBGCreature(AV_CPLACE_HERALD))
        creature->AI()->Talk(GetAttackString(node, teamId));

    //update the statistic for the assaulting player
    UpdateBotScore(bot, (IsTower(node)) ? SCORE_TOWERS_ASSAULTED : SCORE_GRAVEYARDS_ASSAULTED, 1);
    PlaySoundToAll((teamId == TEAM_ALLIANCE) ? AV_SOUND_ALLIANCE_ASSAULTS : AV_SOUND_HORDE_ASSAULTS);
}

void BattlegroundAV::FillInitialWorldStates(WorldPacket& data)
{
    bool stateok;
    //graveyards
    for (uint8 i = BG_AV_NODES_FIRSTAID_STATION; i <= BG_AV_NODES_FROSTWOLF_HUT; i++)
    {
        for (uint8 j = 1; j <= 3; j += 2)
        {
            //j=1=assaulted j=3=controled
            stateok = (m_Nodes[i].State == j);
            data << uint32(BG_AV_NodeWorldStates[i][GetWorldStateType(j, TEAM_ALLIANCE)]) << uint32((m_Nodes[i].OwnerId == TEAM_ALLIANCE && stateok) ? 1 : 0);
            data << uint32(BG_AV_NodeWorldStates[i][GetWorldStateType(j, TEAM_HORDE)]) << uint32((m_Nodes[i].OwnerId == TEAM_HORDE && stateok) ? 1 : 0);
        }
    }

    //towers
    for (uint8 i = BG_AV_NODES_DUNBALDAR_SOUTH; i < BG_AV_NODES_MAX; ++i)
        for (uint8 j = 1; j <= 3; j += 2)
        {
            //j=1=assaulted j=3=controled //i dont have j=2=destroyed cause destroyed is the same like enemy-team controll
            stateok = (m_Nodes[i].State == j || (m_Nodes[i].State == POINT_DESTROYED && j == 3));
            data << uint32(BG_AV_NodeWorldStates[i][GetWorldStateType(j, TEAM_ALLIANCE)]) << uint32((m_Nodes[i].OwnerId == TEAM_ALLIANCE && stateok) ? 1 : 0);
            data << uint32(BG_AV_NodeWorldStates[i][GetWorldStateType(j, TEAM_HORDE)]) << uint32((m_Nodes[i].OwnerId == TEAM_HORDE && stateok) ? 1 : 0);
        }
    if (m_Nodes[BG_AV_NODES_SNOWFALL_GRAVE].OwnerId == TEAM_NEUTRAL) //cause neutral teams aren't handled generic
        data << uint32(AV_SNOWFALL_N) << uint32(1);
    data << uint32(AV_Alliance_Score)  << uint32(m_Team_Scores[0]);
    data << uint32(AV_Horde_Score) << uint32(m_Team_Scores[1]);
    if (GetStatus() == STATUS_IN_PROGRESS)  //only if game started the teamscores are displayed
    {
        data << uint32(AV_SHOW_A_SCORE) << uint32(1);
        data << uint32(AV_SHOW_H_SCORE) << uint32(1);
    }
    else
    {
        data << uint32(AV_SHOW_A_SCORE) << uint32(0);
        data << uint32(AV_SHOW_H_SCORE) << uint32(0);
    }
    SendMineWorldStates(AV_NORTH_MINE);
    SendMineWorldStates(AV_SOUTH_MINE);
}

uint8 BattlegroundAV::GetWorldStateType(uint8 state, TeamId teamId) //this is used for node worldstates and returns values which fit good into the worldstatesarray
{
    //neutral stuff cant get handled (currently its only snowfall)
    ASSERT(teamId != TEAM_NEUTRAL);
    //a_c a_a h_c h_a the positions in worldstate-array
    if (teamId == TEAM_ALLIANCE)
    {
        if (state == POINT_CONTROLED || state == POINT_DESTROYED)
            return 0;
        if (state == POINT_ASSAULTED)
            return 1;
    }
    if (teamId == TEAM_HORDE)
    {
        if (state == POINT_DESTROYED || state == POINT_CONTROLED)
            return 2;
        if (state == POINT_ASSAULTED)
            return 3;
    }
    LOG_ERROR("bg.battleground", "BG_AV: should update a strange worldstate state:{} team:{}", state, teamId);
    return 5; //this will crash the game, but i want to know if something is wrong here
}

void BattlegroundAV::UpdateNodeWorldState(BG_AV_Nodes node)
{
    UpdateWorldState(BG_AV_NodeWorldStates[node][GetWorldStateType(m_Nodes[node].State, m_Nodes[node].OwnerId)], 1);
    if (m_Nodes[node].PrevOwnerId == TEAM_NEUTRAL) //currently only snowfall is supported as neutral node (i don't want to make an extra row (neutral states) in worldstatesarray just for one node
        UpdateWorldState(AV_SNOWFALL_N, 0);
    else
        UpdateWorldState(BG_AV_NodeWorldStates[node][GetWorldStateType(m_Nodes[node].PrevState, m_Nodes[node].PrevOwnerId)], 0);
}

void BattlegroundAV::SendMineWorldStates(uint32 mine)
{
    ASSERT(mine == AV_NORTH_MINE || mine == AV_SOUTH_MINE);

    uint8 owner = 1;

    if (m_Mine_Owner[mine] == TEAM_ALLIANCE)
        owner = 0;
    else if (m_Mine_Owner[mine] == TEAM_HORDE)
        owner = 2;

    for (uint8 i = 0; i < 3; ++i)
        UpdateWorldState(BG_AV_MineWorldStates[mine][i], 0); // Xinef: Clear data for consistency and buglessness

    UpdateWorldState(BG_AV_MineWorldStates[mine][owner], 1);
}

GraveyardStruct const* BattlegroundAV::GetClosestGraveyard(Player* player)
{
    GraveyardStruct const* entry = nullptr;
    float dist = 0;
    float minDist = 0;
    float x, y;

    player->GetPosition(x, y);

    GraveyardStruct const* pGraveyard = sGraveyard->GetGraveyard(BG_AV_GraveyardIds[player->GetTeamId() + 7]);
    minDist = (pGraveyard->x - x) * (pGraveyard->x - x) + (pGraveyard->y - y) * (pGraveyard->y - y);

    for (uint8 i = BG_AV_NODES_FIRSTAID_STATION; i <= BG_AV_NODES_FROSTWOLF_HUT; ++i)
        if (m_Nodes[i].OwnerId == player->GetTeamId() && m_Nodes[i].State == POINT_CONTROLED)
        {
            entry = sGraveyard->GetGraveyard(BG_AV_GraveyardIds[i]);
            if (entry)
            {
                dist = (entry->x - x) * (entry->x - x) + (entry->y - y) * (entry->y - y);
                if (dist < minDist)
                {
                    minDist = dist;
                    pGraveyard = entry;
                }
            }
        }
    return pGraveyard;
}

//npcbot
GraveyardStruct const* BattlegroundAV::GetClosestGraveyardForBot(Creature* bot) const
{
    GraveyardStruct const* entry = nullptr;
    float dist = 0;
    float minDist = 0;
    float x, y;

    bot->GetPosition(x, y);

    GraveyardStruct const* pGraveyard = sGraveyard->GetGraveyard(BG_AV_GraveyardIds[GetBotTeamId(bot->GetGUID()) + 7]);
    minDist = (pGraveyard->x - x) * (pGraveyard->x - x) + (pGraveyard->y - y) * (pGraveyard->y - y);

    for (uint8 i = BG_AV_NODES_FIRSTAID_STATION; i <= BG_AV_NODES_FROSTWOLF_HUT; ++i)
        if (m_Nodes[i].OwnerId == GetBotTeamId(bot->GetGUID()) && m_Nodes[i].State == POINT_CONTROLED)
        {
            entry = sGraveyard->GetGraveyard(BG_AV_GraveyardIds[i]);
            if (entry)
            {
                dist = (entry->x - x) * (entry->x - x) + (entry->y - y) * (entry->y - y);
                if (dist < minDist)
                {
                    minDist = dist;
                    pGraveyard = entry;
                }
            }
        }
    return pGraveyard;
}
//end npcbot

bool BattlegroundAV::SetupBattleground()
{
    // Create starting objects

    //spawn node-objects
    for (uint8 i = BG_AV_NODES_FIRSTAID_STATION; i < BG_AV_NODES_MAX; ++i)
    {
        if (i <= BG_AV_NODES_FROSTWOLF_HUT)
        {
            if (!AddObject(i, BG_AV_OBJECTID_BANNER_A_B, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                    || !AddObject(i + 11, BG_AV_OBJECTID_BANNER_CONT_A_B, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                    || !AddObject(i + 33, BG_AV_OBJECTID_BANNER_H_B, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                    || !AddObject(i + 22, BG_AV_OBJECTID_BANNER_CONT_H_B, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                    //aura
                    || !AddObject(BG_AV_OBJECT_AURA_N_FIRSTAID_STATION + i * 3, BG_AV_OBJECTID_AURA_N, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                    || !AddObject(BG_AV_OBJECT_AURA_A_FIRSTAID_STATION + i * 3, BG_AV_OBJECTID_AURA_A, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                    || !AddObject(BG_AV_OBJECT_AURA_H_FIRSTAID_STATION + i * 3, BG_AV_OBJECTID_AURA_H, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY))
            {
                LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!2");
                return false;
            }
        }
        else //towers
        {
            if (i <= BG_AV_NODES_STONEHEART_BUNKER) //alliance towers
            {
                if (!AddObject(i, BG_AV_OBJECTID_BANNER_A, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(i + 22, BG_AV_OBJECTID_BANNER_CONT_H, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TAURA_A_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_AURA_A, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TAURA_H_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_AURA_N, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_TOWER_BANNER_A, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TFLAG_H_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_TOWER_BANNER_PH, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY))
                {
                    LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!3");
                    return false;
                }
            }
            else //horde towers
            {
                if (!AddObject(i + 7, BG_AV_OBJECTID_BANNER_CONT_A, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(i + 29, BG_AV_OBJECTID_BANNER_H, BG_AV_ObjectPos[i][0], BG_AV_ObjectPos[i][1], BG_AV_ObjectPos[i][2], BG_AV_ObjectPos[i][3], 0, 0, std::sin(BG_AV_ObjectPos[i][3] / 2), cos(BG_AV_ObjectPos[i][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TAURA_A_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_AURA_N, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TAURA_H_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_AURA_H, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_TOWER_BANNER_PA, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY)
                        || !AddObject(BG_AV_OBJECT_TFLAG_H_DUNBALDAR_SOUTH + (2 * (i - BG_AV_NODES_DUNBALDAR_SOUTH)), BG_AV_OBJECTID_TOWER_BANNER_H, BG_AV_ObjectPos[i + 8][0], BG_AV_ObjectPos[i + 8][1], BG_AV_ObjectPos[i + 8][2], BG_AV_ObjectPos[i + 8][3], 0, 0, std::sin(BG_AV_ObjectPos[i + 8][3] / 2), cos(BG_AV_ObjectPos[i + 8][3] / 2), RESPAWN_ONE_DAY))
                {
                    LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!4");
                    return false;
                }
            }
            for (uint8 j = 0; j <= 9; j++) //burning aura
            {
                if (!AddObject(BG_AV_OBJECT_BURN_DUNBALDAR_SOUTH + ((i - BG_AV_NODES_DUNBALDAR_SOUTH) * 10) + j, BG_AV_OBJECTID_FIRE, BG_AV_ObjectPos[AV_OPLACE_BURN_DUNBALDAR_SOUTH + ((i - BG_AV_NODES_DUNBALDAR_SOUTH) * 10) + j][0], BG_AV_ObjectPos[AV_OPLACE_BURN_DUNBALDAR_SOUTH + ((i - BG_AV_NODES_DUNBALDAR_SOUTH) * 10) + j][1], BG_AV_ObjectPos[AV_OPLACE_BURN_DUNBALDAR_SOUTH + ((i - BG_AV_NODES_DUNBALDAR_SOUTH) * 10) + j][2], BG_AV_ObjectPos[AV_OPLACE_BURN_DUNBALDAR_SOUTH + ((i - BG_AV_NODES_DUNBALDAR_SOUTH) * 10) + j][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_BURN_DUNBALDAR_SOUTH + ((i - BG_AV_NODES_DUNBALDAR_SOUTH) * 10) + j][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_BURN_DUNBALDAR_SOUTH + ((i - BG_AV_NODES_DUNBALDAR_SOUTH) * 10) + j][3] / 2), RESPAWN_ONE_DAY))
                {
                    LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!5.{}", i);
                    return false;
                }
            }
        }
    }
    for (uint8 i = 0; i < 2; i++) //burning aura for buildings
    {
        for (uint8 j = 0; j <= 9; j++)
        {
            if (j < 5)
            {
                if (!AddObject(BG_AV_OBJECT_BURN_BUILDING_ALLIANCE + (i * 10) + j, BG_AV_OBJECTID_SMOKE, BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][0], BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][1], BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][2], BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][3] / 2), RESPAWN_ONE_DAY))
                {
                    LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!6.{}", i);
                    return false;
                }
            }
            else
            {
                if (!AddObject(BG_AV_OBJECT_BURN_BUILDING_ALLIANCE + (i * 10) + j, BG_AV_OBJECTID_FIRE, BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][0], BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][1], BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][2], BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_BURN_BUILDING_A + (i * 10) + j][3] / 2), RESPAWN_ONE_DAY))
                {
                    LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!7.{}", i);
                    return false;
                }
            }
        }
    }
    for (uint16 i = 0; i <= (BG_AV_OBJECT_MINE_SUPPLY_N_MAX - BG_AV_OBJECT_MINE_SUPPLY_N_MIN); i++)
    {
        if (!AddObject(BG_AV_OBJECT_MINE_SUPPLY_N_MIN + i, BG_AV_OBJECTID_MINE_N, BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_N_MIN + i][0], BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_N_MIN + i][1], BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_N_MIN + i][2], BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_N_MIN + i][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_N_MIN + i][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_N_MIN + i][3] / 2), RESPAWN_ONE_DAY))
        {
            LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some mine supplies Battleground not created!7.5.{}", i);
            return false;
        }
    }
    for (uint16 i = 0; i <= (BG_AV_OBJECT_MINE_SUPPLY_S_MAX - BG_AV_OBJECT_MINE_SUPPLY_S_MIN); i++)
    {
        if (!AddObject(BG_AV_OBJECT_MINE_SUPPLY_S_MIN + i, BG_AV_OBJECTID_MINE_S, BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_S_MIN + i][0], BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_S_MIN + i][1], BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_S_MIN + i][2], BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_S_MIN + i][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_S_MIN + i][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_MINE_SUPPLY_S_MIN + i][3] / 2), RESPAWN_ONE_DAY))
        {
            LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some mine supplies Battleground not created!7.6.{}", i);
            return false;
        }
    }

    if (!AddObject(BG_AV_OBJECT_FLAG_N_SNOWFALL_GRAVE, BG_AV_OBJECTID_BANNER_SNOWFALL_N, BG_AV_ObjectPos[BG_AV_NODES_SNOWFALL_GRAVE][0], BG_AV_ObjectPos[BG_AV_NODES_SNOWFALL_GRAVE][1], BG_AV_ObjectPos[BG_AV_NODES_SNOWFALL_GRAVE][2], BG_AV_ObjectPos[BG_AV_NODES_SNOWFALL_GRAVE][3], 0, 0, std::sin(BG_AV_ObjectPos[BG_AV_NODES_SNOWFALL_GRAVE][3] / 2), cos(BG_AV_ObjectPos[BG_AV_NODES_SNOWFALL_GRAVE][3] / 2), RESPAWN_ONE_DAY))
    {
        LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!8");
        return false;
    }
    for (uint8 i = 0; i < 4; i++)
    {
        if (!AddObject(BG_AV_OBJECT_SNOW_EYECANDY_A + i, BG_AV_OBJECTID_SNOWFALL_CANDY_A, BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][0], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][1], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][2], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), RESPAWN_ONE_DAY)
                || !AddObject(BG_AV_OBJECT_SNOW_EYECANDY_PA + i, BG_AV_OBJECTID_SNOWFALL_CANDY_PA, BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][0], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][1], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][2], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), RESPAWN_ONE_DAY)
                || !AddObject(BG_AV_OBJECT_SNOW_EYECANDY_H + i, BG_AV_OBJECTID_SNOWFALL_CANDY_H, BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][0], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][1], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][2], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), RESPAWN_ONE_DAY)
                || !AddObject(BG_AV_OBJECT_SNOW_EYECANDY_PH + i, BG_AV_OBJECTID_SNOWFALL_CANDY_PH, BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][0], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][1], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][2], BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_SNOW_1 + i][3] / 2), RESPAWN_ONE_DAY))
        {
            LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!9.{}", i);
            return false;
        }
    }

    // Handpacked snowdrift, only during holiday
    if (IsHolidayActive(HOLIDAY_FEAST_OF_WINTER_VEIL))
        for (uint16 i = 0 ; i <= (BG_AV_OBJECT_HANDPACKED_SNOWDRIFT_MAX - BG_AV_OBJECT_HANDPACKED_SNOWDRIFT_MIN); i++)
        {
            if (!AddObject(BG_AV_OBJECT_HANDPACKED_SNOWDRIFT_MIN + i, BG_AV_OBJECTID_HARDPACKED_SNOWDRIFT, BG_AV_ObjectPos[AV_OPLACE_HANDPACKED_SNOWDRIFT_MIN + i][0], BG_AV_ObjectPos[AV_OPLACE_HANDPACKED_SNOWDRIFT_MIN + i][1], BG_AV_ObjectPos[AV_OPLACE_HANDPACKED_SNOWDRIFT_MIN + i][2], BG_AV_ObjectPos[AV_OPLACE_HANDPACKED_SNOWDRIFT_MIN + i][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_HANDPACKED_SNOWDRIFT_MIN + i][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_HANDPACKED_SNOWDRIFT_MIN + i][3] / 2), RESPAWN_ONE_DAY))
                return false;
        }

    // Generic gameobjects
    for (uint16 i = 0; i <= (BG_AV_OBJECT_GENERIC_MAX - BG_AV_OBJECT_GENERIC_MIN); i++)
    {
        if (!AddObject(BG_AV_OBJECT_GENERIC_MIN + i,
            std::get<0>(BG_AV_GenericObjectPos[i]),
            std::get<1>(BG_AV_GenericObjectPos[i]).GetPositionX(),
            std::get<1>(BG_AV_GenericObjectPos[i]).GetPositionY(),
            std::get<1>(BG_AV_GenericObjectPos[i]).GetPositionZ(),
            std::get<1>(BG_AV_GenericObjectPos[i]).GetOrientation(),
            std::get<2>(BG_AV_GenericObjectPos[i])[0],
            std::get<2>(BG_AV_GenericObjectPos[i])[1],
            std::get<2>(BG_AV_GenericObjectPos[i])[2],
            std::get<2>(BG_AV_GenericObjectPos[i])[3],
            RESPAWN_ONE_DAY))
        {
            LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!10.{}", i);
            return false;
        }
    }

    // Quest banners
    if (!AddObject(BG_AV_OBJECT_FROSTWOLF_BANNER, BG_AV_OBJECTID_FROSTWOLF_BANNER, BG_AV_ObjectPos[AV_OPLACE_FROSTWOLF_BANNER][0], BG_AV_ObjectPos[AV_OPLACE_FROSTWOLF_BANNER][1], BG_AV_ObjectPos[AV_OPLACE_FROSTWOLF_BANNER][2], BG_AV_ObjectPos[AV_OPLACE_FROSTWOLF_BANNER][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_FROSTWOLF_BANNER][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_FROSTWOLF_BANNER][3] / 2), RESPAWN_ONE_DAY))
    {
        LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!8");
        return false;
    }
    if (!AddObject(BG_AV_OBJECT_STORMPIKE_BANNER, BG_AV_OBJECTID_STORMPIKE_BANNER, BG_AV_ObjectPos[AV_OPLACE_STORMPIKE_BANNER][0], BG_AV_ObjectPos[AV_OPLACE_STORMPIKE_BANNER][1], BG_AV_ObjectPos[AV_OPLACE_STORMPIKE_BANNER][2], BG_AV_ObjectPos[AV_OPLACE_STORMPIKE_BANNER][3], 0, 0, std::sin(BG_AV_ObjectPos[AV_OPLACE_STORMPIKE_BANNER][3] / 2), cos(BG_AV_ObjectPos[AV_OPLACE_STORMPIKE_BANNER][3] / 2), RESPAWN_ONE_DAY))
    {
        LOG_ERROR("bg.battleground", "BatteGroundAV: Failed to spawn some object Battleground not created!8");
        return false;
    }

    uint16 i;
    LOG_DEBUG("bg.battleground", "Alterac Valley: entering state STATUS_WAIT_JOIN ...");
    // Initial Nodes
    for (i = 0; i < BG_AV_OBJECT_MAX; i++)
        SpawnBGObject(i, RESPAWN_ONE_DAY);

    for (i = BG_AV_OBJECT_FLAG_A_FIRSTAID_STATION; i <= BG_AV_OBJECT_FLAG_A_STONEHEART_GRAVE; i++)
    {
        SpawnBGObject(BG_AV_OBJECT_AURA_A_FIRSTAID_STATION + 3 * i, RESPAWN_IMMEDIATELY);
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);
    }

    for (i = BG_AV_OBJECT_FLAG_A_DUNBALDAR_SOUTH; i <= BG_AV_OBJECT_FLAG_A_STONEHEART_BUNKER; i++)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    for (i = BG_AV_OBJECT_FLAG_H_ICEBLOOD_GRAVE; i <= BG_AV_OBJECT_FLAG_H_FROSTWOLF_WTOWER; i++)
    {
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);
        if (i <= BG_AV_OBJECT_FLAG_H_FROSTWOLF_HUT)
            SpawnBGObject(BG_AV_OBJECT_AURA_H_FIRSTAID_STATION + 3 * GetNodeThroughObject(i), RESPAWN_IMMEDIATELY);
    }

    for (i = BG_AV_OBJECT_TFLAG_A_DUNBALDAR_SOUTH; i <= BG_AV_OBJECT_TFLAG_A_STONEHEART_BUNKER; i += 2)
    {
        SpawnBGObject(i, RESPAWN_IMMEDIATELY); //flag
        SpawnBGObject(i + 16, RESPAWN_IMMEDIATELY); //aura
    }

    for (i = BG_AV_OBJECT_TFLAG_H_ICEBLOOD_TOWER; i <= BG_AV_OBJECT_TFLAG_H_FROSTWOLF_WTOWER; i += 2)
    {
        SpawnBGObject(i, RESPAWN_IMMEDIATELY); //flag
        SpawnBGObject(i + 16, RESPAWN_IMMEDIATELY); //aura
    }

    //snowfall and the doors
    SpawnBGObject(BG_AV_OBJECT_FLAG_N_SNOWFALL_GRAVE, RESPAWN_IMMEDIATELY);
    SpawnBGObject(BG_AV_OBJECT_AURA_N_SNOWFALL_GRAVE, RESPAWN_IMMEDIATELY);

    // Handpacked snowdrift, only during holiday
    if (IsHolidayActive(HOLIDAY_FEAST_OF_WINTER_VEIL))
        for (i = BG_AV_OBJECT_HANDPACKED_SNOWDRIFT_MIN ; i <= BG_AV_OBJECT_HANDPACKED_SNOWDRIFT_MAX; i++)
            SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    // Generic gameobjects
    for (uint16 i = BG_AV_OBJECT_GENERIC_MIN; i <= BG_AV_OBJECT_GENERIC_MAX; i++)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    // Quest banners
    SpawnBGObject(BG_AV_OBJECT_FROSTWOLF_BANNER, RESPAWN_IMMEDIATELY);
    SpawnBGObject(BG_AV_OBJECT_STORMPIKE_BANNER, RESPAWN_IMMEDIATELY);

    //creatures
    LOG_DEBUG("bg.battleground", "BG_AV start poputlating nodes");
    for (i = BG_AV_NODES_FIRSTAID_STATION; i < BG_AV_NODES_MAX; ++i)
    {
        if (m_Nodes[i].OwnerId != TEAM_NEUTRAL)
            PopulateNode(BG_AV_Nodes(i));
    }
    //all creatures which don't get despawned through the script are static
    LOG_DEBUG("bg.battleground", "BG_AV: start spawning static creatures");
    for (i = 0; i < AV_STATICCPLACE_MAX; i++)
        AddAVCreature(0, i + AV_CPLACE_MAX);
    //mainspiritguides:
    LOG_DEBUG("bg.battleground", "BG_AV: start spawning spiritguides creatures");
    AddSpiritGuide(7, BG_AV_CreaturePos[7][0], BG_AV_CreaturePos[7][1], BG_AV_CreaturePos[7][2], BG_AV_CreaturePos[7][3], TEAM_ALLIANCE);
    AddSpiritGuide(8, BG_AV_CreaturePos[8][0], BG_AV_CreaturePos[8][1], BG_AV_CreaturePos[8][2], BG_AV_CreaturePos[8][3], TEAM_HORDE);
    //spawn the marshals (those who get deleted, if a tower gets destroyed)
    LOG_DEBUG("bg.battleground", "BG_AV: start spawning marshal creatures");
    for (i = AV_NPC_A_MARSHAL_SOUTH; i <= AV_NPC_H_MARSHAL_WTOWER; i++)
        AddAVCreature(i, AV_CPLACE_A_MARSHAL_SOUTH + (i - AV_NPC_A_MARSHAL_SOUTH));
    AddAVCreature(AV_NPC_HERALD, AV_CPLACE_HERALD);

    if (
        // alliance gates
        !AddObject(BG_AV_OBJECT_DOOR_A, BG_AV_OBJECTID_GATE_A, BG_AV_DoorPositons[0][0], BG_AV_DoorPositons[0][1], BG_AV_DoorPositons[0][2], BG_AV_DoorPositons[0][3], 0, 0, std::sin(BG_AV_DoorPositons[0][3] / 2), cos(BG_AV_DoorPositons[0][3] / 2), RESPAWN_IMMEDIATELY)
        // horde gates
        || !AddObject(BG_AV_OBJECT_DOOR_H, BG_AV_OBJECTID_GATE_H, BG_AV_DoorPositons[1][0], BG_AV_DoorPositons[1][1], BG_AV_DoorPositons[1][2], BG_AV_DoorPositons[1][3], 0, 0, std::sin(BG_AV_DoorPositons[1][3] / 2), cos(BG_AV_DoorPositons[1][3] / 2), RESPAWN_IMMEDIATELY))
    {
        LOG_ERROR("sql.sql", "BatteGroundAV: Failed to spawn some object Battleground not created!1");
        return false;
    }

    return true;
}

uint8 BattlegroundAV::GetAttackString(BG_AV_Nodes node, TeamId teamId)
{
    uint8 strId = 0;
    switch (node)
    {
    case BG_AV_NODES_FIRSTAID_STATION:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STORMPIKE_AID_STATION_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_STORMPIKE_AID_STATION_ATTACK;
        break;
    case BG_AV_NODES_DUNBALDAR_SOUTH:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_DUN_BALDAR_SOUTH_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_DUN_BALDAR_SOUTH_ATTACK;
        break;
    case BG_AV_NODES_DUNBALDAR_NORTH:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_DUN_BALDAR_NORTH_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_DUN_BALDAR_NORTH_ATTACK;
        break;
    case BG_AV_NODES_STORMPIKE_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STORMPIKE_GRAVEYARD_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_STORMPIKE_GRAVEYARD_ATTACK;
        break;
    case BG_AV_NODES_ICEWING_BUNKER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_ICEWING_BUNKER_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_ICEWING_BUNKER_ATTACK;
        break;
    case BG_AV_NODES_STONEHEART_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STONEHEARTH_GRAVEYARD_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_STONEHEARTH_GRAVEYARD_ATTACK;
        break;
    case BG_AV_NODES_STONEHEART_BUNKER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STONEHEARTH_BUNKER_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_STONEHEARTH_BUNKER_ATTACK;
        break;
    case BG_AV_NODES_SNOWFALL_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_SNOWFALL_GRAVEYARD_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_SNOWFALL_GRAVEYARD_ATTACK;
        break;
    case BG_AV_NODES_ICEBLOOD_TOWER:
        strId = AV_TEXT_A_HERALD_ICEBLOOD_TOWER_ATTACK;
        break;
    case BG_AV_NODES_ICEBLOOD_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_ICEBLOOD_GRAVEYARD_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_ICEBLOOD_GRAVEYARD_ATTACK;
        break;
    case BG_AV_NODES_TOWER_POINT:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_TOWER_POINT_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_TOWER_POINT_ATTACK;
        break;
    case BG_AV_NODES_FROSTWOLF_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_FROSTWOLF_GRAVEYARD_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_FROSTWOLF_GRAVEYARD_ATTACK;
        break;
    case BG_AV_NODES_FROSTWOLF_ETOWER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_EAST_FROSTWOLF_TOWER_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_EAST_FROSTWOLF_TOWER_ATTACK;
        break;
    case BG_AV_NODES_FROSTWOLF_WTOWER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_WEST_FROSTWOLF_TOWER_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_WEST_FROSTWOLF_TOWER_ATTACK;
        break;
    case BG_AV_NODES_FROSTWOLF_HUT:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_FROSTWOLF_RELIEF_HUT_ATTACK;
        else
            strId = AV_TEXT_H_HERALD_FROSTWOLF_RELIEF_HUT_ATTACK;
        break;
    default:
        break;
    }

    return strId;
}

uint8 BattlegroundAV::GetDefendString(BG_AV_Nodes node, TeamId teamId)
{
    uint8 strId = 0;
    switch (node)
    {
    case BG_AV_NODES_FIRSTAID_STATION:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STORMPIKE_AID_STATION_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_STORMPIKE_AID_STATION_TAKEN;
        break;
    case BG_AV_NODES_DUNBALDAR_SOUTH:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_DUN_BALDAR_SOUTH_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_DUN_BALDAR_SOUTH_TAKEN;
        break;
    case BG_AV_NODES_DUNBALDAR_NORTH:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_DUN_BALDAR_NORTH_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_DUN_BALDAR_NORTH_TAKEN;
        break;
    case BG_AV_NODES_STORMPIKE_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STORMPIKE_GRAVEYARD_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_STORMPIKE_GRAVEYARD_TAKEN;
        break;
    case BG_AV_NODES_ICEWING_BUNKER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_ICEWING_BUNKER_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_ICEWING_BUNKER_TAKEN;
        break;
    case BG_AV_NODES_STONEHEART_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STONEHEARTH_GRAVEYARD_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_STONEHEARTH_GRAVEYARD_TAKEN;
        break;
    case BG_AV_NODES_STONEHEART_BUNKER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_STONEHEARTH_BUNKER_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_STONEHEARTH_BUNKER_TAKEN;
        break;
    case BG_AV_NODES_SNOWFALL_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_SNOWFALL_GRAVEYARD_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_SNOWFALL_GRAVEYARD_TAKEN;
        break;
    case BG_AV_NODES_ICEBLOOD_TOWER:
        strId = AV_TEXT_A_HERALD_ICEBLOOD_TOWER_TAKEN;
        break;
    case BG_AV_NODES_ICEBLOOD_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_ICEBLOOD_GRAVEYARD_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_ICEBLOOD_GRAVEYARD_TAKEN;
        break;
    case BG_AV_NODES_TOWER_POINT:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_TOWER_POINT_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_TOWER_POINT_TAKEN;
        break;
    case BG_AV_NODES_FROSTWOLF_GRAVE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_FROSTWOLF_GRAVEYARD_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_FROSTWOLF_GRAVEYARD_TAKEN;
        break;
    case BG_AV_NODES_FROSTWOLF_ETOWER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_EAST_FROSTWOLF_TOWER_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_EAST_FROSTWOLF_TOWER_TAKEN;
        break;
    case BG_AV_NODES_FROSTWOLF_WTOWER:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_WEST_FROSTWOLF_TOWER_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_WEST_FROSTWOLF_TOWER_TAKEN;
        break;
    case BG_AV_NODES_FROSTWOLF_HUT:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_FROSTWOLF_RELIEF_HUT_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_FROSTWOLF_RELIEF_HUT_TAKEN;
        break;
    default:
        break;
    }

    return strId;
}

uint8 BattlegroundAV::GetMineString(uint8 mineId, TeamId teamId)
{
    uint8 strId = 0;
    switch (mineId)
    {
    case AV_NORTH_MINE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_IRONDEEP_MINE_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_IRONDEEP_MINE_TAKEN;
        break;
    case AV_SOUTH_MINE:
        if (teamId == TEAM_ALLIANCE)
            strId = AV_TEXT_A_HERALD_COLDTOOTH_MINE_TAKEN;
        else
            strId = AV_TEXT_H_HERALD_COLDTOOTH_MINE_TAKEN;
        break;
    default:
        break;
    }

    return strId;
}

void BattlegroundAV::AssaultNode(BG_AV_Nodes node, TeamId teamId)
{
    if (m_Nodes[node].TotalOwnerId == teamId)
    {
        LOG_FATAL("bg.battleground", "Assaulting team is TotalOwner of node");
        ABORT();
    }
    if (m_Nodes[node].OwnerId == teamId)
    {
        LOG_FATAL("bg.battleground", "Assaulting team is owner of node");
        ABORT();
    }
    if (m_Nodes[node].State == POINT_DESTROYED)
    {
        LOG_FATAL("bg.battleground", "Destroyed node is being assaulted");
        ABORT();
    }
    if (m_Nodes[node].State == POINT_ASSAULTED && m_Nodes[node].TotalOwnerId != TEAM_NEUTRAL) //only assault an assaulted node if no totalowner exists
    {
        LOG_FATAL("bg.battleground", "Assault on an not assaulted node with total owner");
        ABORT();
    }
    //the timer gets another time, if the previous owner was 0 == Neutral
    m_Nodes[node].Timer      = (m_Nodes[node].PrevOwnerId != TEAM_NEUTRAL) ? BG_AV_CAPTIME : BG_AV_SNOWFALL_FIRSTCAP;
    m_Nodes[node].PrevOwnerId = m_Nodes[node].OwnerId;
    m_Nodes[node].OwnerId    = teamId;
    m_Nodes[node].PrevState  = m_Nodes[node].State;
    m_Nodes[node].State      = POINT_ASSAULTED;
}

void BattlegroundAV::DestroyNode(BG_AV_Nodes node)
{
    ASSERT(m_Nodes[node].State == POINT_ASSAULTED);

    m_Nodes[node].TotalOwnerId = m_Nodes[node].OwnerId;
    m_Nodes[node].PrevOwnerId  = m_Nodes[node].OwnerId;
    m_Nodes[node].PrevState  = m_Nodes[node].State;
    m_Nodes[node].State      = (m_Nodes[node].Tower) ? POINT_DESTROYED : POINT_CONTROLED;
    m_Nodes[node].Timer      = 0;
}

void BattlegroundAV::InitNode(BG_AV_Nodes node, TeamId teamId, bool tower)
{
    m_Nodes[node].TotalOwnerId = teamId;
    m_Nodes[node].OwnerId      = teamId;
    m_Nodes[node].PrevOwnerId  = TEAM_NEUTRAL;
    m_Nodes[node].State      = POINT_CONTROLED;
    m_Nodes[node].PrevState  = m_Nodes[node].State;
    m_Nodes[node].Timer      = 0;
    m_Nodes[node].Tower      = tower;
}

void BattlegroundAV::DefendNode(BG_AV_Nodes node, TeamId teamId)
{
    ASSERT(m_Nodes[node].TotalOwnerId == teamId);
    ASSERT(m_Nodes[node].OwnerId != teamId);
    ASSERT(m_Nodes[node].State != POINT_CONTROLED && m_Nodes[node].State != POINT_DESTROYED);
    m_Nodes[node].PrevOwnerId = m_Nodes[node].OwnerId;
    m_Nodes[node].OwnerId    = teamId;
    m_Nodes[node].PrevState  = m_Nodes[node].State;
    m_Nodes[node].State      = POINT_CONTROLED;
    m_Nodes[node].Timer      = 0;
}

void BattlegroundAV::ResetBGSubclass()
{
    for (uint8 i = 0; i < 2; i++) //forloop for both teams (it just make 0 == alliance and 1 == horde also for both mines 0=north 1=south
    {
        for (uint8 j = 0; j < 9; j++)
            m_Team_QuestStatus[i][j] = 0;
        m_Team_Scores[i] = BG_AV_SCORE_INITIAL_POINTS;
        m_IsInformedNearVictory[i] = false;
        m_CaptainAlive[i] = true;
        m_CaptainBuffTimer[i] = 120000 + urand(0, 4) * 60; //as far as i could see, the buff is randomly so i make 2minutes (thats the duration of the buff itself) + 0-4minutes TODO get the right times
        m_Mine_Owner[i] = TEAM_NEUTRAL;
    }
    for (BG_AV_Nodes i = BG_AV_NODES_FIRSTAID_STATION; i <= BG_AV_NODES_STONEHEART_GRAVE; ++i) //alliance graves
        InitNode(i, TEAM_ALLIANCE, false);
    for (BG_AV_Nodes i = BG_AV_NODES_DUNBALDAR_SOUTH; i <= BG_AV_NODES_STONEHEART_BUNKER; ++i) //alliance towers
        InitNode(i, TEAM_ALLIANCE, true);
    for (BG_AV_Nodes i = BG_AV_NODES_ICEBLOOD_GRAVE; i <= BG_AV_NODES_FROSTWOLF_HUT; ++i) //horde graves
        InitNode(i, TEAM_HORDE, false);
    for (BG_AV_Nodes i = BG_AV_NODES_ICEBLOOD_TOWER; i <= BG_AV_NODES_FROSTWOLF_WTOWER; ++i) //horde towers
        InitNode(i, TEAM_HORDE, true);
    InitNode(BG_AV_NODES_SNOWFALL_GRAVE, TEAM_NEUTRAL, false); //give snowfall neutral owner

    m_Mine_Timer = AV_MINE_TICK_TIMER;
    for (uint16 i = 0; i < static_cast<uint16>(AV_CPLACE_MAX) + AV_STATICCPLACE_MAX; i++)
        if (BgCreatures[i])
            DelCreature(i);
}

bool BattlegroundAV::IsBothMinesControlledByTeam(TeamId teamId) const
{
    for (auto& mine : m_Mine_Owner)
        if (mine != teamId)
            return false;

    return true;
}

bool BattlegroundAV::IsAllTowersControlledAndCaptainAlive(TeamId teamId) const
{
    if (teamId == TEAM_ALLIANCE)
    {
        for (BG_AV_Nodes i = BG_AV_NODES_DUNBALDAR_SOUTH; i <= BG_AV_NODES_STONEHEART_BUNKER; ++i) // alliance towers controlled
        {
            if (m_Nodes[i].State == POINT_CONTROLED)
            {
                if (m_Nodes[i].OwnerId != TEAM_ALLIANCE)
                    return false;
            }
            else
                return false;
        }

        for (BG_AV_Nodes i = BG_AV_NODES_ICEBLOOD_TOWER; i <= BG_AV_NODES_FROSTWOLF_WTOWER; ++i) // horde towers destroyed
            if (m_Nodes[i].State != POINT_DESTROYED)
                return false;

        return m_CaptainAlive[0];
    }
    else if (teamId == TEAM_HORDE)
    {
        for (BG_AV_Nodes i = BG_AV_NODES_ICEBLOOD_TOWER; i <= BG_AV_NODES_FROSTWOLF_WTOWER; ++i) // horde towers controlled
        {
            if (m_Nodes[i].State == POINT_CONTROLED)
            {
                if (m_Nodes[i].OwnerId != TEAM_HORDE)
                    return false;
            }
            else
                return false;
        }

        for (BG_AV_Nodes i = BG_AV_NODES_DUNBALDAR_SOUTH; i <= BG_AV_NODES_STONEHEART_BUNKER; ++i) // alliance towers destroyed
            if (m_Nodes[i].State != POINT_DESTROYED)
                return false;

        return m_CaptainAlive[1];
    }

    return false;
}

TeamId BattlegroundAV::GetPrematureWinner()
{
    if (GetTeamScore(TEAM_ALLIANCE) > GetTeamScore(TEAM_HORDE))
        return TEAM_ALLIANCE;

    return GetTeamScore(TEAM_HORDE) > GetTeamScore(TEAM_ALLIANCE) ? TEAM_HORDE : Battleground::GetPrematureWinner();
}
