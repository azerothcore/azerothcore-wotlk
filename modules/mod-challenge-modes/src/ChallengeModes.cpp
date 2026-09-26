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
#include "ItemTemplate.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "StringFormat.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "WorldSessionMgr.h"
#include <limits>
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
            return spanish ? "Hombre de Hierro" : "Iron Man";
        default:
            return spanish ? "Desconocido" : "Unknown";
    }
}

char const* ChallengeModes::GetModeTitle(uint8 mode, bool spanish)
{
    switch (mode)
    {
        case CHALLENGE_HARDCORE:
            return spanish ? "el Imperecedero" : "the Undying";
        case CHALLENGE_SEMI_HARDCORE:
            return spanish ? "de la Caida Nocturna" : "of the Nightfall";
        case CHALLENGE_SELF_CRAFTED:
            return spanish ? "el Supremo" : "the Supreme";
        case CHALLENGE_ITEM_QUALITY:
            return "Jenkins";
        case CHALLENGE_SLOW_XP:
            return spanish ? "el Paciente" : "the Patient";
        case CHALLENGE_VERY_SLOW_XP:
            return spanish ? "el Explorador" : "the Explorer";
        case CHALLENGE_QUEST_XP_ONLY:
            return spanish ? "Maestro Cultural" : "Loremaster";
        case CHALLENGE_IRON_MAN:
            return spanish ? "el Demente" : "the Insane";
        default:
            return "";
    }
}

char const* ChallengeModes::GetModeShortDescription(uint8 mode, bool spanish)
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

