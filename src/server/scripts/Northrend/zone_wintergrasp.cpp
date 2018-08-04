/* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2 This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "BattlefieldMgr.h"
#include "BattlefieldWG.h"
#include "Battlefield.h"
#include "ScriptSystem.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "Vehicle.h"
#include "GameObjectAI.h"
#include "SpellScript.h"
#include "ScriptedGossip.h"
#include "CombatAI.h"
#include "Player.h"
#include "PoolMgr.h"
#include "World.h"

#define GOSSIP_HELLO_DEMO1  "Build catapult."
#define GOSSIP_HELLO_DEMO2  "Build demolisher."
#define GOSSIP_HELLO_DEMO3  "Build siege engine."
#define GOSSIP_HELLO_DEMO4  "I cannot build more!"

enum eWGqueuenpctext
{
    WG_NPCQUEUE_TEXT_H_NOWAR            = 14775,
    WG_NPCQUEUE_TEXT_H_QUEUE            = 14790,
    WG_NPCQUEUE_TEXT_H_WAR              = 14777,
    WG_NPCQUEUE_TEXT_A_NOWAR            = 14782,
    WG_NPCQUEUE_TEXT_A_QUEUE            = 14791,
    WG_NPCQUEUE_TEXT_A_WAR              = 14781,
    WG_NPCQUEUE_TEXTOPTION_JOIN         = -1850507,
};

enum Spells
{
    // Demolisher engineers spells
    SPELL_BUILD_SIEGE_VEHICLE_FORCE_HORDE     = 61409, //
    SPELL_BUILD_SIEGE_VEHICLE_FORCE_ALLIANCE  = 56662, // Which faction uses which ?
    SPELL_BUILD_CATAPULT_FORCE                = 56664,
    SPELL_BUILD_DEMOLISHER_FORCE              = 56659,
    SPELL_ACTIVATE_CONTROL_ARMS               = 49899,

    SPELL_VEHICLE_TELEPORT                    = 49759,

    // Spirit guide
    SPELL_CHANNEL_SPIRIT_HEAL                 = 22011,

    // RP-GG
    SPELL_RP_GG_TRIGGER_MISSILE               = 49769,

    // Teleport to fortress
    SPELL_TELEPORT_TO_FORTRESS                = 59096,
};

enum CreatureIds
{
    NPC_GOBLIN_MECHANIC                 = 30400,
    NPC_GNOMISH_ENGINEER                = 30499,

    NPC_WINTERGRASP_CONTROL_ARMS        = 27852,

    NPC_WORLD_TRIGGER_LARGE_AOI_NOT_IMMUNE_PC_NPC = 23742,
};

enum QuestIds
{
    QUEST_BONES_AND_ARROWS_HORDE_ATT              = 13199,
    QUEST_JINXING_THE_WALLS_HORDE_ATT             = 13202,
    QUEST_SLAY_THEM_ALL_HORDE_ATT                 = 13180,
    QUEST_FUELING_THE_DEMOLISHERS_HORDE_ATT       = 13200,
    QUEST_HEALING_WITH_ROSES_HORDE_ATT            = 13201,
    QUEST_DEFEND_THE_SIEGE_HORDE_ATT              = 13223,

    QUEST_BONES_AND_ARROWS_HORDE_DEF              = 13193,
    QUEST_WARDING_THE_WALLS_HORDE_DEF             = 13192,
    QUEST_SLAY_THEM_ALL_HORDE_DEF                 = 13178,
    QUEST_FUELING_THE_DEMOLISHERS_HORDE_DEF       = 13191,
    QUEST_HEALING_WITH_ROSES_HORDE_DEF            = 13194,
    QUEST_TOPPLING_THE_TOWERS_HORDE_DEF           = 13539,
    QUEST_STOP_THE_SIEGE_HORDE_DEF                = 13185,

    QUEST_BONES_AND_ARROWS_ALLIANCE_ATT           = 13196,
    QUEST_WARDING_THE_WARRIORS_ALLIANCE_ATT       = 13198,
    QUEST_NO_MERCY_FOR_THE_MERCILESS_ALLIANCE_ATT = 13179,
    QUEST_DEFEND_THE_SIEGE_ALLIANCE_ATT           = 13222,
    QUEST_A_RARE_HERB_ALLIANCE_ATT                = 13195,
    QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_ATT    = 13197,

    QUEST_BONES_AND_ARROWS_ALLIANCE_DEF           = 13154,
    QUEST_WARDING_THE_WARRIORS_ALLIANCE_DEF       = 13153,
    QUEST_NO_MERCY_FOR_THE_MERCILESS_ALLIANCE_DEF = 13177,
    QUEST_SHOUTHERN_SABOTAGE_ALLIANCE_DEF         = 13538,
    QUEST_STOP_THE_SIEGE_ALLIANCE_DEF             = 13186,
    QUEST_A_RARE_HERB_ALLIANCE_DEF                = 13156,
    QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_DEF    = 236,
};

uint8 const MAX_WINTERGRASP_VEHICLES = 4;

uint32 const vehiclesList[MAX_WINTERGRASP_VEHICLES] =
{
    NPC_WINTERGRASP_CATAPULT,
    NPC_WINTERGRASP_DEMOLISHER,
    NPC_WINTERGRASP_SIEGE_ENGINE_ALLIANCE,
    NPC_WINTERGRASP_SIEGE_ENGINE_HORDE
};

////////////////////////////////////////////////
/////// NPCs
////////////////////////////////////////////////

class npc_wg_demolisher_engineer : public CreatureScript
{
    public:
        npc_wg_demolisher_engineer() : CreatureScript("npc_wg_demolisher_engineer") { }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (canBuild(creature))
            {
                if (player->HasAura(SPELL_CORPORAL))
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_DEMO1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                else if (player->HasAura(SPELL_LIEUTENANT))
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_DEMO1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_DEMO2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_DEMO3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                }
            }
            else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_HELLO_DEMO4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender */ , uint32 action)
        {
            player->CLOSE_GOSSIP_MENU();

            if (canBuild(creature))
            {
                switch (action - GOSSIP_ACTION_INFO_DEF)
                {
                    case 0:
                        creature->CastSpell(player, SPELL_BUILD_CATAPULT_FORCE, true);
                        break;
                    case 1:
                        creature->CastSpell(player, SPELL_BUILD_DEMOLISHER_FORCE, true);
                        break;
                    case 2:
                        creature->CastSpell(player, player->GetTeamId() == TEAM_ALLIANCE ? SPELL_BUILD_SIEGE_VEHICLE_FORCE_ALLIANCE : SPELL_BUILD_SIEGE_VEHICLE_FORCE_HORDE, true);
                        break;
                }
                creature->CastSpell(creature, SPELL_ACTIVATE_CONTROL_ARMS, true);
            }
            return true;
        }

    private:
        bool canBuild(Creature* creature)
        {
            Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
            if (!wintergrasp)
                return false;

            switch (creature->GetEntry())
            {
                case NPC_GOBLIN_MECHANIC:
                    return (wintergrasp->GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H) > wintergrasp->GetData(BATTLEFIELD_WG_DATA_VEHICLE_H));
                case NPC_GNOMISH_ENGINEER:
                    return (wintergrasp->GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A) > wintergrasp->GetData(BATTLEFIELD_WG_DATA_VEHICLE_A));
                default:
                    return false;
            }
        }
};

