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

void ScriptMgr::OnBeforePlayerDurabilityRepair(Player* player, ObjectGuid npcGUID, ObjectGuid itemGUID, float& discountMod, uint8 guildBank)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_DURABILITY_REPAIR, script->OnBeforeDurabilityRepair(player, npcGUID, itemGUID, discountMod, guildBank));
}

void ScriptMgr::OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GOSSIP_SELECT, script->OnGossipSelect(player, menu_id, sender, action));
}

void ScriptMgr::OnGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GOSSIP_SELECT_CODE, script->OnGossipSelectCode(player, menu_id, sender, action, code));
}

void ScriptMgr::OnPlayerCompleteQuest(Player* player, Quest const* quest)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_COMPLETE_QUEST, script->OnPlayerCompleteQuest(player, quest));
}

void ScriptMgr::OnSendInitialPacketsBeforeAddToMap(Player* player, WorldPacket& data)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SEND_INITIAL_PACKETS_BEFORE_ADD_TO_MAP, {
        script->OnSendInitialPacketsBeforeAddToMap(player, data);
    });
}

void ScriptMgr::OnBattlegroundDesertion(Player* player, BattlegroundDesertionType const desertionType)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BATTLEGROUND_DESERTION, script->OnBattlegroundDesertion(player, desertionType));
}

void ScriptMgr::OnPlayerJustDied(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_JUST_DIED, script->OnPlayerJustDied(player));
}

void ScriptMgr::OnPlayerReleasedGhost(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_RELEASED_GHOST, script->OnPlayerReleasedGhost(player));
}

bool ScriptMgr::OnCanPlayerFlyInZone(Player* player, uint32 mapId, uint32 zoneId, SpellInfo const* bySpell)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_CAN_PLAYER_FLY_IN_ZONE, !script->OnCanPlayerFlyInZone(player, mapId, zoneId, bySpell));
}

void ScriptMgr::OnPVPKill(Player* killer, Player* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PVP_KILL, script->OnPVPKill(killer, killed));
}

void ScriptMgr::OnPlayerPVPFlagChange(Player* player, bool state)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_PVP_FLAG_CHANGE,script->OnPlayerPVPFlagChange(player, state));
}

void ScriptMgr::OnCreatureKill(Player* killer, Creature* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATURE_KILL,script->OnCreatureKill(killer, killed));
}

void ScriptMgr::OnCreatureKilledByPet(Player* petOwner, Creature* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATURE_KILLED_BY_PET,script->OnCreatureKilledByPet(petOwner, killed));
}

void ScriptMgr::OnPlayerKilledByCreature(Creature* killer, Player* killed)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_KILLED_BY_CREATURE, script->OnPlayerKilledByCreature(killer, killed));
}

void ScriptMgr::OnPlayerLevelChanged(Player* player, uint8 oldLevel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LEVEL_CHANGED, script->OnLevelChanged(player, oldLevel));
}

void ScriptMgr::OnPlayerFreeTalentPointsChanged(Player* player, uint32 points)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FREE_TALENT_POINTS_CHANGED, script->OnFreeTalentPointsChanged(player, points));
}

void ScriptMgr::OnPlayerTalentsReset(Player* player, bool noCost)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_TALENTS_RESET, script->OnTalentsReset(player, noCost));
}

void ScriptMgr::OnAfterSpecSlotChanged(Player* player, uint8 newSlot)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_SPEC_SLOT_CHANGED, script->OnAfterSpecSlotChanged(player, newSlot));
}

void ScriptMgr::OnPlayerMoneyChanged(Player* player, int32& amount)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_MONEY_CHANGED, script->OnMoneyChanged(player, amount));
}

void ScriptMgr::OnBeforeLootMoney(Player* player, Loot* loot)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_LOOT_MONEY, script->OnBeforeLootMoney(player, loot));
}

void ScriptMgr::OnGivePlayerXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GIVE_EXP, script->OnGiveXP(player, amount, victim, xpSource));
}

