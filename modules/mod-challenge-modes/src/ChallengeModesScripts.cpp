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
#include "CommandScript.h"
#include "DBCStructure.h"
#include "SharedDefines.h"
#include "Creature.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "Group.h"
#include "Item.h"
#include "ItemTemplate.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "StringFormat.h"
#include "UpdateFields.h"

using namespace Acore::ChatCommands;

enum ChallengeGossipAction
{
    GOSSIP_CHALLENGE_HELLO = 0
};

enum AllowedChallengeProfessions
{
    SPELL_RUNEFORGING    = 53428,
    SPELL_POISONS        = 2842,
    SPELL_BEAST_TRAINING = 5149
};

namespace
{
void BuildChallengeGossip(Player* player)
{
    ClearGossipMenuFor(player);
    bool const spanish = ChallengeModes::IsSpanish(player);
    ObjectGuid const guid = player->GetGUID();

    Optional<uint8> activeMode = sChallengeModes->GetActiveChallenge(guid);
    if (activeMode)
    {
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            Acore::StringFormat(spanish ? "Modo activo: {}" : "Active mode: {}",
                ChallengeModes::GetModeName(*activeMode, spanish)),
            GOSSIP_SENDER_MAIN, GOSSIP_CHALLENGE_HELLO);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            Acore::StringFormat(spanish ? "Titulo: {}" : "Title: {}",
                ChallengeModes::GetModeTitle(*activeMode, spanish)),
            GOSSIP_SENDER_MAIN, GOSSIP_CHALLENGE_HELLO);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            spanish ? "Solo se permite un modo por personaje."
                    : "Only one challenge mode is allowed per character.",
            GOSSIP_SENDER_MAIN, GOSSIP_CHALLENGE_HELLO);
    }

    if (sChallengeModes->IsEnabled(guid, CHALLENGE_HARDCORE_DEAD))
    {
        AddGossipItemFor(player, GOSSIP_ICON_BATTLE,
            spanish ? "Has muerto en Hardcore. El desafio ha terminado."
                    : "You died in Hardcore. The challenge is over.",
            GOSSIP_SENDER_MAIN, GOSSIP_CHALLENGE_HELLO);
        return;
    }

    bool const canActivate = sChallengeModes->CanActivate(player);
    if (!canActivate && !activeMode)
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            spanish ? "Los desafios solo se activan en nivel 1 (o 55 DK)."
                    : "Challenges can only be enabled at level 1 (or 55 DK).",
            GOSSIP_SENDER_MAIN, GOSSIP_CHALLENGE_HELLO);

    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
    {
        if (!sChallengeModes->IsModeEnabled(mode) || sChallengeModes->IsEnabled(guid, mode))
            continue;

        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            Acore::StringFormat(spanish ? "Info: {} — {}" : "Info: {} — {}",
                ChallengeModes::GetModeName(mode, spanish),
                ChallengeModes::GetModeTitle(mode, spanish)),
            GOSSIP_SENDER_MAIN, uint32(GOSSIP_CHALLENGE_INFO_BASE) + mode);

        if (!canActivate || sChallengeModes->HasActiveChallenge(guid))
            continue;

        std::string const label = Acore::StringFormat(
            spanish ? "Activar {} ({})" : "Enable {} ({})",
            ChallengeModes::GetModeName(mode, spanish),
            ChallengeModes::GetModeTitle(mode, spanish));
        uint32 const action = uint32(GOSSIP_CHALLENGE_ENABLE_BASE) + mode;

        if (mode == CHALLENGE_HARDCORE || mode == CHALLENGE_IRON_MAN)
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, label, GOSSIP_SENDER_MAIN, action,
                spanish ? "Solo un modo por personaje y no se puede desactivar. ¿Continuar?"
                        : "One mode per character and it cannot be turned off. Continue?",
                0, false);
        else
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, label, GOSSIP_SENDER_MAIN, action);
    }

    if (canActivate && !sChallengeModes->HasActiveChallenge(guid) && !sChallengeModes->IsPickerDone(guid))
        AddGossipItemFor(player, GOSSIP_ICON_CHAT,
            spanish ? "|cff00ff00Modo normal|r - Juego clasico, sin restricciones."
                    : "|cff00ff00Normal mode|r - Classic play, no restrictions.",
            GOSSIP_SENDER_MAIN, GOSSIP_CHALLENGE_NORMAL);
}

