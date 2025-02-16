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

#include "PlayerScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnPlayerBeforeDurabilityRepair(Player* player, ObjectGuid npcGUID, ObjectGuid itemGUID, float& discountMod, uint8 guildBank)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_DURABILITY_REPAIR, script->OnPlayerBeforeDurabilityRepair(player, npcGUID, itemGUID, discountMod, guildBank));
}

void ScriptMgr::OnPlayerGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GOSSIP_SELECT, script->OnPlayerGossipSelect(player, menu_id, sender, action));
}

void ScriptMgr::OnPlayerGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GOSSIP_SELECT_CODE, script->OnPlayerGossipSelectCode(player, menu_id, sender, action, code));
}

void ScriptMgr::OnPlayerCompleteQuest(Player* player, Quest const* quest)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_COMPLETE_QUEST, script->OnPlayerCompleteQuest(player, quest));
}

void ScriptMgr::OnPlayerSendInitialPacketsBeforeAddToMap(Player* player, WorldPacket& data)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SEND_INITIAL_PACKETS_BEFORE_ADD_TO_MAP, script->OnPlayerSendInitialPacketsBeforeAddToMap(player, data));
}

void ScriptMgr::OnPlayerBattlegroundDesertion(Player* player, BattlegroundDesertionType const desertionType)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BATTLEGROUND_DESERTION, script->OnPlayerBattlegroundDesertion(player, desertionType));
}

void ScriptMgr::OnPlayerJustDied(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_JUST_DIED, script->OnPlayerJustDied(player));
}

void ScriptMgr::OnPlayerCalculateTalentsPoints(Player const* player, uint32& talentPointsForLevel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CALCULATE_TALENTS_POINTS, script->OnPlayerCalculateTalentsPoints(player, talentPointsForLevel));
}

void ScriptMgr::OnPlayerReleasedGhost(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_RELEASED_GHOST, script->OnPlayerReleasedGhost(player));
}

bool ScriptMgr::OnPlayerCanFlyInZone(Player* player, uint32 mapId, uint32 zoneId, SpellInfo const* bySpell)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_CAN_PLAYER_FLY_IN_ZONE, !script->OnPlayerCanFlyInZone(player, mapId, zoneId, bySpell));
}

void ScriptMgr::OnPlayerPVPKill(Player* killer, Player* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PVP_KILL, script->OnPlayerPVPKill(killer, killed));
}

void ScriptMgr::OnPlayerPVPFlagChange(Player* player, bool state)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_PVP_FLAG_CHANGE, script->OnPlayerPVPFlagChange(player, state));
}

void ScriptMgr::OnPlayerCreatureKill(Player* killer, Creature* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATURE_KILL, script->OnPlayerCreatureKill(killer, killed));
}

void ScriptMgr::OnPlayerCreatureKilledByPet(Player* petOwner, Creature* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATURE_KILLED_BY_PET, script->OnPlayerCreatureKilledByPet(petOwner, killed));
}

void ScriptMgr::OnPlayerKilledByCreature(Creature* killer, Player* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_KILLED_BY_CREATURE, script->OnPlayerKilledByCreature(killer, killed));
}

void ScriptMgr::OnPlayerLevelChanged(Player* player, uint8 oldLevel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LEVEL_CHANGED, script->OnPlayerLevelChanged(player, oldLevel));
}

void ScriptMgr::OnPlayerFreeTalentPointsChanged(Player* player, uint32 points)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FREE_TALENT_POINTS_CHANGED, script->OnPlayerFreeTalentPointsChanged(player, points));
}

void ScriptMgr::OnPlayerTalentsReset(Player* player, bool noCost)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_TALENTS_RESET, script->OnPlayerTalentsReset(player, noCost));
}

void ScriptMgr::OnPlayerAfterSpecSlotChanged(Player* player, uint8 newSlot)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_SPEC_SLOT_CHANGED, script->OnPlayerAfterSpecSlotChanged(player, newSlot));
}

void ScriptMgr::OnPlayerMoneyChanged(Player* player, int32& amount)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_MONEY_CHANGED, script->OnPlayerMoneyChanged(player, amount));
}

void ScriptMgr::OnPlayerBeforeLootMoney(Player* player, Loot* loot)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_LOOT_MONEY, script->OnPlayerBeforeLootMoney(player, loot));
}

void ScriptMgr::OnPlayerGiveXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GIVE_EXP, script->OnPlayerGiveXP(player, amount, victim, xpSource));
}

bool ScriptMgr::OnPlayerReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_REPUTATION_CHANGE, !script->OnPlayerReputationChange(player, factionID, standing, incremental));
}

void ScriptMgr::OnPlayerReputationRankChange(Player* player, uint32 factionID, ReputationRank newRank, ReputationRank oldRank, bool increased)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_REPUTATION_RANK_CHANGE, script->OnPlayerReputationRankChange(player, factionID, newRank, oldRank, increased));
}

