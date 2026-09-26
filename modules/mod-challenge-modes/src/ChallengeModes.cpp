/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 */

#include "ChallengeModes.h"
#include "Chat.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "GossipDef.h"
#include "Log.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "StringFormat.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include <sstream>

ChallengeModes* ChallengeModes::instance()
{
    static ChallengeModes instance;
    return &instance;
}

char const* ChallengeModes::GetModeName(uint8 mode, bool spanish)
{
    switch (mode)
    {
        case CHALLENGE_HARDCORE:
            return spanish ? "Hardcore" : "Hardcore";
        case CHALLENGE_SEMI_HARDCORE:
            return spanish ? "Semi-Hardcore" : "Semi-Hardcore";
        case CHALLENGE_SELF_CRAFTED:
            return spanish ? "Solo fabricado" : "Self-Crafted";
        case CHALLENGE_ITEM_QUALITY:
            return spanish ? "Calidad baja" : "Item Quality";
        case CHALLENGE_SLOW_XP:
            return spanish ? "XP lenta" : "Slow XP";
        case CHALLENGE_VERY_SLOW_XP:
            return spanish ? "XP muy lenta" : "Very Slow XP";
        case CHALLENGE_QUEST_XP_ONLY:
            return spanish ? "Solo XP de misiones" : "Quest XP Only";
        case CHALLENGE_IRON_MAN:
            return spanish ? "Iron Man" : "Iron Man";
        default:
            return spanish ? "Desconocido" : "Unknown";
    }
}

char const* ChallengeModes::GetModeDescription(uint8 mode, bool spanish)
{
    switch (mode)
    {
        case CHALLENGE_HARDCORE:
            return spanish
                ? "Si mueres, quedas como fantasma para siempre."
                : "If you die you remain a ghost forever.";
        case CHALLENGE_SEMI_HARDCORE:
            return spanish
                ? "Si mueres pierdes el equipo puesto y todo el oro."
                : "If you die you lose worn gear and all carried gold.";
        case CHALLENGE_SELF_CRAFTED:
            return spanish
                ? "Solo puedes equipar objetos que hayas fabricado tu."
                : "You can only equip items you crafted yourself.";
        case CHALLENGE_ITEM_QUALITY:
            return spanish
                ? "Solo puedes equipar objetos pobres o comunes."
                : "You can only equip Poor or Common quality items.";
        case CHALLENGE_SLOW_XP:
            return spanish ? "Recibes la mitad de experiencia." : "You receive half the normal experience.";
        case CHALLENGE_VERY_SLOW_XP:
            return spanish ? "Recibes un cuarto de experiencia." : "You receive a quarter of the normal experience.";
        case CHALLENGE_QUEST_XP_ONLY:
            return spanish
                ? "Solo las misiones dan experiencia."
                : "Only quests grant experience.";
        case CHALLENGE_IRON_MAN:
            return spanish
                ? "Sin resucitar, sin talentos, sin objetos raros, pociones, encantamientos ni grupos."
                : "No resurrect, talents, rare gear, potions, enchants or groups.";
        default:
            return "";
    }
}

uint8 ChallengeModes::GetModeGossipIcon(uint8 mode)
{
    switch (mode)
    {
        case CHALLENGE_HARDCORE:
            return GOSSIP_ICON_BATTLE;
        case CHALLENGE_SEMI_HARDCORE:
            return GOSSIP_ICON_MONEY_BAG;
        case CHALLENGE_SELF_CRAFTED:
            return GOSSIP_ICON_TRAINER;
        case CHALLENGE_ITEM_QUALITY:
            return GOSSIP_ICON_TABARD;
        case CHALLENGE_SLOW_XP:
            return GOSSIP_ICON_TAXI;
        case CHALLENGE_VERY_SLOW_XP:
            return GOSSIP_ICON_INTERACT_1;
        case CHALLENGE_QUEST_XP_ONLY:
            return GOSSIP_ICON_TALK;
        case CHALLENGE_IRON_MAN:
            return GOSSIP_ICON_BATTLE;
        case CHALLENGE_NORMAL_MODE:
            return GOSSIP_ICON_CHAT;
        default:
            return GOSSIP_ICON_DOT;
    }
}

bool ChallengeModes::IsSpanish(Player const* player)
{
    if (!player || !player->GetSession())
        return false;

    LocaleConstant locale = player->GetSession()->GetSessionDbcLocale();
    return locale == LOCALE_esES || locale == LOCALE_esMX;
}