char const* ChallengeModes::GetModeDescription(uint8 mode, bool spanish)
{
    switch (mode)
    {
        case CHALLENGE_HARDCORE:
            return spanish
                ? "HARDCORE: una sola vida. Si mueres por un monstruo, un jugador o al liberar tu espiritu, "
                  "quedas como fantasma para siempre: no puedes resucitar, ni en cementerio ni por hechizo. "
                  "El servidor anuncia tu caida. El reto se completa al llegar a nivel 80 sin morir. "
                  "No se puede desactivar y es el unico modo que puede tener este personaje."
                : "HARDCORE: one life. If you die to a mob, a player or by releasing your spirit you stay a "
                  "ghost forever — no graveyard, no res spells. The realm announces your fall. Finish by "
                  "reaching level 80 without dying. Cannot be turned off. One mode per character.";
        case CHALLENGE_SEMI_HARDCORE:
            return spanish
                ? "SEMI-HARDCORE: puedes morir, pero cada muerte te despoja de TODO el equipo puesto y de "
                  "TODO el oro que lleves encima (bolsas y banco no). Sirve para jugar con riesgo sin "
                  "perder el personaje. Completas el reto al llegar a nivel 80. Un solo modo por personaje."
                : "SEMI-HARDCORE: you may die, but each death strips ALL worn equipment and ALL gold you "
                  "are carrying (bags and bank stay). High risk without deleting the character. Complete "
                  "the run by reaching level 80. One mode per character.";
        case CHALLENGE_SELF_CRAFTED:
            return spanish
                ? "SOLO FABRICADO: solo puedes equipar objetos que TU hayas fabricado (el creador del "
                  "objeto debe ser este personaje). No vale loot, ni el AH, ni regalos, ni drops de jefes. "
                  "Armaduras y armas tienen que salir de tus profesiones. Completas el reto al nivel 80. "
                  "Un solo modo por personaje."
                : "SELF-CRAFTED: you may only equip items YOU crafted (item creator must be this character). "
                  "No loot, auction house, gifts or boss drops. Armor and weapons must come from your "
                  "professions. Complete the run at level 80. One mode per character.";
        case CHALLENGE_ITEM_QUALITY:
            return spanish
                ? "CALIDAD BAJA: solo puedes equipar objetos pobres (gris) o comunes (blanco). Nada de "
                  "verdes, azules, epicos ni legendarios: ni de misiones, ni de mazmorras, ni del AH. "
                  "Las bolsas y objetos no equipables no cuentan. Completas el reto al nivel 80. "
                  "Un solo modo por personaje."
                : "ITEM QUALITY: you may only equip Poor (grey) or Common (white) items. No uncommon, rare, "
                  "epic or legendary gear from quests, dungeons or the auction house. Bags and non-equip "
                  "items are fine. Complete the run at level 80. One mode per character.";
        case CHALLENGE_SLOW_XP:
            return spanish
                ? "XP LENTA: recibes la mitad de la experiencia (muertes, misiones y exploracion). El "
                  "subir de nivel tarda el doble. Puedes usar equipo normal. Completas el reto al "
                  "llegar a nivel 80. Un solo modo por personaje; no se combina con XP muy lenta."
                : "SLOW XP: you receive half experience from kills, quests and exploration, so leveling "
                  "takes twice as long. Normal gear is allowed. Complete the run at level 80. One mode "
                  "per character; cannot be combined with Very Slow XP.";
        case CHALLENGE_VERY_SLOW_XP:
            return spanish
                ? "XP MUY LENTA: recibes un 25% de la experiencia normal. Es el ritmo mas exigente: "
                  "cada nivel cuesta cuatro veces mas. Equipo libre. Completas el reto al nivel 80. "
                  "Un solo modo por personaje; no se combina con XP lenta."
                : "VERY SLOW XP: you receive 25% of normal experience. The harshest pace — each level "
                  "costs four times as much. Gear is unrestricted. Complete the run at level 80. One "
                  "mode per character; cannot be combined with Slow XP.";
        case CHALLENGE_QUEST_XP_ONLY:
            return spanish
                ? "SOLO XP DE MISIONES: las muertes, la exploracion y los campos de batalla no dan "
                  "experiencia. Solo las misiones suben de nivel (tu mascota si puede ganar XP de "
                  "asesinatos). Equipo libre. Completas el reto al nivel 80. Un solo modo por personaje."
                : "QUEST XP ONLY: kills, exploration and battlegrounds grant no experience. Only quests "
                  "level you (your pet can still gain kill XP). Gear is unrestricted. Complete the run "
                  "at level 80. One mode per character.";
        case CHALLENGE_IRON_MAN:
            return spanish
                ? "HOMBRE DE HIERRO: el reglamento mas duro. No puedes resucitar. No ganas puntos de "
                  "talento (el servidor los anula al subir de nivel y no puedes aprenderlos). "
                  "Solo equipo pobre o comun, sin encantamientos, sin pociones, elixires, frascos ni "
                  "comida con buff. No puedes aprender profesiones extra ni unirte a un grupo. Una "
                  "muerte termina el espiritu de la run. Completas el reto al nivel 80. Un solo modo."
                : "IRON MAN: the strictest ruleset. You cannot resurrect. You gain no talent points "
                  "(the server zeroes them on level-up and blocks learning). "
                  "Poor/Common gear only, no enchants, potions, elixirs, flasks or food buffs. No extra "
                  "professions and no groups. Death ends the spirit of the run. Complete at level 80. "
                  "One mode per character.";
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

    auto isEs = [](LocaleConstant loc)
    {
        return loc == LOCALE_esES || loc == LOCALE_esMX;
    };

    WorldSession const* session = player->GetSession();
    return isEs(session->GetSessionDbcLocale()) || isEs(session->GetSessionDbLocaleIndex());
}

std::string ChallengeModes::GetFormattedTitle(Player const* player, uint8 mode) const
{
    if (!player)
        return GetModeTitle(mode, false);

    uint32 const titleId = GetModeConfig(mode).RewardTitle;
    if (CharTitlesEntry const* title = titleId ? sCharTitlesStore.LookupEntry(titleId) : nullptr)
    {
        LocaleConstant const loc = player->GetSession()
            ? player->GetSession()->GetSessionDbcLocale()
            : LOCALE_enUS;
        char const* pattern = player->getGender() == GENDER_MALE
            ? title->nameMale[loc]
            : title->nameFemale[loc];
        if (!pattern || !pattern[0])
            pattern = title->nameMale[LOCALE_enUS];

        if (pattern && pattern[0])
        {
            std::string formatted(pattern);
            if (size_t const pos = formatted.find("%s"); pos != std::string::npos)
                formatted.replace(pos, 2, player->GetName());
            return formatted;
        }
    }

    return Acore::StringFormat("{} {}", player->GetName(), GetModeTitle(mode, IsSpanish(player)));
}

void ChallengeModes::GrantModeTitle(Player* player, uint8 mode, bool makeCurrent) const
{
    if (!player || mode > CHALLENGE_IRON_MAN)
        return;

    uint32 const titleId = _modes[mode].RewardTitle;
    if (!titleId)
        return;

    CharTitlesEntry const* title = sCharTitlesStore.LookupEntry(titleId);
    if (!title)
    {
        LOG_ERROR("module.challengemodes", "Invalid RewardTitle {} for {}",
            titleId, GetModeName(mode, false));
        return;
    }

    player->SetTitle(title);
    if (makeCurrent)
        player->SetCurrentTitle(title);
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
    _announce = sConfigMgr->GetOption<bool>("ChallengeModes.Announce", true);
    _firstLoginUi = sConfigMgr->GetOption<bool>("ChallengeModes.FirstLoginUI", true);
    _npcEntry = sConfigMgr->GetOption<uint32>("ChallengeModes.NPCEntry", NPC_CHALLENGE_KEEPER);

    auto loadMode = [this](uint8 mode, char const* prefix, float defaultXp, uint32 defaultTitle)
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
        config.RewardLevel = sConfigMgr->GetOption<uint32>(option("RewardLevel"), 80);
        config.RewardItem = sConfigMgr->GetOption<uint32>(option("RewardItem"), 0);
        config.RewardItemCount = sConfigMgr->GetOption<uint32>(option("RewardItemCount"), 1);
        config.RewardTitle = sConfigMgr->GetOption<uint32>(option("RewardTitle"), defaultTitle);
        config.RewardGold = sConfigMgr->GetOption<uint32>(option("RewardGold"), 0);
        config.RewardHonor = sConfigMgr->GetOption<uint32>(option("RewardHonor"), 0);
        config.RewardAchievement = sConfigMgr->GetOption<uint32>(option("RewardAchievement"), 0);
        config.RewardTalents = sConfigMgr->GetOption<uint32>(option("RewardTalents"), 0);
        LoadRewardMap(config.TitleRewards, sConfigMgr->GetOption<std::string>(option("TitleRewards"), ""));
        LoadRewardMap(config.TalentRewards, sConfigMgr->GetOption<std::string>(option("TalentRewards"), ""));
        LoadRewardMap(config.ItemRewards, sConfigMgr->GetOption<std::string>(option("ItemRewards"), ""));
        LoadRewardMap(config.AchievementRewards, sConfigMgr->GetOption<std::string>(option("AchievementReward"), ""));
    };

    // Default titles are stock 3.3.5 CharTitles.dbc ids (visible without a client patch).
    loadMode(CHALLENGE_HARDCORE, "Hardcore", 1.f, 142);             // the Undying
    loadMode(CHALLENGE_SEMI_HARDCORE, "SemiHardcore", 1.f, 140);    // of the Nightfall
    loadMode(CHALLENGE_SELF_CRAFTED, "SelfCrafted", 1.f, 85);       // the Supreme
    loadMode(CHALLENGE_ITEM_QUALITY, "ItemQualityLevel", 1.f, 143); // Jenkins
    loadMode(CHALLENGE_SLOW_XP, "SlowXpGain", 0.5f, 172);           // the Patient
    loadMode(CHALLENGE_VERY_SLOW_XP, "VerySlowXpGain", 0.25f, 78);  // the Explorer
    loadMode(CHALLENGE_QUEST_XP_ONLY, "QuestXpOnly", 1.f, 125);     // Loremaster
    loadMode(CHALLENGE_IRON_MAN, "IronMan", 1.f, 145);              // the Insane

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
    uint32 const id = guid.GetCounter();
    _players.erase(id);
    _ironManDeathAnnounced.erase(id);
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

bool ChallengeModes::HasActiveChallenge(ObjectGuid guid) const
{
    return GetActiveChallenge(guid).has_value();
}

Optional<uint8> ChallengeModes::GetActiveChallenge(ObjectGuid guid) const
{
    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
        if (IsEnabled(guid, mode))
            return mode;

    return {};
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

    if (HasActiveChallenge(player->GetGUID()))
    {
        error = spanish
            ? "Este personaje ya tiene un modo de juego. Solo se permite uno."
            : "This character already has a challenge mode. Only one is allowed.";
        return false;
    }

    SetEnabled(player, mode, true);
    MarkPickerDone(player);
    GrantModeTitle(player, mode, true);
    if (mode == CHALLENGE_IRON_MAN)
    {
        player->SetFreeTalentPoints(0);
        player->InitTalentForLevel();
    }
    BroadcastStart(player, mode);
    return true;
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

std::string ChallengeModes::SanitizeAddonField(std::string text, size_t maxLen)
{
    for (char& c : text)
        if (c == '\t' || c == '\n' || c == '\r')
            c = ' ';

    while (!text.empty() && text.front() == ' ')
        text.erase(text.begin());
    while (!text.empty() && text.back() == ' ')
        text.pop_back();

    if (text.size() > maxLen)
        text.resize(maxLen);

    return text;
}

std::string ChallengeModes::GetTitleHonorific(Player const* player, uint32 titleId) const
{
    CharTitlesEntry const* title = titleId ? sCharTitlesStore.LookupEntry(titleId) : nullptr;
    if (!title)
        return {};

    LocaleConstant const loc = player && player->GetSession()
        ? player->GetSession()->GetSessionDbcLocale()
        : LOCALE_enUS;
    bool const female = player && player->getGender() == GENDER_FEMALE;
    char const* pattern = female ? title->nameFemale[loc] : title->nameMale[loc];
    if (!pattern || !pattern[0])
        pattern = title->nameMale[LOCALE_enUS];
    if (!pattern || !pattern[0])
        return {};

    std::string formatted(pattern);
    if (size_t const pos = formatted.find("%s"); pos != std::string::npos)
        formatted.erase(pos, 2);

    return SanitizeAddonField(std::move(formatted), 48);
}

std::string ChallengeModes::GetLocalizedItemName(Player const* player, uint32 itemId) const
{
    ItemTemplate const* proto = sObjectMgr->GetItemTemplate(itemId);
    if (!proto)
        return {};

    std::string name = proto->Name1;
    LocaleConstant const loc = player && player->GetSession()
        ? player->GetSession()->GetSessionDbLocaleIndex()
        : LOCALE_enUS;
    if (ItemLocale const* itemLocale = sObjectMgr->GetItemLocale(itemId))
        ObjectMgr::GetLocaleString(itemLocale->Name, loc, name);

    return SanitizeAddonField(std::move(name), 48);
}

std::string ChallengeModes::GetLocalizedAchievementName(Player const* player, uint32 achievementId) const
{
    AchievementEntry const* achievement = sAchievementStore.LookupEntry(achievementId);
    if (!achievement)
        return {};

    LocaleConstant loc = player && player->GetSession()
        ? player->GetSession()->GetSessionDbcLocale()
        : LOCALE_enUS;
    char const* name = achievement->name[loc];
    if (!name || !name[0])
        name = achievement->name[LOCALE_enUS];
    if (!name || !name[0])
        return {};

    return SanitizeAddonField(name, 40);
}

void ChallengeModes::SendAddonWhisper(Player* player, std::string const& payload) const
{
    if (!player || payload.empty())
        return;

    WorldPacket data;
    ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER, LANG_ADDON, player, player, payload);
    player->SendDirectMessage(&data);
}

void ChallengeModes::SendPickerRewards(Player* player) const
{
    if (!player)
        return;

    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
    {
        if (!IsModeEnabled(mode))
            continue;

        ChallengeModeConfig const& config = _modes[mode];
        std::string titleName = GetTitleHonorific(player, config.RewardTitle);
        if (titleName.empty())
            titleName = GetModeTitle(mode, IsSpanish(player));

        std::string itemName;
        if (config.RewardItem)
        {
            itemName = GetLocalizedItemName(player, config.RewardItem);
            if (itemName.empty())
                itemName = Acore::StringFormat("#{}", config.RewardItem);
        }

        std::string achName;
        if (config.RewardAchievement)
        {
            achName = GetLocalizedAchievementName(player, config.RewardAchievement);
            if (achName.empty())
                achName = Acore::StringFormat("#{}", config.RewardAchievement);
        }

        SendAddonWhisper(player, Acore::StringFormat(
            "CMUI\tREWARD\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}",
            uint32(mode),
            config.RewardLevel,
            titleName,
            config.RewardItem,
            config.RewardItemCount ? config.RewardItemCount : 1,
            itemName,
            config.RewardGold,
            config.RewardHonor,
            config.RewardAchievement,
            achName,
            config.RewardTalents));

        auto sendExtra = [this, player, mode](char const* kind, uint8 level, uint32 id, std::string const& name,
            uint32 count)
        {
            SendAddonWhisper(player, Acore::StringFormat("CMUI\tEXTRA\t{}\t{}\t{}\t{}\t{}\t{}",
                uint32(mode), kind, uint32(level), id, SanitizeAddonField(name, 40), count));
        };

        for (auto const& [level, titleId] : config.TitleRewards)
        {
            if (titleId == config.RewardTitle && level == config.RewardLevel)
                continue;
            sendExtra("title", level, titleId, GetTitleHonorific(player, titleId), 1);
        }

        for (auto const& [level, itemId] : config.ItemRewards)
        {
            if (itemId == config.RewardItem && level == config.RewardLevel)
                continue;
            std::string name = GetLocalizedItemName(player, itemId);
            if (name.empty())
                name = Acore::StringFormat("#{}", itemId);
            sendExtra("item", level, itemId, name, config.ItemRewardAmount ? config.ItemRewardAmount : 1);
        }

        for (auto const& [level, achId] : config.AchievementRewards)
        {
            if (achId == config.RewardAchievement && level == config.RewardLevel)
                continue;
            std::string name = GetLocalizedAchievementName(player, achId);
            if (name.empty())
                name = Acore::StringFormat("#{}", achId);
            sendExtra("ach", level, achId, name, 1);
        }

        for (auto const& [level, talents] : config.TalentRewards)
        {
            if (talents == config.RewardTalents && level == config.RewardLevel)
                continue;
            sendExtra("talent", level, talents, "", talents);
        }
    }
}

void ChallengeModes::PrintModeRewards(Player* player, uint8 mode) const
{
    if (!player || mode > CHALLENGE_IRON_MAN)
        return;

    ChatHandler handler(player->GetSession());
    bool const spanish = IsSpanish(player);
    ChallengeModeConfig const& config = _modes[mode];

    handler.PSendSysMessage(spanish ? "Completas el reto al nivel {}." : "Completes at level {}.",
        config.RewardLevel);

    std::string titleName = GetTitleHonorific(player, config.RewardTitle);
    if (titleName.empty())
        titleName = GetModeTitle(mode, spanish);
    if (!titleName.empty())
        handler.PSendSysMessage(spanish ? "Titulo: |cffffd100{}|r" : "Title: |cffffd100{}|r", titleName);

    if (config.RewardItem)
    {
        std::string itemName = GetLocalizedItemName(player, config.RewardItem);
        if (itemName.empty())
            itemName = Acore::StringFormat("#{}", config.RewardItem);
        handler.PSendSysMessage(spanish ? "Objeto: |cff00ff00{}|r x{}" : "Item: |cff00ff00{}|r x{}",
            itemName, config.RewardItemCount ? config.RewardItemCount : 1);
    }

    if (config.RewardGold)
    {
        uint32 const gold = config.RewardGold / 10000;
        uint32 const silver = (config.RewardGold % 10000) / 100;
        uint32 const copper = config.RewardGold % 100;
        handler.PSendSysMessage(spanish ? "Oro: {}g {}s {}c" : "Gold: {}g {}s {}c", gold, silver, copper);
    }

    if (config.RewardHonor)
        handler.PSendSysMessage(spanish ? "Honor: {}" : "Honor: {}", config.RewardHonor);

    if (config.RewardAchievement)
    {
        std::string achName = GetLocalizedAchievementName(player, config.RewardAchievement);
        if (achName.empty())
            achName = Acore::StringFormat("#{}", config.RewardAchievement);
        handler.PSendSysMessage(spanish ? "Logro: |cff00ccff{}|r" : "Achievement: |cff00ccff{}|r", achName);
    }

    if (config.RewardTalents && mode != CHALLENGE_IRON_MAN)
        handler.PSendSysMessage(spanish ? "Talentos extra: {}" : "Extra talent points: {}", config.RewardTalents);

    if (!config.RewardItem && !config.RewardGold && !config.RewardHonor &&
        !config.RewardAchievement && !config.RewardTalents)
        handler.SendSysMessage(spanish
            ? "Sin objeto, oro, honor, logro ni talentos extra en el conf."
            : "No extra item, gold, honor, achievement or talents in the conf.");
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

    SendAddonWhisper(player, Acore::StringFormat("CMUI\tOPEN\t{}\t{}",
        IsSpanish(player) ? "es" : "en", flags));
    SendPickerRewards(player);
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

        std::string const label = Acore::StringFormat("|cffffd100{}|r ({}) - {}",
            GetModeName(mode, spanish), GetModeTitle(mode, spanish), GetModeShortDescription(mode, spanish));
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

    if (body == "HELLO" || body == "SYNC")
    {
        SendPickerRewards(player);
        return true;
    }

    if (body.rfind("SELECT\t", 0) != 0)
        return false;

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
        spanish ? "Desafio activado: {} [{}]." : "Challenge enabled: {} [{}].",
        GetModeName(uint8(mode), spanish), GetModeTitle(uint8(mode), spanish));
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

        if (config.RewardLevel && config.RewardLevel == level)
        {
            GiveConfiguredReward(player, mode, level);
            BroadcastComplete(player, mode);
        }

        if (config.DisableLevel && config.DisableLevel <= level)
        {
            SetEnabled(player, mode, false);
            ChatHandler(player->GetSession()).PSendSysMessage(
                spanish ? "{} se ha completado y se ha desactivado." : "{} has been completed and disabled.",
                GetModeName(mode, spanish));
        }
    }
}