void ScriptMgr::OnPlayerLearnSpell(Player* player, uint32 spellID)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LEARN_SPELL, script->OnPlayerLearnSpell(player, spellID));
}

void ScriptMgr::OnPlayerForgotSpell(Player* player, uint32 spellID)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FORGOT_SPELL, script->OnPlayerForgotSpell(player, spellID));
}

void ScriptMgr::OnPlayerDuelRequest(Player* target, Player* challenger)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DUEL_REQUEST, script->OnPlayerDuelRequest(target, challenger));
}

void ScriptMgr::OnPlayerDuelStart(Player* player1, Player* player2)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DUEL_START, script->OnPlayerDuelStart(player1, player2));
}

void ScriptMgr::OnPlayerDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DUEL_END, script->OnPlayerDuelEnd(winner, loser, type));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT, script->OnPlayerChat(player, type, lang, msg));
}

void ScriptMgr::OnPlayerBeforeSendChatMessage(Player* player, uint32& type, uint32& lang, std::string& msg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_SEND_CHAT_MESSAGE, script->OnPlayerBeforeSendChatMessage(player, type, lang, msg));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_RECEIVER, script->OnPlayerChat(player, type, lang, msg, receiver));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_GROUP, script->OnPlayerChat(player, type, lang, msg, group));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_GUILD, script->OnPlayerChat(player, type, lang, msg, guild));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_CHANNEL, script->OnPlayerChat(player, type, lang, msg, channel));
}

void ScriptMgr::OnPlayerEmote(Player* player, uint32 emote)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_EMOTE, script->OnPlayerEmote(player, emote));
}

void ScriptMgr::OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, ObjectGuid guid)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_TEXT_EMOTE, script->OnPlayerTextEmote(player, textEmote, emoteNum, guid));
}

void ScriptMgr::OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SPELL_CAST, script->OnPlayerSpellCast(player, spell, skipCheck));
}

void ScriptMgr::OnPlayerBeforeUpdate(Player* player, uint32 p_time)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_UPDATE, script->OnPlayerBeforeUpdate(player, p_time));
}

void ScriptMgr::OnPlayerUpdate(Player* player, uint32 p_time)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE, script->OnPlayerUpdate(player, p_time));
}

void ScriptMgr::OnPlayerLogin(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOGIN, script->OnPlayerLogin(player));
}

void ScriptMgr::OnPlayerLoadFromDB(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOAD_FROM_DB, script->OnPlayerLoadFromDB(player));
}

void ScriptMgr::OnPlayerBeforeLogout(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_LOGOUT, script->OnPlayerBeforeLogout(player));
}

void ScriptMgr::OnPlayerLogout(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOGOUT, script->OnPlayerLogout(player));
}

void ScriptMgr::OnPlayerCreate(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATE, script->OnPlayerCreate(player));
}

void ScriptMgr::OnPlayerSave(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SAVE, script->OnPlayerSave(player));
}

void ScriptMgr::OnPlayerDelete(ObjectGuid guid, uint32 accountId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DELETE, script->OnPlayerDelete(guid, accountId));
}

void ScriptMgr::OnPlayerFailedDelete(ObjectGuid guid, uint32 accountId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FAILED_DELETE, script->OnPlayerFailedDelete(guid, accountId));
}

void ScriptMgr::OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BIND_TO_INSTANCE, script->OnPlayerBindToInstance(player, difficulty, mapid, permanent));
}

void ScriptMgr::OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_ZONE, script->OnPlayerUpdateZone(player, newZone, newArea));
}

void ScriptMgr::OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_AREA, script->OnPlayerUpdateArea(player, oldArea, newArea));
}

bool ScriptMgr::OnPlayerBeforeTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit* target)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_TELEPORT, !script->OnPlayerBeforeTeleport(player, mapid, x, y, z, orientation, options, target));
}

void ScriptMgr::OnPlayerUpdateFaction(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_FACTION, script->OnPlayerUpdateFaction(player));
}

void ScriptMgr::OnPlayerAddToBattleground(Player* player, Battleground* bg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_ADD_TO_BATTLEGROUND, script->OnPlayerAddToBattleground(player, bg));
}

void ScriptMgr::OnPlayerQueueRandomDungeon(Player* player, uint32 & rDungeonId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEUE_RANDOM_DUNGEON, script->OnPlayerQueueRandomDungeon(player, rDungeonId));
}

void ScriptMgr::OnPlayerRemoveFromBattleground(Player* player, Battleground* bg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_REMOVE_FROM_BATTLEGROUND, script->OnPlayerRemoveFromBattleground(player, bg));
}

bool ScriptMgr::OnPlayerBeforeAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_ACHI_COMPLETE, !script->OnPlayerBeforeAchievementComplete(player, achievement));
}

void ScriptMgr::OnPlayerAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_ACHI_COMPLETE, script->OnPlayerAchievementComplete(player, achievement));
}

