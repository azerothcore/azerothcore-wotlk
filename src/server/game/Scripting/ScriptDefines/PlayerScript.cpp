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
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeDurabilityRepair(player, npcGUID, itemGUID, discountMod, guildBank);
    });
}

void ScriptMgr::OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGossipSelect(player, menu_id, sender, action);
    });
}

void ScriptMgr::OnGossipSelectCode(Player* player, uint32 menu_id, uint32 sender, uint32 action, const char* code)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGossipSelectCode(player, menu_id, sender, action, code);
    });
}

void ScriptMgr::OnPlayerCompleteQuest(Player* player, Quest const* quest)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerCompleteQuest(player, quest);
    });
}

void ScriptMgr::OnSendInitialPacketsBeforeAddToMap(Player* player, WorldPacket& data)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSendInitialPacketsBeforeAddToMap(player, data);
    });
}

void ScriptMgr::OnBattlegroundDesertion(Player* player, BattlegroundDesertionType const desertionType)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBattlegroundDesertion(player, desertionType);
    });
}

void ScriptMgr::OnPlayerJustDied(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerJustDied(player);
    });
}

void ScriptMgr::OnPlayerReleasedGhost(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerReleasedGhost(player);
    });
}

bool ScriptMgr::OnCanPlayerFlyInZone(Player* player, uint32 mapId, uint32 zoneId, SpellInfo const* bySpell)
{
    auto ret = IsValidBoolScript<PlayerScript>([player, mapId, zoneId, bySpell](PlayerScript* script)
        {
            return !script->OnCanPlayerFlyInZone(player, mapId, zoneId, bySpell);
        });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPVPKill(Player* killer, Player* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPVPKill(killer, killed);
    });
}

void ScriptMgr::OnPlayerPVPFlagChange(Player* player, bool state)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerPVPFlagChange(player, state);
    });
}

void ScriptMgr::OnCreatureKill(Player* killer, Creature* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreatureKill(killer, killed);
    });
}

void ScriptMgr::OnCreatureKilledByPet(Player* petOwner, Creature* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreatureKilledByPet(petOwner, killed);
    });
}

void ScriptMgr::OnPlayerKilledByCreature(Creature* killer, Player* killed)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerKilledByCreature(killer, killed);
    });
}

void ScriptMgr::OnPlayerLevelChanged(Player* player, uint8 oldLevel)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLevelChanged(player, oldLevel);
    });
}

void ScriptMgr::OnPlayerFreeTalentPointsChanged(Player* player, uint32 points)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnFreeTalentPointsChanged(player, points);
    });
}

void ScriptMgr::OnPlayerTalentsReset(Player* player, bool noCost)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnTalentsReset(player, noCost);
    });
}

void ScriptMgr::OnAfterSpecSlotChanged(Player* player, uint8 newSlot)
{
    ExecuteScript<PlayerScript>([=](PlayerScript* script)
    {
        script->OnAfterSpecSlotChanged(player, newSlot);
    });
}

void ScriptMgr::OnPlayerMoneyChanged(Player* player, int32& amount)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnMoneyChanged(player, amount);
    });
}

void ScriptMgr::OnBeforeLootMoney(Player* player, Loot* loot)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeLootMoney(player, loot);
    });
}

void ScriptMgr::OnGivePlayerXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGiveXP(player, amount, victim, xpSource);
    });
}

bool ScriptMgr::OnPlayerReputationChange(Player* player, uint32 factionID, int32& standing, bool incremental)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
        {
            return !script->OnReputationChange(player, factionID, standing, incremental);
        });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerReputationRankChange(Player* player, uint32 factionID, ReputationRank newRank, ReputationRank oldRank, bool increased)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnReputationRankChange(player, factionID, newRank, oldRank, increased);
    });
}

void ScriptMgr::OnPlayerLearnSpell(Player* player, uint32 spellID)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLearnSpell(player, spellID);
    });
}

void ScriptMgr::OnPlayerForgotSpell(Player* player, uint32 spellID)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnForgotSpell(player, spellID);
    });
}

void ScriptMgr::OnPlayerDuelRequest(Player* target, Player* challenger)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDuelRequest(target, challenger);
    });
}

