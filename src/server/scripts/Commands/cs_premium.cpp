/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 */

#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "Chat.h"
#include "Language.h"
#include "Player.h"

class premium_commandscript : public CommandScript
{
public:
    premium_commandscript() : CommandScript("premium_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> characterCommandTable
        {
            { "create",     SEC_GAMEMASTER, false, &HandlePremiumCharacterCreateCommand, "" },
            { "delete",     SEC_GAMEMASTER, false, &HandlePremiumCharacterDeleteCommand, "" },
            { "info",       SEC_GAMEMASTER, false, &HandlePremiumCharacterInfoCommand, "" }
        };

        static std::vector<ChatCommand> accountCommandTable
        {
            { "create",     SEC_GAMEMASTER, false, &HandlePremiumAccountCreateCommand, "" },
            { "delete",     SEC_GAMEMASTER, false, &HandlePremiumAccountDeleteCommand, "" },
            { "info",       SEC_GAMEMASTER, false, &HandlePremiumAccountInfoCommand, "" }
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "account",    SEC_GAMEMASTER, false, nullptr, "", accountCommandTable},
            { "character",  SEC_GAMEMASTER, false, nullptr, "", characterCommandTable}
        };
        static std::vector<ChatCommand> premiumCommandTable =
        {
            { "premium",    SEC_GAMEMASTER, false, nullptr, "", commandTable}
        };
        return premiumCommandTable;
    }

    static bool HandlePremiumCharacterInfoCommand(ChatHandler* handler, const char* /*args*/)
    {
        Player* target = handler->getSelectedPlayer();
        string playerName = target->GetName().c_str();
        if (!target)
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (handler->HasLowerSecurity(target, 0))
            return false;

        int premium_level = target->GetCharacterPremiumLevel(target->GetGUIDLow());
        if (!premium_level)
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage("No premium level available for character.");
            handler->SetSentErrorMessage(true);
            return false;
        }
        else
            (ChatHandler(handler->GetSession())).PSendSysMessage("Character premium level: %u.", premium_level);

        return true;
    }

    static bool HandlePremiumCharacterCreateCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        // Which premium level to be added
        int premiumLevel = atoi((char*)args);

        Player* target = handler->getSelectedPlayer();
        string playerName = target->GetName().c_str();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (handler->HasLowerSecurity(target, 0))
            return false;

        bool characterPremiumLevelAdded = target->CreateCharacterPremiumLevel(target->GetGUIDLow(), premiumLevel);
        if (characterPremiumLevelAdded)
            (ChatHandler(handler->GetSession())).PSendSysMessage("Character created with premium level %u.", premiumLevel);
        else
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage("Character already has a premium level. Please remove before hand.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandlePremiumCharacterDeleteCommand(ChatHandler* handler, const char* /*args*/)
    {
        Player* target = handler->getSelectedPlayer();
        string playerName = target->GetName().c_str();
        if (!target)
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (handler->HasLowerSecurity(target, 0))
            return false;

        bool characterPremiumDeleted = target->DeleteCharacterPremiumLevel(target->GetGUIDLow());
        if (characterPremiumDeleted)
            (ChatHandler(handler->GetSession())).PSendSysMessage("Premium character deleted.");
        else
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage("No premium level assigned to character.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandlePremiumAccountInfoCommand(ChatHandler* handler, const char* /*args*/)
    {
        Player* target = handler->getSelectedPlayer();
        string playerName = target->GetName().c_str();
        if (!target)
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (handler->HasLowerSecurity(target, 0))
            return false;

        int premium_level = target->GetAccountPremiumLevel(target->GetGUIDLow());
        if (!premium_level)
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage("Character's account doesn't have premium level.");
            handler->SetSentErrorMessage(true);
            return false;
        }
        else
            (ChatHandler(handler->GetSession())).PSendSysMessage("Account premium level %u", premium_level);

        return true;
    }

    static bool HandlePremiumAccountCreateCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        // Which premium level to be added
        int premiumLevel = atoi((char*)args);

        Player* target = handler->getSelectedPlayer();
        string playerName = target->GetName().c_str();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (handler->HasLowerSecurity(target, 0))
            return false;

        bool characterPremiumLevelAdded = target->CreateAccountPremiumLevel(target->GetGUIDLow(), premiumLevel);
        if (characterPremiumLevelAdded)
            (ChatHandler(handler->GetSession())).PSendSysMessage("Account premium level set to: %u", premiumLevel);
        else
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage("Account already has a premium level. Please remove before hand.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandlePremiumAccountDeleteCommand(ChatHandler* handler, const char* /*args*/)
    {
        Player* target = handler->getSelectedPlayer();
        string playerName = target->GetName().c_str();
        if (!target)
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (handler->HasLowerSecurity(target, 0))
            return false;

        bool characterPremiumDeleted = target->DeleteAccountPremiumLevel(target->GetGUIDLow());
        if (characterPremiumDeleted)
            (ChatHandler(handler->GetSession())).PSendSysMessage("Premium account deleted");
        else
        {
            (ChatHandler(handler->GetSession())).PSendSysMessage("No premium level assigned.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }
};

void AddSC_premium_commandscript()
{
    new premium_commandscript();
}