bool ScriptMgr::OnPlayerBeforeCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_CRITERIA_PROGRESS, !script->OnPlayerBeforeCriteriaProgress(player, criteria));
}

void ScriptMgr::OnPlayerCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CRITERIA_PROGRESS, script->OnPlayerCriteriaProgress(player, criteria));
}

void ScriptMgr::OnPlayerAchievementSave(CharacterDatabaseTransaction trans, Player* player, uint16 achiId, CompletedAchievementData achiData)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_ACHI_SAVE, script->OnPlayerAchievementSave(trans, player, achiId, achiData));
}

void ScriptMgr::OnPlayerCriteriaSave(CharacterDatabaseTransaction trans, Player* player, uint16 critId, CriteriaProgress criteriaData)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CRITERIA_SAVE, script->OnPlayerCriteriaSave(trans, player, critId, criteriaData));
}

void ScriptMgr::OnPlayerBeingCharmed(Player* player, Unit* charmer, uint32 oldFactionId, uint32 newFactionId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEING_CHARMED, script->OnPlayerBeingCharmed(player, charmer, oldFactionId, newFactionId));
}

void ScriptMgr::OnPlayerAfterSetVisibleItemSlot(Player* player, uint8 slot, Item* item)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_SET_VISIBLE_ITEM_SLOT, script->OnPlayerAfterSetVisibleItemSlot(player, slot, item));
}

void ScriptMgr::OnPlayerAfterMoveItemFromInventory(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_MOVE_ITEM_FROM_INVENTORY, script->OnPlayerAfterMoveItemFromInventory(player, it, bag, slot, update));
}

void ScriptMgr::OnPlayerEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_EQUIP, script->OnPlayerEquip(player, it, bag, slot, update));
}

void ScriptMgr::OnPlayerJoinBG(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_JOIN_BG, script->OnPlayerJoinBG(player));
}

void ScriptMgr::OnPlayerJoinArena(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_JOIN_ARENA, script->OnPlayerJoinArena(player));
}

void ScriptMgr::OnPlayerGetMaxPersonalArenaRatingRequirement(Player const* player, uint32 minSlot, uint32& maxArenaRating) const
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_MAX_PERSONAL_ARENA_RATING_REQUIREMENT, script->OnPlayerGetMaxPersonalArenaRatingRequirement(player, minSlot, maxArenaRating));
}

void ScriptMgr::OnPlayerLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOOT_ITEM, script->OnPlayerLootItem(player, item, count, lootguid));
}

void ScriptMgr::OnPlayerBeforeFillQuestLootItem(Player* player, LootItem& item)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_FILL_QUEST_LOOT_ITEM, script->OnPlayerBeforeFillQuestLootItem(player, item));
}

void ScriptMgr::OnPlayerStoreNewItem(Player* player, Item* item, uint32 count)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_STORE_NEW_ITEM, script->OnPlayerStoreNewItem(player, item, count));
}

void ScriptMgr::OnPlayerCreateItem(Player* player, Item* item, uint32 count)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATE_ITEM, script->OnPlayerCreateItem(player, item, count));
}

void ScriptMgr::OnPlayerQuestRewardItem(Player* player, Item* item, uint32 count)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEST_REWARD_ITEM, script->OnPlayerQuestRewardItem(player, item, count));
}

bool ScriptMgr::OnPlayerCanPlaceAuctionBid(Player* player, AuctionEntry* auction)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLACE_AUCTION_BID, !script->OnPlayerCanPlaceAuctionBid(player, auction));
}

void ScriptMgr::OnPlayerGroupRollRewardItem(Player* player, Item* item, uint32 count, RollVote voteType, Roll* roll)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GROUP_ROLL_REWARD_ITEM, script->OnPlayerGroupRollRewardItem(player, item, count, voteType, roll));
}

bool ScriptMgr::OnPlayerBeforeOpenItem(Player* player, Item* item)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_OPEN_ITEM, !script->OnPlayerBeforeOpenItem(player, item));
}

void ScriptMgr::OnPlayerFirstLogin(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FIRST_LOGIN, script->OnPlayerFirstLogin(player));
}

void ScriptMgr::OnPlayerSetMaxLevel(Player* player, uint32& maxPlayerLevel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SET_MAX_LEVEL, script->OnPlayerSetMaxLevel(player, maxPlayerLevel));
}

bool ScriptMgr::OnPlayerCanJoinInBattlegroundQueue(Player* player, ObjectGuid BattlemasterGuid, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, GroupJoinBattlegroundResult& err)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_JOIN_IN_BATTLEGROUND_QUEUE, !script->OnPlayerCanJoinInBattlegroundQueue(player, BattlemasterGuid, BGTypeID, joinAsGroup, err));
}

bool ScriptMgr::OnPlayerShouldBeRewardedWithMoneyInsteadOfExp(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS_WITH_DEFAULT_FALSE(PlayerScript, PLAYERHOOK_SHOULD_BE_REWARDED_WITH_MONEY_INSTEAD_OF_EXP, script->OnPlayerShouldBeRewardedWithMoneyInsteadOfExp(player));
}