void ScriptMgr::OnPlayerDuelStart(Player* player1, Player* player2)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDuelStart(player1, player2);
    });
}

void ScriptMgr::OnPlayerDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDuelEnd(winner, loser, type);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg);
    });
}

void ScriptMgr::OnBeforeSendChatMessage(Player* player, uint32& type, uint32& lang, std::string& msg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeSendChatMessage(player, type, lang, msg);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Player* receiver)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, receiver);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Group* group)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, group);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Guild* guild)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, guild);
    });
}

void ScriptMgr::OnPlayerChat(Player* player, uint32 type, uint32 lang, std::string& msg, Channel* channel)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnChat(player, type, lang, msg, channel);
    });
}

void ScriptMgr::OnPlayerEmote(Player* player, uint32 emote)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnEmote(player, emote);
    });
}

void ScriptMgr::OnPlayerTextEmote(Player* player, uint32 textEmote, uint32 emoteNum, ObjectGuid guid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnTextEmote(player, textEmote, emoteNum, guid);
    });
}

void ScriptMgr::OnPlayerSpellCast(Player* player, Spell* spell, bool skipCheck)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSpellCast(player, spell, skipCheck);
    });
}

void ScriptMgr::OnBeforePlayerUpdate(Player* player, uint32 p_time)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeUpdate(player, p_time);
    });
}

void ScriptMgr::OnPlayerUpdate(Player* player, uint32 p_time)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdate(player, p_time);
    });
}

void ScriptMgr::OnPlayerLogin(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLogin(player);
    });
}

void ScriptMgr::OnPlayerLoadFromDB(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLoadFromDB(player);
    });
}

void ScriptMgr::OnBeforePlayerLogout(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
        {
            script->OnBeforeLogout(player);
        });
}

void ScriptMgr::OnPlayerLogout(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLogout(player);
    });
}

void ScriptMgr::OnPlayerCreate(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreate(player);
    });
}

void ScriptMgr::OnPlayerSave(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSave(player);
    });
}

void ScriptMgr::OnPlayerDelete(ObjectGuid guid, uint32 accountId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDelete(guid, accountId);
    });
}

void ScriptMgr::OnPlayerFailedDelete(ObjectGuid guid, uint32 accountId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnFailedDelete(guid, accountId);
    });
}

void ScriptMgr::OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapid, bool permanent)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBindToInstance(player, difficulty, mapid, permanent);
    });
}

void ScriptMgr::OnPlayerUpdateZone(Player* player, uint32 newZone, uint32 newArea)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateZone(player, newZone, newArea);
    });
}

void ScriptMgr::OnPlayerUpdateArea(Player* player, uint32 oldArea, uint32 newArea)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateArea(player, oldArea, newArea);
    });
}

bool ScriptMgr::OnBeforePlayerTeleport(Player* player, uint32 mapid, float x, float y, float z, float orientation, uint32 options, Unit* target)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeTeleport(player, mapid, x, y, z, orientation, options, target);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerUpdateFaction(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateFaction(player);
    });
}

void ScriptMgr::OnPlayerAddToBattleground(Player* player, Battleground* bg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAddToBattleground(player, bg);
    });
}

void ScriptMgr::OnPlayerQueueRandomDungeon(Player* player, uint32 & rDungeonId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnQueueRandomDungeon(player, rDungeonId);
    });
}

void ScriptMgr::OnPlayerRemoveFromBattleground(Player* player, Battleground* bg)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnRemoveFromBattleground(player, bg);
    });
}

bool ScriptMgr::OnBeforeAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeAchiComplete(player, achievement);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnAchievementComplete(Player* player, AchievementEntry const* achievement)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAchiComplete(player, achievement);
    });
}

bool ScriptMgr::OnBeforeCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeCriteriaProgress(player, criteria);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnCriteriaProgress(Player* player, AchievementCriteriaEntry const* criteria)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCriteriaProgress(player, criteria);
    });
}

void ScriptMgr::OnAchievementSave(CharacterDatabaseTransaction trans, Player* player, uint16 achiId, CompletedAchievementData achiData)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAchiSave(trans, player, achiId, achiData);
    });
}