void ChallengeModes::LoadRewardMap(std::unordered_map<uint8, uint32>& map, std::string const& config)
{
    map.clear();
    std::stringstream stream(config);
    std::string token;
    while (std::getline(stream, token, ','))
    {
        std::stringstream pairStream(token);
        uint32 level = 0;
        uint32 value = 0;
        if (!(pairStream >> level >> value) || !level)
            continue;

        map[static_cast<uint8>(level)] = value;
    }
}

void ChallengeModes::LoadConfig(bool /*reload*/)
{
    _enabled = sConfigMgr->GetOption<bool>("ChallengeModes.Enable", true);
    _firstLoginUi = sConfigMgr->GetOption<bool>("ChallengeModes.FirstLoginUI", true);
    _npcEntry = sConfigMgr->GetOption<uint32>("ChallengeModes.NPCEntry", NPC_CHALLENGE_KEEPER);

    auto loadMode = [this](uint8 mode, char const* prefix, float defaultXp)
    {
        auto option = [prefix](char const* name)
        {
            return Acore::StringFormat("{}.{}", prefix, name);
        };

        ChallengeModeConfig& config = _modes[mode];
        config.Enabled = sConfigMgr->GetOption<bool>(option("Enable"), true);
        config.DisableLevel = sConfigMgr->GetOption<uint32>(option("DisableLevel"), 0);
        config.XpMultiplier = sConfigMgr->GetOption<float>(option("XPMultiplier"), defaultXp);
        config.ItemRewardAmount = sConfigMgr->GetOption<uint32>(option("ItemRewardAmount"), 1);
        LoadRewardMap(config.TitleRewards, sConfigMgr->GetOption<std::string>(option("TitleRewards"), ""));
        LoadRewardMap(config.TalentRewards, sConfigMgr->GetOption<std::string>(option("TalentRewards"), ""));
        LoadRewardMap(config.ItemRewards, sConfigMgr->GetOption<std::string>(option("ItemRewards"), ""));
        LoadRewardMap(config.AchievementRewards, sConfigMgr->GetOption<std::string>(option("AchievementReward"), ""));
    };

    loadMode(CHALLENGE_HARDCORE, "Hardcore", 1.f);
    loadMode(CHALLENGE_SEMI_HARDCORE, "SemiHardcore", 1.f);
    loadMode(CHALLENGE_SELF_CRAFTED, "SelfCrafted", 1.f);
    loadMode(CHALLENGE_ITEM_QUALITY, "ItemQualityLevel", 1.f);
    loadMode(CHALLENGE_SLOW_XP, "SlowXpGain", 0.5f);
    loadMode(CHALLENGE_VERY_SLOW_XP, "VerySlowXpGain", 0.25f);
    loadMode(CHALLENGE_QUEST_XP_ONLY, "QuestXpOnly", 1.f);
    loadMode(CHALLENGE_IRON_MAN, "IronMan", 1.f);

    LOG_INFO("module.challengemodes", "Challenge Modes: {} (npc {})", _enabled ? "enabled" : "disabled", _npcEntry);
}