void ChallengeModes::GiveConfiguredReward(Player* player, uint8 mode, uint8 /*level*/)
{
    ChallengeModeConfig const& config = _modes[mode];
    bool const spanish = IsSpanish(player);

    if (config.RewardTitle)
    {
        if (CharTitlesEntry const* title = sCharTitlesStore.LookupEntry(config.RewardTitle))
        {
            player->SetTitle(title);
            player->SetCurrentTitle(title);
        }
        else
            LOG_ERROR("module.challengemodes", "Invalid RewardTitle {} for {}",
                config.RewardTitle, GetModeName(mode, false));
    }

    if (config.RewardTalents && mode != CHALLENGE_IRON_MAN)
        player->RewardExtraBonusTalentPoints(config.RewardTalents);

    if (config.RewardAchievement)
    {
        if (AchievementEntry const* achievement = sAchievementStore.LookupEntry(config.RewardAchievement))
            player->CompletedAchievement(achievement);
        else
            LOG_ERROR("module.challengemodes", "Invalid RewardAchievement {} for {}",
                config.RewardAchievement, GetModeName(mode, false));
    }

    if (config.RewardItem)
        player->SendItemRetrievalMail({ { config.RewardItem, config.RewardItemCount ? config.RewardItemCount : 1 } });

    if (config.RewardGold)
    {
        int32 copper = config.RewardGold > uint32(std::numeric_limits<int32>::max())
            ? std::numeric_limits<int32>::max()
            : int32(config.RewardGold);
        player->ModifyMoney(copper, false);
    }

    if (config.RewardHonor)
        player->ModifyHonorPoints(int32(config.RewardHonor));

    ChatHandler(player->GetSession()).PSendSysMessage(
        spanish ? "Has completado {} y recibes las recompensas configuradas."
                : "You completed {} and received the configured rewards.",
        GetModeName(mode, spanish));
}

