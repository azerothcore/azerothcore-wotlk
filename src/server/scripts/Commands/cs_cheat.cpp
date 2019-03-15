/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 */

#include "Chat.h"
#include "Language.h"
#include "Player.h"
#include "ScriptMgr.h"

class cheat_commandscript : public CommandScript
{
public:
    cheat_commandscript() : CommandScript("cheat_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {

        static std::vector<ChatCommand> cheatCommandTable =
        {
            { "god",            SEC_GAMEMASTER,     false, &HandleGodModeCheatCommand,         "" },
            { "casttime",       SEC_GAMEMASTER,     false, &HandleCasttimeCheatCommand,        "" },
            { "cooldown",       SEC_GAMEMASTER,     false, &HandleCoolDownCheatCommand,        "" },
            { "power",          SEC_GAMEMASTER,     false, &HandlePowerCheatCommand,           "" },
            { "waterwalk",      SEC_GAMEMASTER,     false, &HandleWaterwalkCheatCommand,       "" },
            { "status",         SEC_GAMEMASTER,     false, &HandleCheatStatusCommand,          "" },
            { "taxi",           SEC_GAMEMASTER,     false, &HandleTaxiCheatCommand,            "" },

        };

        static std::vector<ChatCommand> commandTable =
        {
            { "cheat",          SEC_GAMEMASTER,     false, nullptr,                  "", cheatCommandTable },

        };
        return commandTable;
    }

    static bool HandleGodModeCheatCommand(ChatHandler* handler, char const* args)
    {
        std::string argstr = (char*)args;

        if (!*args)
            argstr = (handler->GetSession()->GetPlayer()->GetCommandStatus(CHEAT_GOD)) ? "off" : "on";

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOff(CHEAT_GOD);
            handler->SendSysMessage("Godmode is OFF. You can take damage.");
            return true;
        }
        else if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOn(CHEAT_GOD);
            handler->SendSysMessage("Godmode is ON. You won't take damage.");
            return true;
        }

        return false;
    }

    static bool HandleCasttimeCheatCommand(ChatHandler* handler, char const* args)
    {
        std::string argstr = (char*)args;

        if (!*args)
            argstr = (handler->GetSession()->GetPlayer()->GetCommandStatus(CHEAT_CASTTIME)) ? "off" : "on";

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOff(CHEAT_CASTTIME);
            handler->SendSysMessage("CastTime Cheat is OFF. Your spells will have a casttime.");
            return true;
        }
        else if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOn(CHEAT_CASTTIME);
            handler->SendSysMessage("CastTime Cheat is ON. Your spells won't have a casttime.");
            return true;
        }

        return false;
    }

    static bool HandleCoolDownCheatCommand(ChatHandler* handler, char const* args)
    {
        std::string argstr = (char*)args;

        if (!*args)
            argstr = (handler->GetSession()->GetPlayer()->GetCommandStatus(CHEAT_COOLDOWN)) ? "off" : "on";

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOff(CHEAT_COOLDOWN);
            handler->SendSysMessage("Cooldown Cheat is OFF. You are on the global cooldown.");
            return true;
        }
        else if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOn(CHEAT_COOLDOWN);
            handler->SendSysMessage("Cooldown Cheat is ON. You are not on the global cooldown.");
            return true;
        }

        return false;
    }

    static bool HandlePowerCheatCommand(ChatHandler* handler, char const* args)
    {
        std::string argstr = (char*)args;

        if (!*args)
            argstr = (handler->GetSession()->GetPlayer()->GetCommandStatus(CHEAT_POWER)) ? "off" : "on";

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOff(CHEAT_POWER);
            handler->SendSysMessage("Power Cheat is OFF. You need mana/rage/energy to use spells.");
            return true;
        }
        else if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetCommandStatusOn(CHEAT_POWER);
            handler->SendSysMessage("Power Cheat is ON. You don't need mana/rage/energy to use spells.");
            return true;
        }

        return false;
    }

    static bool HandleWaterwalkCheatCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* player = handler->getSelectedPlayer();
        if (!player)
        {
            handler->PSendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(player, 0))
            return false;

        if (strncmp(args, "on", 3) == 0)
        {
            player->SetMovement(MOVE_WATER_WALK);               // ON
            handler->GetSession()->GetPlayer()->SetCommandStatusOn(CHEAT_WATERWALK);
        }
        else if (strncmp(args, "off", 4) == 0)
        {
            player->SetMovement(MOVE_LAND_WALK);                // OFF
            handler->GetSession()->GetPlayer()->SetCommandStatusOff(CHEAT_WATERWALK);
        }
        else
        {
            handler->SendSysMessage(LANG_USE_BOL);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_SET_WATERWALK, args, handler->GetNameLink(player).c_str());
        if (handler->needReportToTarget(player))
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOUR_WATERWALK_SET, args, handler->GetNameLink().c_str());
        return true;
    }

    static bool HandleCheatStatusCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        char const* enabled = "ON";
        char const* disabled = "OFF";

        handler->SendSysMessage(LANG_COMMAND_CHEAT_STATUS);
        handler->PSendSysMessage(LANG_COMMAND_CHEAT_GOD, player->GetCommandStatus(CHEAT_GOD) ? enabled : disabled);
        handler->PSendSysMessage(LANG_COMMAND_CHEAT_CD, player->GetCommandStatus(CHEAT_COOLDOWN) ? enabled : disabled);
        handler->PSendSysMessage(LANG_COMMAND_CHEAT_CT, player->GetCommandStatus(CHEAT_CASTTIME) ? enabled : disabled);
        handler->PSendSysMessage(LANG_COMMAND_CHEAT_POWER, player->GetCommandStatus(CHEAT_POWER) ? enabled : disabled);
        handler->PSendSysMessage(LANG_COMMAND_CHEAT_WW, player->GetCommandStatus(CHEAT_WATERWALK) ? enabled : disabled);
        handler->PSendSysMessage(LANG_COMMAND_CHEAT_TAXINODES, player->isTaxiCheater() ? enabled : disabled);

        return true;
    }

    
    static bool HandleTaxiCheatCommand(ChatHandler* handler, char const* args)
    {
        std::string argStr = (char*)args;

        Player* chr = handler->getSelectedPlayer();

        if (!chr)
            chr = handler->GetSession()->GetPlayer();
        else if (handler->HasLowerSecurity(chr, 0)) // check online security
            return false;

        if (!*args)
            argStr = (chr->isTaxiCheater()) ? "off" : "on";

        if (argStr == "off")
        {
            chr->SetTaxiCheater(false);
            handler->PSendSysMessage(LANG_YOU_REMOVE_TAXIS, handler->GetNameLink(chr).c_str());
            if (handler->needReportToTarget(chr))
                ChatHandler(chr->GetSession()).PSendSysMessage(LANG_YOURS_TAXIS_REMOVED, handler->GetNameLink().c_str());

            return true;
        }
        else if (argStr == "on")
        {
            chr->SetTaxiCheater(true);
            handler->PSendSysMessage(LANG_YOU_GIVE_TAXIS, handler->GetNameLink(chr).c_str());
            if (handler->needReportToTarget(chr))
                ChatHandler(chr->GetSession()).PSendSysMessage(LANG_YOURS_TAXIS_ADDED, handler->GetNameLink().c_str());
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);

        return false;
    }
};

void AddSC_cheat_commandscript()
{
    new cheat_commandscript();
}