void ChallengeModes::EnsureDatabase()
{
    CharacterDatabase.DirectExecute(
        "CREATE TABLE IF NOT EXISTS `character_challenge_modes` ("
        " `guid` INT UNSIGNED NOT NULL,"
        " `hardcore` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `semi_hardcore` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `self_crafted` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `item_quality` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `slow_xp` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `very_slow_xp` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `quest_xp` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `iron_man` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `hardcore_dead` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " `picker_done` TINYINT UNSIGNED NOT NULL DEFAULT 0,"
        " PRIMARY KEY (`guid`)"
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

    if (!CharacterDatabase.Query("SHOW COLUMNS FROM character_challenge_modes LIKE 'picker_done'"))
        CharacterDatabase.DirectExecute(
            "ALTER TABLE character_challenge_modes ADD COLUMN `picker_done` TINYINT UNSIGNED NOT NULL DEFAULT 0");
}

void ChallengeModes::LoadPlayer(Player* player)
{
    if (!player)
        return;

    uint32 guid = player->GetGUID().GetCounter();
    ChallengeModeState state;
    if (QueryResult result = CharacterDatabase.Query(
            "SELECT hardcore, semi_hardcore, self_crafted, item_quality, slow_xp, very_slow_xp, "
            "quest_xp, iron_man, hardcore_dead, picker_done FROM character_challenge_modes WHERE guid = {}", guid))
    {
        Field* fields = result->Fetch();
        for (uint8 i = 0; i < CHALLENGE_MODE_MAX; ++i)
            state.Flag[i] = fields[i].Get<uint8>();
        state.PickerDone = fields[CHALLENGE_MODE_MAX].Get<uint8>();
    }

    _players[guid] = state;
}

void ChallengeModes::UnloadPlayer(ObjectGuid guid)
{
    _players.erase(guid.GetCounter());
}

void ChallengeModes::SavePlayer(ObjectGuid guid)
{
    ChallengeModeState const* state = GetState(guid);
    if (!state)
        return;

    CharacterDatabase.Execute(
        "REPLACE INTO character_challenge_modes "
        "(guid, hardcore, semi_hardcore, self_crafted, item_quality, slow_xp, very_slow_xp, "
        "quest_xp, iron_man, hardcore_dead, picker_done) VALUES ({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {})",
        guid.GetCounter(),
        uint32(state->Flag[CHALLENGE_HARDCORE]),
        uint32(state->Flag[CHALLENGE_SEMI_HARDCORE]),
        uint32(state->Flag[CHALLENGE_SELF_CRAFTED]),
        uint32(state->Flag[CHALLENGE_ITEM_QUALITY]),
        uint32(state->Flag[CHALLENGE_SLOW_XP]),
        uint32(state->Flag[CHALLENGE_VERY_SLOW_XP]),
        uint32(state->Flag[CHALLENGE_QUEST_XP_ONLY]),
        uint32(state->Flag[CHALLENGE_IRON_MAN]),
        uint32(state->Flag[CHALLENGE_HARDCORE_DEAD]),
        uint32(state->PickerDone));
}

ChallengeModeState* ChallengeModes::GetState(ObjectGuid guid)
{
    auto it = _players.find(guid.GetCounter());
    return it == _players.end() ? nullptr : &it->second;
}

ChallengeModeState const* ChallengeModes::GetState(ObjectGuid guid) const
{
    auto it = _players.find(guid.GetCounter());
    return it == _players.end() ? nullptr : &it->second;
}

bool ChallengeModes::IsModeEnabled(uint8 mode) const
{
    return _enabled && mode <= CHALLENGE_IRON_MAN && _modes[mode].Enabled;
}

ChallengeModeConfig const& ChallengeModes::GetModeConfig(uint8 mode) const
{
    return _modes[mode <= CHALLENGE_IRON_MAN ? mode : uint8(CHALLENGE_HARDCORE)];
}

bool ChallengeModes::IsEnabled(ObjectGuid guid, uint8 mode) const
{
    if (mode >= CHALLENGE_MODE_MAX)
        return false;

    ChallengeModeState const* state = GetState(guid);
    return state && state->Flag[mode] != 0;
}

void ChallengeModes::SetEnabled(Player* player, uint8 mode, bool enabled)
{
    if (!player || mode >= CHALLENGE_MODE_MAX)
        return;

    ChallengeModeState* state = GetState(player->GetGUID());
    if (!state)
    {
        LoadPlayer(player);
        state = GetState(player->GetGUID());
        if (!state)
            return;
    }

    state->Flag[mode] = enabled ? 1 : 0;
    SavePlayer(player->GetGUID());
}

bool ChallengeModes::CanActivate(Player const* player) const
{
    if (!player)
        return false;

    if (player->getClass() == CLASS_DEATH_KNIGHT)
        return player->GetLevel() <= 55;

    return player->GetLevel() <= 1;
}

bool ChallengeModes::Conflicts(uint8 mode, ObjectGuid guid) const
{
    switch (mode)
    {
        case CHALLENGE_HARDCORE:
            return IsEnabled(guid, CHALLENGE_SEMI_HARDCORE);
        case CHALLENGE_SEMI_HARDCORE:
            return IsEnabled(guid, CHALLENGE_HARDCORE);
        case CHALLENGE_SELF_CRAFTED:
            return IsEnabled(guid, CHALLENGE_IRON_MAN);
        case CHALLENGE_IRON_MAN:
            return IsEnabled(guid, CHALLENGE_SELF_CRAFTED);
        case CHALLENGE_SLOW_XP:
            return IsEnabled(guid, CHALLENGE_VERY_SLOW_XP);
        case CHALLENGE_VERY_SLOW_XP:
            return IsEnabled(guid, CHALLENGE_SLOW_XP);
        default:
            return false;
    }
}

bool ChallengeModes::EnableChallenge(Player* player, uint8 mode, std::string& error)
{
    bool const spanish = IsSpanish(player);

    if (!_enabled)
    {
        error = spanish ? "Los desafios estan desactivados." : "Challenge modes are disabled.";
        return false;
    }

    if (!IsModeEnabled(mode))
    {
        error = spanish ? "Ese desafio no esta disponible." : "That challenge is not available.";
        return false;
    }

    if (!CanActivate(player))
    {
        error = spanish
            ? "Solo puedes activar desafios en nivel 1 (o 55 si eres Caballero de la Muerte)."
            : "Challenges can only be enabled at level 1 (or 55 for Death Knights).";
        return false;
    }

    if (IsEnabled(player->GetGUID(), mode))
    {
        error = spanish ? "Ya tienes ese desafio activo." : "That challenge is already active.";
        return false;
    }

    if (Conflicts(mode, player->GetGUID()))
    {
        error = spanish
            ? "Ese desafio entra en conflicto con uno que ya tienes activo."
            : "That challenge conflicts with one you already have active.";
        return false;
    }

    SetEnabled(player, mode, true);
    MarkPickerDone(player);
    return true;
}

bool ChallengeModes::HasActiveChallenge(ObjectGuid guid) const
{
    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
        if (IsEnabled(guid, mode))
            return true;

    return false;
}

bool ChallengeModes::IsPickerDone(ObjectGuid guid) const
{
    ChallengeModeState const* state = GetState(guid);
    return state && state->PickerDone != 0;
}

bool ChallengeModes::ShouldShowFirstLoginPicker(Player const* player) const
{
    if (!_enabled || !_firstLoginUi || !player)
        return false;

    if (!CanActivate(player))
        return false;

    if (IsPickerDone(player->GetGUID()) || HasActiveChallenge(player->GetGUID()))
        return false;

    return true;
}

void ChallengeModes::MarkPickerDone(Player* player)
{
    if (!player)
        return;

    ChallengeModeState* state = GetState(player->GetGUID());
    if (!state)
    {
        LoadPlayer(player);
        state = GetState(player->GetGUID());
        if (!state)
            return;
    }

    state->PickerDone = 1;
    SavePlayer(player->GetGUID());
}

bool ChallengeModes::ChooseNormal(Player* player, std::string& error)
{
    bool const spanish = IsSpanish(player);

    if (!_enabled)
    {
        error = spanish ? "Los desafios estan desactivados." : "Challenge modes are disabled.";
        return false;
    }

    if (!CanActivate(player))
    {
        error = spanish
            ? "Solo puedes elegir modo en nivel 1 (o 55 si eres Caballero de la Muerte)."
            : "You can only choose a mode at level 1 (or 55 for Death Knights).";
        return false;
    }

    if (HasActiveChallenge(player->GetGUID()))
    {
        error = spanish ? "Este personaje ya tiene un modo de juego." : "This character already has a challenge mode.";
        return false;
    }

    MarkPickerDone(player);
    return true;
}

void ChallengeModes::SendPickerAddon(Player* player) const
{
    if (!player)
        return;

    std::string flags;
    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
    {
        if (!flags.empty())
            flags += ',';
        flags += IsModeEnabled(mode) ? '1' : '0';
    }

    std::string const msg = Acore::StringFormat("CMUI\tOPEN\t{}\t{}",
        IsSpanish(player) ? "es" : "en", flags);

    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER, LANG_ADDON, player, player, msg);
    player->SendDirectMessage(&data);
}

