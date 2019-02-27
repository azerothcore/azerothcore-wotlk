/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: account_commandscript
%Complete: 100
Comment: All account related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "Chat.h"
#include "Language.h"
#include "Player.h"

class account_commandscript : public CommandScript
{
public:
    account_commandscript() : CommandScript("account_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> accountSetCommandTable =
        {
            { "addon", SEC_GAMEMASTER, true, &HandleAccountSetAddonCommand, "" },
            { "gmlevel", SEC_CONSOLE, true, &HandleAccountSetGmLevelCommand, "" },
            { "password", SEC_CONSOLE, true, &HandleAccountSetPasswordCommand, "" }
        };
        static std::vector<ChatCommand> accountLockCommandTable
        {
            { "country", SEC_PLAYER, true, &HandleAccountLockCountryCommand, "" },
            { "ip", SEC_PLAYER, true, &HandleAccountLockIpCommand, "" }
        };
        static std::vector<ChatCommand> accountCommandTable =
        {
            { "addon", SEC_MODERATOR, false, &HandleAccountAddonCommand, "" },
            { "create", SEC_CONSOLE, true, &HandleAccountCreateCommand, "" },
            { "delete", SEC_CONSOLE, true, &HandleAccountDeleteCommand, "" },
            { "onlinelist", SEC_CONSOLE, true, &HandleAccountOnlineListCommand, "" },
            { "lock", SEC_PLAYER, false, nullptr, "", accountLockCommandTable },
            { "set", SEC_ADMINISTRATOR, true, nullptr, "", accountSetCommandTable },
            { "password", SEC_PLAYER, false, &HandleAccountPasswordCommand, "" },
            { "", SEC_PLAYER, false, &HandleAccountCommand, "" }
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "account", SEC_PLAYER, true, nullptr, "", accountCommandTable }
        };
        return commandTable;
    }

    static bool HandleAccountAddonCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* exp = strtok((char*)args, " ");

        uint32 accountId = handler->GetSession()->GetAccountId();

        int expansion = atoi(exp); //get int anyway (0 if error)
        if (expansion < 0 || uint8(expansion) > sWorld->getIntConfig(CONFIG_EXPANSION))
        {
            handler->SendSysMessage(LANG_IMPROPER_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_EXPANSION);

        stmt->setUInt8(0, uint8(expansion));
        stmt->setUInt32(1, accountId);

        LoginDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_ACCOUNT_ADDON, expansion);
        return true;
    }

    /// Create an account
    static bool HandleAccountCreateCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        ///- %Parse the command line arguments
        char* accountName = strtok((char*)args, " ");
        char* password = strtok(nullptr, " ");
        if (!accountName || !password)
            return false;

        AccountOpResult result = AccountMgr::CreateAccount(std::string(accountName), std::string(password));
        switch (result)
        {
        case AOR_OK:
            handler->PSendSysMessage(LANG_ACCOUNT_CREATED, accountName);
            if (handler->GetSession())
            {
                sLog->outDebug(LOG_FILTER_WARDEN, "Account: %d (IP: %s) Character:[%s] (GUID: %u) Change Password.",
                    handler->GetSession()->GetAccountId(), handler->GetSession()->GetRemoteAddress().c_str(),
                    handler->GetSession()->GetPlayer()->GetName().c_str(), handler->GetSession()->GetPlayer()->GetGUIDLow());
            }
            break;
        case AOR_NAME_TOO_LONG:
            handler->SendSysMessage(LANG_ACCOUNT_TOO_LONG);
            handler->SetSentErrorMessage(true);
            return false;
        case AOR_NAME_ALREDY_EXIST:
            handler->SendSysMessage(LANG_ACCOUNT_ALREADY_EXIST);
            handler->SetSentErrorMessage(true);
            return false;
        case AOR_DB_INTERNAL_ERROR:
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_CREATED_SQL_ERROR, accountName);
            handler->SetSentErrorMessage(true);
            return false;
        default:
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_CREATED, accountName);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    /// Delete a user account and all associated characters in this realm
    /// \todo This function has to be enhanced to respect the login/realm split (delete char, delete account chars in realm then delete account)
    static bool HandleAccountDeleteCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        ///- Get the account name from the command line
        char* account = strtok((char*)args, " ");
        if (!account)
            return false;

        std::string accountName = account;
        if (!AccountMgr::normalizeString(accountName))
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 accountId = AccountMgr::GetId(accountName);
        if (!accountId)
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        /// Commands not recommended call from chat, but support anyway
        /// can delete only for account with less security
        /// This is also reject self apply in fact
        if (handler->HasLowerSecurityAccount(nullptr, accountId, true))
            return false;

        AccountOpResult result = AccountMgr::DeleteAccount(accountId);
        switch (result)
        {
        case AOR_OK:
            handler->PSendSysMessage(LANG_ACCOUNT_DELETED, accountName.c_str());
            break;
        case AOR_NAME_NOT_EXIST:
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        case AOR_DB_INTERNAL_ERROR:
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_DELETED_SQL_ERROR, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        default:
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_DELETED, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    /// Display info on users currently in the realm
    static bool HandleAccountOnlineListCommand(ChatHandler* handler, char const* /*args*/)
    {
        ///- Get the list of accounts ID logged to the realm
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ONLINE);

        PreparedQueryResult result = CharacterDatabase.Query(stmt);

        if (!result)
        {
            handler->SendSysMessage(LANG_ACCOUNT_LIST_EMPTY);
            return true;
        }

        ///- Display the list of account/characters online
        handler->SendSysMessage(LANG_ACCOUNT_LIST_BAR_HEADER);
        handler->SendSysMessage(LANG_ACCOUNT_LIST_HEADER);
        handler->SendSysMessage(LANG_ACCOUNT_LIST_BAR);

        ///- Cycle through accounts
        do
        {
            Field* fieldsDB = result->Fetch();
            std::string name = fieldsDB[0].GetString();
            uint32 account = fieldsDB[1].GetUInt32();

            ///- Get the username, last IP and GM level of each account
            // No SQL injection. account is uint32.
            stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_INFO);
            stmt->setUInt32(0, account);
            PreparedQueryResult resultLogin = LoginDatabase.Query(stmt);

            if (resultLogin)
            {
                Field* fieldsLogin = resultLogin->Fetch();
                handler->PSendSysMessage(LANG_ACCOUNT_LIST_LINE,
                    fieldsLogin[0].GetCString(), name.c_str(), fieldsLogin[1].GetCString(),
                    fieldsDB[2].GetUInt16(), fieldsDB[3].GetUInt16(), fieldsLogin[3].GetUInt8(),
                    fieldsLogin[2].GetUInt8());
            }
            else
                handler->PSendSysMessage(LANG_ACCOUNT_LIST_ERROR, name.c_str());
        } while (result->NextRow());

        handler->SendSysMessage(LANG_ACCOUNT_LIST_BAR);
        return true;
    }

    static bool HandleAccountLockCountryCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_USE_BOL);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string param = (char*)args;

        if (!param.empty())
        {
            if (param == "on")
            {
                PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_LOGON_COUNTRY);
                uint32 ip = inet_addr(handler->GetSession()->GetRemoteAddress().c_str());
                EndianConvertReverse(ip);
                stmt->setUInt32(0, ip);
                PreparedQueryResult result = LoginDatabase.Query(stmt);
                if (result)
                {
                    Field* fields = result->Fetch();
                    std::string country = fields[0].GetString();
                    stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_LOCK_CONTRY);
                    stmt->setString(0, country);
                    stmt->setUInt32(1, handler->GetSession()->GetAccountId());
                    LoginDatabase.Execute(stmt);
                    handler->PSendSysMessage(LANG_COMMAND_ACCLOCKLOCKED);
                }
                else
                {
                    handler->PSendSysMessage("[IP2NATION] Table empty");
                    ;//sLog->outDebug(LOG_FILTER_NETWORKIO, "[IP2NATION] Table empty");
                }
            }
            else if (param == "off")
            {
                PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_LOCK_CONTRY);
                stmt->setString(0, "00");
                stmt->setUInt32(1, handler->GetSession()->GetAccountId());
                LoginDatabase.Execute(stmt);
                handler->PSendSysMessage(LANG_COMMAND_ACCLOCKUNLOCKED);
            }
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleAccountLockIpCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_USE_BOL);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string param = (char*)args;

        if (!param.empty())
        {
            PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_LOCK);

            if (param == "on")
            {
                stmt->setBool(0, true);                                     // locked
                handler->PSendSysMessage(LANG_COMMAND_ACCLOCKLOCKED);
            }
            else if (param == "off")
            {
                stmt->setBool(0, false);                                    // unlocked
                handler->PSendSysMessage(LANG_COMMAND_ACCLOCKUNLOCKED);
            }

            stmt->setUInt32(1, handler->GetSession()->GetAccountId());

            LoginDatabase.Execute(stmt);
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleAccountPasswordCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* oldPassword = strtok((char*)args, " ");
        char* newPassword = strtok(nullptr, " ");
        char* passwordConfirmation = strtok(nullptr, " ");

        if (!oldPassword || !newPassword || !passwordConfirmation)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!AccountMgr::CheckPassword(handler->GetSession()->GetAccountId(), std::string(oldPassword)))
        {
            handler->SendSysMessage(LANG_COMMAND_WRONGOLDPASSWORD);
            sScriptMgr->OnFailedPasswordChange(handler->GetSession()->GetAccountId());
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (strcmp(newPassword, passwordConfirmation) != 0)
        {
            handler->SendSysMessage(LANG_NEW_PASSWORDS_NOT_MATCH);
            sScriptMgr->OnFailedPasswordChange(handler->GetSession()->GetAccountId());
            handler->SetSentErrorMessage(true);
            return false;
        }

        AccountOpResult result = AccountMgr::ChangePassword(handler->GetSession()->GetAccountId(), std::string(newPassword));
        switch (result)
        {
        case AOR_OK:
            handler->SendSysMessage(LANG_COMMAND_PASSWORD);
            sScriptMgr->OnPasswordChange(handler->GetSession()->GetAccountId());
            break;
        case AOR_PASS_TOO_LONG:
            handler->SendSysMessage(LANG_PASSWORD_TOO_LONG);
            sScriptMgr->OnFailedPasswordChange(handler->GetSession()->GetAccountId());
            handler->SetSentErrorMessage(true);
            return false;
        default:
            handler->SendSysMessage(LANG_COMMAND_NOTCHANGEPASSWORD);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandleAccountCommand(ChatHandler* handler, char const* /*args*/)
    {
        AccountTypes gmLevel = handler->GetSession()->GetSecurity();
        handler->PSendSysMessage(LANG_ACCOUNT_LEVEL, uint32(gmLevel));
        return true;
    }

    /// Set/Unset the expansion level for an account
    static bool HandleAccountSetAddonCommand(ChatHandler* handler, char const* args)
    {
        ///- Get the command line arguments
        char* account = strtok((char*)args, " ");
        char* exp = strtok(nullptr, " ");

        if (!account)
            return false;

        std::string accountName;
        uint32 accountId;

        if (!exp)
        {
            Player* player = handler->getSelectedPlayer();
            if (!player)
                return false;

            accountId = player->GetSession()->GetAccountId();
            AccountMgr::GetName(accountId, accountName);
            exp = account;
        }
        else
        {
            ///- Convert Account name to Upper Format
            accountName = account;
            if (!AccountMgr::normalizeString(accountName))
            {
                handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }

            accountId = AccountMgr::GetId(accountName);
            if (!accountId)
            {
                handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        // Let set addon state only for lesser (strong) security level
        // or to self account
        if (handler->GetSession() && handler->GetSession()->GetAccountId() != accountId &&
            handler->HasLowerSecurityAccount(nullptr, accountId, true))
            return false;

        int expansion = atoi(exp); //get int anyway (0 if error)
        if (expansion < 0 || uint8(expansion) > sWorld->getIntConfig(CONFIG_EXPANSION))
            return false;

        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_EXPANSION);

        stmt->setUInt8(0, expansion);
        stmt->setUInt32(1, accountId);

        LoginDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_ACCOUNT_SETADDON, accountName.c_str(), accountId, expansion);
        return true;
    }

    static bool HandleAccountSetGmLevelCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        std::string targetAccountName;
        uint32 targetAccountId = 0;
        uint32 targetSecurity = 0;
        uint32 gm = 0;
        char* arg1 = strtok((char*)args, " ");
        char* arg2 = strtok(nullptr, " ");
        char* arg3 = strtok(nullptr, " ");
        bool isAccountNameGiven = true;

        if (arg1 && !arg3)
        {
            if (!handler->getSelectedPlayer())
                return false;
            isAccountNameGiven = false;
        }

        // Check for second parameter
        if (!isAccountNameGiven && !arg2)
            return false;

        // Check for account
        if (isAccountNameGiven)
        {
            targetAccountName = arg1;
            if (!AccountMgr::normalizeString(targetAccountName))
            {
                handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, targetAccountName.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        // Check for invalid specified GM level.
        gm = (isAccountNameGiven) ? atoi(arg2) : atoi(arg1);
        if (gm > SEC_CONSOLE)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // handler->getSession() == nullptr only for console
        targetAccountId = (isAccountNameGiven) ? AccountMgr::GetId(targetAccountName) : handler->getSelectedPlayer()->GetSession()->GetAccountId();
        int32 gmRealmID = (isAccountNameGiven) ? atoi(arg3) : atoi(arg2);
        uint32 playerSecurity;
        if (handler->GetSession())
            playerSecurity = AccountMgr::GetSecurity(handler->GetSession()->GetAccountId(), gmRealmID);
        else
            playerSecurity = SEC_CONSOLE;

        // can set security level only for target with less security and to less security that we have
        // This is also reject self apply in fact
        targetSecurity = AccountMgr::GetSecurity(targetAccountId, gmRealmID);
        if (targetSecurity >= playerSecurity || gm >= playerSecurity)
        {
            handler->SendSysMessage(LANG_YOURS_SECURITY_IS_LOW);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Check and abort if the target gm has a higher rank on one of the realms and the new realm is -1
        if (gmRealmID == -1 && !AccountMgr::IsConsoleAccount(playerSecurity))
        {
            PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_ACCESS_GMLEVEL_TEST);

            stmt->setUInt32(0, targetAccountId);
            stmt->setUInt8(1, uint8(gm));

            PreparedQueryResult result = LoginDatabase.Query(stmt);

            if (result)
            {
                handler->SendSysMessage(LANG_YOURS_SECURITY_IS_LOW);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        // Check if provided realmID has a negative value other than -1
        if (gmRealmID < -1)
        {
            handler->SendSysMessage(LANG_INVALID_REALMID);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // If gmRealmID is -1, delete all values for the account id, else, insert values for the specific realmID
        PreparedStatement* stmt;

        if (gmRealmID == -1)
        {
            stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_ACCESS);

            stmt->setUInt32(0, targetAccountId);
        }
        else
        {
            stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_ACCESS_BY_REALM);

            stmt->setUInt32(0, targetAccountId);
            stmt->setUInt32(1, realmID);
        }

        LoginDatabase.Execute(stmt);

        if (gm != 0)
        {
            stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_ACCESS);

            stmt->setUInt32(0, targetAccountId);
            stmt->setUInt8(1, uint8(gm));
            stmt->setInt32(2, gmRealmID);

            LoginDatabase.Execute(stmt);
        }


        handler->PSendSysMessage(LANG_YOU_CHANGE_SECURITY, targetAccountName.c_str(), gm);
        return true;
    }

    /// Set password for account
    static bool HandleAccountSetPasswordCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        ///- Get the command line arguments
        char* account = strtok((char*)args, " ");
        char* password = strtok(nullptr, " ");
        char* passwordConfirmation = strtok(nullptr, " ");

        if (!account || !password || !passwordConfirmation)
            return false;

        std::string accountName = account;
        if (!AccountMgr::normalizeString(accountName))
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 targetAccountId = AccountMgr::GetId(accountName);
        if (!targetAccountId)
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        /// can set password only for target with less security
        /// This is also reject self apply in fact
        if (handler->HasLowerSecurityAccount(nullptr, targetAccountId, true))
            return false;

        if (strcmp(password, passwordConfirmation))
        {
            handler->SendSysMessage(LANG_NEW_PASSWORDS_NOT_MATCH);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AccountOpResult result = AccountMgr::ChangePassword(targetAccountId, password);

        switch (result)
        {
        case AOR_OK:
            handler->SendSysMessage(LANG_COMMAND_PASSWORD);
            break;
        case AOR_NAME_NOT_EXIST:
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        case AOR_PASS_TOO_LONG:
            handler->SendSysMessage(LANG_PASSWORD_TOO_LONG);
            handler->SetSentErrorMessage(true);
            return false;
        default:
            handler->SendSysMessage(LANG_COMMAND_NOTCHANGEPASSWORD);
            handler->SetSentErrorMessage(true);
            return false;
        }
        return true;
    }
};

void AddSC_account_commandscript()
{
    new account_commandscript();
}