void ScriptMgr::OnPlayerBeforeTempSummonInitStats(Player* player, TempSummon* tempSummon, uint32& duration)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_TEMP_SUMMON_INIT_STATS, script->OnPlayerBeforeTempSummonInitStats(player, tempSummon, duration));
}

void ScriptMgr::OnPlayerBeforeGuardianInitStatsForLevel(Player* player, Guardian* guardian, CreatureTemplate const* cinfo, PetType& petType)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_GUARDIAN_INIT_STATS_FOR_LEVEL, script->OnPlayerBeforeGuardianInitStatsForLevel(player, guardian, cinfo, petType));
}

void ScriptMgr::OnPlayerAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_GUARDIAN_INIT_STATS_FOR_LEVEL, script->OnPlayerAfterGuardianInitStatsForLevel(player, guardian));
}

void ScriptMgr::OnPlayerBeforeLoadPetFromDB(Player* player, uint32& petentry, uint32& petnumber, bool& current, bool& forceLoadFromDB)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_LOAD_PET_FROM_DB, script->OnPlayerBeforeLoadPetFromDB(player, petentry, petnumber, current, forceLoadFromDB));
}

void ScriptMgr::OnPlayerBeforeBuyItemFromVendor(Player* player, ObjectGuid vendorguid, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_BUY_ITEM_FROM_VENDOR, script->OnPlayerBeforeBuyItemFromVendor(player, vendorguid, vendorslot, item, count, bag, slot));
}

void ScriptMgr::OnPlayerAfterStoreOrEquipNewItem(Player* player, uint32 vendorslot, Item* item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_STORE_OR_EQUIP_NEW_ITEM, script->OnPlayerAfterStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore));
}

void ScriptMgr::OnPlayerAfterUpdateMaxPower(Player* player, Powers& power, float& value)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_UPDATE_MAX_POWER, script->OnPlayerAfterUpdateMaxPower(player, power, value));
}

void ScriptMgr::OnPlayerAfterUpdateMaxHealth(Player* player, float& value)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_UPDATE_MAX_HEALTH, script->OnPlayerAfterUpdateMaxHealth(player, value));
}

void ScriptMgr::OnPlayerBeforeUpdateAttackPowerAndDamage(Player* player, float& level, float& val2, bool ranged)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_UPDATE_ATTACK_POWER_AND_DAMAGE, script->OnPlayerBeforeUpdateAttackPowerAndDamage(player, level, val2, ranged));
}

void ScriptMgr::OnPlayerAfterUpdateAttackPowerAndDamage(Player* player, float& level, float& base_attPower, float& attPowerMod, float& attPowerMultiplier, bool ranged)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_UPDATE_ATTACK_POWER_AND_DAMAGE, script->OnPlayerAfterUpdateAttackPowerAndDamage(player, level, base_attPower, attPowerMod, attPowerMultiplier, ranged));
}

void ScriptMgr::OnPlayerBeforeInitTalentForLevel(Player* player, uint8& level, uint32& talentPointsForLevel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_INIT_TALENT_FOR_LEVEL, script->OnPlayerBeforeInitTalentForLevel(player, level, talentPointsForLevel));
}

bool ScriptMgr::OnPlayerBeforeQuestComplete(Player* player, uint32 quest_id)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_QUEST_COMPLETE, !script->OnPlayerBeforeQuestComplete(player, quest_id));
}

void ScriptMgr::OnPlayerQuestComputeXP(Player* player, Quest const* quest, uint32& xpValue)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEST_COMPUTE_EXP, script->OnPlayerQuestComputeXP(player, quest, xpValue));
}

void ScriptMgr::OnPlayerBeforeStoreOrEquipNewItem(Player* player, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_STORE_OR_EQUIP_NEW_ITEM, script->OnPlayerBeforeStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore));
}

bool ScriptMgr::OnPlayerCanJoinInArenaQueue(Player* player, ObjectGuid BattlemasterGuid, uint8 arenaslot, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, uint8 IsRated, GroupJoinBattlegroundResult& err)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_JOIN_IN_ARENA_QUEUE, !script->OnPlayerCanJoinInArenaQueue(player, BattlemasterGuid, arenaslot, BGTypeID, joinAsGroup, IsRated, err));
}

bool ScriptMgr::OnPlayerCanBattleFieldPort(Player* player, uint8 arenaType, BattlegroundTypeId BGTypeID, uint8 action)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_BATTLEFIELD_PORT, !script->OnPlayerCanBattleFieldPort(player, arenaType, BGTypeID, action));
}

bool ScriptMgr::OnPlayerCanGroupInvite(Player* player, std::string& membername)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_GROUP_INVITE, !script->OnPlayerCanGroupInvite(player, membername));
}

