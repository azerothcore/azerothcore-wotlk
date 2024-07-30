/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
Name: account_commandscript
%Complete: 100
Comment: All account related commands
Category: commandscripts
EndScriptData */

#include "AES.h"
#include "AccountMgr.h"
#include "Base32.h"
#include "Chat.h"
#include "CommandScript.h"
#include "CryptoGenerics.h"
#include "IPLocation.h"
#include "Player.h"
#include "Realm.h"
#include "ScriptMgr.h"
#include "SecretMgr.h"
#include "StringConvert.h"
#include "TOTP.h"
#include <unordered_map>

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class account_commandscript : public CommandScript
{
public:
    account_commandscript() : CommandScript("account_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable accountSetCommandTable =
        {
            { "addon",      HandleAccountSetAddonCommand,     SEC_GAMEMASTER, Console::Yes },
            { "gmlevel",    HandleAccountSetGmLevelCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "password",   HandleAccountSetPasswordCommand,  SEC_ADMINISTRATOR, Console::Yes },
            { "2fa",        HandleAccountSet2FACommand,       SEC_PLAYER,    Console::Yes  },
            { "email",      HandleAccountSetEmailCommand,     SEC_ADMINISTRATOR, Console::Yes }
        };

        static ChatCommandTable accountLockCommandTable
        {
            { "country",    HandleAccountLockCountryCommand,  SEC_PLAYER,    Console::Yes  },
            { "ip",         HandleAccountLockIpCommand,       SEC_PLAYER,    Console::Yes  }
        };

        static ChatCommandTable account2faCommandTable
        {
            { "setup",      HandleAccount2FASetupCommand,   SEC_PLAYER,    Console::No  },
            { "remove",     HandleAccount2FARemoveCommand,  SEC_PLAYER,    Console::No  }
        };

        static ChatCommandTable accountRemoveCommandTable
        {
            { "country",    HandleAccountRemoveLockCountryCommand,  SEC_ADMINISTRATOR, Console::Yes },
        };

        static ChatCommandTable accountCommandTable =
        {
            { "2fa",        account2faCommandTable                                       },
            { "addon",      HandleAccountAddonCommand,       SEC_MODERATOR, Console::No  },
            { "create",     HandleAccountCreateCommand,      SEC_CONSOLE,   Console::Yes },
            { "delete",     HandleAccountDeleteCommand,      SEC_CONSOLE,   Console::Yes },
            { "onlinelist", HandleAccountOnlineListCommand,  SEC_CONSOLE,   Console::Yes },
            { "lock",       accountLockCommandTable                                      },
            { "set",        accountSetCommandTable                                       },
            { "password",   HandleAccountPasswordCommand,    SEC_PLAYER,    Console::No  },
            { "remove",     accountRemoveCommandTable                                    },
            { "",           HandleAccountCommand,            SEC_PLAYER,    Console::No  }
        };

        static ChatCommandTable commandTable =
        {
            { "account", accountCommandTable }
        };

        return commandTable;
    }

    static bool HandleAccount2FASetupCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        auto token = Acore::StringTo<uint32>(args);

        auto const& masterKey = sSecretMgr->GetSecret(SECRET_TOTP_MASTER_KEY);
        if (!masterKey.IsAvailable())
        {
            handler->SendErrorMessage(LANG_2FA_COMMANDS_NOT_SETUP);
            return false;
        }

        uint32 const accountId = handler->GetSession()->GetAccountId();

        { // check if 2FA already enabled
            auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_TOTP_SECRET);
            stmt->SetData(0, accountId);
            PreparedQueryResult result = LoginDatabase.Query(stmt);

            if (!result)
            {
                LOG_ERROR("misc", "Account {} not found in login database when processing .account 2fa setup command.", accountId);
                handler->SendErrorMessage(LANG_UNKNOWN_ERROR);
                return false;
            }

            if (!result->Fetch()->IsNull())
            {
                handler->SendErrorMessage(LANG_2FA_ALREADY_SETUP);
                return false;
            }
        }

        // store random suggested secrets
        static std::unordered_map<uint32, Acore::Crypto::TOTP::Secret> suggestions;
        auto pair = suggestions.emplace(std::piecewise_construct, std::make_tuple(accountId), std::make_tuple(Acore::Crypto::TOTP::RECOMMENDED_SECRET_LENGTH)); // std::vector 1-argument std::size_t constructor invokes resize

        if (pair.second) // no suggestion yet, generate random secret
            Acore::Crypto::GetRandomBytes(pair.first->second);

        if (!pair.second && token) // suggestion already existed and token specified - validate
        {
            if (Acore::Crypto::TOTP::ValidateToken(pair.first->second, *token))
            {
                if (masterKey)
                    Acore::Crypto::AEEncryptWithRandomIV<Acore::Crypto::AES>(pair.first->second, *masterKey);

                auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_TOTP_SECRET);
                stmt->SetData(0, pair.first->second);
                stmt->SetData(1, accountId);
                LoginDatabase.Execute(stmt);

                suggestions.erase(pair.first);
                handler->SendSysMessage(LANG_2FA_SETUP_COMPLETE);
                return true;
            }
            else
                handler->SendSysMessage(LANG_2FA_INVALID_TOKEN);
        }

        // new suggestion, or no token specified, output TOTP parameters
        handler->SendErrorMessage(LANG_2FA_SECRET_SUGGESTION, Acore::Encoding::Base32::Encode(pair.first->second).c_str());
        return false;
    }

    static bool HandleAccount2FARemoveCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        auto token = Acore::StringTo<uint32>(args);

        auto const& masterKey = sSecretMgr->GetSecret(SECRET_TOTP_MASTER_KEY);
        if (!masterKey.IsAvailable())
        {
            handler->SendErrorMessage(LANG_2FA_COMMANDS_NOT_SETUP);
            return false;
        }

        uint32 const accountId = handler->GetSession()->GetAccountId();
        Acore::Crypto::TOTP::Secret secret;
        { // get current TOTP secret
            auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_TOTP_SECRET);
            stmt->SetData(0, accountId);
            PreparedQueryResult result = LoginDatabase.Query(stmt);

            if (!result)
            {
                LOG_ERROR("misc", "Account {} not found in login database when processing .account 2fa setup command.", accountId);
                handler->SendErrorMessage(LANG_UNKNOWN_ERROR);
                return false;
            }

            Field* field = result->Fetch();
            if (field->IsNull())
            { // 2FA not enabled
                handler->SendErrorMessage(LANG_2FA_NOT_SETUP);
                return false;
            }

            secret = field->Get<Binary>();
        }

        if (token)
        {
            if (masterKey)
            {
                bool success = Acore::Crypto::AEDecrypt<Acore::Crypto::AES>(secret, *masterKey);
                if (!success)
                {
                    LOG_ERROR("misc", "Account {} has invalid ciphertext in TOTP token.", accountId);
                    handler->SendErrorMessage(LANG_UNKNOWN_ERROR);
                    return false;
                }
            }

            if (Acore::Crypto::TOTP::ValidateToken(secret, *token))
            {
                auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_TOTP_SECRET);
                stmt->SetData(0);
                stmt->SetData(1, accountId);
                LoginDatabase.Execute(stmt);
                handler->SendSysMessage(LANG_2FA_REMOVE_COMPLETE);
                return true;
            }
            else
                handler->SendSysMessage(LANG_2FA_INVALID_TOKEN);
        }

        handler->SendErrorMessage(LANG_2FA_REMOVE_NEED_TOKEN);
        return false;
    }

    static bool HandleAccountAddonCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        char* exp = strtok((char*)args, " ");

        uint32 accountId = handler->GetSession()->GetAccountId();

        auto expansion = Acore::StringTo<uint8>(exp); //get int anyway (0 if error)
        if (!expansion || *expansion > sWorld->getIntConfig(CONFIG_EXPANSION))
        {
            handler->SendErrorMessage(LANG_IMPROPER_VALUE);
            return false;
        }

        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_EXPANSION);

        stmt->SetData(0, *expansion);
        stmt->SetData(1, accountId);

        LoginDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_ACCOUNT_ADDON, *expansion);
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
                    LOG_DEBUG("warden", "Account: {} (IP: {}) Character:[{}] ({}) Change Password.",
                                   handler->GetSession()->GetAccountId(), handler->GetSession()->GetRemoteAddress(),
                                   handler->GetSession()->GetPlayer()->GetName(), handler->GetSession()->GetPlayer()->GetGUID().ToString());
                }
                break;
            case AOR_NAME_TOO_LONG:
                handler->SendErrorMessage(LANG_ACCOUNT_TOO_LONG);
                return false;
            case AOR_PASS_TOO_LONG:
                handler->SendErrorMessage(LANG_ACCOUNT_PASS_TOO_LONG);
                return false;
            case AOR_NAME_ALREADY_EXIST:
                handler->SendErrorMessage(LANG_ACCOUNT_ALREADY_EXIST);
                return false;
            case AOR_DB_INTERNAL_ERROR:
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_CREATED_SQL_ERROR, accountName);
                return false;
            default:
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_CREATED, accountName);
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
        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            return false;
        }

        uint32 accountId = AccountMgr::GetId(accountName);
        if (!accountId)
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
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
                handler->PSendSysMessage(LANG_ACCOUNT_DELETED, accountName);
                break;
            case AOR_NAME_NOT_EXIST:
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
                return false;
            case AOR_DB_INTERNAL_ERROR:
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_DELETED_SQL_ERROR, accountName.c_str());
                return false;
            default:
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_DELETED, accountName.c_str());
                return false;
        }

        return true;
    }

    /// Display info on users currently in the realm
    static bool HandleAccountOnlineListCommand(ChatHandler* handler, char const* /*args*/)
    {
        ///- Get the list of accounts ID logged to the realm
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_ONLINE);

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
            std::string name = fieldsDB[0].Get<std::string>();
            uint32 account = fieldsDB[1].Get<uint32>();

            ///- Get the username, last IP and GM level of each account
            // No SQL injection. account is uint32.
            LoginDatabasePreparedStatement* loginStmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_INFO);
            loginStmt->SetData(0, account);
            PreparedQueryResult resultLogin = LoginDatabase.Query(loginStmt);

            if (resultLogin)
            {
                Field* fieldsLogin = resultLogin->Fetch();
                handler->PSendSysMessage(LANG_ACCOUNT_LIST_LINE,
                                         fieldsLogin[0].Get<std::string>(), name, fieldsLogin[1].Get<std::string>(),
                                         fieldsDB[2].Get<uint16>(), fieldsDB[3].Get<uint16>(), fieldsLogin[3].Get<uint8>(),
                                         fieldsLogin[2].Get<uint8>());
            }
            else
                handler->PSendSysMessage(LANG_ACCOUNT_LIST_ERROR, name);
        } while (result->NextRow());

        handler->SendSysMessage(LANG_ACCOUNT_LIST_BAR);
        return true;
    }

    static bool HandleAccountRemoveLockCountryCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        ///- %Parse the command line arguments
        char* _accountName = strtok((char*)args, " ");
        if (!_accountName)
            return false;

        std::string accountName = _accountName;
        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        uint32 accountId = AccountMgr::GetId(accountName);
        if (!accountId)
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_LOCK_COUNTRY);
        stmt->SetData(0, "00");
        stmt->SetData(1, accountId);
        LoginDatabase.Execute(stmt);
        handler->PSendSysMessage(LANG_COMMAND_ACCLOCKUNLOCKED);

        return true;
    }

    static bool HandleAccountLockCountryCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_USE_BOL);
            return false;
        }

        std::string param = (char*)args;

        if (!param.empty())
        {
            if (param == "on")
            {
                if (IpLocationRecord const* location = sIPLocation->GetLocationRecord(handler->GetSession()->GetRemoteAddress()))
                {
                    auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_LOCK_COUNTRY);
                    stmt->SetData(0, location->CountryCode);
                    stmt->SetData(1, handler->GetSession()->GetAccountId());
                    LoginDatabase.Execute(stmt);
                    handler->PSendSysMessage(LANG_COMMAND_ACCLOCKLOCKED);
                }
                else
                {
                    handler->SendErrorMessage("No IP2Location information - account not locked");
                    return false;
                }
            }
            else if (param == "off")
            {
                auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_LOCK_COUNTRY);
                stmt->SetData(0, "00");
                stmt->SetData(1, handler->GetSession()->GetAccountId());
                LoginDatabase.Execute(stmt);
                handler->PSendSysMessage(LANG_COMMAND_ACCLOCKUNLOCKED);
            }
            return true;
        }

        handler->SendErrorMessage(LANG_USE_BOL);
        return false;
    }

    static bool HandleAccountLockIpCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_USE_BOL);
            return false;
        }

        std::string param = (char*)args;

        if (!param.empty())
        {
            LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_LOCK);

            if (param == "on")
            {
                stmt->SetData(0, true);                                     // locked
                handler->PSendSysMessage(LANG_COMMAND_ACCLOCKLOCKED);
            }
            else if (param == "off")
            {
                stmt->SetData(0, false);                                    // unlocked
                handler->PSendSysMessage(LANG_COMMAND_ACCLOCKUNLOCKED);
            }

            stmt->SetData(1, handler->GetSession()->GetAccountId());

            LoginDatabase.Execute(stmt);
            return true;
        }

        handler->SendErrorMessage(LANG_USE_BOL);
        return false;
    }

    static bool HandleAccountPasswordCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        char* oldPassword = strtok((char*)args, " ");
        char* newPassword = strtok(nullptr, " ");
        char* passwordConfirmation = strtok(nullptr, " ");

        if (!oldPassword || !newPassword || !passwordConfirmation)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        if (!AccountMgr::CheckPassword(handler->GetSession()->GetAccountId(), std::string(oldPassword)))
        {
            handler->SendErrorMessage(LANG_COMMAND_WRONGOLDPASSWORD);
            sScriptMgr->OnFailedPasswordChange(handler->GetSession()->GetAccountId());
            return false;
        }

        if (strcmp(newPassword, passwordConfirmation) != 0)
        {
            handler->SendErrorMessage(LANG_NEW_PASSWORDS_NOT_MATCH);
            sScriptMgr->OnFailedPasswordChange(handler->GetSession()->GetAccountId());
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
                handler->SendErrorMessage(LANG_PASSWORD_TOO_LONG);
                sScriptMgr->OnFailedPasswordChange(handler->GetSession()->GetAccountId());
                return false;
            default:
                handler->SendErrorMessage(LANG_COMMAND_NOTCHANGEPASSWORD);
                return false;
        }

        return true;
    }

    static bool HandleAccountSet2FACommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        char* _account = strtok((char*)args, " ");
        char* _secret = strtok(nullptr, " ");

        if (!_account || !_secret)
        {
            handler->SendErrorMessage(LANG_CMD_SYNTAX);
            return false;
        }

        std::string accountName = _account;
        std::string secret = _secret;

        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        uint32 targetAccountId = AccountMgr::GetId(accountName);
        if (!targetAccountId)
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        if (handler->HasLowerSecurityAccount(nullptr, targetAccountId, true))
            return false;

        if (secret == "off")
        {
            auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_TOTP_SECRET);
            stmt->SetData(0);
            stmt->SetData(1, targetAccountId);
            LoginDatabase.Execute(stmt);
            handler->PSendSysMessage(LANG_2FA_REMOVE_COMPLETE);
            return true;
        }

        auto const& masterKey = sSecretMgr->GetSecret(SECRET_TOTP_MASTER_KEY);
        if (!masterKey.IsAvailable())
        {
            handler->SendErrorMessage(LANG_2FA_COMMANDS_NOT_SETUP);
            return false;
        }

        Optional<std::vector<uint8>> decoded = Acore::Encoding::Base32::Decode(secret);
        if (!decoded)
        {
            handler->SendErrorMessage(LANG_2FA_SECRET_INVALID);
            return false;
        }

        if (128 < (decoded->size() + Acore::Crypto::AES::IV_SIZE_BYTES + Acore::Crypto::AES::TAG_SIZE_BYTES))
        {
            handler->SendErrorMessage(LANG_2FA_SECRET_TOO_LONG);
            return false;
        }

        if (masterKey)
            Acore::Crypto::AEEncryptWithRandomIV<Acore::Crypto::AES>(*decoded, *masterKey);

        auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_TOTP_SECRET);
        stmt->SetData(0, *decoded);
        stmt->SetData(1, targetAccountId);
        LoginDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_2FA_SECRET_SET_COMPLETE, accountName);
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
            if (!Utf8ToUpperOnlyLatin(accountName))
            {
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
                return false;
            }

            accountId = AccountMgr::GetId(accountName);
            if (!accountId)
            {
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
                return false;
            }
        }

        // Let set addon state only for lesser (strong) security level
        // or to self account
        if (handler->GetSession() && handler->GetSession()->GetAccountId() != accountId &&
                handler->HasLowerSecurityAccount(nullptr, accountId, true))
            return false;

        auto expansion = Acore::StringTo<uint8>(exp); //get int anyway (0 if error)
        if (!expansion || *expansion > sWorld->getIntConfig(CONFIG_EXPANSION))
            return false;

        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_EXPANSION);

        stmt->SetData(0, *expansion);
        stmt->SetData(1, accountId);

        LoginDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_ACCOUNT_SETADDON, accountName, accountId, *expansion);
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
            if (!Utf8ToUpperOnlyLatin(targetAccountName))
            {
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, targetAccountName);
                return false;
            }
        }

        // Check for invalid specified GM level.
        gm = (isAccountNameGiven) ? Acore::StringTo<int32>(arg2).value_or(0) : Acore::StringTo<int32>(arg1).value_or(0);
        if (gm > SEC_CONSOLE)
        {
            handler->SendErrorMessage(LANG_BAD_VALUE);
            return false;
        }

        // handler->getSession() == nullptr only for console
        targetAccountId = (isAccountNameGiven) ? AccountMgr::GetId(targetAccountName) : handler->getSelectedPlayer()->GetSession()->GetAccountId();
        int32 gmRealmID = (isAccountNameGiven) ? Acore::StringTo<int32>(arg3).value_or(0) : Acore::StringTo<int32>(arg2).value_or(0);
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
            handler->SendErrorMessage(LANG_YOURS_SECURITY_IS_LOW);
            return false;
        }

        // Check and abort if the target gm has a higher rank on one of the realms and the new realm is -1
        if (gmRealmID == -1 && !AccountMgr::IsConsoleAccount(playerSecurity))
        {
            LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_ACCESS_GMLEVEL_TEST);

            stmt->SetData(0, targetAccountId);
            stmt->SetData(1, uint8(gm));

            PreparedQueryResult result = LoginDatabase.Query(stmt);

            if (result)
            {
                handler->SendErrorMessage(LANG_YOURS_SECURITY_IS_LOW);
                return false;
            }
        }

        // Check if provided realm.Id.Realm has a negative value other than -1
        if (gmRealmID < -1)
        {
            handler->SendErrorMessage(LANG_INVALID_REALMID);
            return false;
        }

        // If gmRealmID is -1, delete all values for the account id, else, insert values for the specific realm.Id.Realm
        LoginDatabasePreparedStatement* stmt;

        if (gmRealmID == -1)
        {
            stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_ACCESS);
            stmt->SetData(0, targetAccountId);
        }
        else
        {
            stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_ACCOUNT_ACCESS_BY_REALM);
            stmt->SetData(0, targetAccountId);
            stmt->SetData(1, realm.Id.Realm);
        }

        LoginDatabase.Execute(stmt);

        if (gm != 0)
        {
            stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_ACCESS);

            stmt->SetData(0, targetAccountId);
            stmt->SetData(1, uint8(gm));
            stmt->SetData(2, gmRealmID);

            LoginDatabase.Execute(stmt);
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_SECURITY, targetAccountName, gm);
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
        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        uint32 targetAccountId = AccountMgr::GetId(accountName);
        if (!targetAccountId)
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        /// can set password only for target with less security
        /// This is also reject self apply in fact
        if (handler->HasLowerSecurityAccount(nullptr, targetAccountId, true))
            return false;

        if (strcmp(password, passwordConfirmation))
        {
            handler->SendErrorMessage(LANG_NEW_PASSWORDS_NOT_MATCH);
            return false;
        }

        AccountOpResult result = AccountMgr::ChangePassword(targetAccountId, password);

        switch (result)
        {
            case AOR_OK:
                handler->SendSysMessage(LANG_COMMAND_PASSWORD);
                break;
            case AOR_NAME_NOT_EXIST:
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
                return false;
            case AOR_PASS_TOO_LONG:
                handler->SendErrorMessage(LANG_PASSWORD_TOO_LONG);
                return false;
            default:
                handler->SendErrorMessage(LANG_COMMAND_NOTCHANGEPASSWORD);
                return false;
        }
        return true;
    }

    /// Set email for account
    static bool HandleAccountSetEmailCommand(ChatHandler* handler, AccountIdentifier account, std::string email, std::string emailConfirmation)

    {
        if (!account || !email.data() || !emailConfirmation.data())
            return false;

        std::string accountName = account.GetName();
        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        uint32 targetAccountId = account.GetID();
        if (!targetAccountId)
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return false;
        }

        if (email != emailConfirmation)
        {
            handler->SendErrorMessage(LANG_NEW_EMAILS_NOT_MATCH);
            return false;
        }

        AccountOpResult result = AccountMgr::ChangeEmail(targetAccountId, email.data());

        switch (result)
        {
            case AOR_OK:
                handler->SendSysMessage(LANG_COMMAND_EMAIL);
                break;
            case AOR_NAME_NOT_EXIST:
                handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
                return false;
            case AOR_EMAIL_TOO_LONG:
                handler->SendErrorMessage(LANG_EMAIL_TOO_LONG);
                return false;
            default:
                handler->SendErrorMessage(LANG_COMMAND_NOTCHANGEEMAIL);
                return false;
        }
        return true;
    }
};

void AddSC_account_commandscript()
{
    new account_commandscript();
}