class npc_wg_spirit_guide : public CreatureScript
{
    public:
        npc_wg_spirit_guide() : CreatureScript("npc_wg_spirit_guide") { }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
            if (!wintergrasp)
                return true;

            GraveyardVect graveyard = wintergrasp->GetGraveyardVector();
            for (uint8 i = 0; i < graveyard.size(); i++)
                if (graveyard[i]->GetControlTeamId() == player->GetTeamId())
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(((BfGraveyardWG*)graveyard[i])->GetTextId()), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + i);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* /*creature */ , uint32 /*sender */ , uint32 action)
        {
            player->CLOSE_GOSSIP_MENU();

            Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
            if (wintergrasp)
            {
                GraveyardVect gy = wintergrasp->GetGraveyardVector();
                for (uint8 i = 0; i < gy.size(); i++)
                    if (action - GOSSIP_ACTION_INFO_DEF == i && gy[i]->GetControlTeamId() == player->GetTeamId())
                        if (WorldSafeLocsEntry const* safeLoc = sWorldSafeLocsStore.LookupEntry(gy[i]->GetGraveyardId()))
                            player->TeleportTo(safeLoc->map_id, safeLoc->x, safeLoc->y, safeLoc->z, 0);
            }
            return true;
        }

        struct npc_wg_spirit_guideAI : public ScriptedAI
        {
            npc_wg_spirit_guideAI(Creature* creature) : ScriptedAI(creature)
            {
                me->setActive(true);
            }

            void UpdateAI(uint32 /* diff */)
            {
                if (!me->HasUnitState(UNIT_STATE_CASTING))
                    DoCast(me, SPELL_CHANNEL_SPIRIT_HEAL);
            }
        };

        CreatureAI *GetAI(Creature* creature) const
        {
            return new npc_wg_spirit_guideAI(creature);
        }
};

enum eWgQueue
{
    EVENT_ARCANIST_BRAEDIN_YELL     = 1,
    EVENT_MAGISTER_SURDIEL_YELL     = 2,
    EVENT_SPELL_FROST_ARMOR         = 3,

    SAY_ARCANIST_BRAEDIN            = 0,
    SAY_MAGISTER_SURDIEL            = 0,