bool ScriptMgr::OnPlayerCanGroupAccept(Player* player, Group* group)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_GROUP_ACCEPT, !script->OnPlayerCanGroupAccept(player, group));
}

bool ScriptMgr::OnPlayerCanSellItem(Player* player, Item* item, Creature* creature)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SELL_ITEM, !script->OnPlayerCanSellItem(player, item, creature));
}

bool ScriptMgr::OnPlayerCanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 COD, Item* item)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SEND_MAIL, !script->OnPlayerCanSendMail(player, receiverGuid, mailbox, subject, body, money, COD, item));
}

bool ScriptMgr::OnPlayerCanSendErrorAlreadyLooted(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SEND_ERROR_ALREADY_LOOTED, !script->OnPlayerCanSendErrorAlreadyLooted(player));
}

void ScriptMgr::OnPlayerAfterCreatureLoot(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_CREATURE_LOOT, script->OnPlayerAfterCreatureLoot(player));
}

void ScriptMgr::OnPlayerAfterCreatureLootMoney(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_CREATURE_LOOT_MONEY, script->OnPlayerAfterCreatureLootMoney(player));
}

void ScriptMgr::OnPlayerPetitionBuy(Player* player, Creature* creature, uint32& charterid, uint32& cost, uint32& type)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_PETITION_BUY, script->OnPlayerPetitionBuy(player, creature, charterid, cost, type));
}

void ScriptMgr::OnPlayerPetitionShowList(Player* player, Creature* creature, uint32& CharterEntry, uint32& CharterDispayID, uint32& CharterCost)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_PETITION_SHOW_LIST, script->OnPlayerPetitionShowList(player, creature, CharterEntry, CharterDispayID, CharterCost));
}

void ScriptMgr::OnPlayerRewardKillRewarder(Player* player, KillRewarder* rewarder, bool isDungeon, float& rate)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_REWARD_KILL_REWARDER, script->OnPlayerRewardKillRewarder(player, rewarder, isDungeon, rate));
}

bool ScriptMgr::OnPlayerCanGiveMailRewardAtGiveLevel(Player* player, uint8 level)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_GIVE_MAIL_REWARD_AT_GIVE_LEVEL, !script->OnPlayerCanGiveMailRewardAtGiveLevel(player, level));
}

void ScriptMgr::OnPlayerDeleteFromDB(CharacterDatabaseTransaction trans, uint32 guid)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DELETE_FROM_DB, script->OnPlayerDeleteFromDB(trans, guid));
}

bool ScriptMgr::OnPlayerCanRepopAtGraveyard(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_REPOP_AT_GRAVEYARD, !script->OnPlayerCanRepopAtGraveyard(player));
}

Optional<bool> ScriptMgr::OnPlayerIsClass(Player const* player, Classes unitClass, ClassContext context)
{
    if (ScriptRegistry<PlayerScript>::EnabledHooks[PLAYERHOOK_ON_PLAYER_IS_CLASS].empty())
        return {};

    for (auto const& script : ScriptRegistry<PlayerScript>::EnabledHooks[PLAYERHOOK_ON_PLAYER_IS_CLASS])
    {
        Optional<bool> scriptResult = script->OnPlayerIsClass(player, unitClass, context);
        if (scriptResult)
            return scriptResult;
    }

    return {};
}

void ScriptMgr::OnPlayerGetMaxSkillValue(Player* player, uint32 skill, int32& result, bool IsPure)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_MAX_SKILL_VALUE, script->OnPlayerGetMaxSkillValue(player, skill, result, IsPure));
}

bool ScriptMgr::OnPlayerHasActivePowerType(Player const* player, Powers power)
{
    CALL_ENABLED_BOOLEAN_HOOKS_WITH_DEFAULT_FALSE(PlayerScript, PLAYERHOOK_ON_PLAYER_HAS_ACTIVE_POWER_TYPE, script->OnPlayerHasActivePowerType(player, power));
}

void ScriptMgr::OnPlayerUpdateGatheringSkill(Player *player, uint32 skillId, uint32 currentLevel, uint32 gray, uint32 green, uint32 yellow, uint32 &gain)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_GATHERING_SKILL, script->OnPlayerUpdateGatheringSkill(player, skillId, currentLevel, gray, green, yellow, gain));
}

void ScriptMgr::OnPlayerUpdateCraftingSkill(Player *player, SkillLineAbilityEntry const* skill, uint32 currentLevel, uint32& gain)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_CRAFTING_SKILL, script->OnPlayerUpdateCraftingSkill(player, skill, currentLevel, gain));
}

bool ScriptMgr::OnPlayerUpdateFishingSkill(Player* player, int32 skill, int32 zone_skill, int32 chance, int32 roll)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_FISHING_SKILL, !script->OnPlayerUpdateFishingSkill(player, skill, zone_skill, chance, roll));
}

bool ScriptMgr::OnPlayerCanAreaExploreAndOutdoor(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_AREA_EXPLORE_AND_OUTDOOR, !script->OnPlayerCanAreaExploreAndOutdoor(player));
}