void ScriptMgr::OnCriteriaSave(CharacterDatabaseTransaction trans, Player* player, uint16 critId, CriteriaProgress criteriaData)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCriteriaSave(trans, player, critId, criteriaData);
    });
}

void ScriptMgr::OnPlayerBeingCharmed(Player* player, Unit* charmer, uint32 oldFactionId, uint32 newFactionId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeingCharmed(player, charmer, oldFactionId, newFactionId);
    });
}

void ScriptMgr::OnAfterPlayerSetVisibleItemSlot(Player* player, uint8 slot, Item* item)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterSetVisibleItemSlot(player, slot, item);
    });
}

void ScriptMgr::OnAfterPlayerMoveItemFromInventory(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterMoveItemFromInventory(player, it, bag, slot, update);
    });
}

void ScriptMgr::OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool update)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnEquip(player, it, bag, slot, update);
    });
}

void ScriptMgr::OnPlayerJoinBG(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerJoinBG(player);
    });
}

void ScriptMgr::OnPlayerJoinArena(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerJoinArena(player);
    });
}

void ScriptMgr::GetCustomGetArenaTeamId(Player const* player, uint8 slot, uint32& teamID) const
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->GetCustomGetArenaTeamId(player, slot, teamID);
    });
}

void ScriptMgr::GetCustomArenaPersonalRating(Player const* player, uint8 slot, uint32& rating) const
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->GetCustomArenaPersonalRating(player, slot, rating);
    });
}

void ScriptMgr::OnGetMaxPersonalArenaRatingRequirement(Player const* player, uint32 minSlot, uint32& maxArenaRating) const
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetMaxPersonalArenaRatingRequirement(player, minSlot, maxArenaRating);
    });
}

void ScriptMgr::OnLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnLootItem(player, item, count, lootguid);
    });
}

void ScriptMgr::OnBeforeFillQuestLootItem(Player* player, LootItem& item)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeFillQuestLootItem(player, item);
    });
}

void ScriptMgr::OnStoreNewItem(Player* player, Item* item, uint32 count)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnStoreNewItem(player, item, count);
    });
}

void ScriptMgr::OnCreateItem(Player* player, Item* item, uint32 count)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCreateItem(player, item, count);
    });
}

void ScriptMgr::OnQuestRewardItem(Player* player, Item* item, uint32 count)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnQuestRewardItem(player, item, count);
    });
}

bool ScriptMgr::CanPlaceAuctionBid(Player* player, AuctionEntry* auction)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript *script)
    {
       return !script->CanPlaceAuctionBid(player, auction);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGroupRollRewardItem(Player* player, Item* item, uint32 count, RollVote voteType, Roll* roll)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGroupRollRewardItem(player, item, count, voteType, roll);
    });
}

bool ScriptMgr::OnBeforeOpenItem(Player* player, Item* item)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
        {
            return !script->OnBeforeOpenItem(player, item);
        });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnFirstLogin(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnFirstLogin(player);
    });
}

void ScriptMgr::OnSetMaxLevel(Player* player, uint32& maxPlayerLevel)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSetMaxLevel(player, maxPlayerLevel);
    });
}

bool ScriptMgr::CanJoinInBattlegroundQueue(Player* player, ObjectGuid BattlemasterGuid, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, GroupJoinBattlegroundResult& err)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanJoinInBattlegroundQueue(player, BattlemasterGuid, BGTypeID, joinAsGroup, err);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::ShouldBeRewardedWithMoneyInsteadOfExp(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return script->ShouldBeRewardedWithMoneyInsteadOfExp(player);
    });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

void ScriptMgr::OnBeforeTempSummonInitStats(Player* player, TempSummon* tempSummon, uint32& duration)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeTempSummonInitStats(player, tempSummon, duration);
    });
}

void ScriptMgr::OnBeforeGuardianInitStatsForLevel(Player* player, Guardian* guardian, CreatureTemplate const* cinfo, PetType& petType)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeGuardianInitStatsForLevel(player, guardian, cinfo, petType);
    });
}

