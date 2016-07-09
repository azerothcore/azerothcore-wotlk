/*
 * Copyright (C) 2008-2015 TrinityCore <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// #include "Chat.h"
// #include "ScriptMgr.h"
// #include "AccountMgr.h"
// #include "ArenaTeamMgr.h"
// #include "CellImpl.h"
// #include "GridNotifiers.h"
// #include "Group.h"
// #include "Language.h"
// #include "Opcodes.h"
// #include "Player.h"
// #include "Pet.h"
// #include "ReputationMgr.h"
// #include "server/game/CustomRates.h"
// #include "server/game/AzthSharedDefines.h"
//
// class azth_commandscript : public CommandScript {
// public:
//
//     azth_commandscript() : CommandScript("azth_commandscript") {
//     }
//
//     std::vector<ChatCommand> GetCommands() const override {
//         static std::vector<ChatCommand> lookupAzthCommands = {
//             { "maxskill", AzthRbac::RBAC_PERM_COMMAND_AZTH_MAXSKILL, true, &handleAzthMaxSkill, ""},
//             { "xp", AzthRbac::RBAC_PERM_COMMAND_AZTH_XP, false, &handleAzthXP, ""},
//         };
//
//         static std::vector<ChatCommand> commandTable = {
//             { "azth", AzthRbac::RBAC_PERM_COMMAND_AZTH, true, NULL, "", lookupAzthCommands},
//             { "qc", AzthRbac::RBAC_PERM_COMMAND_QUESTCOMPLETER, true, &HandleQuestCompleterCommand, ""},
//         };
//         return commandTable;
//     }
//
//     // Based on HandleQuestComplete method of cs_quest.cpp
//
//     static bool HandleQuestCompleterCompHelper(Player* player, uint32 entry, ChatHandler* handler, char const* args, uint8 checked) {
//         if (!player) {
//             handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
//             handler->SetSentErrorMessage(true);
//             return false;
//         }
//
//         Quest const* quest = sObjectMgr->GetQuestTemplate(entry);
//
//         // If player doesn't have the quest
//         if (!quest || player->GetQuestStatus(entry) == QUEST_STATUS_NONE) {
//             handler->PSendSysMessage(LANG_COMMAND_QUEST_NOTFOUND, entry);
//             handler->SetSentErrorMessage(true);
//             return false;
//         }
//
//         // Add quest items for quests that require items
//         for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x) {
//             uint32 id = quest->RequiredItemId[x];
//             uint32 count = quest->RequiredItemCount[x];
//             if (!id || !count)
//                 continue;
//
//             uint32 curItemCount = player->GetItemCount(id, true);
//
//             ItemPosCountVec dest;
//             uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count - curItemCount);
//             if (msg == EQUIP_ERR_OK) {
//                 Item* item = player->StoreNewItem(dest, id, true);
//                 player->SendNewItem(item, count - curItemCount, true, false);
//             }
//         }
//
//         // All creature/GO slain/cast (not required, but otherwise it will display "Creature slain 0/10")
//         for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i) {
//             int32 creature = quest->RequiredNpcOrGo[i];
//             uint32 creatureCount = quest->RequiredNpcOrGoCount[i];
//
//             if (creature > 0) {
//                 if (CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creature))
//                     for (uint16 z = 0; z < creatureCount; ++z)
//                         player->KilledMonster(creatureInfo, ObjectGuid::Empty);
//             } else if (creature < 0)
//                 for (uint16 z = 0; z < creatureCount; ++z)
//                     player->KillCreditGO(creature);
//         }
//
//         // If the quest requires reputation to complete
//         if (uint32 repFaction = quest->GetRepObjectiveFaction()) {
//             uint32 repValue = quest->GetRepObjectiveValue();
//             uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
//             if (curRep < repValue)
//                 if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
//                     player->GetReputationMgr().SetReputation(factionEntry, repValue);
//         }
//
//         // If the quest requires a SECOND reputation to complete
//         if (uint32 repFaction = quest->GetRepObjectiveFaction2()) {
//             uint32 repValue2 = quest->GetRepObjectiveValue2();
//             uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
//             if (curRep < repValue2)
//                 if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
//                     player->GetReputationMgr().SetReputation(factionEntry, repValue2);
//         }
//
//         // If the quest requires money
//         int32 ReqOrRewMoney = quest->GetRewOrReqMoney();
//         if (ReqOrRewMoney < 0)
//             player->ModifyMoney(-ReqOrRewMoney);
//
//         if (sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER)) // check if Quest Tracker is enabled
//         {
//             // prepare Quest Tracker datas
//             PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_GM_COMPLETE);
//             stmt->setUInt32(0, quest->GetQuestId());
//             stmt->setUInt32(1, player->GetGUID().GetCounter());
//
//             // add to Quest Tracker
//             CharacterDatabase.Execute(stmt);
//         }
//
//         player->CompleteQuest(entry);
//
//         // if bugged field is set on 2
//         // then reward the quest too
//         if (checked == 2) {
//             Quest const* quest = sObjectMgr->GetQuestTemplate(entry);
//
//             // If player doesn't have the quest
//             if (!quest || player->GetQuestStatus(entry) != QUEST_STATUS_COMPLETE) {
//                 handler->PSendSysMessage(LANG_COMMAND_QUEST_NOTFOUND, entry);
//                 handler->SetSentErrorMessage(true);
//                 return false;
//             }
//
//             player->RewardQuest(quest, 0, player);
//         }
//
//         return true;
//     }
//
//     // Based on TrueWoW code
//
//     static bool HandleQuestCompleterCommand(ChatHandler* handler, char const* args) {
//         char* cId = handler->extractKeyFromLink((char*) args, "Hquest");
//         if (!cId) {
//             handler->PSendSysMessage("Syntax: .qc $quest\n\nControlla se la $quest è buggata.");
//             handler->SetSentErrorMessage(true);
//             return false;
//         }
//
//         uint32 entry = atol(cId);
//         Quest const* quest = sObjectMgr->GetQuestTemplate(entry);
//         if (!quest || quest == 0) {
//             handler->PSendSysMessage("Please enter a quest link.");
//             handler->SetSentErrorMessage(true);
//             return false;
//         } else {
//             uint32 checked = 0;
//             PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_QUESTCOMPLETER);
//             stmt->setUInt32(0, entry);
//             PreparedQueryResult resultCheck = WorldDatabase.Query(stmt);
//
//             if (!resultCheck) {
//                 handler->PSendSysMessage("Errore: quest non trovata.");
//                 handler->SetSentErrorMessage(true);
//                 return false;
//             }
//
//             std::string questTitle = quest->GetTitle();
//
//             checked = (*resultCheck)[0].GetUInt8();
//
//             if (checked >= 1) {
//                 std::string name;
//                 const char* playerName = handler->GetSession() ? handler->GetSession()->GetPlayer()->GetName().c_str() : NULL;
//
//                 if (playerName) {
//                     name = playerName;
//                     normalizePlayerName(name);
//
//                     Player* player = ObjectAccessor::FindPlayerByName(name);
//                     if (player->GetQuestStatus(entry) != QUEST_STATUS_INCOMPLETE) {
//                         handler->PSendSysMessage("[%s] è buggata!", questTitle.c_str());
//                         return true;
//                     } else {
//                         HandleQuestCompleterCompHelper(player, entry, handler, args, checked);
//                         handler->PSendSysMessage("[%s] è buggata ed è stata completata!", questTitle.c_str());
//                         return true;
//                     }
//                 } else {
//                     handler->PSendSysMessage("[%s] è buggata!", questTitle.c_str());
//                     return true;
//                 }
//             } else {
//                 handler->PSendSysMessage("[%s] non risulta essere buggata, se ritieni che lo sia ti preghiamo di segnalarcelo utilizzando il bugtracker.", questTitle.c_str());
//                 return true;
//             }
//         }
//     }
//
//     static bool handleAzthMaxSkill(ChatHandler* handler, const char* args) {
//
//         Player* target = handler->getSelectedPlayerOrSelf();
//         if (!target) {
//             handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
//             handler->SetSentErrorMessage(true);
//             return false;
//         }
//         if (target->getLevel() < 80) {
//             handler->PSendSysMessage(LANG_LEVEL_MINREQUIRED, 80);
//             handler->SetSentErrorMessage(true);
//             return false;
//         }
//
//         enum SkillSpells {
//             ONE_HAND_AXES = 196,
//             TWO_HAND_AXES = 197,
//             ONE_HAND_MACES = 198,
//             TWO_HAND_MACES = 199,
//             POLEARMS = 200,
//             ONE_HAND_SWORDS = 201,
//             TWO_HAND_SWORDS = 202,
//             STAVES = 227,
//             BOWS = 264,
//             GUNS = 266,
//             DAGGERS = 1180,
//             WANDS = 5009,
//             CROSSBOWS = 5011,
//             FIST_WEAPONS = 15590
//         };
//         static const SkillSpells spells[] = {ONE_HAND_AXES, TWO_HAND_AXES, ONE_HAND_MACES,
//             TWO_HAND_MACES, POLEARMS, ONE_HAND_SWORDS, TWO_HAND_SWORDS, STAVES, BOWS,
//             GUNS, DAGGERS, WANDS, CROSSBOWS, FIST_WEAPONS};
//
//         std::list<SkillSpells> learnList;
//         for (SkillSpells spell : spells) {
//             switch (target->getClass()) {
//                 case CLASS_WARRIOR:
//                     if (spell != WANDS)
//                         learnList.push_back(spell);
//                     break;
//                 case CLASS_DEATH_KNIGHT:
//                 case CLASS_PALADIN:
//                     if (spell != STAVES && spell != BOWS && spell != GUNS && spell != DAGGERS &&
//                             spell != WANDS && spell != CROSSBOWS && spell != FIST_WEAPONS)
//                         learnList.push_back(spell);
//                     break;
//                 case CLASS_HUNTER:
//                     if (spell != ONE_HAND_MACES && spell != TWO_HAND_MACES && spell != WANDS)
//                         learnList.push_back(spell);
//                     break;
//                 case CLASS_ROGUE:
//                     if (spell != TWO_HAND_AXES && spell != TWO_HAND_MACES && spell != POLEARMS &&
//                             spell != TWO_HAND_SWORDS && spell != STAVES && spell != WANDS)
//                         learnList.push_back(spell);
//                     break;
//                 case CLASS_PRIEST:
//                     if (spell == WANDS || spell == ONE_HAND_MACES || spell == STAVES ||
//                             spell == DAGGERS)
//                         learnList.push_back(spell);
//                     break;
//                 case CLASS_SHAMAN:
//                     if (spell != ONE_HAND_SWORDS && spell != TWO_HAND_SWORDS && spell != POLEARMS &&
//                             spell != BOWS && spell != GUNS && spell != WANDS && spell != CROSSBOWS)
//                         learnList.push_back(spell);
//                     break;
//                 case CLASS_WARLOCK:
//                 case CLASS_MAGE:
//                     if (spell == WANDS || spell == ONE_HAND_SWORDS || spell == STAVES ||
//                             spell == DAGGERS)
//                         learnList.push_back(spell);
//                     break;
//                 case CLASS_DRUID:
//                     if (spell != ONE_HAND_SWORDS && spell != TWO_HAND_SWORDS &&
//                             spell != BOWS && spell != GUNS && spell != WANDS && spell != CROSSBOWS &&
//                             spell != ONE_HAND_AXES && spell != TWO_HAND_AXES)
//                         learnList.push_back(spell);
//                     break;
//                 default:
//                     break;
//             }
//         }
//
//         for (SkillSpells spell : learnList) {
//             if (!target->HasSpell(spell))
//                 target->LearnSpell(spell, false);
//         }
//
//         target->UpdateSkillsToMaxSkillsForLevel();
//         return true;
//     }
//
//     static bool handleAzthXP(ChatHandler* handler, const char* args) {
//         Player *me = handler->GetSession() ? handler->GetSession()->GetPlayer() : NULL;
//         Player *target = handler->getSelectedPlayer();
//         Player *player = NULL;
//
//         if (!me || !me->GetSession())
//             return false;
//
//         // first, check if I can use the command
//         if (me->GetSession()->GetSecurity() < (int) sWorld->getIntConfig(CONFIG_PLAYER_INDIVIDUAL_XP_RATE_SECURITY)) {
//             handler->SendSysMessage(LANG_YOURS_SECURITY_IS_LOW);
//             handler->SetSentErrorMessage(true);
//             return false;
//         }
//
//         // If no arguments provided, show current custom XP rate
//         if (!*args) {
//             handler->PSendSysMessage("|CFF7BBEF7[Custom Rates]|r: Your current XP rate is %.2f.", me->azthPlayer->GetPlayerQuestRate());
//             return true;
//         }
//
//         float rate = atof((char *) args);
//         float maxRate = sWorld->getFloatConfig(CONFIG_PLAYER_MAXIMUM_INDIVIDUAL_XP_RATE);
//         if (rate < 0 || rate > maxRate) {
//             handler->PSendSysMessage("|CFF7BBEF7[Custom Rates]|r: Invalid rate specified, must be in interval [0, %.2f].", maxRate);
//             handler->SetSentErrorMessage(true);
//             return false;
//         }
//
//         // Without target; Set my XP rate
//         if (!target || !target->GetSession())
//             player = me;
//         else {
//             // Have a target AND my security level is higher than target's (I am a GM, he is a player); Set target XP rate
//             if (me->GetSession()->GetSecurity() > target->GetSession()->GetSecurity())
//                 player = target;
//             else
//                 player = me;
//         }
//
//         CustomRates::SaveXpRateToDB(player, rate);
//
//         player->azthPlayer->SetPlayerQuestRate(rate);
//
//         if (me->azthPlayer->GetPlayerQuestRate() == 0.0f)
//             handler->PSendSysMessage("|CFF7BBEF7[Custom Rates]|r: Quest XP Rate set to 0. You won't gain any experience from now on.");
//         else
//             handler->PSendSysMessage("|CFF7BBEF7[Custom Rates]|r: Quest XP Rate set to %.2f.", me->azthPlayer->GetPlayerQuestRate());
//         return true;
//     }
// };
//
// void AddSC_azth_commandscript() {
//     new azth_commandscript();
// }