bool ScriptMgr::OnPlayerReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_REPUTATION_CHANGE, !script->OnReputationChange(player, factionID, standing, incremental));
}

void ScriptMgr::OnPlayerReputationRankChange(Player* player, uint32 factionID, ReputationRank newRank, ReputationRank oldRank, bool increased)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_REPUTATION_RANK_CHANGE, script->OnReputationRankChange(player, factionID, newRank, oldRank, increased));
}

void ScriptMgr::OnPlayerLearnSpell(Player* player, uint32 spellID)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_LEARN_TALENTS, script->OnLearnSpell(player, spellID));
}

void ScriptMgr::OnPlayerForgotSpell(Player* player, uint32 spellID)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FORGOT_SPELL, script->OnForgotSpell(player, spellID));
}

void ScriptMgr::OnPlayerDuelRequest(Player* target, Player* challenger)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DUEL_REQUEST, script->OnDuelRequest(target, challenger));
}

void ScriptMgr::OnPlayerDuelStart(Player* player1, Player* player2)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DUEL_START, script->OnDuelStart(player1, player2));
}

void ScriptMgr::OnPlayerDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DUEL_END, script->OnDuelEnd(winner, loser, type));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT, script->OnChat(player, type, lang, msg));
}

void ScriptMgr::OnBeforeSendChatMessage(Player* player, uint32& type, uint32& lang, std::string& msg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_SEND_CHAT_MESSAGE, script->OnBeforeSendChatMessage(player, type, lang, msg));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_RECEIVER, script->OnChat(player, type, lang, msg, receiver));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_GROUP, script->OnChat(player, type, lang, msg, group));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_GUILD, script->OnChat(player, type, lang, msg, guild));
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CHAT_WITH_CHANNEL, script->OnChat(player, type, lang, msg, channel));
}

void ScriptMgr::OnPlayerEmote(Player* player, uint32 emote)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_EMOTE, script->OnEmote(player, emote));
}

void ScriptMgr::OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, ObjectGuid guid)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_TEXT_EMOTE,
        (
         script->OnTextEmote(player, textEmote, emoteNum, guid)
        )
    );
}

void ScriptMgr::OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SPELL_CAST, script->OnSpellCast(player, spell, skipCheck));
}

void ScriptMgr::OnBeforePlayerUpdate(Player* player, uint32 p_time)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_UPDATE, script->OnBeforeUpdate(player, p_time));
}

void ScriptMgr::OnPlayerUpdate(Player* player, uint32 p_time)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_UPDATE, script->OnUpdate(player, p_time));
}

void ScriptMgr::OnPlayerLogin(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOGIN, script->OnLogin(player));
}

void ScriptMgr::OnPlayerLoadFromDB(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOAD_FROM_DB, script->OnLoadFromDB(player));
}

void ScriptMgr::OnBeforePlayerLogout(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_LOGOUT, script->OnBeforeLogout(player));
}

void ScriptMgr::OnPlayerLogout(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOGOUT, script->OnLogout(player));
}

void ScriptMgr::OnPlayerCreate(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATE, script->OnCreate(player));
}

void ScriptMgr::OnPlayerSave(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SAVE, script->OnSave(player));
}

void ScriptMgr::OnPlayerDelete(ObjectGuid guid, uint32 accountId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DELETE, script->OnDelete(guid, accountId));
}

void ScriptMgr::OnPlayerFailedDelete(ObjectGuid guid, uint32 accountId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FAILED_DELETE, script->OnFailedDelete(guid, accountId));
}

void ScriptMgr::OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BIND_TO_INSTANCE, script->OnBindToInstance(player, difficulty, mapid, permanent));
}

void ScriptMgr::OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_ZONE, script->OnUpdateZone(player, newZone, newArea));
}

void ScriptMgr::OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_AREA, script->OnUpdateArea(player, oldArea, newArea));
}

bool ScriptMgr::OnBeforePlayerTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit* target)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_TELEPORT, !script->OnBeforeTeleport(player, mapid, x, y, z, orientation, options, target));
}