void ChallengeModes::OpenFirstLoginPicker(Player* player)
{
    if (!player || !ShouldShowFirstLoginPicker(player))
        return;

    SendPickerAddon(player);

    ClearGossipMenuFor(player);
    bool const spanish = IsSpanish(player);

    AddGossipItemFor(player, GOSSIP_ICON_TALK,
        spanish ? "Elige un camino. Solo uno, y no se puede cambiar."
                : "Choose a path. Only one, and it cannot be changed.",
        GOSSIP_SENDER_MAIN, 0);

    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
    {
        if (!IsModeEnabled(mode))
            continue;

        std::string const label = Acore::StringFormat("|cffffd100{}|r - {}",
            GetModeName(mode, spanish), GetModeDescription(mode, spanish));
        uint32 const action = GOSSIP_CHALLENGE_ENABLE_BASE + mode;

        if (mode == CHALLENGE_HARDCORE || mode == CHALLENGE_IRON_MAN)
            AddGossipItemFor(player, GetModeGossipIcon(mode), label, GOSSIP_SENDER_MAIN, action,
                spanish ? "Este modo no se puede desactivar. ¿Aceptar?"
                        : "This mode cannot be turned off. Accept?",
                0, false);
        else
            AddGossipItemFor(player, GetModeGossipIcon(mode), label, GOSSIP_SENDER_MAIN, action);
    }

    AddGossipItemFor(player, GOSSIP_ICON_CHAT,
        spanish ? "|cff00ff00Modo normal|r - Juego clasico, sin restricciones."
                : "|cff00ff00Normal mode|r - Classic play, no restrictions.",
        GOSSIP_SENDER_MAIN, GOSSIP_CHALLENGE_NORMAL);

    player->PlayerTalkClass->GetGossipMenu().SetMenuId(GOSSIP_MENU_CHALLENGE);
    SendGossipMenuFor(player, NPC_TEXT_CHALLENGE_PICKER, player->GetGUID());
}