bool HandleChallengeGossipSelect(Player* player, uint32 action)
{
    bool const spanish = ChallengeModes::IsSpanish(player);

    if (action >= GOSSIP_CHALLENGE_INFO_BASE && action < GOSSIP_CHALLENGE_INFO_BASE + CHALLENGE_MODE_MAX)
    {
        uint8 mode = static_cast<uint8>(action - GOSSIP_CHALLENGE_INFO_BASE);
        ChatHandler handler(player->GetSession());
        handler.PSendSysMessage("|cff00ccff===== {} — {} =====|r",
            ChallengeModes::GetModeName(mode, spanish),
            ChallengeModes::GetModeTitle(mode, spanish));
        handler.SendSysMessage(ChallengeModes::GetModeDescription(mode, spanish));
        sChallengeModes->PrintModeRewards(player, mode);
        handler.SendSysMessage(spanish
            ? "Solo un modo por personaje."
            : "One mode per character.");
        return true;
    }

    if (action >= GOSSIP_CHALLENGE_ENABLE_BASE && action < GOSSIP_CHALLENGE_ENABLE_BASE + CHALLENGE_MODE_MAX)
    {
        uint8 mode = static_cast<uint8>(action - GOSSIP_CHALLENGE_ENABLE_BASE);
        std::string error;
        if (!sChallengeModes->EnableChallenge(player, mode, error))
        {
            ChatHandler(player->GetSession()).SendSysMessage(error);
            return false;
        }

        return true;
    }

    if (action == GOSSIP_CHALLENGE_NORMAL)
    {
        std::string error;
        if (!sChallengeModes->ChooseNormal(player, error))
        {
            ChatHandler(player->GetSession()).SendSysMessage(error);
            return false;
        }

        ChatHandler(player->GetSession()).SendSysMessage(spanish
            ? "Has elegido el modo normal. Juega sin restricciones."
            : "You chose Normal mode. Play without restrictions.");
        return true;
    }

    return true;
}

void ApplyXpForPlayer(Player* player, uint32& amount, Unit* victim, uint8 xpSource)
{
    if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_QUEST_XP_ONLY) &&
        sChallengeModes->IsModeEnabled(CHALLENGE_QUEST_XP_ONLY))
    {
        if (xpSource != XPSOURCE_QUEST && xpSource != XPSOURCE_QUEST_DF)
        {
            if (victim && xpSource == XPSOURCE_KILL)
            {
                if (Pet* pet = player->GetPet())
                    pet->GivePetXP(player->GetGroup() ? amount / 2 : amount);
            }
            amount = 0;
            return;
        }
    }

    for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
    {
        if (!sChallengeModes->IsModeEnabled(mode) || !sChallengeModes->IsEnabled(player->GetGUID(), mode))
            continue;

        amount = uint32(float(amount) * sChallengeModes->GetModeConfig(mode).XpMultiplier);
    }
}

void StripEquippedGearAndGold(Player* player)
{
    for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
    {
        Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        if (!item || !item->GetTemplate())
            continue;

        ChatHandler(player->GetSession()).PSendSysMessage(
            "|cffff2020{}|r |cffffffff|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r",
            ChallengeModes::IsSpanish(player) ? "Has perdido" : "You lost",
            item->GetEntry(), item->GetTemplate()->Name1);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
    }

    player->SetMoney(0);
}
}

class ChallengeModesWorldScript : public WorldScript
{
public:
    ChallengeModesWorldScript() : WorldScript("ChallengeModesWorldScript", {
        WORLDHOOK_ON_AFTER_CONFIG_LOAD,
        WORLDHOOK_ON_LOAD_CUSTOM_DATABASE_TABLE
    }) { }

    void OnAfterConfigLoad(bool reload) override
    {
        sChallengeModes->LoadConfig(reload);
    }

    void OnLoadCustomDatabaseTable() override
    {
        sChallengeModes->EnsureDatabase();
    }
};