void ScriptMgr::OnPlayerUpdateFaction(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_FACTION, script->OnUpdateFaction(player));
}

void ScriptMgr::OnPlayerAddToBattleground(Player* player, Battleground* bg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_ADD_TO_BATTLEGROUND, script->OnAddToBattleground(player, bg));
}

void ScriptMgr::OnPlayerQueueRandomDungeon(Player* player, uint32 & rDungeonId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEUE_RANDOM_DUNGEON, script->OnQueueRandomDungeon(player, rDungeonId));
}

void ScriptMgr::OnPlayerRemoveFromBattleground(Player* player, Battleground* bg)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_REMOVE_FROM_BATTLEGROUND, script->OnRemoveFromBattleground(player, bg));
}

bool ScriptMgr::OnBeforeAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_ACHI_COMPLETE, !script->OnBeforeAchiComplete(player, achievement));
}

void ScriptMgr::OnAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_ACHI_COMPLETE, script->OnAchiComplete(player, achievement));
}

bool ScriptMgr::OnBeforeCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_CRITERIA_PROGRESS, !script->OnBeforeCriteriaProgress(player, criteria));
}

void ScriptMgr::OnCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CRITERIA_PROGRESS, script->OnCriteriaProgress(player, criteria));
}

void ScriptMgr::OnAchievementSave(CharacterDatabaseTransaction trans, Player* player, uint16 achiId, CompletedAchievementData achiData)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_ACHI_SAVE, script->OnAchiSave(trans, player, achiId, achiData));
}

void ScriptMgr::OnCriteriaSave(CharacterDatabaseTransaction trans, Player* player, uint16 critId, CriteriaProgress criteriaData)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CRITERIA_SAVE, script->OnCriteriaSave(trans, player, critId, criteriaData));
}

void ScriptMgr::OnPlayerBeingCharmed(Player* player, Unit* charmer, uint32 oldFactionId, uint32 newFactionId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEING_CHARMED, script->OnBeingCharmed(player, charmer, oldFactionId, newFactionId));
}

void ScriptMgr::OnAfterPlayerSetVisibleItemSlot(Player* player, uint8 slot, Item* item)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_SET_VISIBLE_ITEM_SLOT, script->OnAfterSetVisibleItemSlot(player, slot, item));
}

void ScriptMgr::OnAfterPlayerMoveItemFromInventory(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_MOVE_ITEM_FROM_INVENTORY, script->OnAfterMoveItemFromInventory(player, it, bag, slot, update));
}

void ScriptMgr::OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_EQUIP, script->OnEquip(player, it, bag, slot, update));
}

void ScriptMgr::OnPlayerJoinBG(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_JOIN_BG, script->OnPlayerJoinBG(player));
}

void ScriptMgr::OnPlayerJoinArena(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_JOIN_ARENA, script->OnPlayerJoinArena(player));
}

void ScriptMgr::GetCustomGetArenaTeamId(Player const* player, uint8 slot, uint32& teamID) const
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_GET_CUSTOM_GET_ARENA_TEAM_ID, script->GetCustomGetArenaTeamId(player, slot, teamID));
}

void ScriptMgr::GetCustomArenaPersonalRating(Player const* player, uint8 slot, uint32& rating) const
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_GET_CUSTOM_ARENA_PERSONAL_RATING, script->GetCustomArenaPersonalRating(player, slot, rating));
}

void ScriptMgr::OnGetMaxPersonalArenaRatingRequirement(Player const* player, uint32 minSlot, uint32& maxArenaRating) const
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_MAX_PERSONAL_ARENA_RATING_REQUIREMENT, script->OnGetMaxPersonalArenaRatingRequirement(player, minSlot, maxArenaRating));
}

void ScriptMgr::OnLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_LOOT_ITEM, script->OnLootItem(player, item, count, lootguid));
}

void ScriptMgr::OnBeforeFillQuestLootItem(Player* player, LootItem& item)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_FILL_QUEST_LOOT_ITEM, script->OnBeforeFillQuestLootItem(player, item));
}