void ScriptMgr::OnPlayerVictimRewardBefore(Player* player, Player* victim, uint32& killer_title, uint32& victim_title)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_VICTIM_REWARD_BEFORE, script->OnPlayerVictimRewardBefore(player, victim, killer_title, victim_title));
}

void ScriptMgr::OnPlayerVictimRewardAfter(Player* player, Player* victim, uint32& killer_title, uint32& victim_rank, float& honor_f)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_VICTIM_REWARD_AFTER, script->OnPlayerVictimRewardAfter(player, victim, killer_title, victim_rank, honor_f));
}

void ScriptMgr::OnPlayerCustomScalingStatValueBefore(Player* player, ItemTemplate const* proto, uint8 slot, bool apply, uint32& CustomScalingStatValue)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CUSTOM_SCALING_STAT_VALUE_BEFORE, script->OnPlayerCustomScalingStatValueBefore(player, proto, slot, apply, CustomScalingStatValue));
}

void ScriptMgr::OnPlayerCustomScalingStatValue(Player* player, ItemTemplate const* proto, uint32& statType, int32& val, uint8 itemProtoStatNumber, uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CUSTOM_SCALING_STAT_VALUE, script->OnPlayerCustomScalingStatValue(player, proto, statType, val, itemProtoStatNumber, ScalingStatValue, ssv));
}

void ScriptMgr::OnPlayerApplyItemModsBefore(Player* player, uint8 slot, bool apply, uint8 itemProtoStatNumber, uint32 statType, int32& val)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_APPLY_ITEM_MODS_BEFORE, script->OnPlayerApplyItemModsBefore(player, slot, apply, itemProtoStatNumber, statType, val));
}

void ScriptMgr::OnPlayerApplyEnchantmentItemModsBefore(Player* player, Item* item, EnchantmentSlot slot, bool apply, uint32 enchant_spell_id, uint32& enchant_amount)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_APPLY_ENCHANTMENT_ITEM_MODS_BEFORE, script->OnPlayerApplyEnchantmentItemModsBefore(player, item, slot, apply, enchant_spell_id, enchant_amount));
}

void ScriptMgr::OnPlayerApplyWeaponDamage(Player* player, uint8 slot, ItemTemplate const* proto, float& minDamage, float& maxDamage, uint8 damageIndex)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_APPLY_WEAPON_DAMAGE, script->OnPlayerApplyWeaponDamage(player, slot, proto, minDamage, maxDamage, damageIndex));
}

bool ScriptMgr::OnPlayerCanArmorDamageModifier(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_ARMOR_DAMAGE_MODIFIER, !script->OnPlayerCanArmorDamageModifier(player));
}

void ScriptMgr::OnPlayerGetFeralApBonus(Player* player, int32& feral_bonus, int32 dpsMod, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_FERAL_AP_BONUS, script->OnPlayerGetFeralApBonus(player, feral_bonus, dpsMod, proto, ssv));
}

bool ScriptMgr::OnPlayerCanApplyWeaponDependentAuraDamageMod(Player* player, Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_WEAPON_DEPENDENT_AURA_DAMAGE_MOD, !script->OnPlayerCanApplyWeaponDependentAuraDamageMod(player, item, attackType, aura, apply));
}

bool ScriptMgr::OnPlayerCanApplyEquipSpell(Player* player, SpellInfo const* spellInfo, Item* item, bool apply, bool form_change)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_EQUIP_SPELL, !script->OnPlayerCanApplyEquipSpell(player, spellInfo, item, apply, form_change));
}

bool ScriptMgr::OnPlayerCanApplyEquipSpellsItemSet(Player* player, ItemSetEffect* eff)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_EQUIP_SPELLS_ITEM_SET, !script->OnPlayerCanApplyEquipSpellsItemSet(player, eff));
}

bool ScriptMgr::OnPlayerCanCastItemCombatSpell(Player* player, Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_CAST_ITEM_COMBAT_SPELL, !script->OnPlayerCanCastItemCombatSpell(player, target, attType, procVictim, procEx, item, proto));
}

bool ScriptMgr::OnPlayerCanCastItemUseSpell(Player* player, Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_CAST_ITEM_USE_SPELL, !script->OnPlayerCanCastItemUseSpell(player, item, targets, cast_count, glyphIndex));
}

void ScriptMgr::OnPlayerApplyAmmoBonuses(Player* player, ItemTemplate const* proto, float& currentAmmoDPS)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_APPLY_AMMO_BONUSES, script->OnPlayerApplyAmmoBonuses(player, proto, currentAmmoDPS));
}

bool ScriptMgr::OnPlayerCanEquipItem(Player* player, uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_EQUIP_ITEM, !script->OnPlayerCanEquipItem(player, slot, dest, pItem, swap, not_loading));
}