void ScriptMgr::OnAfterGuardianInitStatsForLevel(Player* player, Guardian* guardian)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterGuardianInitStatsForLevel(player, guardian);
    });
}

void ScriptMgr::OnBeforeLoadPetFromDB(Player* player, uint32& petentry, uint32& petnumber, bool& current, bool& forceLoadFromDB)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeLoadPetFromDB(player, petentry, petnumber, current, forceLoadFromDB);
    });
}

void ScriptMgr::OnBeforeBuyItemFromVendor(Player* player, ObjectGuid vendorguid, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeBuyItemFromVendor(player, vendorguid, vendorslot, item, count, bag, slot);
    });
}

void ScriptMgr::OnAfterStoreOrEquipNewItem(Player* player, uint32 vendorslot, Item* item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore);
    });
}

void ScriptMgr::OnAfterUpdateMaxPower(Player* player, Powers& power, float& value)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterUpdateMaxPower(player, power, value);
    });
}

void ScriptMgr::OnAfterUpdateMaxHealth(Player* player, float& value)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterUpdateMaxHealth(player, value);
    });
}

void ScriptMgr::OnBeforeUpdateAttackPowerAndDamage(Player* player, float& level, float& val2, bool ranged)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeUpdateAttackPowerAndDamage(player, level, val2, ranged);
    });
}

void ScriptMgr::OnAfterUpdateAttackPowerAndDamage(Player* player, float& level, float& base_attPower, float& attPowerMod, float& attPowerMultiplier, bool ranged)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterUpdateAttackPowerAndDamage(player, level, base_attPower, attPowerMod, attPowerMultiplier, ranged);
    });
}

void ScriptMgr::OnBeforeInitTalentForLevel(Player* player, uint8& level, uint32& talentPointsForLevel)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeInitTalentForLevel(player, level, talentPointsForLevel);
    });
}
bool ScriptMgr::OnBeforePlayerQuestComplete(Player* player, uint32 quest_id)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnBeforeQuestComplete(player, quest_id);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}
void ScriptMgr::OnQuestComputeXP(Player* player, Quest const* quest, uint32& xpValue)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnQuestComputeXP(player, quest, xpValue);
    });
}

void ScriptMgr::OnBeforeStoreOrEquipNewItem(Player* player, uint32 vendorslot, uint32& item, uint8 count, uint8 bag, uint8 slot, ItemTemplate const* pProto, Creature* pVendor, VendorItem const* crItem, bool bStore)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeStoreOrEquipNewItem(player, vendorslot, item, count, bag, slot, pProto, pVendor, crItem, bStore);
    });
}

bool ScriptMgr::CanJoinInArenaQueue(Player* player, ObjectGuid BattlemasterGuid, uint8 arenaslot, BattlegroundTypeId BGTypeID, uint8 joinAsGroup, uint8 IsRated, GroupJoinBattlegroundResult& err)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanJoinInArenaQueue(player, BattlemasterGuid, arenaslot, BGTypeID, joinAsGroup, IsRated, err);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanBattleFieldPort(Player* player, uint8 arenaType, BattlegroundTypeId BGTypeID, uint8 action)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanBattleFieldPort(player, arenaType, BGTypeID, action);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanGroupInvite(Player* player, std::string& membername)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanGroupInvite(player, membername);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanGroupAccept(Player* player, Group* group)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanGroupAccept(player, group);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSellItem(Player* player, Item* item, Creature* creature)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanSellItem(player, item, creature);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 COD, Item* item)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanSendMail(player, receiverGuid, mailbox, subject, body, money, COD, item);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSendErrorAlreadyLooted(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanSendErrorAlreadyLooted(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnAfterCreatureLoot(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterCreatureLoot(player);
    });
}

void ScriptMgr::OnAfterCreatureLootMoney(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnAfterCreatureLootMoney(player);
    });
}

void ScriptMgr::PetitionBuy(Player* player, Creature* creature, uint32& charterid, uint32& cost, uint32& type)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->PetitionBuy(player, creature, charterid, cost, type);
    });
}