void ScriptMgr::OnStoreNewItem(Player* player, Item* item, uint32 count)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_STORE_NEW_ITEM, script->OnStoreNewItem(player, item, count));
}

void ScriptMgr::OnCreateItem(Player* player, Item* item, uint32 count)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CREATE_ITEM, script->OnCreateItem(player, item, count));
}

void ScriptMgr::OnQuestRewardItem(Player* player, Item* item, uint32 count)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEST_REWARD_ITEM, script->OnQuestRewardItem(player, item, count));
}

bool ScriptMgr::CanPlaceAuctionBid(Player* player, AuctionEntry* auction)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLACE_AUCTION_BID, !script->CanPlaceAuctionBid(player, auction));
}

void ScriptMgr::OnGroupRollRewardItem(Player* player, Item* item, uint32 count, RollVote voteType, Roll* roll)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GROUP_ROLL_REWARD_ITEM, script->OnGroupRollRewardItem(player, item, count, voteType, roll));
}

bool ScriptMgr::OnBeforeOpenItem(Player* player, Item* item)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_OPEN_ITEM, !script->OnBeforeOpenItem(player, item));
}

void ScriptMgr::OnFirstLogin(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FIRST_LOGIN, script->OnFirstLogin(player));
}

void ScriptMgr::OnSetMaxLevel(Player* player, uint32& maxPlayerLevel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SET_MAX_LEVEL, script->OnSetMaxLevel(player, maxPlayerLevel));
}

bool ScriptMgr::CanJoinInBattlegroundQueue(Player* player, ObjectGuid BattlemasterGuid, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, GroupJoinBattlegroundResult& err)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_JOIN_IN_BATTLEGROUND_QUEUE, !script->CanJoinInBattlegroundQueue(player, BattlemasterGuid, BGTypeID, joinAsGroup, err));
}

bool ScriptMgr::ShouldBeRewardedWithMoneyInsteadOfExp(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_SHOULD_BE_REWARDED_WITH_MONEY_INSTEAD_OF_EXP, script->ShouldBeRewardedWithMoneyInsteadOfExp(player));
}

void ScriptMgr::OnBeforeTempSummonInitStats(Player* player, TempSummon* tempSummon, uint32& duration)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_TEMP_SUMMON_INIT_STATS, script->OnBeforeTempSummonInitStats(player, tempSummon, duration));
}

void ScriptMgr::OnBeforeGuardianInitStatsForLevel(Player* player, Guardian* guardian, CreatureTemplate const* cinfo, PetType& petType)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_GUARDIAN_INIT_STATS_FOR_LEVEL, script->OnBeforeGuardianInitStatsForLevel(player, guardian, cinfo, petType));
}

void ScriptMgr::OnAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_GUARDIAN_INIT_STATS_FOR_LEVEL, script->OnAfterGuardianInitStatsForLevel(player, guardian));
}

void ScriptMgr::OnBeforeLoadPetFromDB(Player* player, uint32& petentry, uint32& petnumber, bool& current, bool& forceLoadFromDB)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_LOAD_PET_FROM_DB, script->OnBeforeLoadPetFromDB(player, petentry, petnumber, current, forceLoadFromDB));
}

void ScriptMgr::OnBeforeBuyItemFromVendor(Player* player, ObjectGuid vendorguid, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_BUY_ITEM_FROM_VENDOR, script->OnBeforeBuyItemFromVendor(player, vendorguid, vendorslot, item, count, bag, slot));
}

void ScriptMgr::OnAfterStoreOrEquipNewItem(Player* player, uint32 vendorslot, Item* item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_STORE_OR_EQUIP_NEW_ITEM, script->OnAfterStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore));
}

void ScriptMgr::OnAfterUpdateMaxPower(Player* player, Powers& power, float& value)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_UPDATE_MAX_POWER, script->OnAfterUpdateMaxPower(player, power, value));
}

void ScriptMgr::OnAfterUpdateMaxHealth(Player* player, float& value)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_UPDATE_MAX_HEALTH, script->OnAfterUpdateMaxHealth(player, value));
}