bool ScriptMgr::OnPlayerCanUnequipItem(Player* player, uint16 pos, bool swap)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_UNEQUIP_ITEM, !script->OnPlayerCanUnequipItem(player, pos, swap));
}

bool ScriptMgr::OnPlayerCanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_USE_ITEM, !script->OnPlayerCanUseItem(player, proto, result));
}

bool ScriptMgr::OnPlayerCanSaveEquipNewItem(Player* player, Item* item, uint16 pos, bool update)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SAVE_EQUIP_NEW_ITEM, !script->OnPlayerCanSaveEquipNewItem(player, item, pos, update));
}

bool ScriptMgr::OnPlayerCanApplyEnchantment(Player* player, Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_ENCHANTMENT, !script->OnPlayerCanApplyEnchantment(player, item, slot, apply, apply_dur, ignore_condition));
}

void ScriptMgr::OnPlayerGetQuestRate(Player* player, float& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_QUEST_RATE, script->OnPlayerGetQuestRate(player, result));
}

bool ScriptMgr::OnPlayerPassedQuestKilledMonsterCredit(Player* player, Quest const* qinfo, uint32 entry, uint32 real_entry, ObjectGuid guid)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_PASSED_QUEST_KILLED_MONSTER_CREDIT, !script->OnPlayerPassedQuestKilledMonsterCredit(player, qinfo, entry, real_entry, guid));
}

bool ScriptMgr::OnPlayerCheckItemInSlotAtLoadInventory(Player* player, Item* item, uint8 slot, uint8& err, uint16& dest)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CHECK_ITEM_IN_SLOT_AT_LOAD_INVENTORY, !script->OnPlayerCheckItemInSlotAtLoadInventory(player, item, slot, err, dest));
}

bool ScriptMgr::OnPlayerNotAvoidSatisfy(Player* player, DungeonProgressionRequirements const* ar, uint32 target_map, bool report)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_NOT_AVOID_SATISFY, !script->OnPlayerNotAvoidSatisfy(player, ar, target_map, report));
}

bool ScriptMgr::OnPlayerNotVisibleGloballyFor(Player* player, Player const* u)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_NOT_VISIBLE_GLOBALLY_FOR, !script->OnPlayerNotVisibleGloballyFor(player, u));
}

void ScriptMgr::OnPlayerGetArenaPersonalRating(Player* player, uint8 slot, uint32& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_ARENA_PERSONAL_RATING, script->OnPlayerGetArenaPersonalRating(player, slot, result));
}

void ScriptMgr::OnPlayerGetArenaTeamId(Player* player, uint8 slot, uint32& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_ARENA_TEAM_ID, script->OnPlayerGetArenaTeamId(player, slot, result));
}

void ScriptMgr::OnPlayerIsFFAPvP(Player* player, bool& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_IS_FFA_PVP, script->OnPlayerIsFFAPvP(player, result));
}

void ScriptMgr::OnPlayerFfaPvpStateUpdate(Player* player, bool result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FFA_PVP_STATE_UPDATE, script->OnPlayerFfaPvpStateUpdate(player, result));
}

void ScriptMgr::OnPlayerIsPvP(Player* player, bool& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_IS_PVP, script->OnPlayerIsPvP(player, result));
}

void ScriptMgr::OnPlayerGetMaxSkillValueForLevel(Player* player, uint16& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_MAX_SKILL_VALUE_FOR_LEVEL, script->OnPlayerGetMaxSkillValueForLevel(player, result));
}

bool ScriptMgr::OnPlayerNotSetArenaTeamInfoField(Player* player, uint8 slot, ArenaTeamInfoType type, uint32 value)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_NOT_SET_ARENA_TEAM_INFO_FIELD, !script->OnPlayerNotSetArenaTeamInfoField(player, slot, type, value));
}

bool ScriptMgr::OnPlayerCanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_JOIN_LFG, !script->OnPlayerCanJoinLfg(player, roles, dungeons, comment));
}

bool ScriptMgr::OnPlayerCanEnterMap(Player* player, MapEntry const* entry, InstanceTemplate const* instance, MapDifficulty const* mapDiff, bool loginCheck)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_ENTER_MAP, !script->OnPlayerCanEnterMap(player, entry, instance, mapDiff, loginCheck));
}

bool ScriptMgr::OnPlayerCanInitTrade(Player* player, Player* target)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_INIT_TRADE, !script->OnPlayerCanInitTrade(player, target));
}

bool ScriptMgr::OnPlayerCanSetTradeItem(Player* player, Item* tradedItem, uint8 tradeSlot)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SET_TRADE_ITEM, !script->OnPlayerCanSetTradeItem(player, tradedItem, tradeSlot));
}

void ScriptMgr::OnPlayerSetServerSideVisibility(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SET_SERVER_SIDE_VISIBILITY, script->OnPlayerSetServerSideVisibility(player, type, sec));
}