bool ChallengeModes::HandlePickerAddon(Player* player, std::string const& msg)
{
    if (!player || msg.rfind("CMUI\t", 0) != 0)
        return false;

    std::string const body = msg.substr(5);
    bool const spanish = IsSpanish(player);
    std::string error;

    if (body == "NORMAL")
    {
        if (!ChooseNormal(player, error))
        {
            ChatHandler(player->GetSession()).SendSysMessage(error);
            return true;
        }

        ChatHandler(player->GetSession()).SendSysMessage(spanish
            ? "Has elegido el modo normal. Juega sin restricciones."
            : "You chose Normal mode. Play without restrictions.");
        CloseGossipMenuFor(player);
        return true;
    }

    if (body.rfind("SELECT\t", 0) != 0)
        return body == "HELLO";

    uint32 mode = 0;
    std::stringstream selectStream(body.substr(7));
    if (!(selectStream >> mode) || mode > CHALLENGE_IRON_MAN)
        return true;

    if (!EnableChallenge(player, uint8(mode), error))
    {
        ChatHandler(player->GetSession()).SendSysMessage(error);
        return true;
    }

    ChatHandler(player->GetSession()).PSendSysMessage(
        spanish ? "Desafio activado: {}." : "Challenge enabled: {}.",
        GetModeName(uint8(mode), spanish));
    CloseGossipMenuFor(player);
    return true;
}

void ChallengeModes::GiveLevelRewards(Player* player, uint8 /*oldLevel*/)
{
    if (!player)
        return;

    uint8 const level = player->GetLevel();
    bool const spanish = IsSpanish(player);

    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
    {
        if (!IsEnabled(player->GetGUID(), mode))
            continue;

        ChallengeModeConfig const& config = _modes[mode];

        if (auto it = config.TitleRewards.find(level); it != config.TitleRewards.end())
        {
            if (CharTitlesEntry const* title = sCharTitlesStore.LookupEntry(it->second))
                player->SetTitle(title);
            else
                LOG_ERROR("module.challengemodes", "Invalid title {} for {} at level {}",
                    it->second, GetModeName(mode, false), level);
        }

        if (auto it = config.TalentRewards.find(level); it != config.TalentRewards.end())
            player->RewardExtraBonusTalentPoints(it->second);

        if (auto it = config.AchievementRewards.find(level); it != config.AchievementRewards.end())
        {
            if (AchievementEntry const* achievement = sAchievementStore.LookupEntry(it->second))
                player->CompletedAchievement(achievement);
            else
                LOG_ERROR("module.challengemodes", "Invalid achievement {} for {} at level {}",
                    it->second, GetModeName(mode, false), level);
        }

        if (auto it = config.ItemRewards.find(level); it != config.ItemRewards.end())
            player->SendItemRetrievalMail({ { it->second, config.ItemRewardAmount } });

        if (config.DisableLevel && config.DisableLevel <= level)
        {
            SetEnabled(player, mode, false);
            ChatHandler(player->GetSession()).PSendSysMessage(
                spanish ? "{} se ha completado y se ha desactivado." : "{} has been completed and disabled.",
                GetModeName(mode, spanish));
        }
    }
}