void ScriptMgr::OnBeforeUpdateAttackPowerAndDamage(Player* player, float& level, float& val2, bool ranged)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_UPDATE_ATTACK_POWER_AND_DAMAGE, script->OnBeforeUpdateAttackPowerAndDamage(player, level, val2, ranged));
}

void ScriptMgr::OnAfterUpdateAttackPowerAndDamage(Player* player, float& level, float& base_attPower, float& attPowerMod, float& attPowerMultiplier, bool ranged)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_UPDATE_ATTACK_POWER_AND_DAMAGE, script->OnAfterUpdateAttackPowerAndDamage(player, level, base_attPower, attPowerMod, attPowerMultiplier, ranged));
}

void ScriptMgr::OnBeforeInitTalentForLevel(Player* player, uint8& level, uint32& talentPointsForLevel)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_INIT_TALENT_FOR_LEVEL, script->OnBeforeInitTalentForLevel(player, level, talentPointsForLevel));
}

bool ScriptMgr::OnBeforePlayerQuestComplete(Player* player, uint32 quest_id)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_QUEST_COMPLETE, !script->OnBeforeQuestComplete(player, quest_id));
}

void ScriptMgr::OnQuestComputeXP(Player* player, Quest const* quest, uint32& xpValue)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEST_COMPUTE_EXP, script->OnQuestComputeXP(player, quest, xpValue));
}

void ScriptMgr::OnBeforeStoreOrEquipNewItem(Player* player, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_STORE_OR_EQUIP_NEW_ITEM, script->OnBeforeStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore));
}

bool ScriptMgr::CanJoinInArenaQueue(Player* player, ObjectGuid BattlemasterGuid, uint8 arenaslot, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, uint8 IsRated, GroupJoinBattlegroundResult& err)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_JOIN_IN_ARENA_QUEUE, !script->CanJoinInArenaQueue(player, BattlemasterGuid, arenaslot, BGTypeID, joinAsGroup, IsRated, err));
}

bool ScriptMgr::CanBattleFieldPort(Player* player, uint8 arenaType, BattlegroundTypeId BGTypeID, uint8 action)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_BATTLEFIELD_PORT, !script->CanBattleFieldPort(player, arenaType, BGTypeID, action));
}

bool ScriptMgr::CanGroupInvite(Player* player, std::string& membername)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_GROUP_INVITE, !script->CanGroupInvite(player, membername));
}

bool ScriptMgr::CanGroupAccept(Player* player, Group* group)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_GROUP_ACCEPT, !script->CanGroupAccept(player, group));
}

bool ScriptMgr::CanSellItem(Player* player, Item* item, Creature* creature)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SELL_ITEM, !script->CanSellItem(player, item, creature));
}

bool ScriptMgr::CanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 COD, Item* item)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SEND_MAIL, !script->CanSendMail(player, receiverGuid, mailbox, subject, body, money, COD, item));
}

bool ScriptMgr::CanSendErrorAlreadyLooted(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SEND_ERROR_ALREADY_LOOTED, !script->CanSendErrorAlreadyLooted(player));
}

void ScriptMgr::OnAfterCreatureLoot(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_CREATURE_LOOT, script->OnAfterCreatureLoot(player));
}

void ScriptMgr::OnAfterCreatureLootMoney(Player* player)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_AFTER_CREATURE_LOOT_MONEY, script->OnAfterCreatureLootMoney(player));
}

void ScriptMgr::PetitionBuy(Player* player, Creature* creature, uint32& charterid, uint32& cost, uint32& type)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_PETITION_BUY, script->PetitionBuy(player, creature, charterid, cost, type));
}

void ScriptMgr::PetitionShowList(Player* player, Creature* creature, uint32& CharterEntry, uint32& CharterDispayID, uint32& CharterCost)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_PETITION_SHOW_LIST, script->PetitionShowList(player, creature, CharterEntry, CharterDispayID, CharterCost));
}