    NPC_ARCANIST_BRAEDIN            = 32169,
    NPC_MAGISTER_SURDIEL            = 32170,

    SPELL_FROST_ARMOR               = 31256
};

class npc_wg_queue : public CreatureScript
{
    public:
        npc_wg_queue() : CreatureScript("npc_wg_queue") { }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (!sWorld->getBoolConfig(CONFIG_MINIGOB_MANABONK))
                return false;

            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
            if (!wintergrasp)
                return true;

            if (wintergrasp->IsWarTime())
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT_19, "Queue for Wintergrasp.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                player->SEND_GOSSIP_MENU(wintergrasp->GetDefenderTeam()? WG_NPCQUEUE_TEXT_H_WAR : WG_NPCQUEUE_TEXT_A_WAR, creature->GetGUID());
            }
            else
            {
                uint32 timer = wintergrasp->GetTimer() / 1000;
                player->SendUpdateWorldState(4354, time(NULL) + timer);
                if (timer < 15 * MINUTE)
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Queue for Wintergrasp.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                    player->SEND_GOSSIP_MENU(wintergrasp->GetDefenderTeam() ? WG_NPCQUEUE_TEXT_H_QUEUE : WG_NPCQUEUE_TEXT_A_QUEUE, creature->GetGUID());
                }
                else
                    player->SEND_GOSSIP_MENU(wintergrasp->GetDefenderTeam() ? WG_NPCQUEUE_TEXT_H_NOWAR : WG_NPCQUEUE_TEXT_A_NOWAR, creature->GetGUID());
            }
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* /*creature */ , uint32 /*sender */ , uint32 /*action*/)
        {
            player->CLOSE_GOSSIP_MENU();

            Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
            if (!wintergrasp)
                return true;

            if (wintergrasp->IsWarTime())
                wintergrasp->InvitePlayerToWar(player);
            else
            {
                uint32 timer = wintergrasp->GetTimer() / 1000;
                if (timer < 15 * MINUTE)
                    wintergrasp->InvitePlayerToQueue(player);
            }
            return true;
        }

        struct npc_wg_queueAI : public ScriptedAI
        {
            npc_wg_queueAI(Creature* creature) : ScriptedAI(creature)
            {
                if (creature->GetEntry() == NPC_ARCANIST_BRAEDIN)
                    events.ScheduleEvent(EVENT_ARCANIST_BRAEDIN_YELL, 0);
                else if (creature->GetEntry() == NPC_MAGISTER_SURDIEL)
                    events.ScheduleEvent(EVENT_MAGISTER_SURDIEL_YELL, 0);

                events.ScheduleEvent(EVENT_SPELL_FROST_ARMOR, 0);
            }

            EventMap events;

            void UpdateAI(uint32 diff)
            {
                if (CONFIG_WINTERGRASP_ENABLE == false)
                    return;

                ScriptedAI::UpdateAI(diff);

                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_ARCANIST_BRAEDIN_YELL:
                        if (Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG))
                        {
                            if (wintergrasp->IsWarTime())
                            {
                                Talk(SAY_ARCANIST_BRAEDIN);
                                events.ScheduleEvent(EVENT_ARCANIST_BRAEDIN_YELL, 240000);
                                break;
                            }
                        }
                        events.ScheduleEvent(EVENT_ARCANIST_BRAEDIN_YELL, 5000);
                        break;
                    case EVENT_MAGISTER_SURDIEL_YELL:
                        if (Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG))
                        {
                            uint32 timer = wintergrasp->GetTimer() / 1000;
                            if (!wintergrasp->IsWarTime() && timer < 5*MINUTE && timer > 4*MINUTE)
                            {
                                Talk(SAY_MAGISTER_SURDIEL);
                                events.ScheduleEvent(EVENT_MAGISTER_SURDIEL_YELL, 300000);
                                break;
                            }
                        }
                        events.ScheduleEvent(EVENT_MAGISTER_SURDIEL_YELL, 5000);
                        break;
                    case EVENT_SPELL_FROST_ARMOR:
                        me->CastSpell(me, SPELL_FROST_ARMOR, true);
                        events.ScheduleEvent(EVENT_SPELL_FROST_ARMOR, 900000);
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_wg_queueAI(creature);
        }
};

class npc_wg_quest_giver : public CreatureScript
{
    public:
        npc_wg_quest_giver() : CreatureScript("npc_wg_quest_giver") { }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
            if (!wintergrasp)
                return true;

