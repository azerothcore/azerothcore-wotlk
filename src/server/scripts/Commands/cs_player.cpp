/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "Chat.h"
#include "ScriptMgr.h"
#include "Language.h"
#include "Player.h"
#include "PlayerCommand.h"

class player_commandscript : public CommandScript, public PlayerCommand
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
        char const* all = strtok(nullptr, " ");
        Player* targetPlayer = FindPlayer(handler, playerName);
        if (!spellid || !targetPlayer)
            return false;

        uint32 spell = handler->extractSpellIdFromLink(spellid);
        if (!spell)
            return false;

        return Learn(handler, targetPlayer, spell, all);
    }

    static bool HandlePlayerUnLearnCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* playerName = strtok((char*)args, " ");
        char* spellid = strtok(nullptr, " ");
        char const* all = strtok(nullptr, " ");
        Player* targetPlayer = FindPlayer(handler, playerName);
        if (!spellid || !targetPlayer)
            return false;

        uint32 spell = handler->extractSpellIdFromLink(spellid);
        if (!spell)
            return false;

        return UnLearn(handler, targetPlayer, spell, all);
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
