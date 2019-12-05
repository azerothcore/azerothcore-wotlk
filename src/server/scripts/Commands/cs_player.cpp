/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "Chat.h"
#include "ScriptMgr.h"
#include "Language.h"
#include "Player.h"

class player_commandscript : public CommandScript
{
public:
    player_commandscript() : CommandScript("player_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> playerCommandTable =
        {
            { "learn",               SEC_GAMEMASTER,  true, &HandlePlayerLearnCommand,           "" },
            { "unlearn",             SEC_GAMEMASTER,  true, &HandlePlayerUnLearnCommand,         "" }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "player",              SEC_GAMEMASTER,  true, nullptr,                             "", playerCommandTable }
        };
        return commandTable;
    }

    static bool HandlePlayerLearnCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* playerName = strtok((char*)args, " ");
        char* spellid = strtok(nullptr, " ");
        char* all = strtok(nullptr, " ");
        Player* targetPlayer = FindPlayer(handler, playerName);
        if (!spellid || !targetPlayer)
            return false;

        uint32 spell = handler->extractSpellIdFromLink(spellid);
        if (!spell)
            return false;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell);
        if (!spellInfo)
        {
            handler->PSendSysMessage(LANG_COMMAND_NOSPELLFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!SpellMgr::IsSpellValid(spellInfo))
        {
            handler->PSendSysMessage(LANG_COMMAND_SPELL_BROKEN, spell);
            handler->SetSentErrorMessage(true);
            return false;
        }

        bool allRanks = all ? (strncmp(all, "all", 3) == 0) : false;

        if (!allRanks && targetPlayer->HasSpell(spell))
        {
            handler->PSendSysMessage(LANG_TARGET_KNOWN_SPELL, handler->GetNameLink(targetPlayer).c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (allRanks)
            targetPlayer->learnSpellHighRank(spell);
        else
            targetPlayer->learnSpell(spell);

        uint32 firstSpell = sSpellMgr->GetFirstSpellInChain(spell);
        if (GetTalentSpellCost(firstSpell))
            targetPlayer->SendTalentsInfoData(false);

        return true;
    }

    static bool HandlePlayerUnLearnCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* playerName = strtok((char*)args, " ");
        char* spellid = strtok(nullptr, " ");
        char* all = strtok(nullptr, " ");
        Player* targetPlayer = FindPlayer(handler, playerName);
        if (!spellid || !targetPlayer)
            return false;

        uint32 spell = handler->extractSpellIdFromLink(spellid);
        if (!spell)
            return false;

        bool allRanks = all ? (strncmp(all, "all", 3) == 0) : false;

        if (allRanks)
            spell = sSpellMgr->GetFirstSpellInChain(spell);

        if (targetPlayer->HasSpell(spell))
            targetPlayer->removeSpell(spell, SPEC_MASK_ALL, false);
        else
            handler->SendSysMessage(LANG_FORGET_SPELL);

        if (GetTalentSpellCost(spell))
            targetPlayer->SendTalentsInfoData(false);

        return true;
    }

private:
    static Player* FindPlayer(ChatHandler* handler, char* playerName)
    {
        if (!playerName)
            return nullptr;

        Player* targetPlayer;
        if (!handler->extractPlayerTarget(playerName, &targetPlayer))
            return nullptr;

        if (!targetPlayer)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return nullptr;
        }

        return targetPlayer;
    }
};

void AddSC_player_commandscript()
{
    new player_commandscript();
}