            if (creature->IsQuestGiver())
            {
                QuestRelationBounds objectQR = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
                QuestRelationBounds objectQIR = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(creature->GetEntry());

                QuestMenu& qm = player->PlayerTalkClass->GetQuestMenu();
                qm.ClearMenu();

                for (QuestRelations::const_iterator i = objectQIR.first; i != objectQIR.second; ++i)
                {
                    uint32 quest_id = i->second;
                    QuestStatus status = player->GetQuestStatus(quest_id);
                    if (status == QUEST_STATUS_COMPLETE)
                        qm.AddMenuItem(quest_id, 4);
                    else if (status == QUEST_STATUS_INCOMPLETE)
                        qm.AddMenuItem(quest_id, 4);
                    //else if (status == QUEST_STATUS_AVAILABLE)
                    //    qm.AddMenuItem(quest_id, 2);
                }

                // xinef: add att/def doubles if this quest is spawned
                std::vector<uint32> questRelationVector;
                for (QuestRelations::const_iterator i = objectQR.first; i != objectQR.second; ++i)
                {
                    uint32 questId = i->second;
                    Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
                    if (!quest)
                        continue;

                    switch (questId)
                    {
                        case QUEST_BONES_AND_ARROWS_ALLIANCE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_BONES_AND_ARROWS_ALLIANCE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_BONES_AND_ARROWS_ALLIANCE_ATT);
                            break;
                        case QUEST_WARDING_THE_WARRIORS_ALLIANCE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_WARDING_THE_WARRIORS_ALLIANCE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_WARDING_THE_WARRIORS_ALLIANCE_ATT);
                            break;
                        case QUEST_A_RARE_HERB_ALLIANCE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_A_RARE_HERB_ALLIANCE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_A_RARE_HERB_ALLIANCE_ATT);
                            break;
                        case QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_ATT);
                            break;
                        case QUEST_BONES_AND_ARROWS_HORDE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_BONES_AND_ARROWS_HORDE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_BONES_AND_ARROWS_HORDE_ATT);
                            break;
                        case QUEST_JINXING_THE_WALLS_HORDE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_WARDING_THE_WALLS_HORDE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_JINXING_THE_WALLS_HORDE_ATT);
                            break;
                        case QUEST_FUELING_THE_DEMOLISHERS_HORDE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_FUELING_THE_DEMOLISHERS_HORDE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_FUELING_THE_DEMOLISHERS_HORDE_ATT);
                            break;
                        case QUEST_HEALING_WITH_ROSES_HORDE_ATT:
                            if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_HEALING_WITH_ROSES_HORDE_DEF))
                                continue;
                            questRelationVector.push_back(QUEST_HEALING_WITH_ROSES_HORDE_ATT);
                            break;
                        default:
                            questRelationVector.push_back(questId);
                            break;
                    }
                }

                for (std::vector<uint32>::const_iterator i = questRelationVector.begin(); i != questRelationVector.end(); ++i)
                {
                    uint32 questId = *i;
                    Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
                    switch (questId)
                    {
                        // Horde attacker
                        case QUEST_BONES_AND_ARROWS_HORDE_ATT:
                        case QUEST_JINXING_THE_WALLS_HORDE_ATT:
                        case QUEST_SLAY_THEM_ALL_HORDE_ATT:
                        case QUEST_FUELING_THE_DEMOLISHERS_HORDE_ATT:
                        case QUEST_HEALING_WITH_ROSES_HORDE_ATT:
                        case QUEST_DEFEND_THE_SIEGE_HORDE_ATT:
                            if (wintergrasp->GetAttackerTeam() == TEAM_HORDE)
                            {
                                QuestStatus status = player->GetQuestStatus(questId);

                                if (quest->IsAutoComplete() && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 4);
                                else if (status == QUEST_STATUS_NONE && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 2);
                            }
                            break;
                        // Horde defender
                        case QUEST_BONES_AND_ARROWS_HORDE_DEF:
                        case QUEST_WARDING_THE_WALLS_HORDE_DEF:
                        case QUEST_SLAY_THEM_ALL_HORDE_DEF:
                        case QUEST_FUELING_THE_DEMOLISHERS_HORDE_DEF:
                        case QUEST_HEALING_WITH_ROSES_HORDE_DEF:
                        case QUEST_TOPPLING_THE_TOWERS_HORDE_DEF:
                        case QUEST_STOP_THE_SIEGE_HORDE_DEF:
                            if (wintergrasp->GetDefenderTeam() == TEAM_HORDE)
                            {
                                QuestStatus status = player->GetQuestStatus(questId);

                                if (quest->IsAutoComplete() && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 4);
                                else if (status == QUEST_STATUS_NONE && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 2);
                            }
                            break;
                        // Alliance attacker
                        case QUEST_BONES_AND_ARROWS_ALLIANCE_ATT:
                        case QUEST_WARDING_THE_WARRIORS_ALLIANCE_ATT:
                        case QUEST_NO_MERCY_FOR_THE_MERCILESS_ALLIANCE_ATT:
                        case QUEST_DEFEND_THE_SIEGE_ALLIANCE_ATT:
                        case QUEST_A_RARE_HERB_ALLIANCE_ATT:
                        case QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_ATT:
                            if (wintergrasp->GetAttackerTeam() == TEAM_ALLIANCE)
                            {
                                QuestStatus status = player->GetQuestStatus(questId);

                                if (quest->IsAutoComplete() && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 4);
                                else if (status == QUEST_STATUS_NONE && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 2);
                            }
                            break;
                        // Alliance defender
                        case QUEST_BONES_AND_ARROWS_ALLIANCE_DEF:
                        case QUEST_WARDING_THE_WARRIORS_ALLIANCE_DEF:
                        case QUEST_NO_MERCY_FOR_THE_MERCILESS_ALLIANCE_DEF:
                        case QUEST_SHOUTHERN_SABOTAGE_ALLIANCE_DEF:
                        case QUEST_STOP_THE_SIEGE_ALLIANCE_DEF:
                        case QUEST_A_RARE_HERB_ALLIANCE_DEF:
                        case QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_DEF:
                            if (wintergrasp->GetDefenderTeam() == TEAM_ALLIANCE)
                            {
                                QuestStatus status = player->GetQuestStatus(questId);

                                if (quest->IsAutoComplete() && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 4);
                                else if (status == QUEST_STATUS_NONE && player->CanTakeQuest(quest, false))
                                    qm.AddMenuItem(questId, 2);
                            }
                            break;
                        default:
                            QuestStatus status = player->GetQuestStatus(questId);

                            if (quest->IsAutoComplete() && player->CanTakeQuest(quest, false))
                                qm.AddMenuItem(questId, 4);
                            else if (status == QUEST_STATUS_NONE && player->CanTakeQuest(quest, false))
                                qm.AddMenuItem(questId, 2);
                            break;
                    }
                }
            }
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        uint32 GetDialogStatus(Player* player, Creature* creature)
        { 
            QuestRelationBounds qr = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
            QuestRelationBounds qir = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(creature->GetEntry());
            QuestGiverStatus result = DIALOG_STATUS_NONE;

            for (QuestRelations::const_iterator i = qir.first; i != qir.second; ++i)
            {
                QuestGiverStatus result2 = DIALOG_STATUS_NONE;
                uint32 questId = i->second;
                Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
                if (!quest)
                    continue;

                ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_SHOW_MARK, quest->GetQuestId());
                if (!sConditionMgr->IsObjectMeetToConditions(player, conditions))
                    continue;

                QuestStatus status = player->GetQuestStatus(questId);
                if ((status == QUEST_STATUS_COMPLETE && !player->GetQuestRewardStatus(questId)) ||
                    (quest->IsAutoComplete() && player->CanTakeQuest(quest, false)))
                {
                    if (quest->IsAutoComplete() && quest->IsRepeatable() && !quest->IsDailyOrWeekly())
                        result2 = DIALOG_STATUS_REWARD_REP;
                    else
                        result2 = DIALOG_STATUS_REWARD;
                }
                else if (status == QUEST_STATUS_INCOMPLETE)
                    result2 = DIALOG_STATUS_INCOMPLETE;

                if (result2 > result)
                    result = result2;
            }

            for (QuestRelations::const_iterator i = qr.first; i != qr.second; ++i)
            {
                QuestGiverStatus result2 = DIALOG_STATUS_NONE;
                uint32 questId = i->second;
                Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
                if (!quest)
                    continue;

                ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_QUEST_SHOW_MARK, quest->GetQuestId());
                if (!sConditionMgr->IsObjectMeetToConditions(player, conditions))
                    continue;

                switch (questId)
                {
                    case QUEST_BONES_AND_ARROWS_ALLIANCE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_BONES_AND_ARROWS_ALLIANCE_DEF))
                            continue;
                        break;
                    case QUEST_WARDING_THE_WARRIORS_ALLIANCE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_WARDING_THE_WARRIORS_ALLIANCE_DEF))
                            continue;
                        break;
                    case QUEST_A_RARE_HERB_ALLIANCE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_A_RARE_HERB_ALLIANCE_DEF))
                            continue;
                        break;
                    case QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_FUELING_THE_DEMOLISHERS_ALLIANCE_DEF))
                            continue;
                        break;
                    case QUEST_BONES_AND_ARROWS_HORDE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_BONES_AND_ARROWS_HORDE_DEF))
                            continue;
                        break;
                    case QUEST_JINXING_THE_WALLS_HORDE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_WARDING_THE_WALLS_HORDE_DEF))
                            continue;
                        break;
                    case QUEST_FUELING_THE_DEMOLISHERS_HORDE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_FUELING_THE_DEMOLISHERS_HORDE_DEF))
                            continue;
                        break;
                    case QUEST_HEALING_WITH_ROSES_HORDE_ATT:
                        if (!sPoolMgr->IsSpawnedObject<Quest>(QUEST_HEALING_WITH_ROSES_HORDE_DEF))
                            continue;
                        break;
                }

                QuestStatus status = player->GetQuestStatus(questId);
                if (status == QUEST_STATUS_NONE)
                {
                    if (player->CanSeeStartQuest(quest))
                    {
                        if (player->SatisfyQuestLevel(quest, false))
                        {
                            if (quest->IsAutoComplete())
                                result2 = DIALOG_STATUS_REWARD_REP;
                            else if (player->getLevel() <= (player->GetQuestLevel(quest) + sWorld->getIntConfig(CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF)))
                            {
                                if (quest->IsDaily())
                                    result2 = DIALOG_STATUS_AVAILABLE_REP;
                                else
                                    result2 = DIALOG_STATUS_AVAILABLE;
                            }
                            else
                                result2 = DIALOG_STATUS_LOW_LEVEL_AVAILABLE;
                        }
                        else
                            result2 = DIALOG_STATUS_UNAVAILABLE;
                    }
                }

                if (result2 > result)
                    result = result2;
            }

            return result;
        }
};