void ScriptMgr::OnRewardKillRewarder(Player* player, KillRewarder* rewarder, bool isDungeon, float& rate)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_REWARD_KILL_REWARDER, script->OnRewardKillRewarder(player, rewarder, isDungeon, rate));
}

bool ScriptMgr::CanGiveMailRewardAtGiveLevel(Player* player, uint8 level)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_GIVE_MAIL_REWARD_AT_GIVE_LEVEL, !script->CanGiveMailRewardAtGiveLevel(player, level));
}

void ScriptMgr::OnDeleteFromDB(CharacterDatabaseTransaction trans, uint32 guid)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_DELETE_FROM_DB, script->OnDeleteFromDB(trans, guid));
}

bool ScriptMgr::CanRepopAtGraveyard(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_REPOP_AT_GRAVEYARD, !script->CanRepopAtGraveyard(player));
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

void ScriptMgr::OnGetMaxSkillValue(Player* player, uint32 skill, int32& result, bool IsPure)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_MAX_SKILL_VALUE, script->OnGetMaxSkillValue(player, skill, result, IsPure));
}

bool ScriptMgr::OnPlayerHasActivePowerType(Player const* player, Powers power)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_HAS_ACTIVE_POWER_TYPE, !script->OnPlayerHasActivePowerType(player, power));
}

void ScriptMgr::OnUpdateGatheringSkill(Player *player, uint32 skillId, uint32 currentLevel, uint32 gray, uint32 green, uint32 yellow, uint32 &gain) {
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_GATHERING_SKILL, script->OnUpdateGatheringSkill(player, skillId, currentLevel, gray, green, yellow, gain));
}

void ScriptMgr::OnUpdateCraftingSkill(Player *player, SkillLineAbilityEntry const* skill, uint32 currentLevel, uint32& gain) {
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_CRAFTING_SKILL, script->OnUpdateCraftingSkill(player, skill, currentLevel, gain));
}

bool ScriptMgr::OnUpdateFishingSkill(Player* player, int32 skill, int32 zone_skill, int32 chance, int32 roll)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_ON_UPDATE_FISHING_SKILL, !script->OnUpdateFishingSkill(player, skill, zone_skill, chance, roll));
}

bool ScriptMgr::CanAreaExploreAndOutdoor(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_AREA_EXPLORE_AND_OUTDOOR, !script->CanAreaExploreAndOutdoor(player));
}

void ScriptMgr::OnVictimRewardBefore(Player* player, Player* victim, uint32& killer_title, uint32& victim_title)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_VICTIM_REWARD_BEFORE, script->OnVictimRewardBefore(player, victim, killer_title, victim_title));
}

void ScriptMgr::OnVictimRewardAfter(Player* player, Player* victim, uint32& killer_title, uint32& victim_rank, float& honor_f)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_VICTIM_REWARD_AFTER, script->OnVictimRewardAfter(player, victim, killer_title, victim_rank, honor_f));
}

void ScriptMgr::OnCustomScalingStatValueBefore(Player* player, ItemTemplate const* proto, uint8 slot, bool apply, uint32& CustomScalingStatValue)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CUSTOM_SCALING_STAT_VALUE_BEFORE, script->OnCustomScalingStatValueBefore(player, proto, slot, apply, CustomScalingStatValue));
}

void ScriptMgr::OnCustomScalingStatValue(Player* player, ItemTemplate const* proto, uint32& statType, int32& val, uint8 itemProtoStatNumber, uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_CUSTOM_SCALING_STAT_VALUE, script->OnCustomScalingStatValue(player, proto, statType, val, itemProtoStatNumber, ScalingStatValue, ssv));
}

bool ScriptMgr::CanArmorDamageModifier(Player* player)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_ARMOR_DAMAGE_MODIFIER, !script->CanArmorDamageModifier(player));
}

void ScriptMgr::OnGetFeralApBonus(Player* player, int32& feral_bonus, int32 dpsMod, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_FERAL_AP_BONUS, script->OnGetFeralApBonus(player, feral_bonus, dpsMod, proto, ssv));
}