class ChallengeModesPlayerScript : public PlayerScript
{
public:
    ChallengeModesPlayerScript() : PlayerScript("ChallengeModesPlayerScript", {
        PLAYERHOOK_ON_LOAD_FROM_DB,
        PLAYERHOOK_ON_FIRST_LOGIN,
        PLAYERHOOK_ON_LOGIN,
        PLAYERHOOK_ON_GOSSIP_SELECT,
        PLAYERHOOK_ON_BEFORE_SEND_CHAT_MESSAGE,
        PLAYERHOOK_ON_LOGOUT,
        PLAYERHOOK_ON_PLAYER_RELEASED_GHOST,
        PLAYERHOOK_ON_PVP_KILL,
        PLAYERHOOK_ON_PLAYER_KILLED_BY_CREATURE,
        PLAYERHOOK_ON_PLAYER_RESURRECT,
        PLAYERHOOK_CAN_RESURRECT,
        PLAYERHOOK_ON_GIVE_EXP,
        PLAYERHOOK_ON_LEVEL_CHANGED,
        PLAYERHOOK_ON_CALCULATE_TALENTS_POINTS,
        PLAYERHOOK_CAN_LEARN_TALENT,
        PLAYERHOOK_CAN_EQUIP_ITEM,
        PLAYERHOOK_CAN_USE_ITEM,
        PLAYERHOOK_CAN_APPLY_ENCHANTMENT,
        PLAYERHOOK_ON_LEARN_SPELL,
        PLAYERHOOK_ON_TALENTS_RESET,
        PLAYERHOOK_CAN_GROUP_INVITE,
        PLAYERHOOK_CAN_GROUP_ACCEPT
    }) { }

    void OnPlayerLoadFromDB(Player* player) override
    {
        if (player)
            sChallengeModes->LoadPlayer(player);
    }