class npc_wg_siege_machine : public CreatureScript
{
    public:
        npc_wg_siege_machine() : CreatureScript("npc_wg_siege_machine") { }

        struct npc_wg_siege_machineAI : public VehicleAI
        {
            npc_wg_siege_machineAI(Creature* creature) : VehicleAI(creature)
            {
                checkTimer = 0;
            }

            uint32 checkTimer;

            bool CanControlVehicle(Unit* passenger)
            {
                if (passenger->HasAura(SPELL_LIEUTENANT))
                    return true;

                if (me->GetEntry() == NPC_WINTERGRASP_CATAPULT && passenger->HasAura(SPELL_CORPORAL))
                    return true;

                return false;
            }

            void UpdateAI(uint32 diff)
            {
                VehicleAI::UpdateAI(diff);

                checkTimer += diff;
                if (checkTimer >= 1000)
                {
                    checkTimer = 0;
                    if (me->GetVehicleKit())
                        for (SeatMap::iterator itr = me->GetVehicleKit()->Seats.begin(); itr != me->GetVehicleKit()->Seats.end(); ++itr)
                            if (const VehicleSeatEntry* seatInfo = itr->second.SeatInfo)
                                if (seatInfo->m_flags & VEHICLE_SEAT_FLAG_CAN_CONTROL)
                                    if (Unit* passenger = ObjectAccessor::GetUnit(*me, itr->second.Passenger.Guid))
                                        if (!CanControlVehicle(passenger))
                                        {
                                            passenger->ExitVehicle();
                                            return;
                                        }
                }
            }
        };