bool ScriptMgr::CanApplyWeaponDependentAuraDamageMod(Player* player, Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_WEAPON_DEPENDENT_AURA_DAMAGE_MOD, !script->CanApplyWeaponDependentAuraDamageMod(player, item, attackType, aura, apply));
}

bool ScriptMgr::CanApplyEquipSpell(Player* player, SpellInfo const* spellInfo, Item* item, bool apply, bool form_change)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_EQUIP_SPELL, !script->CanApplyEquipSpell(player, spellInfo, item, apply, form_change));
}

bool ScriptMgr::CanApplyEquipSpellsItemSet(Player* player, ItemSetEffect* eff)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_EQUIP_SPELLS_ITEM_SET, !script->CanApplyEquipSpellsItemSet(player, eff));
}

bool ScriptMgr::CanCastItemCombatSpell(Player* player, Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_CAST_ITEM_COMBAT_SPELL, !script->CanCastItemCombatSpell(player, target, attType, procVictim, procEx, item, proto));
}

bool ScriptMgr::CanCastItemUseSpell(Player* player, Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_CAST_ITEM_USE_SPELL, !script->CanCastItemUseSpell(player, item, targets, cast_count, glyphIndex));
}

void ScriptMgr::OnApplyAmmoBonuses(Player* player, ItemTemplate const* proto, float& currentAmmoDPS)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_APPLY_AMMO_BONUSES, script->OnApplyAmmoBonuses(player, proto, currentAmmoDPS));
}

bool ScriptMgr::CanEquipItem(Player* player, uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_EQUIP_ITEM, !script->CanEquipItem(player, slot, dest, pItem, swap, not_loading));
}

bool ScriptMgr::CanUnequipItem(Player* player, uint16 pos, bool swap)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_UNEQUIP_ITEM, !script->CanUnequipItem(player, pos, swap));
}

bool ScriptMgr::CanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_USE_ITEM, !script->CanUseItem(player, proto, result));
}

bool ScriptMgr::CanSaveEquipNewItem(Player* player, Item* item, uint16 pos, bool update)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SAVE_EQUIP_NEW_ITEM, !script->CanSaveEquipNewItem(player, item, pos, update));
}

bool ScriptMgr::CanApplyEnchantment(Player* player, Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_APPLY_ENCHANTMENT, !script->CanApplyEnchantment(player, item, slot, apply, apply_dur, ignore_condition));
}

void ScriptMgr::OnGetQuestRate(Player* player, float& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_QUEST_RATE, script->OnGetQuestRate(player, result));
}

bool ScriptMgr::PassedQuestKilledMonsterCredit(Player* player, Quest const* qinfo, uint32 entry, uint32 real_entry, ObjectGuid guid)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_PASSED_QUEST_KILLED_MONSTER_CREDIT, !script->PassedQuestKilledMonsterCredit(player, qinfo, entry, real_entry, guid));
}

bool ScriptMgr::CheckItemInSlotAtLoadInventory(Player* player, Item* item, uint8 slot, uint8& err, uint16& dest)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CHECK_ITEM_IN_SLOT_AT_LOAD_INVENTORY, !script->CheckItemInSlotAtLoadInventory(player, item, slot, err, dest));
}

bool ScriptMgr::NotAvoidSatisfy(Player* player, DungeonProgressionRequirements const* ar, uint32 target_map, bool report)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_NOT_AVOID_SATISFY, !script->NotAvoidSatisfy(player, ar, target_map, report));
}

bool ScriptMgr::NotVisibleGloballyFor(Player* player, Player const* u)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_NOT_VISIBLE_GLOBALLY_FOR, !script->NotVisibleGloballyFor(player, u));
}

void ScriptMgr::OnGetArenaPersonalRating(Player* player, uint8 slot, uint32& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_ARENA_PERSONAL_RATING, script->OnGetArenaPersonalRating(player, slot, result));
}

void ScriptMgr::OnGetArenaTeamId(Player* player, uint8 slot, uint32& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_ARENA_TEAM_ID, script->OnGetArenaTeamId(player, slot, result));
}