void ChallengeModes::HandlePlayerDeath(Player* player, char const* killer)
{
    if (!player)
        return;

    if (IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE))
    {
        if (!IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE_DEAD))
        {
            SetEnabled(player, CHALLENGE_HARDCORE_DEAD, true);
            BroadcastDeath(player, CHALLENGE_HARDCORE, killer);
        }
        return;
    }

    if (IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN) &&
        _ironManDeathAnnounced.insert(player->GetGUID().GetCounter()).second)
        BroadcastDeath(player, CHALLENGE_IRON_MAN, killer);
}

void ChallengeModes::Broadcast(std::string const& message) const
{
    if (!_announce || message.empty())
        return;

    sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, message);
}

void ChallengeModes::BroadcastLocalized(std::string const& spanish, std::string const& english) const
{
    if (!_announce)
        return;

    sWorldSessionMgr->DoForAllOnlinePlayers([&](Player* receiver)
    {
        std::string const& text = IsSpanish(receiver) ? spanish : english;
        if (!text.empty())
            sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, text, receiver);
    });
}

void ChallengeModes::BroadcastStart(Player* player, uint8 mode) const
{
    if (!player)
        return;

    std::string const titled = GetFormattedTitle(player, mode);
    BroadcastLocalized(
        Acore::StringFormat(
            "|cff00ccff[Desafio]|r |cffffd100{}|r ha aceptado el modo |cffff2020{}|r.",
            titled, GetModeName(mode, true)),
        Acore::StringFormat(
            "|cff00ccff[Challenge]|r |cffffd100{}|r has accepted |cffff2020{}|r.",
            titled, GetModeName(mode, false)));
}