void ScriptMgr::OnPlayerSetServerSideVisibilityDetect(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SET_SERVER_SIDE_VISIBILITY_DETECT, script->OnPlayerSetServerSideVisibilityDetect(player, type, sec));
}

void ScriptMgr::OnPlayerResurrect(Player* player, float restore_percent, bool applySickness)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_RESURRECT, script->OnPlayerResurrect(player, restore_percent, applySickness));
}

void ScriptMgr::OnPlayerBeforeChooseGraveyard(Player* player, TeamId teamId, bool nearCorpse, uint32& graveyardOverride)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_CHOOSE_GRAVEYARD, script->OnPlayerBeforeChooseGraveyard(player, teamId, nearCorpse, graveyardOverride));
}

bool ScriptMgr::OnPlayerCanUseChat(Player* player, uint32 type, uint32 language, std::string& msg)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_CHAT, !script->OnPlayerCanUseChat(player, type, language, msg));
}

bool ScriptMgr::OnPlayerCanUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Player* receiver)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_PRIVATE_CHAT, !script->OnPlayerCanUseChat(player, type, language, msg, receiver));
}

bool ScriptMgr::OnPlayerCanUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Group* group)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_GROUP_CHAT, !script->OnPlayerCanUseChat(player, type, language, msg, group));
}

bool ScriptMgr::OnPlayerCanUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Guild* guild)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_GUILD_CHAT, !script->OnPlayerCanUseChat(player, type, language, msg, guild));
}

bool ScriptMgr::OnPlayerCanUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Channel* channel)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_CHANNEL_CHAT, !script->OnPlayerCanUseChat(player, type, language, msg, channel));
}

void ScriptMgr::OnPlayerLearnTalents(Player* player, uint32 talentId, uint32 talentRank, uint32 spellid)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_LEARN_TALENTS, script->OnPlayerLearnTalents(player, talentId, talentRank, spellid));
}

void ScriptMgr::OnPlayerEnterCombat(Player* player, Unit* enemy)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_ENTER_COMBAT, script->OnPlayerEnterCombat(player, enemy));
}

void ScriptMgr::OnPlayerLeaveCombat(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_LEAVE_COMBAT, script->OnPlayerLeaveCombat(player));
}

void ScriptMgr::OnPlayerQuestAbandon(Player* player, uint32 questId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEST_ABANDON, script->OnPlayerQuestAbandon(player, questId));
}

// Player anti cheat
void ScriptMgr::AnticheatSetCanFlybyServer(Player* player, bool apply)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ANTICHEAT_SET_CAN_FLY_BY_SERVER, script->AnticheatSetCanFlybyServer(player, apply));
}

void ScriptMgr::AnticheatSetUnderACKmount(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ANTICHEAT_SET_UNDER_ACK_MOUNT, script->AnticheatSetUnderACKmount(player));
}

void ScriptMgr::AnticheatSetRootACKUpd(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ANTICHEAT_SET_ROOT_ACK_UPD, script->AnticheatSetRootACKUpd(player));
}

void ScriptMgr::AnticheatSetJumpingbyOpcode(Player* player, bool jump)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ANTICHEAT_SET_JUMPING_BY_OPCODE, script->AnticheatSetJumpingbyOpcode(player, jump));
}

void ScriptMgr::AnticheatUpdateMovementInfo(Player* player, MovementInfo const& movementInfo)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ANTICHEAT_UPDATE_MOVEMENT_INFO, script->AnticheatUpdateMovementInfo(player, movementInfo));
}

bool ScriptMgr::AnticheatHandleDoubleJump(Player* player, Unit* mover)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ANTICHEAT_HANDLE_DOUBLE_JUMP, !script->AnticheatHandleDoubleJump(player, mover));
}

bool ScriptMgr::AnticheatCheckMovementInfo(Player* player, MovementInfo const& movementInfo, Unit* mover, bool jump)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ANTICHEAT_CHECK_MOVEMENT_INFO, !script->AnticheatCheckMovementInfo(player, movementInfo, mover, jump));
}

bool ScriptMgr::OnPlayerCanUpdateSkill(Player* player, uint32 skillId)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_CAN_UPDATE_SKILL, !script->OnPlayerCanUpdateSkill(player, skillId));
}

void ScriptMgr::OnPlayerBeforeUpdateSkill(Player* player, uint32 skillId, uint32& value, uint32 max, uint32 step)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_UPDATE_SKILL, script->OnPlayerBeforeUpdateSkill(player, skillId, value, max, step));
}

void ScriptMgr::OnPlayerUpdateSkill(Player* player, uint32 skillId, uint32 value, uint32 max, uint32 step, uint32 newValue)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_SKILL, script->OnPlayerUpdateSkill(player, skillId, value, max, step, newValue));
}

bool ScriptMgr::OnPlayerCanResurrect(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_RESURRECT, !script->OnPlayerCanResurrect(player));
}

PlayerScript::PlayerScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, PLAYERHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < PLAYERHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<PlayerScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<PlayerScript>;
