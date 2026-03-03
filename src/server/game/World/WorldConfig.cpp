/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Player.h"
#include "WorldConfig.h"

void WorldConfig::BuildConfigCache()
{
    SetConfigValue<bool>(CONFIG_ALLOW_TICKETS, "AllowTickets", true);
    SetConfigValue<bool>(CONFIG_DELETE_CHARACTER_TICKET_TRACE, "DeletedCharacterTicketTrace", false);

    ///- Send server info on login?
    SetConfigValue<uint32>(CONFIG_ENABLE_SINFO_LOGIN, "Server.LoginInfo", 0);

    ///- Read all rates from the config file
    SetConfigValue<float>(RATE_HEALTH, "Rate.Health", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value > 0.0f; }, "> 0");
    SetConfigValue<float>(RATE_POWER_MANA, "Rate.Mana", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value > 0.0f; }, "> 0");
    SetConfigValue<float>(RATE_POWER_RAGE_INCOME, "Rate.Rage.Income", 1.0f);
    SetConfigValue<float>(RATE_POWER_RAGE_LOSS, "Rate.Rage.Loss", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value > 0.0f; }, "> 0");
    SetConfigValue<float>(RATE_POWER_RUNICPOWER_INCOME, "Rate.RunicPower.Income", 1.0f);
    SetConfigValue<float>(RATE_POWER_RUNICPOWER_LOSS, "Rate.RunicPower.Loss", 1, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value > 0.0f; }, "> 0");
    SetConfigValue<float>(RATE_POWER_FOCUS, "Rate.Focus", 1.0f);
    SetConfigValue<float>(RATE_POWER_ENERGY, "Rate.Energy", 1.0f);

    SetConfigValue<float>(RATE_SKILL_DISCOVERY, "Rate.Skill.Discovery", 1.0f);

    SetConfigValue<float>(RATE_DROP_ITEM_POOR, "Rate.Drop.Item.Poor", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_NORMAL, "Rate.Drop.Item.Normal", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_UNCOMMON, "Rate.Drop.Item.Uncommon", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_RARE, "Rate.Drop.Item.Rare", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_EPIC, "Rate.Drop.Item.Epic", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_LEGENDARY, "Rate.Drop.Item.Legendary", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_ARTIFACT, "Rate.Drop.Item.Artifact", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_REFERENCED, "Rate.Drop.Item.Referenced", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_REFERENCED_AMOUNT, "Rate.Drop.Item.ReferencedAmount", 1.0f);
    SetConfigValue<float>(RATE_DROP_ITEM_GROUP_AMOUNT, "Rate.Drop.Item.GroupAmount", 1.0f);
    SetConfigValue<float>(RATE_DROP_MONEY, "Rate.Drop.Money", 1.0f);

    SetConfigValue<float>(RATE_REWARD_QUEST_MONEY, "Rate.RewardQuestMoney", 1.0f);
    SetConfigValue<float>(RATE_REWARD_BONUS_MONEY, "Rate.RewardBonusMoney", 1.0f);
    SetConfigValue<float>(RATE_XP_KILL, "Rate.XP.Kill", 1.0f);
    SetConfigValue<float>(RATE_XP_BG_KILL_AV, "Rate.XP.BattlegroundKillAV", 1.0f);
    SetConfigValue<float>(RATE_XP_BG_KILL_WSG, "Rate.XP.BattlegroundKillWSG", 1.0f);
    SetConfigValue<float>(RATE_XP_BG_KILL_AB, "Rate.XP.BattlegroundKillAB", 1.0f);
    SetConfigValue<float>(RATE_XP_BG_KILL_EOTS, "Rate.XP.BattlegroundKillEOTS", 1.0f);
    SetConfigValue<float>(RATE_XP_BG_KILL_SOTA, "Rate.XP.BattlegroundKillSOTA", 1.0f);
    SetConfigValue<float>(RATE_XP_BG_KILL_IC, "Rate.XP.BattlegroundKillIC", 1.0f);
    SetConfigValue<float>(RATE_XP_QUEST, "Rate.XP.Quest", 1.0f);
    SetConfigValue<float>(RATE_XP_QUEST_DF, "Rate.XP.Quest.DF", 1.0f);
    SetConfigValue<float>(RATE_XP_EXPLORE, "Rate.XP.Explore", 1.0f);
    SetConfigValue<float>(RATE_XP_PET, "Rate.XP.Pet", 1.0f);
    SetConfigValue<float>(RATE_XP_PET_NEXT_LEVEL, "Rate.Pet.LevelXP", 0.05f);
    SetConfigValue<float>(RATE_XP_BATTLEGROUND_BONUS, "Rate.XP.BattlegroundBonus", 1.0f);
    SetConfigValue<float>(RATE_REPAIRCOST, "Rate.RepairCost", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");

    SetConfigValue<float>(RATE_SELLVALUE_ITEM_POOR, "Rate.SellValue.Item.Poor", 1.0f);
    SetConfigValue<float>(RATE_SELLVALUE_ITEM_NORMAL, "Rate.SellValue.Item.Normal", 1.0f);
    SetConfigValue<float>(RATE_SELLVALUE_ITEM_UNCOMMON, "Rate.SellValue.Item.Uncommon", 1.0f);
    SetConfigValue<float>(RATE_SELLVALUE_ITEM_RARE, "Rate.SellValue.Item.Rare", 1.0f);
    SetConfigValue<float>(RATE_SELLVALUE_ITEM_EPIC, "Rate.SellValue.Item.Epic", 1.0f);
    SetConfigValue<float>(RATE_SELLVALUE_ITEM_LEGENDARY, "Rate.SellValue.Item.Legendary", 1.0f);
    SetConfigValue<float>(RATE_SELLVALUE_ITEM_ARTIFACT, "Rate.SellValue.Item.Artifact", 1.0f);
    SetConfigValue<float>(RATE_SELLVALUE_ITEM_HEIRLOOM, "Rate.SellValue.Item.Heirloom", 1.0f);

    SetConfigValue<float>(RATE_BUYVALUE_ITEM_POOR, "Rate.BuyValue.Item.Poor", 1.0f);
    SetConfigValue<float>(RATE_BUYVALUE_ITEM_NORMAL, "Rate.BuyValue.Item.Normal", 1.0f);
    SetConfigValue<float>(RATE_BUYVALUE_ITEM_UNCOMMON, "Rate.BuyValue.Item.Uncommon", 1.0f);
    SetConfigValue<float>(RATE_BUYVALUE_ITEM_RARE, "Rate.BuyValue.Item.Rare", 1.0f);
    SetConfigValue<float>(RATE_BUYVALUE_ITEM_EPIC, "Rate.BuyValue.Item.Epic", 1.0f);
    SetConfigValue<float>(RATE_BUYVALUE_ITEM_LEGENDARY, "Rate.BuyValue.Item.Legendary", 1.0f);
    SetConfigValue<float>(RATE_BUYVALUE_ITEM_ARTIFACT, "Rate.BuyValue.Item.Artifact", 1.0f);
    SetConfigValue<float>(RATE_BUYVALUE_ITEM_HEIRLOOM, "Rate.BuyValue.Item.Heirloom", 1.0f);

    SetConfigValue<float>(RATE_REPUTATION_GAIN, "Rate.Reputation.Gain", 1.0f);
    SetConfigValue<float>(RATE_REPUTATION_GAIN_AB, "Rate.Reputation.Gain.AB", 1.0f);
    SetConfigValue<float>(RATE_REPUTATION_GAIN_AV, "Rate.Reputation.Gain.AV", 1.0f);
    SetConfigValue<float>(RATE_REPUTATION_GAIN_WSG, "Rate.Reputation.Gain.WSG", 1.0f);
    SetConfigValue<float>(RATE_REPUTATION_LOWLEVEL_KILL, "Rate.Reputation.LowLevel.Kill", 1.0f);
    SetConfigValue<float>(RATE_REPUTATION_LOWLEVEL_QUEST, "Rate.Reputation.LowLevel.Quest", 1.0f);
    SetConfigValue<float>(RATE_REPUTATION_RECRUIT_A_FRIEND_BONUS, "Rate.Reputation.RecruitAFriendBonus", 0.1f);
    SetConfigValue<float>(RATE_CREATURE_NORMAL_DAMAGE, "Rate.Creature.Normal.Damage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_ELITE_DAMAGE, "Rate.Creature.Elite.Elite.Damage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_RAREELITE_DAMAGE, "Rate.Creature.Elite.RAREELITE.Damage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_WORLDBOSS_DAMAGE, "Rate.Creature.Elite.WORLDBOSS.Damage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_RARE_DAMAGE, "Rate.Creature.Elite.RARE.Damage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_NORMAL_HP, "Rate.Creature.Normal.HP", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_ELITE_HP, "Rate.Creature.Elite.Elite.HP", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_RAREELITE_HP, "Rate.Creature.Elite.RAREELITE.HP", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_WORLDBOSS_HP, "Rate.Creature.Elite.WORLDBOSS.HP", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_RARE_HP, "Rate.Creature.Elite.RARE.HP", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_NORMAL_SPELLDAMAGE, "Rate.Creature.Normal.SpellDamage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_ELITE_SPELLDAMAGE, "Rate.Creature.Elite.Elite.SpellDamage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_RAREELITE_SPELLDAMAGE, "Rate.Creature.Elite.RAREELITE.SpellDamage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_WORLDBOSS_SPELLDAMAGE, "Rate.Creature.Elite.WORLDBOSS.SpellDamage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_ELITE_RARE_SPELLDAMAGE, "Rate.Creature.Elite.RARE.SpellDamage", 1.0f);
    SetConfigValue<float>(RATE_CREATURE_AGGRO, "Rate.Creature.Aggro", 1.0f);
    SetConfigValue<float>(RATE_REST_INGAME, "Rate.Rest.InGame", 1.0f);
    SetConfigValue<float>(RATE_REST_OFFLINE_IN_TAVERN_OR_CITY, "Rate.Rest.Offline.InTavernOrCity", 1.0f);
    SetConfigValue<float>(RATE_REST_OFFLINE_IN_WILDERNESS, "Rate.Rest.Offline.InWilderness", 1.0f);
    SetConfigValue<float>(RATE_REST_MAX_BONUS, "Rate.Rest.MaxBonus", 1.5f);
    SetConfigValue<float>(RATE_DAMAGE_FALL, "Rate.Damage.Fall", 1.0f);
    SetConfigValue<float>(RATE_AUCTION_TIME, "Rate.Auction.Time", 1.0f);
    SetConfigValue<float>(RATE_AUCTION_DEPOSIT, "Rate.Auction.Deposit", 1.0f);
    SetConfigValue<float>(RATE_AUCTION_CUT, "Rate.Auction.Cut", 1.0f);
    SetConfigValue<float>(RATE_HONOR, "Rate.Honor", 1.0f);
    SetConfigValue<float>(RATE_ARENA_POINTS, "Rate.ArenaPoints", 1.0f);
    SetConfigValue<float>(RATE_ARENA_POINTS_2V2, "Rate.ArenaPoints2v2", 0.76f);
    SetConfigValue<float>(RATE_ARENA_POINTS_3V3, "Rate.ArenaPoints3v3", 0.88f);
    SetConfigValue<float>(RATE_INSTANCE_RESET_TIME, "Rate.InstanceResetTime", 1.0f);

    SetConfigValue<float>(RATE_MISS_CHANCE_MULTIPLIER_TARGET_CREATURE, "Rate.MissChanceMultiplier.TargetCreature", 11.0f);
    SetConfigValue<float>(RATE_MISS_CHANCE_MULTIPLIER_TARGET_PLAYER, "Rate.MissChanceMultiplier.TargetPlayer", 7.0f);
    SetConfigValue<bool>(CONFIG_MISS_CHANCE_MULTIPLIER_ONLY_FOR_PLAYERS, "Rate.MissChanceMultiplier.OnlyAffectsPlayer", false);

    SetConfigValue<float>(RATE_TALENT, "Rate.Talent", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");
    SetConfigValue<float>(RATE_TALENT_PET, "Rate.Talent.Pet", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");
    // Controls Player movespeed rate.
    SetConfigValue<float>(RATE_MOVESPEED_PLAYER, "Rate.MoveSpeed.Player", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");

    // Controls all npc movespeed rate.
    SetConfigValue<float>(RATE_MOVESPEED_NPC, "Rate.MoveSpeed.NPC", 1.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");

    SetConfigValue<float>(RATE_CORPSE_DECAY_LOOTED, "Rate.Corpse.Decay.Looted", 0.5f);

    SetConfigValue<float>(RATE_DURABILITY_LOSS_ON_DEATH, "DurabilityLoss.OnDeath", 10.0f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f && value <= 100.0f; }, ">= 0 && <= 100");

    SetConfigValue<float>(RATE_DURABILITY_LOSS_DAMAGE, "DurabilityLossChance.Damage", 0.5f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");
    SetConfigValue<float>(RATE_DURABILITY_LOSS_ABSORB, "DurabilityLossChance.Absorb", 0.5f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");
    SetConfigValue<float>(RATE_DURABILITY_LOSS_PARRY, "DurabilityLossChance.Parry", 0.05f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");
    SetConfigValue<float>(RATE_DURABILITY_LOSS_BLOCK, "DurabilityLossChance.Block", 0.05f, ConfigValueCache::Reloadable::Yes, [](float const& value) { return value >= 0.0f; }, ">= 0");

    ///- Read other configuration items from the config file

    SetConfigValue<bool>(CONFIG_DURABILITY_LOSS_IN_PVP, "DurabilityLoss.InPvP", false);

    SetConfigValue<uint32>(CONFIG_COMPRESSION, "Compression", 1, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0 && value < 10; }, "> 0 && < 10");

    SetConfigValue<bool>(CONFIG_ADDON_CHANNEL, "AddonChannel", true);
    SetConfigValue<bool>(CONFIG_CLEAN_CHARACTER_DB, "CleanCharacterDB", false);
    SetConfigValue<uint32>(CONFIG_PERSISTENT_CHARACTER_CLEAN_FLAGS, "PersistentCharacterCleanFlags", 0);
    SetConfigValue<uint32>(CONFIG_CHAT_CHANNEL_LEVEL_REQ, "ChatLevelReq.Channel", 1);
    SetConfigValue<uint32>(CONFIG_CHAT_WHISPER_LEVEL_REQ, "ChatLevelReq.Whisper", 1);
    SetConfigValue<uint32>(CONFIG_CHAT_SAY_LEVEL_REQ, "ChatLevelReq.Say", 1);
    SetConfigValue<uint32>(CONFIG_PARTY_LEVEL_REQ, "PartyLevelReq", 1);
    SetConfigValue<uint32>(CONFIG_TRADE_LEVEL_REQ, "LevelReq.Trade", 1);
    SetConfigValue<uint32>(CONFIG_TICKET_LEVEL_REQ, "LevelReq.Ticket", 1);
    SetConfigValue<uint32>(CONFIG_AUCTION_LEVEL_REQ, "LevelReq.Auction", 1);
    SetConfigValue<uint32>(CONFIG_MAIL_LEVEL_REQ, "LevelReq.Mail", 1);
    SetConfigValue<bool>(CONFIG_ALLOW_PLAYER_COMMANDS, "AllowPlayerCommands", 1);
    SetConfigValue<bool>(CONFIG_PRESERVE_CUSTOM_CHANNELS, "PreserveCustomChannels", false);
    SetConfigValue<uint32>(CONFIG_PRESERVE_CUSTOM_CHANNEL_DURATION, "PreserveCustomChannelDuration", 14);
    SetConfigValue<uint32>(CONFIG_INTERVAL_SAVE, "PlayerSaveInterval", 900000);
    SetConfigValue<uint32>(CONFIG_INTERVAL_DISCONNECT_TOLERANCE, "DisconnectToleranceInterval", 0);
    SetConfigValue<bool>(CONFIG_STATS_SAVE_ONLY_ON_LOGOUT, "PlayerSave.Stats.SaveOnlyOnLogout", true);
    SetConfigValue<bool>(CONFIG_VALIDATE_SKILL_LEARNED_BY_SPELLS, "ValidateSkillLearnedBySpells", true);

    SetConfigValue<uint32>(CONFIG_MIN_LEVEL_STAT_SAVE, "PlayerSave.Stats.MinLevel", 0, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value < MAX_LEVEL; }, "< MAX_LEVEL");

    SetConfigValue<uint32>(CONFIG_INTERVAL_MAPUPDATE, "MapUpdateInterval", 10, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value >= MIN_MAP_UPDATE_DELAY; }, ">= MIN_MAP_UPDATE_DELAY");

    SetConfigValue<uint32>(CONFIG_INTERVAL_CHANGEWEATHER, "ChangeWeatherInterval", 600000);

    SetConfigValue<uint32>(CONFIG_PORT_WORLD, "WorldServerPort", 8085, ConfigValueCache::Reloadable::No);

    SetConfigValue<bool>(CONFIG_CLOSE_IDLE_CONNECTIONS, "CloseIdleConnections", true);
    SetConfigValue<uint32>(CONFIG_SOCKET_TIMEOUTTIME, "SocketTimeOutTime", 900000);
    SetConfigValue<uint32>(CONFIG_SOCKET_TIMEOUTTIME_ACTIVE, "SocketTimeOutTimeActive", 60000);
    SetConfigValue<uint32>(CONFIG_SESSION_ADD_DELAY, "SessionAddDelay", 10000);

    SetConfigValue<float>(CONFIG_GROUP_XP_DISTANCE, "MaxGroupXPDistance", 74.0f);
    SetConfigValue<float>(CONFIG_MAX_RECRUIT_A_FRIEND_DISTANCE, "MaxRecruitAFriendBonusDistance", 100.0f);

    SetConfigValue<float>(CONFIG_SIGHT_MONSTER, "MonsterSight", 50.0f);

    SetConfigValue<uint32>(CONFIG_GAME_TYPE, "GameType", 0, ConfigValueCache::Reloadable::No);
    SetConfigValue<uint32>(CONFIG_REALM_ZONE, "RealmZone", REALM_ZONE_DEVELOPMENT, ConfigValueCache::Reloadable::No);

    SetConfigValue<bool>(CONFIG_STRICT_NAMES_RESERVED, "StrictNames.Reserved", true);
    SetConfigValue<bool>(CONFIG_STRICT_NAMES_PROFANITY, "StrictNames.Profanity", true);
    SetConfigValue<uint32>(CONFIG_STRICT_PLAYER_NAMES, "StrictPlayerNames", 0);
    SetConfigValue<uint32>(CONFIG_STRICT_CHARTER_NAMES, "StrictCharterNames", 0);
    SetConfigValue<uint32>(CONFIG_STRICT_CHANNEL_NAMES, "StrictChannelNames", 0);
    SetConfigValue<uint32>(CONFIG_STRICT_PET_NAMES, "StrictPetNames", 0);

    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_ACCOUNTS, "AllowTwoSide.Accounts", true);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CALENDAR, "AllowTwoSide.Interaction.Calendar", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHAT, "AllowTwoSide.Interaction.Chat", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_CHANNEL, "AllowTwoSide.Interaction.Channel", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP, "AllowTwoSide.Interaction.Group", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GUILD, "AllowTwoSide.Interaction.Guild", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_ARENA, "AllowTwoSide.Interaction.Arena", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_AUCTION, "AllowTwoSide.Interaction.Auction", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_MAIL, "AllowTwoSide.Interaction.Mail", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_WHO_LIST, "AllowTwoSide.WhoList", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_ADD_FRIEND, "AllowTwoSide.AddFriend", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_TRADE, "AllowTwoSide.Trade", false);
    SetConfigValue<bool>(CONFIG_ALLOW_TWO_SIDE_INTERACTION_EMOTE, "AllowTwoSide.Interaction.Emote", false);

    SetConfigValue<uint32>(CONFIG_MIN_PLAYER_NAME, "MinPlayerName", 2, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0 && value <= MAX_PLAYER_NAME; }, "> 0 && <= MAX_PLAYER_NAME");
    SetConfigValue<uint32>(CONFIG_MIN_CHARTER_NAME, "MinCharterName", 2, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0 && value <= MAX_CHARTER_NAME; }, "> 0 && <= MAX_CHARTER_NAME");
    SetConfigValue<uint32>(CONFIG_MIN_PET_NAME, "MinPetName", 2, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0 && value <= MAX_PET_NAME; }, "> 0 && <= MAX_PET_NAME");

    SetConfigValue<uint32>(CONFIG_CHARTER_COST_GUILD, "Guild.CharterCost", 1000);
    SetConfigValue<uint32>(CONFIG_CHARTER_COST_ARENA_2v2, "ArenaTeam.CharterCost.2v2", 800000);
    SetConfigValue<uint32>(CONFIG_CHARTER_COST_ARENA_3v3, "ArenaTeam.CharterCost.3v3", 1200000);
    SetConfigValue<uint32>(CONFIG_CHARTER_COST_ARENA_5v5, "ArenaTeam.CharterCost.5v5", 2000000);

    SetConfigValue<uint32>(CONFIG_MAX_WHO_LIST_RETURN, "MaxWhoListReturns", 49);

    SetConfigValue<uint32>(CONFIG_CHARACTER_CREATING_DISABLED, "CharacterCreating.Disabled", 0);
    SetConfigValue<uint32>(CONFIG_CHARACTER_CREATING_DISABLED_RACEMASK, "CharacterCreating.Disabled.RaceMask", 0);

    SetConfigValue<uint32>(CONFIG_CHARACTER_CREATING_DISABLED_CLASSMASK, "CharacterCreating.Disabled.ClassMask", 0);

    SetConfigValue<uint32>(CONFIG_CHARACTERS_PER_REALM, "CharactersPerRealm", 10, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0 && value <= 10; }, "> 0 && <= 10");

    // must be after CONFIG_CHARACTERS_PER_REALM
    SetConfigValue<uint32>(CONFIG_CHARACTERS_PER_ACCOUNT, "CharactersPerAccount", 50, ConfigValueCache::Reloadable::Yes, [this](uint32 const& value) { return value >= GetConfigValue<uint32>(CONFIG_CHARACTERS_PER_REALM); }, ">= CONFIG_CHARACTERS_PER_REALM");
    SetConfigValue<uint32>(CONFIG_HEROIC_CHARACTERS_PER_REALM, "HeroicCharactersPerRealm", 1, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 10; }, "<= 10");

    SetConfigValue<uint32>(CONFIG_CHARACTER_CREATING_MIN_LEVEL_FOR_HEROIC_CHARACTER, "CharacterCreating.MinLevelForHeroicCharacter", 55);

    SetConfigValue<uint32>(CONFIG_SKIP_CINEMATICS, "SkipCinematics", 0, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 2; }, "<= 2");

    SetConfigValue<uint32>(CONFIG_MAX_PLAYER_LEVEL, "MaxPlayerLevel", DEFAULT_MAX_LEVEL, ConfigValueCache::Reloadable::No, [](uint32 const& value) { return value > 0 && value <= MAX_LEVEL; }, "> 0 && <= MAX_LEVEL");

    SetConfigValue<uint32>(CONFIG_MIN_DUALSPEC_LEVEL, "MinDualSpecLevel", 40);

    SetConfigValue<uint32>(CONFIG_START_PLAYER_LEVEL, "StartPlayerLevel", 1, ConfigValueCache::Reloadable::Yes, [this](uint32 const& value) { return value > 0 && value <= GetConfigValue<uint32>(CONFIG_MAX_PLAYER_LEVEL); }, "> 0 && <= CONFIG_MAX_PLAYER_LEVEL");
    SetConfigValue<uint32>(CONFIG_START_HEROIC_PLAYER_LEVEL, "StartHeroicPlayerLevel", 55, ConfigValueCache::Reloadable::Yes, [this](uint32 const& value) { return value > 0 && value <= GetConfigValue<uint32>(CONFIG_MAX_PLAYER_LEVEL); }, "> 0 && <= CONFIG_MAX_PLAYER_LEVEL");

    SetConfigValue<uint32>(CONFIG_START_PLAYER_MONEY, "StartPlayerMoney", 0, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= MAX_MONEY_AMOUNT; }, "<= MAX_MONEY_AMOUNT");
    SetConfigValue<uint32>(CONFIG_START_HEROIC_PLAYER_MONEY, "StartHeroicPlayerMoney", 2000, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= MAX_MONEY_AMOUNT; }, "<= MAX_MONEY_AMOUNT");

    SetConfigValue<uint32>(CONFIG_MAX_HONOR_POINTS, "MaxHonorPoints", 75000);

    SetConfigValue<uint32>(CONFIG_MAX_HONOR_POINTS_MONEY_PER_POINT, "MaxHonorPointsMoneyPerPoint", 0);

    SetConfigValue<uint32>(CONFIG_START_HONOR_POINTS, "StartHonorPoints", 0, ConfigValueCache::Reloadable::Yes, [this](uint32 const& value) { return value <= GetConfigValue<uint32>(CONFIG_MAX_HONOR_POINTS); }, "<= CONFIG_MAX_HONOR_POINTS");

    SetConfigValue<uint32>(CONFIG_MAX_ARENA_POINTS, "MaxArenaPoints", 10000);

    SetConfigValue<uint32>(CONFIG_START_ARENA_POINTS, "StartArenaPoints", 0, ConfigValueCache::Reloadable::Yes, [this](uint32 const& value) { return value <= GetConfigValue<uint32>(CONFIG_MAX_ARENA_POINTS); }, "<= CONFIG_MAX_ARENA_POINTS");

    SetConfigValue<uint32>(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL, "RecruitAFriend.MaxLevel", 60, ConfigValueCache::Reloadable::Yes, [this](uint32 const& value) { return value <= GetConfigValue<uint32>(CONFIG_MAX_PLAYER_LEVEL); }, "<= CONFIG_MAX_PLAYER_LEVEL");

    SetConfigValue<uint32>(CONFIG_MAX_RECRUIT_A_FRIEND_BONUS_PLAYER_LEVEL_DIFFERENCE, "RecruitAFriend.MaxDifference", 4);
    SetConfigValue<bool>(CONFIG_ALL_TAXI_PATHS, "AllFlightPaths", false);
    SetConfigValue<uint32>(CONFIG_INSTANT_TAXI, "InstantFlightPaths", 0);

    SetConfigValue<bool>(CONFIG_INSTANCE_IGNORE_LEVEL, "Instance.IgnoreLevel", false);
    SetConfigValue<bool>(CONFIG_INSTANCE_IGNORE_RAID, "Instance.IgnoreRaid", false);
    SetConfigValue<bool>(CONFIG_INSTANCE_GMSUMMON_PLAYER, "Instance.GMSummonPlayer", false);
    SetConfigValue<bool>(CONFIG_INSTANCE_SHARED_ID, "Instance.SharedNormalHeroicId", true);

    SetConfigValue<uint32>(CONFIG_INSTANCE_RESET_TIME_HOUR, "Instance.ResetTimeHour", 4);
    SetConfigValue<uint32>(CONFIG_INSTANCE_RESET_TIME_RELATIVE_TIMESTAMP, "Instance.ResetTimeRelativeTimestamp", 1135814400);
    SetConfigValue<uint32>(CONFIG_INSTANCE_UNLOAD_DELAY, "Instance.UnloadDelay", 1800000);

    SetConfigValue<uint32>(CONFIG_MAX_PRIMARY_TRADE_SKILL, "MaxPrimaryTradeSkill", 2);
    SetConfigValue<uint32>(CONFIG_MIN_PETITION_SIGNS, "MinPetitionSigns", 9, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 9; }, "<= 9");

    SetConfigValue<uint32>(CONFIG_GM_LOGIN_STATE, "GM.LoginState", 2);
    SetConfigValue<uint32>(CONFIG_GM_VISIBLE_STATE, "GM.Visible", 2);
    SetConfigValue<uint32>(CONFIG_GM_CHAT, "GM.Chat", 2);
    SetConfigValue<uint32>(CONFIG_GM_WHISPERING_TO, "GM.WhisperingTo", 2);

    SetConfigValue<uint32>(CONFIG_GM_LEVEL_IN_GM_LIST, "GM.InGMList.Level", SEC_ADMINISTRATOR);
    SetConfigValue<uint32>(CONFIG_GM_LEVEL_IN_WHO_LIST, "GM.InWhoList.Level", SEC_ADMINISTRATOR);
    SetConfigValue<uint32>(CONFIG_START_GM_LEVEL, "GM.StartLevel", 1, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= MAX_LEVEL; }, "<= MAX_LEVEL");

    SetConfigValue<bool>(CONFIG_ALLOW_GM_GROUP, "GM.AllowInvite", false);
    SetConfigValue<bool>(CONFIG_ALLOW_GM_FRIEND, "GM.AllowFriend", false);
    SetConfigValue<bool>(CONFIG_GM_LOWER_SECURITY, "GM.LowerSecurity", false);
    SetConfigValue<float>(CONFIG_CHANCE_OF_GM_SURVEY, "GM.TicketSystem.ChanceOfGMSurvey", 50.0f);

    SetConfigValue<uint32>(CONFIG_GROUP_VISIBILITY, "Visibility.GroupMode", 1);

    SetConfigValue<bool>(CONFIG_OBJECT_SPARKLES, "Visibility.ObjectSparkles", true);

    SetConfigValue<bool>(CONFIG_LOW_LEVEL_REGEN_BOOST, "EnableLowLevelRegenBoost", true);

    SetConfigValue<bool>(CONFIG_OBJECT_QUEST_MARKERS, "Visibility.ObjectQuestMarkers", true);

    SetConfigValue<uint32>(CONFIG_MAIL_DELIVERY_DELAY, "MailDeliveryDelay", HOUR);

    SetConfigValue<uint32>(CONFIG_UPTIME_UPDATE, "UpdateUptimeInterval", 10, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0; }, "> 0");

    // log db cleanup interval
    SetConfigValue<uint32>(CONFIG_LOGDB_CLEARINTERVAL, "LogDB.Opt.ClearInterval", 10, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0; }, "> 0");
    SetConfigValue<uint32>(CONFIG_LOGDB_CLEARTIME, "LogDB.Opt.ClearTime", 1209600);

    SetConfigValue<uint32>(CONFIG_TELEPORT_TIMEOUT_NEAR, "TeleportTimeoutNear", 25);
    SetConfigValue<uint32>(CONFIG_TELEPORT_TIMEOUT_FAR, "TeleportTimeoutFar", 45);
    SetConfigValue<uint32>(CONFIG_MAX_ALLOWED_MMR_DROP, "MaxAllowedMMRDrop", 500);
    SetConfigValue<bool>(CONFIG_ENABLE_LOGIN_AFTER_DC, "EnableLoginAfterDC", true);
    SetConfigValue<bool>(CONFIG_DONT_CACHE_RANDOM_MOVEMENT_PATHS, "DontCacheRandomMovementPaths", false);

    SetConfigValue<uint32>(CONFIG_SKILL_CHANCE_ORANGE, "SkillChance.Orange", 100);
    SetConfigValue<uint32>(CONFIG_SKILL_CHANCE_YELLOW, "SkillChance.Yellow", 75);
    SetConfigValue<uint32>(CONFIG_SKILL_CHANCE_GREEN, "SkillChance.Green", 25);
    SetConfigValue<uint32>(CONFIG_SKILL_CHANCE_GREY, "SkillChance.Grey", 0);

    SetConfigValue<uint32>(CONFIG_SKILL_CHANCE_MINING_STEPS, "SkillChance.MiningSteps", 0);
    SetConfigValue<uint32>(CONFIG_SKILL_CHANCE_SKINNING_STEPS, "SkillChance.SkinningSteps", 0);

    SetConfigValue<bool>(CONFIG_SKILL_PROSPECTING, "SkillChance.Prospecting", false);
    SetConfigValue<bool>(CONFIG_SKILL_MILLING, "SkillChance.Milling", false);

    SetConfigValue<uint32>(CONFIG_SKILL_GAIN_CRAFTING, "SkillGain.Crafting", 1);

    SetConfigValue<uint32>(CONFIG_SKILL_GAIN_DEFENSE, "SkillGain.Defense", 1);

    SetConfigValue<uint32>(CONFIG_SKILL_GAIN_GATHERING, "SkillGain.Gathering", 1);

    SetConfigValue<uint32>(CONFIG_SKILL_GAIN_WEAPON, "SkillGain.Weapon", 1);

    SetConfigValue<uint32>(CONFIG_MAX_OVERSPEED_PINGS, "MaxOverspeedPings", 2, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value != 1; }, "!= 1");

    SetConfigValue<bool>(CONFIG_SAVE_RESPAWN_TIME_IMMEDIATELY, "SaveRespawnTimeImmediately", true);
    SetConfigValue<bool>(CONFIG_WEATHER, "ActivateWeather", true);

    SetConfigValue<uint32>(CONFIG_DISABLE_BREATHING, "DisableWaterBreath", SEC_CONSOLE);

    SetConfigValue<bool>(CONFIG_ALWAYS_MAX_SKILL_FOR_LEVEL, "AlwaysMaxSkillForLevel", false);

    SetConfigValue<uint32>(CONFIG_EXPANSION, "Expansion", 2, ConfigValueCache::Reloadable::No);

    SetConfigValue<uint32>(CONFIG_CHATFLOOD_MESSAGE_COUNT, "ChatFlood.MessageCount", 10);
    SetConfigValue<uint32>(CONFIG_CHATFLOOD_MESSAGE_DELAY, "ChatFlood.MessageDelay", 1);
    SetConfigValue<uint32>(CONFIG_CHATFLOOD_ADDON_MESSAGE_COUNT, "ChatFlood.AddonMessageCount", 100);
    SetConfigValue<uint32>(CONFIG_CHATFLOOD_ADDON_MESSAGE_DELAY, "ChatFlood.AddonMessageDelay", 1);
    SetConfigValue<uint32>(CONFIG_CHATFLOOD_MUTE_TIME, "ChatFlood.MuteTime", 10);
    SetConfigValue<bool>(CONFIG_CHAT_MUTE_FIRST_LOGIN, "Chat.MuteFirstLogin", false);
    SetConfigValue<uint32>(CONFIG_CHAT_TIME_MUTE_FIRST_LOGIN, "Chat.MuteTimeFirstLogin", 120);

    SetConfigValue<uint32>(CONFIG_EVENT_ANNOUNCE, "Event.Announce", 0);

    SetConfigValue<float>(CONFIG_CREATURE_LEASH_RADIUS, "CreatureLeashRadius", 30.0f);
    SetConfigValue<float>(CONFIG_CREATURE_FAMILY_FLEE_ASSISTANCE_RADIUS, "CreatureFamilyFleeAssistanceRadius", 30.0f);
    SetConfigValue<float>(CONFIG_CREATURE_FAMILY_ASSISTANCE_RADIUS, "CreatureFamilyAssistanceRadius", 10.0f);
    SetConfigValue<uint32>(CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY, "CreatureFamilyAssistanceDelay", 2000);
    SetConfigValue<uint32>(CONFIG_CREATURE_FAMILY_ASSISTANCE_PERIOD, "CreatureFamilyAssistancePeriod", 3000);
    SetConfigValue<uint32>(CONFIG_CREATURE_FAMILY_FLEE_DELAY, "CreatureFamilyFleeDelay", 7000);

    SetConfigValue<uint32>(CONFIG_WORLD_BOSS_LEVEL_DIFF, "WorldBossLevelDiff", 3);

    SetConfigValue<bool>(CONFIG_QUEST_ENABLE_QUEST_TRACKER, "Quests.EnableQuestTracker", false);

    // note: disable value (-1) will assigned as 0xFFFFFFF, to prevent overflow at calculations limit it to max possible player level MAX_LEVEL(100)
    SetConfigValue<uint32>(CONFIG_QUEST_LOW_LEVEL_HIDE_DIFF, "Quests.LowLevelHideDiff", 4, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= MAX_LEVEL; }, "<= MAX_LEVEL");
    SetConfigValue<uint32>(CONFIG_QUEST_HIGH_LEVEL_HIDE_DIFF, "Quests.HighLevelHideDiff", 7, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= MAX_LEVEL; }, "<= MAX_LEVEL");
    SetConfigValue<bool>(CONFIG_QUEST_IGNORE_RAID, "Quests.IgnoreRaid", false);
    SetConfigValue<bool>(CONFIG_QUEST_IGNORE_AUTO_ACCEPT, "Quests.IgnoreAutoAccept", false);
    SetConfigValue<bool>(CONFIG_QUEST_IGNORE_AUTO_COMPLETE, "Quests.IgnoreAutoComplete", false);

    SetConfigValue<uint32>(CONFIG_RANDOM_BG_RESET_HOUR, "Battleground.Random.ResetHour", 6, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 23; }, "<= 23");
    SetConfigValue<uint32>(CONFIG_CALENDAR_DELETE_OLD_EVENTS_HOUR, "Calendar.DeleteOldEventsHour", 6, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 23; }, "<= 23");
    SetConfigValue<uint32>(CONFIG_GUILD_RESET_HOUR, "Guild.ResetHour", 6, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 23; }, "<= 23");

    SetConfigValue<uint32>(CONFIG_GUILD_BANK_INITIAL_TABS, "Guild.BankInitialTabs", 0);
    SetConfigValue<uint32>(CONFIG_GUILD_BANK_TAB_COST_0, "Guild.BankTabCost0", 1000000);
    SetConfigValue<uint32>(CONFIG_GUILD_BANK_TAB_COST_1, "Guild.BankTabCost1", 2500000);
    SetConfigValue<uint32>(CONFIG_GUILD_BANK_TAB_COST_2, "Guild.BankTabCost2", 5000000);
    SetConfigValue<uint32>(CONFIG_GUILD_BANK_TAB_COST_3, "Guild.BankTabCost3", 10000000);
    SetConfigValue<uint32>(CONFIG_GUILD_BANK_TAB_COST_4, "Guild.BankTabCost4", 25000000);
    SetConfigValue<uint32>(CONFIG_GUILD_BANK_TAB_COST_5, "Guild.BankTabCost5", 50000000);

    SetConfigValue<uint32>(CONFIG_GUILD_MEMBER_LIMIT, "Guild.MemberLimit", 0);

    SetConfigValue<bool>(CONFIG_DETECT_POS_COLLISION, "DetectPosCollision", true);

    SetConfigValue<bool>(CONFIG_RESTRICTED_LFG_CHANNEL, "Channel.RestrictedLfg", true);
    SetConfigValue<bool>(CONFIG_SILENTLY_GM_JOIN_TO_CHANNEL, "Channel.SilentlyGMJoin", false);

    SetConfigValue<bool>(CONFIG_TALENTS_INSPECTING, "TalentsInspecting", true);
    SetConfigValue<bool>(CONFIG_CHAT_FAKE_MESSAGE_PREVENTING, "ChatFakeMessagePreventing", true);
    SetConfigValue<uint32>(CONFIG_CHAT_STRICT_LINK_CHECKING_SEVERITY, "ChatStrictLinkChecking.Severity", 0);
    SetConfigValue<uint32>(CONFIG_CHAT_STRICT_LINK_CHECKING_KICK, "ChatStrictLinkChecking.Kick", 0);

    SetConfigValue<uint32>(CONFIG_CORPSE_DECAY_NORMAL, "Corpse.Decay.NORMAL", 60);
    SetConfigValue<uint32>(CONFIG_CORPSE_DECAY_RARE, "Corpse.Decay.RARE", 300);
    SetConfigValue<uint32>(CONFIG_CORPSE_DECAY_ELITE, "Corpse.Decay.ELITE", 300);
    SetConfigValue<uint32>(CONFIG_CORPSE_DECAY_RAREELITE, "Corpse.Decay.RAREELITE", 300);
    SetConfigValue<uint32>(CONFIG_CORPSE_DECAY_WORLDBOSS, "Corpse.Decay.WORLDBOSS", 3600);

    SetConfigValue<uint32>(CONFIG_DEATH_SICKNESS_LEVEL, "Death.SicknessLevel", 11);
    SetConfigValue<bool>(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVP, "Death.CorpseReclaimDelay.PvP", true);
    SetConfigValue<bool>(CONFIG_DEATH_CORPSE_RECLAIM_DELAY_PVE, "Death.CorpseReclaimDelay.PvE", true);
    SetConfigValue<bool>(CONFIG_DEATH_BONES_WORLD, "Death.Bones.World", true);
    SetConfigValue<bool>(CONFIG_DEATH_BONES_BG_OR_ARENA, "Death.Bones.BattlegroundOrArena", true);

    SetConfigValue<bool>(CONFIG_DIE_COMMAND_MODE, "Die.Command.Mode", true);

    // always use declined names in the russian client
    SetConfigValue<bool>(CONFIG_DECLINED_NAMES_USED, "DeclinedNames", GetConfigValue<uint32>(CONFIG_REALM_ZONE) == REALM_ZONE_RUSSIAN);

    SetConfigValue<float>(CONFIG_LISTEN_RANGE_SAY, "ListenRange.Say", 40.0f);
    SetConfigValue<float>(CONFIG_LISTEN_RANGE_TEXTEMOTE, "ListenRange.TextEmote", 40.0f);
    SetConfigValue<float>(CONFIG_LISTEN_RANGE_YELL, "ListenRange.Yell", 300.0f);

    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_PREP_TIME, "Battleground.PrepTime", 120);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_OVERRIDE_LOWLEVELS_MINPLAYERS, "Battleground.Override.LowLevels.MinPlayers", 0);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_DISABLE_QUEST_SHARE_IN_BG, "Battleground.DisableQuestShareInBG", false);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_DISABLE_READY_CHECK_IN_BG, "Battleground.DisableReadyCheckInBG", false);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_CAST_DESERTER, "Battleground.CastDeserter", true);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_ENABLE, "Battleground.QueueAnnouncer.Enable", false);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_LEVEL, "Battleground.QueueAnnouncer.Limit.MinLevel", 0);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_LIMIT_MIN_PLAYERS, "Battleground.QueueAnnouncer.Limit.MinPlayers", 3);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_SPAM_DELAY, "Battleground.QueueAnnouncer.SpamProtection.Delay", 30);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_PLAYERONLY, "Battleground.QueueAnnouncer.PlayerOnly", false);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_TIMED, "Battleground.QueueAnnouncer.Timed", false);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_QUEUE_ANNOUNCER_TIMER, "Battleground.QueueAnnouncer.Timer", 30000);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_STORE_STATISTICS_ENABLE, "Battleground.StoreStatistics.Enable", false);
    SetConfigValue<bool>(CONFIG_BATTLEGROUND_TRACK_DESERTERS, "Battleground.TrackDeserters.Enable", false);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_PREMATURE_FINISH_TIMER, "Battleground.PrematureFinishTimer", 300000);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_INVITATION_TYPE, "Battleground.InvitationType", 0);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_PREMADE_GROUP_WAIT_FOR_MATCH, "Battleground.PremadeGroupWaitForMatch", 1800000);
    SetConfigValue<bool>(CONFIG_BG_XP_FOR_KILL, "Battleground.GiveXPForKills", false);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_REPORT_AFK_TIMER, "Battleground.ReportAFK.Timer", 4);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_REPORT_AFK, "Battleground.ReportAFK", 3, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0 && value <= 9; }, "> 0 && value <= 9");
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_PLAYER_RESPAWN, "Battleground.PlayerRespawn", 30, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value >= 3; }, ">= 3");
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_RESTORATION_BUFF_RESPAWN, "Battleground.RestorationBuffRespawn", 20, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0; }, "> 0");
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_BERSERKING_BUFF_RESPAWN, "Battleground.BerserkingBuffRespawn", 120, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0; }, "> 0");
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_SPEED_BUFF_RESPAWN, "Battleground.SpeedBuffRespawn", 150, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0; }, "> 0");

    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_WARSONG_FLAGS, "Battleground.Warsong.Flags", 3);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_ARATHI_CAPTUREPOINTS, "Battleground.Arathi.CapturePoints", 1600);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_ALTERAC_REINFORCEMENTS, "Battleground.Alterac.Reinforcements", 600);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_ALTERAC_REP_ONBOSSDEATH, "Battleground.Alterac.ReputationOnBossDeath", 350);
    SetConfigValue<uint32>(CONFIG_BATTLEGROUND_EYEOFTHESTORM_CAPTUREPOINTS, "Battleground.EyeOfTheStorm.CapturePoints", 1600);

    SetConfigValue<uint32>(CONFIG_ARENA_PREP_TIME, "Arena.PrepTime", 60);
    SetConfigValue<uint32>(CONFIG_ARENA_MAX_RATING_DIFFERENCE, "Arena.MaxRatingDifference", 150);
    SetConfigValue<uint32>(CONFIG_ARENA_RATING_DISCARD_TIMER, "Arena.RatingDiscardTimer", 600000);
    SetConfigValue<uint32>(CONFIG_ARENA_PREV_OPPONENTS_DISCARD_TIMER, "Arena.PreviousOpponentsDiscardTimer", 120000);
    SetConfigValue<bool>(CONFIG_ARENA_AUTO_DISTRIBUTE_POINTS, "Arena.AutoDistributePoints", false);
    SetConfigValue<uint32>(CONFIG_ARENA_AUTO_DISTRIBUTE_INTERVAL_DAYS, "Arena.AutoDistributeInterval", 7);
    SetConfigValue<uint32>(CONFIG_ARENA_GAMES_REQUIRED, "Arena.GamesRequired", 10);
    SetConfigValue<uint32>(CONFIG_ARENA_START_RATING, "Arena.ArenaStartRating", 0);
    SetConfigValue<uint32>(CONFIG_LEGACY_ARENA_START_RATING, "Arena.LegacyArenaStartRating", 1500);
    SetConfigValue<uint32>(CONFIG_LEGACY_ARENA_POINTS_CALC, "Arena.LegacyArenaPoints", 0);
    SetConfigValue<uint32>(CONFIG_ARENA_START_PERSONAL_RATING, "Arena.ArenaStartPersonalRating", 0);
    SetConfigValue<uint32>(CONFIG_ARENA_START_MATCHMAKER_RATING, "Arena.ArenaStartMatchmakerRating", 1500);
    SetConfigValue<float>(CONFIG_ARENA_WIN_RATING_MODIFIER_1, "Arena.ArenaWinRatingModifier1", 48.0f);
    SetConfigValue<float>(CONFIG_ARENA_WIN_RATING_MODIFIER_2, "Arena.ArenaWinRatingModifier2", 24.0f);
    SetConfigValue<float>(CONFIG_ARENA_LOSE_RATING_MODIFIER, "Arena.ArenaLoseRatingModifier", 24.0f);
    SetConfigValue<float>(CONFIG_ARENA_MATCHMAKER_RATING_MODIFIER, "Arena.ArenaMatchmakerRatingModifier", 24.0f);
    SetConfigValue<bool>(CONFIG_ARENA_QUEUE_ANNOUNCER_ENABLE, "Arena.QueueAnnouncer.Enable", false);
    SetConfigValue<bool>(CONFIG_ARENA_QUEUE_ANNOUNCER_PLAYERONLY, "Arena.QueueAnnouncer.PlayerOnly", false);
    SetConfigValue<uint32>(CONFIG_ARENA_QUEUE_ANNOUNCER_DETAIL, "Arena.QueueAnnouncer.Detail", 3);

    SetConfigValue<bool>(CONFIG_OFFHAND_CHECK_AT_SPELL_UNLEARN, "OffhandCheckAtSpellUnlearn", true);
    SetConfigValue<bool>(CONFIG_CREATURE_REPOSITION_AGAINST_NPCS, "Creature.RepositionAgainstNpcs", true);
    SetConfigValue<uint32>(CONFIG_CREATURE_STOP_FOR_PLAYER, "Creature.MovingStopTimeForPlayer", 180000);

    SetConfigValue<uint32>(CONFIG_WATER_BREATH_TIMER, "WaterBreath.Timer", 180000, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0; }, "> 0");

    SetConfigValue<uint32>(CONFIG_CLIENTCACHE_VERSION, "ClientCacheVersion", 0);

    SetConfigValue<uint32>(CONFIG_INSTANT_LOGOUT, "InstantLogout", SEC_MODERATOR);

    SetConfigValue<uint32>(CONFIG_GUILD_EVENT_LOG_COUNT, "Guild.EventLogRecordsCount", GUILD_EVENTLOG_MAX_RECORDS, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= GUILD_EVENTLOG_MAX_RECORDS; }, "<= GUILD_EVENTLOG_MAX_RECORDS");
    SetConfigValue<uint32>(CONFIG_GUILD_BANK_EVENT_LOG_COUNT, "Guild.BankEventLogRecordsCount", GUILD_BANKLOG_MAX_RECORDS, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= GUILD_BANKLOG_MAX_RECORDS; }, "<= GUILD_BANKLOG_MAX_RECORDS");

    ///- Load the CharDelete related config options
    SetConfigValue<uint32>(CONFIG_CHARDELETE_METHOD, "CharDelete.Method", 0);
    SetConfigValue<uint32>(CONFIG_CHARDELETE_MIN_LEVEL, "CharDelete.MinLevel", 0);
    SetConfigValue<uint32>(CONFIG_CHARDELETE_KEEP_DAYS, "CharDelete.KeepDays", 30);

    ///- Load the ItemDelete related config options
    SetConfigValue<bool>(CONFIG_ITEMDELETE_METHOD, "ItemDelete.Method", 0);
    SetConfigValue<bool>(CONFIG_ITEMDELETE_VENDOR, "ItemDelete.Vendor", 0);
    SetConfigValue<uint32>(CONFIG_ITEMDELETE_QUALITY, "ItemDelete.Quality", 3);
    SetConfigValue<uint32>(CONFIG_ITEMDELETE_ITEM_LEVEL, "ItemDelete.ItemLevel", 80);
    SetConfigValue<uint32>(CONFIG_ITEMDELETE_KEEP_DAYS, "ItemDelete.KeepDays", 0);

    SetConfigValue<uint32>(CONFIG_FFA_PVP_TIMER, "FFAPvPTimer", 30);

    SetConfigValue<float>(CONFIG_OUTDOOR_PVP_CAPTURE_RATE, "OutdoorPvPCaptureRate", 1.0f);

    SetConfigValue<uint32>(CONFIG_LOOT_NEED_BEFORE_GREED_ILVL_RESTRICTION, "LootNeedBeforeGreedILvlRestriction", 70);

    SetConfigValue<bool>(CONFIG_PLAYER_SETTINGS_ENABLED, "EnablePlayerSettings", 0);

    SetConfigValue<bool>(CONFIG_ALLOW_JOIN_BG_AND_LFG, "JoinBGAndLFG.Enable", false);

    SetConfigValue<bool>(CONFIG_LEAVE_GROUP_ON_LOGOUT, "LeaveGroupOnLogout.Enabled", false);

    SetConfigValue<uint32>(CONFIG_RANDOM_ROLL_MAXIMUM, "Group.RandomRollMaximum", 1000000);

    SetConfigValue<bool>(CONFIG_QUEST_POI_ENABLED, "QuestPOI.Enabled", true);

    SetConfigValue<uint32>(CONFIG_CHANGE_FACTION_MAX_MONEY, "ChangeFaction.MaxMoney", 0);

    SetConfigValue<bool>(CONFIG_ALLOWS_RANK_MOD_FOR_PET_HEALTH, "Pet.RankMod.Health", true);

    SetConfigValue<bool>(CONFIG_MUNCHING_BLIZZLIKE, "MunchingBlizzlike.Enabled", true);

    SetConfigValue<bool>(CONFIG_ENABLE_DAZE, "Daze.Enabled", true);

    SetConfigValue<bool>(CONFIG_ENABLE_INFINITEAMMO, "InfiniteAmmo.Enabled", false);

    SetConfigValue<uint32>(CONFIG_DAILY_RBG_MIN_LEVEL_AP_REWARD, "DailyRBGArenaPoints.MinLevel", 71);

    // Respawn
    SetConfigValue<float>(CONFIG_RESPAWN_DYNAMICRATE_CREATURE, "Respawn.DynamicRateCreature", 1.0f);
    SetConfigValue<uint32>(CONFIG_RESPAWN_DYNAMICMINIMUM_CREATURE, "Respawn.DynamicMinimumCreature", 10);

    SetConfigValue<float>(CONFIG_RESPAWN_DYNAMICRATE_GAMEOBJECT, "Respawn.DynamicRateGameObject", 1.0f);
    SetConfigValue<uint32>(CONFIG_RESPAWN_DYNAMICMINIMUM_GAMEOBJECT, "Respawn.DynamicMinimumGameObject", 10);

    SetConfigValue<bool>(CONFIG_VMAP_INDOOR_CHECK, "vmap.enableIndoorCheck", true);
    SetConfigValue<bool>(CONFIG_PET_LOS, "vmap.petLOS", true);

    SetConfigValue<bool>(CONFIG_VMAP_BLIZZLIKE_PVP_LOS, "vmap.BlizzlikePvPLOS", true);
    SetConfigValue<bool>(CONFIG_VMAP_BLIZZLIKE_LOS_OPEN_WORLD, "vmap.BlizzlikeLOSInOpenWorld", true);

    SetConfigValue<bool>(CONFIG_START_CUSTOM_SPELLS, "PlayerStart.CustomSpells", false);
    SetConfigValue<uint32>(CONFIG_HONOR_AFTER_DUEL, "HonorPointsAfterDuel", 0);
    SetConfigValue<bool>(CONFIG_START_ALL_EXPLORED, "PlayerStart.MapsExplored", false);
    SetConfigValue<bool>(CONFIG_START_ALL_REP, "PlayerStart.AllReputation", false);
    SetConfigValue<bool>(CONFIG_ALWAYS_MAXSKILL, "AlwaysMaxWeaponSkill", false);
    SetConfigValue<bool>(CONFIG_PVP_TOKEN_ENABLE, "PvPToken.Enable", false);
    SetConfigValue<uint32>(CONFIG_PVP_TOKEN_MAP_TYPE, "PvPToken.MapAllowType", 4);
    SetConfigValue<uint32>(CONFIG_PVP_TOKEN_ID, "PvPToken.ItemID", 29434);
    SetConfigValue<uint32>(CONFIG_PVP_TOKEN_COUNT, "PvPToken.ItemCount", 1, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value > 0; }, "> 0");

    SetConfigValue<bool>(CONFIG_NO_RESET_TALENT_COST, "NoResetTalentsCost", false);
    SetConfigValue<uint32>(CONFIG_TOGGLE_XP_COST, "ToggleXP.Cost", 100000);
    SetConfigValue<bool>(CONFIG_SHOW_KICK_IN_WORLD, "ShowKickInWorld", false);
    SetConfigValue<bool>(CONFIG_SHOW_MUTE_IN_WORLD, "ShowMuteInWorld", false);
    SetConfigValue<bool>(CONFIG_SHOW_BAN_IN_WORLD, "ShowBanInWorld", false);
    SetConfigValue<uint32>(CONFIG_NUMTHREADS, "MapUpdate.Threads", 1);
    SetConfigValue<uint32>(CONFIG_MAX_RESULTS_LOOKUP_COMMANDS, "Command.LookupMaxResults", 0);

    // Warden
    SetConfigValue<bool>(CONFIG_WARDEN_ENABLED, "Warden.Enabled", true);
    SetConfigValue<uint32>(CONFIG_WARDEN_NUM_MEM_CHECKS, "Warden.NumMemChecks", 3);
    SetConfigValue<uint32>(CONFIG_WARDEN_NUM_LUA_CHECKS, "Warden.NumLuaChecks", 1);
    SetConfigValue<uint32>(CONFIG_WARDEN_NUM_OTHER_CHECKS, "Warden.NumOtherChecks", 7);
    SetConfigValue<uint32>(CONFIG_WARDEN_CLIENT_BAN_DURATION, "Warden.BanDuration", 86400);
    SetConfigValue<uint32>(CONFIG_WARDEN_CLIENT_CHECK_HOLDOFF, "Warden.ClientCheckHoldOff", 30);
    SetConfigValue<uint32>(CONFIG_WARDEN_CLIENT_FAIL_ACTION, "Warden.ClientCheckFailAction", 0);
    SetConfigValue<uint32>(CONFIG_WARDEN_CLIENT_RESPONSE_DELAY, "Warden.ClientResponseDelay", 600);

    // Dungeon finder
    SetConfigValue<uint32>(CONFIG_LFG_OPTIONSMASK, "DungeonFinder.OptionsMask", 5);
    SetConfigValue<bool>(CONFIG_LFG_CAST_DESERTER, "DungeonFinder.CastDeserter", true);
    SetConfigValue<bool>(CONFIG_LFG_ALLOW_COMPLETED, "DungeonFinder.AllowCompleted", true);
    SetConfigValue<uint32>(CONFIG_LFG_DUNGEON_SELECTION_COOLDOWN, "DungeonFinder.DungeonSelectionCooldown", 0);

    // DBC_ItemAttributes
    SetConfigValue<bool>(CONFIG_DBC_ENFORCE_ITEM_ATTRIBUTES, "DBC.EnforceItemAttributes", true);

    // Max instances per hour
    SetConfigValue<uint32>(CONFIG_MAX_INSTANCES_PER_HOUR, "AccountInstancesPerHour", 5);

    // AutoBroadcast
    SetConfigValue<bool>(CONFIG_AUTOBROADCAST, "AutoBroadcast.On", false);
    SetConfigValue<uint32>(CONFIG_AUTOBROADCAST_CENTER, "AutoBroadcast.Center", 0);
    SetConfigValue<uint32>(CONFIG_AUTOBROADCAST_INTERVAL, "AutoBroadcast.Timer", 60000);
    SetConfigValue<uint32>(CONFIG_AUTOBROADCAST_MIN_LEVEL_DISABLE, "AutoBroadcast.MinDisableLevel", 0);

    // MySQL ping time interval
    SetConfigValue<uint32>(CONFIG_DB_PING_INTERVAL, "MaxPingTime", 30);

    // misc
    SetConfigValue<bool>(CONFIG_PDUMP_NO_PATHS, "PlayerDump.DisallowPaths", true);
    SetConfigValue<bool>(CONFIG_PDUMP_NO_OVERWRITE, "PlayerDump.DisallowOverwrite", true);
    SetConfigValue<bool>(CONFIG_ENABLE_MMAPS, "MoveMaps.Enable", true);

    // Wintergrasp
    SetConfigValue<uint32>(CONFIG_WINTERGRASP_ENABLE, "Wintergrasp.Enable", 1);
    SetConfigValue<uint32>(CONFIG_WINTERGRASP_PLR_MAX, "Wintergrasp.PlayerMax", 120);
    SetConfigValue<uint32>(CONFIG_WINTERGRASP_PLR_MIN, "Wintergrasp.PlayerMin", 0);
    SetConfigValue<uint32>(CONFIG_WINTERGRASP_PLR_MIN_LVL, "Wintergrasp.PlayerMinLvl", 75);
    SetConfigValue<uint32>(CONFIG_WINTERGRASP_BATTLETIME, "Wintergrasp.BattleTimer", 30);
    SetConfigValue<uint32>(CONFIG_WINTERGRASP_NOBATTLETIME, "Wintergrasp.NoBattleTimer", 150);
    SetConfigValue<uint32>(CONFIG_WINTERGRASP_RESTART_AFTER_CRASH, "Wintergrasp.CrashRestartTimer", 10);

    SetConfigValue<uint32>(CONFIG_BIRTHDAY_TIME, "BirthdayTime", 1222964635);
    SetConfigValue<bool>(CONFIG_MINIGOB_MANABONK, "Minigob.Manabonk.Enable", true);

    SetConfigValue<bool>(CONFIG_ENABLE_CONTINENT_TRANSPORT, "IsContinentTransport.Enabled", true);
    SetConfigValue<bool>(CONFIG_ENABLE_CONTINENT_TRANSPORT_PRELOADING, "IsPreloadedContinentTransport.Enabled", false);

    SetConfigValue<bool>(CONFIG_IP_BASED_ACTION_LOGGING, "Allow.IP.Based.Action.Logging", false);

    // Whether to use LoS from game objects
    SetConfigValue<bool>(CONFIG_CHECK_GOBJECT_LOS, "CheckGameObjectLoS", true);

    SetConfigValue<bool>(CONFIG_CALCULATE_CREATURE_ZONE_AREA_DATA, "Calculate.Creature.Zone.Area.Data", false);
    SetConfigValue<bool>(CONFIG_CALCULATE_GAMEOBJECT_ZONE_AREA_DATA, "Calculate.Gameoject.Zone.Area.Data", false);

    // Player can join LFG anywhere
    SetConfigValue<bool>(CONFIG_LFG_LOCATION_ALL, "LFG.Location.All", false);

    // Prevent players AFK from being logged out
    SetConfigValue<uint32>(CONFIG_AFK_PREVENT_LOGOUT, "PreventAFKLogout", 0);

    // Preload all grids of all non-instanced maps
    SetConfigValue<bool>(CONFIG_PRELOAD_ALL_NON_INSTANCED_MAP_GRIDS, "PreloadAllNonInstancedMapGrids", false);

    // ICC buff override
    SetConfigValue<uint32>(CONFIG_ICC_BUFF_HORDE, "ICC.Buff.Horde", 73822);
    SetConfigValue<uint32>(CONFIG_ICC_BUFF_ALLIANCE, "ICC.Buff.Alliance", 73828);

    // packet spoof punishment
    SetConfigValue<uint32>(CONFIG_PACKET_SPOOF_BANMODE, "PacketSpoof.BanMode", 0, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value == 0; }, "== 0");
    SetConfigValue<uint32>(CONFIG_PACKET_SPOOF_BANDURATION, "PacketSpoof.BanDuration", 86400);

    // Random Battleground Rewards
    SetConfigValue<uint32>(CONFIG_BG_REWARD_WINNER_HONOR_FIRST, "Battleground.RewardWinnerHonorFirst", 30);
    SetConfigValue<uint32>(CONFIG_BG_REWARD_WINNER_ARENA_FIRST, "Battleground.RewardWinnerArenaFirst", 25);
    SetConfigValue<uint32>(CONFIG_BG_REWARD_WINNER_HONOR_LAST, "Battleground.RewardWinnerHonorLast", 15);
    SetConfigValue<uint32>(CONFIG_BG_REWARD_WINNER_ARENA_LAST, "Battleground.RewardWinnerArenaLast", 0);
    SetConfigValue<uint32>(CONFIG_BG_REWARD_LOSER_HONOR_FIRST, "Battleground.RewardLoserHonorFirst", 5);
    SetConfigValue<uint32>(CONFIG_BG_REWARD_LOSER_HONOR_LAST, "Battleground.RewardLoserHonorLast", 5);

    SetConfigValue<uint32>(CONFIG_WAYPOINT_MOVEMENT_STOP_TIME_FOR_PLAYER, "WaypointMovementStopTimeForPlayer", 120);

    SetConfigValue<uint32>(CONFIG_DUNGEON_ACCESS_REQUIREMENTS_PRINT_MODE, "DungeonAccessRequirements.PrintMode", 1);
    SetConfigValue<bool>(CONFIG_DUNGEON_ACCESS_REQUIREMENTS_PORTAL_CHECK_ILVL, "DungeonAccessRequirements.PortalAvgIlevelCheck", false);
    SetConfigValue<bool>(CONFIG_DUNGEON_ACCESS_REQUIREMENTS_LFG_DBC_LEVEL_OVERRIDE, "DungeonAccessRequirements.LFGLevelDBCOverride", false);
    SetConfigValue<uint32>(CONFIG_DUNGEON_ACCESS_REQUIREMENTS_OPTIONAL_STRING_ID, "DungeonAccessRequirements.OptionalStringID", 0);
    SetConfigValue<uint32>(CONFIG_NPC_EVADE_IF_NOT_REACHABLE, "NpcEvadeIfTargetIsUnreachable", 5);
    SetConfigValue<uint32>(CONFIG_NPC_REGEN_TIME_IF_NOT_REACHABLE_IN_RAID, "NpcRegenHPTimeIfTargetIsUnreachable", 10);
    SetConfigValue<bool>(CONFIG_REGEN_HP_CANNOT_REACH_TARGET_IN_RAID, "NpcRegenHPIfTargetIsUnreachable", true);

    //Debug
    SetConfigValue<bool>(CONFIG_DEBUG_BATTLEGROUND, "Debug.Battleground", false);
    SetConfigValue<bool>(CONFIG_DEBUG_ARENA, "Debug.Arena", false);
    SetConfigValue<bool>(CONFIG_DEBUG_LFG, "Debug.LFG", false);

    SetConfigValue<uint32>(CONFIG_GM_LEVEL_CHANNEL_MODERATION, "Channel.ModerationGMLevel", 1);

    SetConfigValue<bool>(CONFIG_SET_BOP_ITEM_TRADEABLE, "Item.SetItemTradeable", true);

    // Specifies if IP addresses can be logged to the database
    SetConfigValue<bool>(CONFIG_ALLOW_LOGGING_IP_ADDRESSES_IN_DATABASE, "AllowLoggingIPAddressesInDatabase", true);

    // LFG group mechanics.
    SetConfigValue<uint32>(CONFIG_LFG_MAX_KICK_COUNT, "LFG.MaxKickCount", 2, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 3; }, "<= 3");

    SetConfigValue<uint32>(CONFIG_LFG_KICK_PREVENTION_TIMER, "LFG.KickPreventionTimer", 900, ConfigValueCache::Reloadable::Yes, [](uint32 const& value) { return value <= 15 * MINUTE * IN_MILLISECONDS; }, "<= 15 * MINUTE * IN_MILLISECONDS");

    // Realm Availability
    SetConfigValue<bool>(CONFIG_REALM_LOGIN_ENABLED, "World.RealmAvailability", true);

    // AH Worker threads
    SetConfigValue<uint32>(CONFIG_AUCTIONHOUSE_WORKERTHREADS, "AuctionHouse.WorkerThreads", 1, ConfigValueCache::Reloadable::No, [](uint32 const& value) { return value >= 1; }, ">= 1");

    // SpellQueue
    SetConfigValue<bool>(CONFIG_SPELL_QUEUE_ENABLED, "SpellQueue.Enabled", true);
    SetConfigValue<uint32>(CONFIG_SPELL_QUEUE_WINDOW, "SpellQueue.Window", 400);

    // World State
    SetConfigValue<uint32>(CONFIG_SUNSREACH_COUNTER_MAX, "Sunsreach.CounterMax", 10000);
    SetConfigValue<uint32>(CONFIG_SCOURGEINVASION_COUNTER_FIRST, "ScourgeInvasion.CounterFirst", 50);
    SetConfigValue<uint32>(CONFIG_SCOURGEINVASION_COUNTER_SECOND, "ScourgeInvasion.CounterSecond", 100);
    SetConfigValue<uint32>(CONFIG_SCOURGEINVASION_COUNTER_THIRD, "ScourgeInvasion.CounterThird", 150);

    SetConfigValue<std::string>(CONFIG_NEW_CHAR_STRING, "PlayerStart.String", "");
}