void ScriptMgr::PetitionShowList(Player* player, Creature* creature, uint32& CharterEntry, uint32& CharterDispayID, uint32& CharterCost)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->PetitionShowList(player, creature, CharterEntry, CharterDispayID, CharterCost);
    });
}

void ScriptMgr::OnRewardKillRewarder(Player* player, KillRewarder* rewarder, bool isDungeon, float& rate)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnRewardKillRewarder(player, rewarder, isDungeon, rate);
    });
}

bool ScriptMgr::CanGiveMailRewardAtGiveLevel(Player* player, uint8 level)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanGiveMailRewardAtGiveLevel(player, level);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnDeleteFromDB(CharacterDatabaseTransaction trans, uint32 guid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnDeleteFromDB(trans, guid);
    });
}

bool ScriptMgr::CanRepopAtGraveyard(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanRepopAtGraveyard(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

Optional<bool> ScriptMgr::OnPlayerIsClass(Player const* player, Classes unitClass, ClassContext context)
{
    if (ScriptRegistry<PlayerScript>::ScriptPointerList.empty())
        return {};
    for (auto const& [scriptID, script] : ScriptRegistry<PlayerScript>::ScriptPointerList)
    {
        Optional<bool> scriptResult = script->OnPlayerIsClass(player, unitClass, context);
        if (scriptResult)
            return scriptResult;
    }
    return {};
}

void ScriptMgr::OnGetMaxSkillValue(Player* player, uint32 skill, int32& result, bool IsPure)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetMaxSkillValue(player, skill, result, IsPure);
    });
}

bool ScriptMgr::OnPlayerHasActivePowerType(Player const* player, Powers power)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
        {
            return script->OnPlayerHasActivePowerType(player, power);
        });

    if (ret && *ret)
    {
        return true;
    }

    return false;
}

void ScriptMgr::OnUpdateGatheringSkill(Player *player, uint32 skillId, uint32 currentLevel, uint32 gray, uint32 green, uint32 yellow, uint32 &gain) {
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateGatheringSkill(player, skillId, currentLevel, gray, green, yellow, gain);
    });
}

void ScriptMgr::OnUpdateCraftingSkill(Player *player, SkillLineAbilityEntry const* skill, uint32 currentLevel, uint32& gain) {
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnUpdateCraftingSkill(player, skill, currentLevel, gain);
    });
}

bool ScriptMgr::OnUpdateFishingSkill(Player* player, int32 skill, int32 zone_skill, int32 chance, int32 roll)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->OnUpdateFishingSkill(player, skill, zone_skill, chance, roll);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanAreaExploreAndOutdoor(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanAreaExploreAndOutdoor(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnVictimRewardBefore(Player* player, Player* victim, uint32& killer_title, uint32& victim_title)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnVictimRewardBefore(player, victim, killer_title, victim_title);
    });
}

void ScriptMgr::OnVictimRewardAfter(Player* player, Player* victim, uint32& killer_title, uint32& victim_rank, float& honor_f)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnVictimRewardAfter(player, victim, killer_title, victim_rank, honor_f);
    });
}

void ScriptMgr::OnCustomScalingStatValueBefore(Player* player, ItemTemplate const* proto, uint8 slot, bool apply, uint32& CustomScalingStatValue)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCustomScalingStatValueBefore(player, proto, slot, apply, CustomScalingStatValue);
    });
}

void ScriptMgr::OnCustomScalingStatValue(Player* player, ItemTemplate const* proto, uint32& statType, int32& val, uint8 itemProtoStatNumber, uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnCustomScalingStatValue(player, proto, statType, val, itemProtoStatNumber, ScalingStatValue, ssv);
    });
}

bool ScriptMgr::CanArmorDamageModifier(Player* player)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanArmorDamageModifier(player);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetFeralApBonus(Player* player, int32& feral_bonus, int32 dpsMod, ItemTemplate const* proto, ScalingStatValuesEntry const* ssv)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetFeralApBonus(player, feral_bonus, dpsMod, proto, ssv);
    });
}