void ChallengeModes::BroadcastDeath(Player* player, uint8 mode, char const* killer) const
{
    if (!player)
        return;

    std::string const by = (killer && killer[0])
        ? Acore::StringFormat(" ({})", killer)
        : "";

    std::string const titled = GetFormattedTitle(player, mode);
    if (mode == CHALLENGE_HARDCORE)
        BroadcastLocalized(
            Acore::StringFormat(
                "|cffff2020[Hardcore]|r |cffffd100{}|r ha caido{} y queda perdido para siempre.",
                titled, by),
            Acore::StringFormat(
                "|cffff2020[Hardcore]|r |cffffd100{}|r has fallen{} and is lost forever.",
                titled, by));
    else
        BroadcastLocalized(
            Acore::StringFormat(
                "|cffff2020[Hombre de Hierro]|r |cffffd100{}|r ha muerto{} y no puede resucitar.",
                titled, by),
            Acore::StringFormat(
                "|cffff2020[Iron Man]|r |cffffd100{}|r has died{} and cannot resurrect.",
                titled, by));
}

void ChallengeModes::BroadcastComplete(Player* player, uint8 mode) const
{
    if (!player)
        return;

    std::string const titled = GetFormattedTitle(player, mode);
    uint8 const level = player->GetLevel();
    BroadcastLocalized(
        Acore::StringFormat(
            "|cff00ff00[Desafio]|r |cffffd100{}|r ha completado |cff00ff00{}|r al nivel {}.",
            titled, GetModeName(mode, true), level),
        Acore::StringFormat(
            "|cff00ff00[Challenge]|r |cffffd100{}|r has completed |cff00ff00{}|r at level {}.",
            titled, GetModeName(mode, false), level));
}