    void OnPlayerLogin(Player* player) override
    {
        if (!player || !sChallengeModes->IsModuleEnabled())
            return;

        sChallengeModes->LoadPlayer(player);

        if (Optional<uint8> mode = sChallengeModes->GetActiveChallenge(player->GetGUID()))
            sChallengeModes->GrantModeTitle(player, *mode, false);

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE_DEAD))
        {
            if (player->IsAlive())
                player->KillPlayer();
            ChatHandler(player->GetSession()).SendSysMessage(
                ChallengeModes::IsSpanish(player)
                    ? "Este personaje murio en Hardcore y no puede resucitar."
                    : "This character died in Hardcore and cannot be resurrected.");
        }

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            player->SetFreeTalentPoints(0);

        if (sChallengeModes->ShouldShowFirstLoginPicker(player))
            sChallengeModes->OpenFirstLoginPicker(player);
    }

    void OnPlayerFirstLogin(Player* player) override
    {
        if (!player || !sChallengeModes->IsModuleEnabled())
            return;

        sChallengeModes->LoadPlayer(player);
        if (sChallengeModes->ShouldShowFirstLoginPicker(player))
            sChallengeModes->OpenFirstLoginPicker(player);
    }

    void OnPlayerGossipSelect(Player* player, uint32 menuId, uint32 /*sender*/, uint32 action) override
    {
        if (!player || menuId != GOSSIP_MENU_CHALLENGE)
            return;

        HandleChallengeGossipSelect(player, action);

        if (!sChallengeModes->ShouldShowFirstLoginPicker(player))
        {
            CloseGossipMenuFor(player);
            return;
        }

        sChallengeModes->OpenFirstLoginPicker(player);
    }

    void OnPlayerBeforeSendChatMessage(Player* player, uint32& type, uint32& lang, std::string& msg) override
    {
        if (!player || lang != LANG_ADDON)
            return;

        if (type != CHAT_MSG_WHISPER && type != CHAT_MSG_GUILD)
            return;

        if (msg.rfind("CMUI\t", 0) == 0)
            sChallengeModes->HandlePickerAddon(player, msg);
    }

    void OnPlayerLogout(Player* player) override
    {
        if (player)
            sChallengeModes->UnloadPlayer(player->GetGUID());
    }

    void OnPlayerReleasedGhost(Player* player) override
    {
        if (player)
            sChallengeModes->HandlePlayerDeath(player, nullptr);
    }

    void OnPlayerPVPKill(Player* killer, Player* killed) override
    {
        if (!killed)
            return;

        sChallengeModes->HandlePlayerDeath(killed, killer ? killer->GetName().c_str() : nullptr);

        if (sChallengeModes->IsEnabled(killed->GetGUID(), CHALLENGE_SEMI_HARDCORE))
            StripEquippedGearAndGold(killed);
    }

    void OnPlayerKilledByCreature(Creature* killer, Player* killed) override
    {
        if (!killed)
            return;

        sChallengeModes->HandlePlayerDeath(killed, killer ? killer->GetName().c_str() : nullptr);

        if (sChallengeModes->IsEnabled(killed->GetGUID(), CHALLENGE_SEMI_HARDCORE))
            StripEquippedGearAndGold(killed);
    }

    bool OnPlayerCanResurrect(Player* player) override
    {
        if (!player)
            return true;

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE) ||
            sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE_DEAD) ||
            sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            return false;

        return true;
    }

    void OnPlayerResurrect(Player* player, float /*restore_percent*/, bool& /*applySickness*/) override
    {
        if (!player)
            return;

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE) ||
            sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE_DEAD) ||
            sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
        {
            sChallengeModes->HandlePlayerDeath(player, nullptr);
            player->KillPlayer();
        }
    }

    void OnPlayerGiveXP(Player* player, uint32& amount, Unit* victim, uint8 xpSource) override
    {
        if (player)
            ApplyXpForPlayer(player, amount, victim, xpSource);
    }

    void OnPlayerLevelChanged(Player* player, uint8 oldlevel) override
    {
        if (!player)
            return;

        sChallengeModes->GiveLevelRewards(player, oldlevel);

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            player->SetFreeTalentPoints(0);
    }

    void OnPlayerCalculateTalentsPoints(Player const* player, uint32& talentPointsForLevel) override
    {
        if (player && sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            talentPointsForLevel = 0;
    }

    bool OnPlayerCanLearnTalent(Player* player, TalentEntry const* /*talent*/, uint32 /*rank*/) override
    {
        if (!player || !sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            return true;

        ChatHandler(player->GetSession()).SendSysMessage(
            ChallengeModes::IsSpanish(player)
                ? "Hombre de Hierro: no puedes aprender puntos de talento."
                : "Iron Man: you cannot learn talent points.");
        return false;
    }

    bool OnPlayerCanEquipItem(Player* player, uint8 /*slot*/, uint16& /*dest*/, Item* item, bool /*swap*/,
        bool not_loading) override
    {
        if (!player || !item || !not_loading)
            return true;

        ItemTemplate const* proto = item->GetTemplate();
        if (!proto)
            return true;

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_SELF_CRAFTED))
        {
            if (!proto->HasSignature() || item->GetGuidValue(ITEM_FIELD_CREATOR) != player->GetGUID())
                return false;
        }

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_ITEM_QUALITY) ||
            sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
        {
            if (proto->Quality > ITEM_QUALITY_NORMAL)
                return false;
        }

        return true;
    }

    bool OnPlayerCanUseItem(Player* player, ItemTemplate const* proto, InventoryResult& /*result*/) override
    {
        if (!player || !proto || !sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            return true;

        if (proto->Class == ITEM_CLASS_CONSUMABLE &&
            (proto->SubClass == ITEM_SUBCLASS_POTION ||
                proto->SubClass == ITEM_SUBCLASS_ELIXIR ||
                proto->SubClass == ITEM_SUBCLASS_FLASK))
            return false;

        if (proto->Class == ITEM_CLASS_CONSUMABLE && proto->SubClass == ITEM_SUBCLASS_FOOD)
        {
            for (auto const& spell : proto->Spells)
            {
                SpellInfo const* info = sSpellMgr->GetSpellInfo(spell.SpellId);
                if (!info)
                    continue;

                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    if (info->Effects[i].ApplyAuraName == SPELL_AURA_PERIODIC_TRIGGER_SPELL)
                        return false;
            }
        }

        return true;
    }

    bool OnPlayerCanApplyEnchantment(Player* player, Item* /*item*/, EnchantmentSlot /*slot*/, bool apply,
        bool /*apply_dur*/, bool /*ignore_condition*/) override
    {
        if (!player || !apply)
            return true;

        return !sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN);
    }

    void OnPlayerLearnSpell(Player* player, uint32 spellId) override
    {
        if (!player || !sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            return;

        switch (spellId)
        {
            case SPELL_RUNEFORGING:
            case SPELL_POISONS:
            case SPELL_BEAST_TRAINING:
                return;
            default:
                break;
        }

        SpellInfo const* info = sSpellMgr->GetSpellInfo(spellId);
        if (!info)
            return;

        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (info->Effects[i].Effect == SPELL_EFFECT_TRADE_SKILL)
            {
                player->removeSpell(spellId, SPEC_MASK_ALL, false);
                return;
            }
        }
    }

    void OnPlayerTalentsReset(Player* player, bool /*noCost*/) override
    {
        if (player && sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN))
            player->SetFreeTalentPoints(0);
    }

    bool OnPlayerCanGroupInvite(Player* player, std::string& /*membername*/) override
    {
        return !player || !sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN);
    }

    bool OnPlayerCanGroupAccept(Player* player, Group* /*group*/) override
    {
        return !player || !sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_IRON_MAN);
    }
};