void ScriptMgr::OnIsFFAPvP(Player* player, bool& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_IS_FFA_PVP, script->OnIsFFAPvP(player, result));
}

void ScriptMgr::OnFfaPvpStateUpdate(Player* player, bool result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_FFA_PVP_STATE_UPDATE, script->OnFfaPvpStateUpdate(player, result));
}

void ScriptMgr::OnIsPvP(Player* player, bool& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_IS_PVP, {
        script->OnIsPvP(player, result);
    });
}

void ScriptMgr::OnGetMaxSkillValueForLevel(Player* player, uint16& result)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_GET_MAX_SKILL_VALUE_FOR_LEVEL, {
        script->OnGetMaxSkillValueForLevel(player, result);
    });
}

bool ScriptMgr::NotSetArenaTeamInfoField(Player* player, uint8 slot, ArenaTeamInfoType type, uint32 value)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_NOT_SET_ARENA_TEAM_INFO_FIELD, !script->NotSetArenaTeamInfoField(player, slot, type, value));
}

bool ScriptMgr::CanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_JOIN_LFG, !script->CanJoinLfg(player, roles, dungeons, comment));
}

bool ScriptMgr::CanEnterMap(Player* player, MapEntry const* entry, InstanceTemplate const* instance, MapDifficulty const* mapDiff, bool loginCheck)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_ENTER_MAP, !script->CanEnterMap(player, entry, instance, mapDiff, loginCheck));
}

bool ScriptMgr::CanInitTrade(Player* player, Player* target)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_INIT_TRADE, !script->CanInitTrade(player, target));
}

bool ScriptMgr::CanSetTradeItem(Player* player, Item* tradedItem, uint8 tradeSlot)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_SET_TRADE_ITEM, !script->CanSetTradeItem(player, tradedItem, tradeSlot));
}

void ScriptMgr::OnSetServerSideVisibility(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SET_SERVER_SIDE_VISIBILITY, script->OnSetServerSideVisibility(player, type, sec));
}

void ScriptMgr::OnSetServerSideVisibilityDetect(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_SET_SERVER_SIDE_VISIBILITY_DETECT, script->OnSetServerSideVisibilityDetect(player, type, sec));
}

void ScriptMgr::OnPlayerResurrect(Player* player, float restore_percent, bool applySickness)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_PLAYER_RESURRECT, script->OnPlayerResurrect(player, restore_percent, applySickness));
}

void ScriptMgr::OnBeforeChooseGraveyard(Player* player, TeamId teamId, bool nearCorpse, uint32& graveyardOverride)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_BEFORE_CHOOSE_GRAVEYARD, script->OnBeforeChooseGraveyard(player, teamId, nearCorpse, graveyardOverride));
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_CHAT, !script->CanPlayerUseChat(player, type, language, msg));
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Player* receiver)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_PRIVATE_CHAT, !script->CanPlayerUseChat(player, type, language, msg, receiver));
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Group* group)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_GROUP_CHAT, !script->CanPlayerUseChat(player, type, language, msg, group));
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Guild* guild)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_GUILD_CHAT, !script->CanPlayerUseChat(player, type, language, msg, guild));
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Channel* channel)
{
    CALL_ENABLED_BOOLEAN_HOOKS(PlayerScript, PLAYERHOOK_CAN_PLAYER_USE_CHANNEL_CHAT, !script->CanPlayerUseChat(player, type, language, msg, channel));
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

void ScriptMgr::OnQuestAbandon(Player* player, uint32 questId)
{
    CALL_ENABLED_HOOKS(PlayerScript, PLAYERHOOK_ON_QUEST_ABANDON, script->OnQuestAbandon(player, questId));
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

PlayerScript::PlayerScript(const char* name, std::vector<uint16> enabledHooks)
    : ScriptObject(name, PLAYERHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < PLAYERHOOK_END; i++)
            enabledHooks.emplace_back(i);

    ScriptRegistry<PlayerScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<PlayerScript>;