bool ScriptMgr::CanApplyWeaponDependentAuraDamageMod(Player* player, Item* item, WeaponAttackType attackType, AuraEffect const* aura, bool apply)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyWeaponDependentAuraDamageMod(player, item, attackType, aura, apply);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanApplyEquipSpell(Player* player, SpellInfo const* spellInfo, Item* item, bool apply, bool form_change)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyEquipSpell(player, spellInfo, item, apply, form_change);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanApplyEquipSpellsItemSet(Player* player, ItemSetEffect* eff)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyEquipSpellsItemSet(player, eff);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanCastItemCombatSpell(Player* player, Unit* target, WeaponAttackType attType, uint32 procVictim, uint32 procEx, Item* item, ItemTemplate const* proto)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanCastItemCombatSpell(player, target, attType, procVictim, procEx, item, proto);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanCastItemUseSpell(Player* player, Item* item, SpellCastTargets const& targets, uint8 cast_count, uint32 glyphIndex)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanCastItemUseSpell(player, item, targets, cast_count, glyphIndex);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnApplyAmmoBonuses(Player* player, ItemTemplate const* proto, float& currentAmmoDPS)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnApplyAmmoBonuses(player, proto, currentAmmoDPS);
    });
}

bool ScriptMgr::CanEquipItem(Player* player, uint8 slot, uint16& dest, Item* pItem, bool swap, bool not_loading)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanEquipItem(player, slot, dest, pItem, swap, not_loading);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanUnequipItem(Player* player, uint16 pos, bool swap)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanUnequipItem(player, pos, swap);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& result)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanUseItem(player, proto, result);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSaveEquipNewItem(Player* player, Item* item, uint16 pos, bool update)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanSaveEquipNewItem(player, item, pos, update);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanApplyEnchantment(Player* player, Item* item, EnchantmentSlot slot, bool apply, bool apply_dur, bool ignore_condition)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanApplyEnchantment(player, item, slot, apply, apply_dur, ignore_condition);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetQuestRate(Player* player, float& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetQuestRate(player, result);
    });
}

bool ScriptMgr::PassedQuestKilledMonsterCredit(Player* player, Quest const* qinfo, uint32 entry, uint32 real_entry, ObjectGuid guid)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->PassedQuestKilledMonsterCredit(player, qinfo, entry, real_entry, guid);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CheckItemInSlotAtLoadInventory(Player* player, Item* item, uint8 slot, uint8& err, uint16& dest)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CheckItemInSlotAtLoadInventory(player, item, slot, err, dest);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::NotAvoidSatisfy(Player* player, DungeonProgressionRequirements const* ar, uint32 target_map, bool report)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->NotAvoidSatisfy(player, ar, target_map, report);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::NotVisibleGloballyFor(Player* player, Player const* u)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->NotVisibleGloballyFor(player, u);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnGetArenaPersonalRating(Player* player, uint8 slot, uint32& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetArenaPersonalRating(player, slot, result);
    });
}

void ScriptMgr::OnGetArenaTeamId(Player* player, uint8 slot, uint32& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetArenaTeamId(player, slot, result);
    });
}

//Signifies that IsFfaPvp has been called.
void ScriptMgr::OnIsFFAPvP(Player* player, bool& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnIsFFAPvP(player, result);
    });
}
//Fires whenever the UNIT_BYTE2_FLAG_FFA_PVP bit is Changed
void ScriptMgr::OnFfaPvpStateUpdate(Player* player, bool result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
        {
            script->OnFfaPvpStateUpdate(player, result);
        });
}

void ScriptMgr::OnIsPvP(Player* player, bool& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnIsPvP(player, result);
    });
}

void ScriptMgr::OnGetMaxSkillValueForLevel(Player* player, uint16& result)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnGetMaxSkillValueForLevel(player, result);
    });
}

bool ScriptMgr::NotSetArenaTeamInfoField(Player* player, uint8 slot, ArenaTeamInfoType type, uint32 value)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->NotSetArenaTeamInfoField(player, slot, type, value);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanJoinLfg(player, roles, dungeons, comment);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanEnterMap(Player* player, MapEntry const* entry, InstanceTemplate const* instance, MapDifficulty const* mapDiff, bool loginCheck)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanEnterMap(player, entry, instance, mapDiff, loginCheck);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanInitTrade(Player* player, Player* target)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanInitTrade(player, target);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanSetTradeItem(Player* player, Item* tradedItem, uint8 tradeSlot)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
        {
            return !script->CanSetTradeItem(player, tradedItem, tradeSlot);
        });

    if (ret && *ret)
        return false;

    return true;
}