class npc_challenge_modes : public CreatureScript
{
public:
    npc_challenge_modes() : CreatureScript("npc_challenge_modes") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!player || !creature)
            return true;

        if (!sChallengeModes->IsModuleEnabled())
        {
            ChatHandler(player->GetSession()).SendSysMessage(
                ChallengeModes::IsSpanish(player)
                    ? "Los desafios estan desactivados."
                    : "Challenge modes are disabled.");
            CloseGossipMenuFor(player);
            return true;
        }

        BuildChallengeGossip(player);
        SendGossipMenuFor(player, NPC_TEXT_CHALLENGE_GREETING, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        if (!player || !creature)
            return true;

        HandleChallengeGossipSelect(player, action);
        BuildChallengeGossip(player);
        SendGossipMenuFor(player, NPC_TEXT_CHALLENGE_GREETING, creature);
        return true;
    }
};

class gobject_challenge_modes : public GameObjectScript
{
public:
    gobject_challenge_modes() : GameObjectScript("gobject_challenge_modes") { }

    struct gobject_challenge_modesAI : GameObjectAI
    {
        explicit gobject_challenge_modesAI(GameObject* object) : GameObjectAI(object) { }

        bool CanBeSeen(Player const* player) override
        {
            return sChallengeModes->IsModuleEnabled() && player &&
                (sChallengeModes->CanActivate(player) ||
                    sChallengeModes->HasActiveChallenge(player->GetGUID()));
        }
    };

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player || !go || !sChallengeModes->IsModuleEnabled())
            return true;

        BuildChallengeGossip(player);
        SendGossipMenuFor(player, NPC_TEXT_CHALLENGE_GREETING, go->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, GameObject* go, uint32 /*sender*/, uint32 action) override
    {
        if (!player || !go)
            return true;

        HandleChallengeGossipSelect(player, action);
        BuildChallengeGossip(player);
        SendGossipMenuFor(player, NPC_TEXT_CHALLENGE_GREETING, go->GetGUID());
        return true;
    }

    GameObjectAI* GetAI(GameObject* object) const override
    {
        return new gobject_challenge_modesAI(object);
    }
};

class challenge_modes_commandscript : public CommandScript
{
public:
    challenge_modes_commandscript() : CommandScript("challenge_modes_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable challengeTable =
        {
            { "status", HandleStatus, SEC_PLAYER, Console::No },
            { "pick",   HandlePick,   SEC_PLAYER, Console::No },
            { "",       HandleStatus, SEC_PLAYER, Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "challenge", challengeTable }
        };

        return commandTable;
    }

    static bool HandleStatus(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
            return false;

        bool const spanish = ChallengeModes::IsSpanish(player);
        handler->SendSysMessage(spanish ? "Desafios activos:" : "Active challenges:");

        bool any = false;
        for (uint8 mode = 0; mode <= CHALLENGE_IRON_MAN; ++mode)
        {
            if (!sChallengeModes->IsEnabled(player->GetGUID(), mode))
                continue;

            handler->PSendSysMessage("- {} [{}]", ChallengeModes::GetModeName(mode, spanish),
                ChallengeModes::GetModeTitle(mode, spanish));
            handler->SendSysMessage(ChallengeModes::GetModeDescription(mode, spanish));
            any = true;
        }

        if (sChallengeModes->IsEnabled(player->GetGUID(), CHALLENGE_HARDCORE_DEAD))
            handler->SendSysMessage(spanish
                ? "- Hardcore: este personaje esta muerto de forma permanente."
                : "- Hardcore: this character is permanently dead.");

        if (!any)
        {
            if (sChallengeModes->IsPickerDone(player->GetGUID()))
                handler->SendSysMessage(spanish
                    ? "Modo normal. Sin restricciones de desafio."
                    : "Normal mode. No challenge restrictions.");
            else
                handler->SendSysMessage(spanish
                    ? "Ninguno. Usa .challenge pick o habla con el Guardian (.npc add 190012)."
                    : "None. Use .challenge pick or speak with the Keeper (.npc add 190012).");
        }

        return true;
    }

    static bool HandlePick(ChatHandler* handler)
    {
        Player* player = handler->GetPlayer();
        if (!player)
            return false;

        if (!sChallengeModes->ShouldShowFirstLoginPicker(player))
        {
            handler->SendSysMessage(ChallengeModes::IsSpanish(player)
                ? "Ya elegiste un modo para este personaje."
                : "You already chose a mode for this character.");
            return true;
        }

        sChallengeModes->OpenFirstLoginPicker(player);
        return true;
    }
};

void AddSC_challenge_modes()
{
    new ChallengeModesWorldScript();
    new ChallengeModesPlayerScript();
    new npc_challenge_modes();
    new gobject_challenge_modes();
    new challenge_modes_commandscript();
}