        CreatureAI *GetAI(Creature* creature) const
        {
            return new npc_wg_siege_machineAI(creature);
        }
};

////////////////////////////////////////////////
/////// GOs
////////////////////////////////////////////////

class go_wg_vehicle_teleporter : public GameObjectScript
{
    public:
        go_wg_vehicle_teleporter() : GameObjectScript("go_wg_vehicle_teleporter") { }

        struct go_wg_vehicle_teleporterAI : public GameObjectAI
        {
            go_wg_vehicle_teleporterAI(GameObject* gameObject) : GameObjectAI(gameObject),
                _checkTimer(0)
            {
            }

            bool IsFriendly(Unit* passenger)
            {
                return ((go->GetUInt32Value(GAMEOBJECT_FACTION) == WintergraspFaction[TEAM_HORDE] && passenger->getRaceMask() & RACEMASK_HORDE) ||
                        (go->GetUInt32Value(GAMEOBJECT_FACTION) == WintergraspFaction[TEAM_ALLIANCE] && passenger->getRaceMask() & RACEMASK_ALLIANCE));
            }


            Creature* IsValidVehicle(Creature* cVeh)
            {
                if (!cVeh->HasAura(SPELL_VEHICLE_TELEPORT))
                    if (Vehicle* vehicle = cVeh->GetVehicleKit())
                        if (Unit* passenger = vehicle->GetPassenger(0))
                            if (IsFriendly(passenger))
                                if (Creature* teleportTrigger = passenger->SummonTrigger(go->GetPositionX()-60.0f, go->GetPositionY(), go->GetPositionZ()+1.0f, cVeh->GetOrientation(), 1000))
                                    return teleportTrigger;
                    
                return NULL;
            }

            void UpdateAI(uint32 diff)
            {
                _checkTimer += diff;
                if (_checkTimer >= 1000)
                {
                    for (uint8 i = 0; i < MAX_WINTERGRASP_VEHICLES; i++)
                        if (Creature* vehicleCreature = go->FindNearestCreature(vehiclesList[i], 3.0f, true))
                            if (Creature* teleportTrigger = IsValidVehicle(vehicleCreature))
                                teleportTrigger->CastSpell(vehicleCreature, SPELL_VEHICLE_TELEPORT, true);

                    _checkTimer = 0;
                }
            }
          private:
              uint32 _checkTimer;
        };

