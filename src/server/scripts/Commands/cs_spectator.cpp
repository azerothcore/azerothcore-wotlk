/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "AccountMgr.h"
#include "ArenaSpectator.h"
#include "BattlegroundMgr.h"
#include "Chat.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "World.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class spectator_commandscript : public CommandScript
{
public:
    spectator_commandscript() : CommandScript("spectator_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable spectatorCommandTable =
        {
            { "version",        SEC_CONSOLE,        false, &HandleSpectatorVersionCommand,                  "" },
            { "reset",          SEC_CONSOLE,        false, &HandleSpectatorResetCommand,                    "" },
            { "spectate",       SEC_CONSOLE,        false, &ArenaSpectator::HandleSpectatorSpectateCommand, "" },
            { "watch",          SEC_CONSOLE,        false, &ArenaSpectator::HandleSpectatorWatchCommand,    "" },
            { "leave",          SEC_CONSOLE,        false, &HandleSpectatorLeaveCommand,                    "" },
            { "",               SEC_CONSOLE,        false, &HandleSpectatorCommand,                         "" }
        };
        static ChatCommandTable commandTable =
        {
            { "spect",          SEC_CONSOLE,        false, nullptr,                                         "", spectatorCommandTable }
        };
        return commandTable;
    }

    static bool HandleSpectatorCommand(ChatHandler* handler, char const*  /*args*/)
    {
        handler->PSendSysMessage("Incorrect syntax.");
        handler->PSendSysMessage("Command has subcommands:");
        handler->PSendSysMessage("   spectate");
        handler->PSendSysMessage("   leave");
        return true;
    }

    static bool HandleSpectatorVersionCommand(ChatHandler* handler, char const* args)
    {
        if (atoi(args) < SPECTATOR_ADDON_VERSION)
            ArenaSpectator::SendCommand(handler->GetSession()->GetPlayer(), "%sOUTDATED", SPECTATOR_ADDON_PREFIX);
        return true;
    }

    static bool HandleSpectatorResetCommand(ChatHandler* handler, char const*  /*args*/)
    {
        Player* p = handler->GetSession()->GetPlayer();
        if (!p->IsSpectator())
            return true;
        ArenaSpectator::HandleResetCommand(p);
        return true;
    }

    static bool HandleSpectatorLeaveCommand(ChatHandler* handler, char const*  /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player->IsSpectator() || !player->FindMap() || !player->FindMap()->IsBattleArena())
        {
            handler->SendSysMessage("You are not a spectator.");
            return true;
        }

        //player->SetIsSpectator(false);
        player->TeleportToEntryPoint();
        return true;
    }
};

void AddSC_spectator_commandscript()
{
    new spectator_commandscript();
}