void ScriptMgr::OnSetServerSideVisibility(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSetServerSideVisibility(player, type, sec);
    });
}

void ScriptMgr::OnSetServerSideVisibilityDetect(Player* player, ServerSideVisibilityType& type, AccountTypes& sec)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnSetServerSideVisibilityDetect(player, type, sec);
    });
}

//void ScriptMgr::OnGiveHonorPoints(Player* player, float& honor, Unit* victim)
//{
//    ExecuteScript<PlayerScript>([&](PlayerScript* script)
//    {
//        script->OnGiveHonorPoints(player, honor, victim);
//    });
//}
//
//void ScriptMgr::OnAfterResurrect(Player* player, float restore_percent, bool applySickness)
//{
//    ExecuteScript<PlayerScript>([&](PlayerScript* script)
//    {
//        script->OnAfterResurrect(player, restore_percent, applySickness);
//    });
//}

void ScriptMgr::OnPlayerResurrect(Player* player, float restore_percent, bool applySickness)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerResurrect(player, restore_percent, applySickness);
    });
}

void ScriptMgr::OnBeforeChooseGraveyard(Player* player, TeamId teamId, bool nearCorpse, uint32& graveyardOverride)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnBeforeChooseGraveyard(player, teamId, nearCorpse, graveyardOverride);
    });
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Player* receiver)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, receiver);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Group* group)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, group);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Guild* guild)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, guild);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::CanPlayerUseChat(Player* player, uint32 type, uint32 language, std::string& msg, Channel* channel)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->CanPlayerUseChat(player, type, language, msg, channel);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

void ScriptMgr::OnPlayerLearnTalents(Player* player, uint32 talentId, uint32 talentRank, uint32 spellid)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerLearnTalents(player, talentId, talentRank, spellid);
    });
}

void ScriptMgr::OnPlayerEnterCombat(Player* player, Unit* enemy)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerEnterCombat(player, enemy);
    });
}

void ScriptMgr::OnPlayerLeaveCombat(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnPlayerLeaveCombat(player);
    });
}

void ScriptMgr::OnQuestAbandon(Player* player, uint32 questId)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->OnQuestAbandon(player, questId);
    });
}

// Player anti cheat
void ScriptMgr::AnticheatSetCanFlybyServer(Player* player, bool apply)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetCanFlybyServer(player, apply);
    });
}

void ScriptMgr::AnticheatSetUnderACKmount(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetUnderACKmount(player);
    });
}

void ScriptMgr::AnticheatSetRootACKUpd(Player* player)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetRootACKUpd(player);
    });
}

void ScriptMgr::AnticheatSetJumpingbyOpcode(Player* player, bool jump)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatSetJumpingbyOpcode(player, jump);
    });
}

void ScriptMgr::AnticheatUpdateMovementInfo(Player* player, MovementInfo const& movementInfo)
{
    ExecuteScript<PlayerScript>([&](PlayerScript* script)
    {
        script->AnticheatUpdateMovementInfo(player, movementInfo);
    });
}

bool ScriptMgr::AnticheatHandleDoubleJump(Player* player, Unit* mover)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->AnticheatHandleDoubleJump(player, mover);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

bool ScriptMgr::AnticheatCheckMovementInfo(Player* player, MovementInfo const& movementInfo, Unit* mover, bool jump)
{
    auto ret = IsValidBoolScript<PlayerScript>([&](PlayerScript* script)
    {
        return !script->AnticheatCheckMovementInfo(player, movementInfo, mover, jump);
    });

    if (ret && *ret)
    {
        return false;
    }

    return true;
}

PlayerScript::PlayerScript(const char* name)
    : ScriptObject(name)
{
    ScriptRegistry<PlayerScript>::AddScript(this);
}

template class AC_GAME_API ScriptRegistry<PlayerScript>;