        GameObjectAI* GetAI(GameObject* go) const
        {
            return new go_wg_vehicle_teleporterAI(go);
        }
};

////////////////////////////////////////////////
/////// SPELLs
////////////////////////////////////////////////

class spell_wintergrasp_force_building : public SpellScriptLoader
{
    public:
        spell_wintergrasp_force_building() : SpellScriptLoader("spell_wintergrasp_force_building") { }

        class spell_wintergrasp_force_building_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_wintergrasp_force_building_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_BUILD_CATAPULT_FORCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_BUILD_DEMOLISHER_FORCE)
                    || !sSpellMgr->GetSpellInfo(SPELL_BUILD_SIEGE_VEHICLE_FORCE_HORDE)
                    || !sSpellMgr->GetSpellInfo(SPELL_BUILD_SIEGE_VEHICLE_FORCE_ALLIANCE))
                    return false;
                return true;
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, GetEffectValue(), false, NULL, NULL, target->GetGUID());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_wintergrasp_force_building_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_wintergrasp_force_building_SpellScript();
        }
};

class spell_wintergrasp_create_vehicle : public SpellScriptLoader
{
    public:
        spell_wintergrasp_create_vehicle() : SpellScriptLoader("spell_wintergrasp_create_vehicle") { }

        class spell_wintergrasp_create_vehicle_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_wintergrasp_create_vehicle_SpellScript);

            void HandleSummon(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);

                uint32 entry = GetSpellInfo()->Effects[effIndex].MiscValue;
                SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(GetSpellInfo()->Effects[effIndex].MiscValueB);
                int32 duration = GetSpellInfo()->GetDuration();
                if (!GetOriginalCaster() || !properties)
                    return;

                if (TempSummon* summon = GetCaster()->GetMap()->SummonCreature(entry, *GetHitDest(), properties, duration, GetOriginalCaster(), GetSpellInfo()->Id))
                {
                    summon->SetCreatorGUID(GetOriginalCaster()->GetGUID());
                    summon->HandleSpellClick(GetCaster());
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_wintergrasp_create_vehicle_SpellScript::HandleSummon, EFFECT_1, SPELL_EFFECT_SUMMON);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_wintergrasp_create_vehicle_SpellScript;
        }
};

class spell_wintergrasp_rp_gg : public SpellScriptLoader
{
    public:
        spell_wintergrasp_rp_gg() : SpellScriptLoader("spell_wintergrasp_rp_gg") { }

        class spell_wintergrasp_rp_gg_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_wintergrasp_rp_gg_SpellScript);

            bool handled;
            bool Load()
            {
                handled = false;
                return true;
            }

            void HandleFinish()
            {
                if (!GetExplTargetDest())
                    return;

                GetCaster()->CastSpell(GetExplTargetDest()->GetPositionX(), GetExplTargetDest()->GetPositionY(), GetExplTargetDest()->GetPositionZ(), SPELL_RP_GG_TRIGGER_MISSILE, true);
            }

            void Register()
            {
                AfterCast += SpellCastFn(spell_wintergrasp_rp_gg_SpellScript::HandleFinish);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_wintergrasp_rp_gg_SpellScript();
        }
};

class spell_wintergrasp_portal : public SpellScriptLoader
{
    public:
        spell_wintergrasp_portal() : SpellScriptLoader("spell_wintergrasp_portal") { }

        class spell_wintergrasp_portal_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_wintergrasp_portal_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Player* target = GetHitPlayer();
                Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
                if (!wintergrasp || !target || target->getLevel() < 75 || (wintergrasp->GetDefenderTeam() != target->GetTeamId()))
                    return;

                target->CastSpell(target, SPELL_TELEPORT_TO_FORTRESS, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_wintergrasp_portal_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_wintergrasp_portal_SpellScript();
        }
};

class spell_wintergrasp_water : public SpellScriptLoader
{
    public:
        spell_wintergrasp_water() : SpellScriptLoader("spell_wintergrasp_water") { }

        class spell_wintergrasp_water_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_wintergrasp_water_SpellScript);

            SpellCastResult CheckCast()
            {
                Unit* target = GetCaster();
                if (!target || !target->IsVehicle())
                    return SPELL_FAILED_DONT_REPORT;

                return SPELL_CAST_OK;
            }

            void Register()
            {
                OnCheckCast += SpellCheckCastFn(spell_wintergrasp_water_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_wintergrasp_water_SpellScript();
        }
};

class spell_wintergrasp_hide_small_elementals : public SpellScriptLoader
{
    public:
        spell_wintergrasp_hide_small_elementals() : SpellScriptLoader("spell_wintergrasp_hide_small_elementals") { }

        class spell_wintergrasp_hide_small_elementals_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_wintergrasp_hide_small_elementals_AuraScript);

            void HandlePeriodicDummy(AuraEffect const*  /*aurEff*/)
            {
                Unit* target = GetTarget();
                Battlefield* Bf = sBattlefieldMgr->GetBattlefieldToZoneId(target->GetZoneId());
                bool enable = !Bf || !Bf->IsWarTime();
                target->SetPhaseMask(enable ? 1 : 512, true);
                PreventDefaultAction();
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_wintergrasp_hide_small_elementals_AuraScript::HandlePeriodicDummy, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_wintergrasp_hide_small_elementals_AuraScript();
        }
};

class spell_wg_reduce_damage_by_distance : public SpellScriptLoader
{
    public:
        spell_wg_reduce_damage_by_distance() : SpellScriptLoader("spell_wg_reduce_damage_by_distance") { }

        class spell_wg_reduce_damage_by_distance_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_wg_reduce_damage_by_distance_SpellScript);

            void RecalculateDamage()
            {
                if (!GetExplTargetDest() || !GetHitUnit())
                    return;

                float maxDistance = GetSpellInfo()->Effects[EFFECT_0].CalcRadius(GetCaster()); // Xinef: always stored in EFFECT_0
                float distance = std::min<float>(GetHitUnit()->GetDistance(*GetExplTargetDest()), maxDistance);

                int32 damage = std::max<int32>(0, int32(GetHitDamage() - floor(GetHitDamage() * (distance / maxDistance))));
                SetHitDamage(damage);
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_wg_reduce_damage_by_distance_SpellScript::RecalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_wg_reduce_damage_by_distance_SpellScript();
        }
};


////////////////////////////////////////////////
/////// ACHIEVEMENTs
////////////////////////////////////////////////

class achievement_wg_didnt_stand_a_chance : public AchievementCriteriaScript
{
public:
    achievement_wg_didnt_stand_a_chance() : AchievementCriteriaScript("achievement_wg_didnt_stand_a_chance") { }

    bool OnCheck(Player* source, Unit* target)
    {
        if (!target)
            return false;

        if (Player* victim = target->ToPlayer())
        {
            if (!victim->IsMounted())
                return false;

            if (Vehicle* vehicle = source->GetVehicle())
                if (vehicle->GetVehicleInfo()->m_ID == 244) // Wintergrasp Tower Cannon
                    return true;
        }

        return false;
    }
};

class achievement_wg_vehicular_gnomeslaughter : public AchievementCriteriaScript
{
public:
    achievement_wg_vehicular_gnomeslaughter() : AchievementCriteriaScript("achievement_wg_vehicular_gnomeslaughter") { }

    bool OnCheck(Player* source, Unit* target)
    {
        if (!target)
            return false;

        if (Unit* vehicle = source->GetVehicleBase())
            if (vehicle->GetEntry() == NPC_WINTERGRASP_SIEGE_ENGINE_ALLIANCE || vehicle->GetEntry() == NPC_WINTERGRASP_SIEGE_ENGINE_HORDE ||
                vehicle->GetEntry() == NPC_WINTERGRASP_CATAPULT || vehicle->GetEntry() == NPC_WINTERGRASP_DEMOLISHER ||
                vehicle->GetEntry() == NPC_WINTERGRASP_TOWER_CANNON)
                return true;

        return false;
    }
};

class achievement_wg_within_our_grasp : public AchievementCriteriaScript
{
public:
    achievement_wg_within_our_grasp() : AchievementCriteriaScript("achievement_wg_within_our_grasp") { }

    bool OnCheck(Player*  /*source*/, Unit*  /*target*/)
    {
        Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
        if (!wintergrasp)
            return false;

        return wintergrasp->GetTimer() >= (20 * MINUTE * IN_MILLISECONDS);
    }
};

void AddSC_wintergrasp()
{
    // NPCs
    new npc_wg_queue();
    new npc_wg_spirit_guide();
    new npc_wg_demolisher_engineer();
    new npc_wg_quest_giver();
    new npc_wg_siege_machine();

    // GOs
    new go_wg_vehicle_teleporter();

    // SPELLs
    new spell_wintergrasp_force_building();
    new spell_wintergrasp_create_vehicle();
    new spell_wintergrasp_rp_gg();
    new spell_wintergrasp_portal();
    new spell_wintergrasp_water();
    new spell_wintergrasp_hide_small_elementals();
    new spell_wg_reduce_damage_by_distance();

    // ACHIEVEMENTs
    new achievement_wg_didnt_stand_a_chance();
    new achievement_wg_vehicular_gnomeslaughter();
    new achievement_wg_within_our_grasp();
}
