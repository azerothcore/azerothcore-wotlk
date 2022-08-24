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
#include "CryptoGenerics.h"
#include "IPLocation.h"
#include "Language.h"
#include "Player.h"
#include "Realm.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "ScriptMgr.h"
#include "SecretMgr.h"
#include "StringConvert.h"
#include "TOTP.h"
#include <openssl/rand.h>
#include <unordered_map>

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

void static UpdateLevel(Player* player)
{
    char msg[2048];
    uint32 guild = player->GetGuildId();
    QueryResult result = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild =  {}", guild);
    if (result)
    {
        Field* fields = result->Fetch();
        uint16 level = fields[0].Get<uint16>();
        uint32 xp = fields[1].Get<uint32>();

        QueryResult maxlevel = CharacterDatabase.Query("SELECT max(level) FROM guild_xp_table");
        uint32 maxlvl = maxlevel->Fetch()->Get<uint32>();
        QueryResult maxexp = CharacterDatabase.Query("SELECT xp FROM guild_xp_table WHERE level =  {}", maxlvl);
        uint32 maxxp = maxexp->Fetch()->Get<uint32>();

        QueryResult knowLevel = CharacterDatabase.Query("SELECT level FROM guild_xp_table WHERE xp >  {}", xp);
        if (knowLevel)
        {
            Field* fs = knowLevel->Fetch();
            uint16 gLevel = fs[0].Get<uint16>();

            if (level < gLevel)
            {
                if (gLevel == maxlvl)
                {
                    snprintf(msg, 250, "|cffff0000[Новый уровень гильдии]:|r |cff6C8CD5Гильдия достигла максимального уровня.");
                    sWorld->SendGuildText(guild, msg);
                }
                else
                {
                    snprintf(msg, 250, "|cffff0000[Новый уровень гильдии]:|r |cff6C8CD5Гильдия достигла  {}-го уровня.", gLevel);
                    sWorld->SendGuildText(guild, msg);
                }
            }
            CharacterDatabase.Query("UPDATE guild_level SET level =  {} WHERE guild =  {}", gLevel, guild);
        }

        if (xp > maxxp)
            CharacterDatabase.Query("UPDATE `guild_level` SET `xp`= {} WHERE (`guild`= {})", maxxp, guild);
        else
            CharacterDatabase.Query("UPDATE `guild_level` SET `xp`= {} WHERE (`guild`= {})", xp, guild);
    }

    //sGuildMgr->LoadGuilds();
}

class account_commandscript : public CommandScript
{
public:
    account_commandscript() : CommandScript("account_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable accountSetCommandTable =
        {
            { "addon",      SEC_GAMEMASTER,     true,   &HandleAccountSetAddonCommand,          "" },
            { "gmlevel",    SEC_CONSOLE,        true,   &HandleAccountSetGmLevelCommand,        "" },
            { "password",   SEC_CONSOLE,        true,   &HandleAccountSetPasswordCommand,       "" },
            { "2fa",        SEC_PLAYER,         true,   &HandleAccountSet2FACommand,            "" }
        };

        static ChatCommandTable accountLockCommandTable
        {
            { "country",    SEC_PLAYER,         true,   &HandleAccountLockCountryCommand,       "" },
            { "ip",         SEC_PLAYER,         true,   &HandleAccountLockIpCommand,            "" }
        };

        static ChatCommandTable account2faCommandTable
        {
            { "setup",      SEC_PLAYER,         false,  &HandleAccount2FASetupCommand,          "" },
            { "remove",     SEC_PLAYER,         false,  &HandleAccount2FARemoveCommand,         "" },
        };

        static ChatCommandTable accountRemoveCommandTable
        {
            { "country",    SEC_ADMINISTRATOR,  true,  &HandleAccountRemoveLockCountryCommand,  "" }
        };

        static ChatCommandTable accountCommandTable =
        {
            { "2fa",        SEC_PLAYER,         true,   nullptr, "", account2faCommandTable        },
            { "addon",      SEC_MODERATOR,      false,  &HandleAccountAddonCommand,             "" },
            { "create",     SEC_CONSOLE,        true,   &HandleAccountCreateCommand,            "" },
            { "delete",     SEC_CONSOLE,        true,   &HandleAccountDeleteCommand,            "" },
            { "onlinelist", SEC_CONSOLE,        true,   &HandleAccountOnlineListCommand,        "" },
            { "lock",       SEC_PLAYER,         false,  nullptr, "", accountLockCommandTable       },
            { "set",        SEC_ADMINISTRATOR,  true,   nullptr, "", accountSetCommandTable        },
            { "password",   SEC_PLAYER,         false,  &HandleAccountPasswordCommand,          "" },
            { "remove",     SEC_ADMINISTRATOR,  true,   nullptr, "", accountRemoveCommandTable     },
            { "",           SEC_PLAYER,         false,  &HandleAccountCommand,                  "" }
        };

        static ChatCommandTable commandTable =
        {
            { "account", SEC_PLAYER, true, nullptr, "", accountCommandTable }
        };

        return commandTable;
    }

    static bool HandleAccount2FASetupCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        auto token = Acore::StringTo<uint32>(args);

        auto const& masterKey = sSecretMgr->GetSecret(SECRET_TOTP_MASTER_KEY);
        if (!masterKey.IsAvailable())
        {
            handler->SendSysMessage(LANG_2FA_COMMANDS_NOT_SETUP);
            handler->SetSentErrorMessage(true);
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
                handler->SendSysMessage(LANG_UNKNOWN_ERROR);
                handler->SetSentErrorMessage(true);
                return false;
            }

            if (!result->Fetch()->IsNull())
            {
                handler->SendSysMessage(LANG_2FA_ALREADY_SETUP);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        // store random suggested secrets
        static std::unordered_map<uint32, Acore::Crypto::TOTP::Secret> suggestions;
        auto pair = suggestions.emplace(std::piecewise_construct, std::make_tuple(accountId), std::make_tuple(Acore::Crypto::TOTP::RECOMMENDED_SECRET_LENGTH)); // std::vector 1-argument size_t constructor invokes resize

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
        handler->PSendSysMessage(LANG_2FA_SECRET_SUGGESTION, Acore::Encoding::Base32::Encode(pair.first->second).c_str());
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleAccount2FARemoveCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        auto token = Acore::StringTo<uint32>(args);

        auto const& masterKey = sSecretMgr->GetSecret(SECRET_TOTP_MASTER_KEY);
        if (!masterKey.IsAvailable())
        {
            handler->SendSysMessage(LANG_2FA_COMMANDS_NOT_SETUP);
            handler->SetSentErrorMessage(true);
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
                handler->SendSysMessage(LANG_UNKNOWN_ERROR);
                handler->SetSentErrorMessage(true);
                return false;
            }

            Field* field = result->Fetch();
            if (field->IsNull())
            { // 2FA not enabled
                handler->SendSysMessage(LANG_2FA_NOT_SETUP);
                handler->SetSentErrorMessage(true);
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
                    handler->SendSysMessage(LANG_UNKNOWN_ERROR);
                    handler->SetSentErrorMessage(true);
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

        handler->SendSysMessage(LANG_2FA_REMOVE_NEED_TOKEN);
        handler->SetSentErrorMessage(true);
        return false;
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

        auto expansion = Acore::StringTo<uint8>(exp); //get int anyway (0 if error)
        if (!expansion || *expansion > sWorld->getIntConfig(CONFIG_EXPANSION))
        {
            handler->SendSysMessage(LANG_IMPROPER_VALUE);
            handler->SetSentErrorMessage(true);
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
                handler->SendSysMessage(LANG_ACCOUNT_TOO_LONG);
                handler->SetSentErrorMessage(true);
                return false;
            case AOR_PASS_TOO_LONG:
                handler->SendSysMessage(LANG_ACCOUNT_PASS_TOO_LONG);
                handler->SetSentErrorMessage(true);
                return false;
            case AOR_NAME_ALREADY_EXIST:
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
        if (!Utf8ToUpperOnlyLatin(accountName))
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
                                         fieldsLogin[0].Get<std::string>().c_str(), name.c_str(), fieldsLogin[1].Get<std::string>().c_str(),
                                         fieldsDB[2].Get<uint16>(), fieldsDB[3].Get<uint16>(), fieldsLogin[3].Get<uint8>(),
                                         fieldsLogin[2].Get<uint8>());
            }
            else
                handler->PSendSysMessage(LANG_ACCOUNT_LIST_ERROR, name.c_str());
        } while (result->NextRow());

        handler->SendSysMessage(LANG_ACCOUNT_LIST_BAR);
        return true;
    }

    static bool HandleAccountRemoveLockCountryCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        ///- %Parse the command line arguments
        char* _accountName = strtok((char*)args, " ");
        if (!_accountName)
            return false;

        std::string accountName = _accountName;
        if (!Utf8ToUpperOnlyLatin(accountName))
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
            handler->SendSysMessage(LANG_USE_BOL);
            handler->SetSentErrorMessage(true);
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
                    handler->PSendSysMessage("No IP2Location information - account not locked");
                    handler->SetSentErrorMessage(true);
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

    static bool HandleAccountSet2FACommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* _account = strtok((char*)args, " ");
        char* _secret = strtok(nullptr, " ");

        if (!_account || !_secret)
        {
            handler->SendSysMessage(LANG_CMD_SYNTAX);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string accountName = _account;
        std::string secret = _secret;

        if (!Utf8ToUpperOnlyLatin(accountName))
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
            handler->SendSysMessage(LANG_2FA_COMMANDS_NOT_SETUP);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Optional<std::vector<uint8>> decoded = Acore::Encoding::Base32::Decode(secret);
        if (!decoded)
        {
            handler->SendSysMessage(LANG_2FA_SECRET_INVALID);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (128 < (decoded->size() + Acore::Crypto::AES::IV_SIZE_BYTES + Acore::Crypto::AES::TAG_SIZE_BYTES))
        {
            handler->SendSysMessage(LANG_2FA_SECRET_TOO_LONG);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (masterKey)
            Acore::Crypto::AEEncryptWithRandomIV<Acore::Crypto::AES>(*decoded, *masterKey);

        auto* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_ACCOUNT_TOTP_SECRET);
        stmt->SetData(0, *decoded);
        stmt->SetData(1, targetAccountId);
        LoginDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_2FA_SECRET_SET_COMPLETE, accountName.c_str());
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

        auto expansion = Acore::StringTo<uint8>(exp); //get int anyway (0 if error)
        if (!expansion || *expansion > sWorld->getIntConfig(CONFIG_EXPANSION))
            return false;

        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_EXPANSION);

        stmt->SetData(0, *expansion);
        stmt->SetData(1, accountId);

        LoginDatabase.Execute(stmt);

        handler->PSendSysMessage(LANG_ACCOUNT_SETADDON, accountName.c_str(), accountId, *expansion);
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
                handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, targetAccountName.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        // Check for invalid specified GM level.
        gm = (isAccountNameGiven) ? Acore::StringTo<int32>(arg2).value_or(0) : Acore::StringTo<int32>(arg1).value_or(0);
        if (gm > SEC_CONSOLE)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
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
            handler->SendSysMessage(LANG_YOURS_SECURITY_IS_LOW);
            handler->SetSentErrorMessage(true);
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
                handler->SendSysMessage(LANG_YOURS_SECURITY_IS_LOW);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        // Check if provided realm.Id.Realm has a negative value other than -1
        if (gmRealmID < -1)
        {
            handler->SendSysMessage(LANG_INVALID_REALMID);
            handler->SetSentErrorMessage(true);
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
        if (!Utf8ToUpperOnlyLatin(accountName))
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

//GuildLevel

/*
class npc_guild_level : public CreatureScript

{

public:

    npc_guild_level() : CreatureScript("npc_guild_level") {}

    bool OnGossipHello(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        uint32 guild = player->GetGuildId();
        uint16 level;
        if (!guild) {
            SendGossipMenuFor(player, 200171, creature->GetGUID());
            return false;
        }

        QueryResult result = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
        if (result) {
            Field* fields = result->Fetch();
            uint16 level = fields[0].Get<uint16>();
            uint32 xp = fields[1].Get<uint32>();

            std::stringstream buffer2;
            buffer2 << "---------------------------------------";
            std::stringstream buffer;
            buffer << "                 Уровень: " << "|cFF1c21a0" << level << "|r";
            std::stringstream buffer1;
            buffer1 << "                  Опыт: " << "|cFF680a67" << xp << "|r";

            QueryResult result1 = CharacterDatabase.Query("SELECT xp FROM guild_xp_table WHERE level = %u", level);
            if (result1) {
                Field* fields = result1->Fetch();
                uint32 reqXp = fields[0].Get<uint32>();
                uint32 ReqXp = reqXp - xp;
                std::stringstream buffer4;
                buffer4 << "    До " << level + 1 << "-го уровня осталось: " << "|cFF680a67" << ReqXp << "|r";
                std::stringstream buffer3;
                buffer3 << "---------------------------------------";

                if (level < 5) {
                    std::ostringstream temb;
                    temb << "|TInterface/ICONS/INV_Inscription_ArmorScroll02:32:32:-18:0|tП";
                    std::ostringstream femb;
                    femb << "|TInterface/ICONS/Achievement_Guild_DoctorIsIn:20|tПожертвовать Эмблемы";
                    std::ostringstream hnr;
                    hnr << "|TInterface/ICONS/Achievement_Guild_DoctorIsIn:20|tПожертвовать Очки чести";
                    std::ostringstream arn;
                    arn << "|TInterface/ICONS/Achievement_Guild_DoctorIsIn:20|tПожертвовать Очки арены";
                    std::ostringstream gld;
                    gld << "|TInterface/ICONS/Achievement_Guild_DoctorIsIn:20|tПожертвовать Золото";
                    //AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, temb.str(), GOSSIP_SENDER_MAIN, 35)
                    AddGossipItemFor(player,10, buffer2.str(), GOSSIP_SENDER_MAIN, 41);
                    AddGossipItemFor(player,10, buffer.str(), GOSSIP_SENDER_MAIN, 41);
                    AddGossipItemFor(player,10, buffer1.str(), GOSSIP_SENDER_MAIN, 41);
                    AddGossipItemFor(player,10, buffer4.str(), GOSSIP_SENDER_MAIN, 41);
                    AddGossipItemFor(player,10, buffer3.str(), GOSSIP_SENDER_MAIN, 41);
                    AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, femb.str(), GOSSIP_SENDER_MAIN, 37);
                    AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, gld.str(), GOSSIP_SENDER_MAIN, 200, "Введите сумму, которую хотите пожертвовать\n|cfff4b25e[Пожертвование] 1000 золота = 10 опыта|r", 0, true);
                    AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, hnr.str(), GOSSIP_SENDER_MAIN, 1);
                    AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, arn.str(), GOSSIP_SENDER_MAIN, 2);
                }
                else
                    ChatHandler(player->GetSession()).PSendSysMessage("|cfff4b25eВаша гильдия имеет максимальный уровень!|r");
            }
        }


        if (player->GetRank() == 0)
        {
            std::ostringstream clr;
            clr << "|TInterface/ICONS/Spell_Magic_ManaGain:20|tИзменить цвет названия";
            AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, clr.str(), GOSSIP_SENDER_MAIN, 24);
        }
        std::ostringstream gsr;
        gsr << "|TInterface/ICONS/Spell_Shadow_Fumble:20|t[ТОП] Гильдий";
        AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, gsr.str(), GOSSIP_SENDER_MAIN, 13);
        std::ostringstream vlg;
        vlg << "|TInterface/ICONS/Temp:20|tСписок вложивших в гильдию";
        AddGossipItemFor(player,GOSSIP_ICON_MONEY_BAG, vlg.str(), GOSSIP_SENDER_MAIN, 9914);

        std::ostringstream vxd;
        vxd << "|TInterface/ICONS/Spell_ChargeNegative:20|tВыход";
        AddGossipItemFor(player,GOSSIP_ICON_TALK, vxd.str(), GOSSIP_SENDER_MAIN, 4);
        SendGossipMenuFor(player, 200171, creature->GetGUID());

        return true;
    }

    void InvestedRoster(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/inv_misc_frostemblem_01:25:25:-18:0|tТОП 10 вложивших эмблем", GOSSIP_SENDER_MAIN, 9918);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/Achievement_BG_kill_flag_carrierEOS:25:25:-18:0|tТОП 10 вложивших очков чести", GOSSIP_SENDER_MAIN, 9915);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/Achievement_Arena_2v2_1:25:25:-18:0|tТОП 10 вложивших очков арены", GOSSIP_SENDER_MAIN, 9916);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/Achievement_Arena_2v2_2:25:25:-18:0|tТОП 10 вложивших в гильдию золота", GOSSIP_SENDER_MAIN, 9000);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void InvestedRosterGold1(Player* player, Creature* creature)
    {
        player->PlayerTalkClass->ClearMenus();
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT name, gold, number FROM guild_level_invested WHERE gold > 0 AND guild = %u ORDER BY gold DESC LIMIT 10", guild);
        if (result)
        {
            std::string name;
            uint32 gold;
            uint64 number;
            uint32 rank = 1;

            AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/Achievement_Arena_2v2_2:20:20:-18:0|tТОП 10 вложивших золото", GOSSIP_SENDER_MAIN, 9000);

            do {
                Field* fields = result->Fetch();
                name = fields[0].Get<std::string>();
                gold = fields[1].Get<uint32>();
                number = fields[2].Get<uint64>();

                std::stringstream buffer;
                buffer << "|TInterface/ICONS/Achievement_Arena_2v2_2:20:20:-20:0|t" << rank << " Игрок: " << "|cff790C06" << name << "|r" << " вложил " << "|cFF1E90FF" << gold << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, number);

                rank++;

            } while (result->NextRow());
        }
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage("|cff006699В гильдию еще вложений не производилось!");
            CloseGossipMenuFor(player);
        }
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void InvestedToken(Player* player, Creature* creature)
    {
        player->PlayerTalkClass->ClearMenus();
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT name, token, number FROM guild_level_invested WHERE token > 0 AND guild = %u ORDER BY token DESC LIMIT 10", guild);
        if (result)
        {
            std::string name;
            uint32 token;
            uint64 number;
            uint32 rank = 1;

            AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/inv_misc_ornatebox:20:20:-18:0|tТОП 10 вложивших эмблем", GOSSIP_SENDER_MAIN, 9918);

            do
            {
                Field* fields = result->Fetch();
                name = fields[0].Get<std::string>();
                token = fields[1].Get<uint32>();
                number = fields[2].Get<uint64>();

                std::stringstream buffer;
                buffer << "|TInterface/ICONS/inv_misc_ornatebox:20:20:-20:0|t" << rank << " Игрок: " << "|cff790C06" << name << "|r" << " вложил " << "|cFF1E90FF" << token << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, number);

                rank++;

            } while (result->NextRow());
        }
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage("|cff006699В гильдию еще вложений не производилось!");
            CloseGossipMenuFor(player);
        }
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void InvestedRosterHonor1(Player* player, Creature* creature)
    {
        player->PlayerTalkClass->ClearMenus();
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT name, honor, number FROM guild_level_invested WHERE honor > 0 AND guild = %u ORDER BY honor DESC LIMIT 10", guild);
        if (result)
        {
            std::string name;
            uint32 honor;
            uint64 number;
            uint32 rank = 1;

            AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/Achievement_BG_kill_flag_carrierEOS:20:20:-20:0|tТОП 10 вложивших очков чести", GOSSIP_SENDER_MAIN, 9915);
            do
            {
                Field* fields = result->Fetch();
                name = fields[0].Get<std::string>();
                honor = fields[1].Get<uint32>();
                number = fields[2].Get<uint64>();

                std::stringstream buffer;
                buffer << "|TInterface/ICONS/Achievement_BG_kill_flag_carrierEOS:20:20:-20:0|t" << rank << " Игрок: " << "|cff790C06" << name << "|r" << " вложил " << "|cFF1E90FF" << honor << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, number);

                rank++;

            } while (result->NextRow());
        }
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage("|cff006699В гильдию еще вложений не производилось!");
            CloseGossipMenuFor(player);
        }
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void InvestedRosterHonor2(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "<= Назад", GOSSIP_SENDER_MAIN, 9911);
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT name, honor, number FROM guild_level_invested WHERE honor > 0 AND guild = %u ORDER BY honor DESC", guild);
        if (result) {
            std::string name;
            uint32 honor;
            uint64 number;
            uint16 go = 0;
            do {
                if (go < 30) {
                    go++;
                    continue;
                }
                Field* fields = result->Fetch();
                name = fields[0].Get<std::string>();
                honor = fields[1].Get<uint32>();
                number = fields[2].Get<uint64>();

                if (go == 60) break;
                std::stringstream buffer;
                buffer << "Игрок: " << "|cff790C06" << name << "|r" << " вложил " << "|cFF1E90FF" << honor << " чести" << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, number);

                go++;

            } while (result->NextRow());


        }


        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void InvestedRosterArena1(Player* player, Creature* creature)
    {
        player->PlayerTalkClass->ClearMenus();
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT name, arena, number FROM guild_level_invested WHERE arena > 0 AND guild = %u ORDER BY arena DESC LIMIT 10", guild);
        if (result)
        {
            std::string name;
            uint32 arena;
            uint64 number;
            uint32 rank = 1;

            AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "|TInterface/ICONS/Achievement_Arena_2v2_1:20:20:-20:0|tТОП 10 вложивших Очков арены", GOSSIP_SENDER_MAIN, 9916);
            do
            {
                Field* fields = result->Fetch();
                name = fields[0].Get<std::string>();
                arena = fields[1].Get<uint32>();
                number = fields[2].Get<uint64>();

                std::stringstream buffer;
                buffer << "|TInterface/ICONS/Achievement_Arena_2v2_1:20:20:-20:0|t" << rank << " Игрок: " << "|cff790C06" << name << "|r" << " вложил " << "|cFF1E90FF" << arena << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, number);

                rank++;

            } while (result->NextRow());
        }
        else
        {
            ChatHandler(player->GetSession()).PSendSysMessage("|cff006699В гильдию еще вложений не производилось!");
            CloseGossipMenuFor(player);
        }
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void InvestedRosterArena2(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "<= Назад", GOSSIP_SENDER_MAIN, 9913);
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT name, arena, number FROM guild_level_invested WHERE arena > 0 AND guild = %u ORDER BY arena DESC", guild);
        if (result) {
            std::string name;
            uint32 arena;
            uint64 number;
            uint16 go = 0;
            do {
                if (go < 30) {
                    go++;
                    continue;
                }
                Field* fields = result->Fetch();
                name = fields[0].Get<std::string>();
                arena = fields[1].Get<uint32>();
                number = fields[2].Get<uint64>();

                if (go == 60) break;
                std::stringstream buffer;
                buffer << "Игрок: " << "|cff790C06" << name << "|r" << " вложил " << "|cFF1E90FF" << arena << " арены" << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, number);

                go++;

            } while (result->NextRow());


        }


        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }



    void UpdateLevelCost(Player* player) {
        uint32 guild = player->GetGuildId();
        QueryResult result10 = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
        if (result10) {
            Field* fields = result10->Fetch();
            uint16 level = fields[0].Get<uint16>();
            uint32 xp = fields[1].Get<uint32>();

            QueryResult knowLevel = CharacterDatabase.Query("SELECT level FROM guild_xp_table WHERE xp > %u", xp);
            if (knowLevel)
            {
                Field* fs = knowLevel->Fetch();
                uint16 gLevel = fs[0].Get<uint16>();
                CharacterDatabase.Query("UPDATE guild_level SET level = %u WHERE guild = %u", gLevel, guild);
            }

        }
    }



    void SelectSpell5(Player* player, Creature* creature, uint32 action) {
        uint32 spell;
        uint32 cost;
        uint32 number;
        uint32 guild = player->GetGuildId();
        
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, number FROM guild_level_spell WHERE level = 5");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                number = fields[2].Get<uint32>();

                if (number == action) {
                    // learn spell

                    QueryResult result2 = CharacterDatabase.Query("SELECT guid FROM guild_member WHERE guildid = %u", guild);
                    if (result2) {
                        QueryResult result15 = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
                        if (result15) {
                            Field* fields = result15->Fetch();
                            uint16 level = fields[0].Get<uint16>();
                            uint32 xp = fields[1].Get<uint32>();
                            if (xp >= cost) {
                                CharacterDatabase.Query("UPDATE guild_level SET xp = xp-%u WHERE guild = %u", cost, guild);

                                UpdateLevelCost(player);
                            }
                            else {
                                CloseGossipMenuFor(player);
                                player->GetSession()->SendNotification("Недостаточно опыта гильдии!");
                                return;
                            }

                        }
                        do {
                            Field* fields = result2->Fetch();
                            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint64>());
                            if (Player* onlinePlayer = ObjectAccessor::FindPlayer(guid)) {
                                onlinePlayer->learnSpell(spell);
                            }
                            else CharacterDatabase.Query("REPLACE INTO character_spell (guid, spell, active, disabled) VALUES (%u, %u, 1, 0)", guid, spell);

                            CharacterDatabase.Query("REPLACE INTO guild_learn_spell (guild, spell) VALUES (%u, %u)", guild, spell);


                        } while (result2->NextRow());

                    }

                    // learn spell
                    CloseGossipMenuFor(player);
                    player->GetSession()->SendAreaTriggerMessage("Гильдейское заклинание успешно куплено!");
                }

            } while (result->NextRow());
        }

    }

    void SelectSpell10(Player* player, Creature* creature, uint32 action) {
        uint32 spell;
        uint32 cost;
        uint32 number;
        uint32 guild = player->GetGuildId();
        
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, number FROM guild_level_spell WHERE level = 10");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                number = fields[2].Get<uint32>();

                if (number == action) {
                    // learn spell

                    QueryResult result2 = CharacterDatabase.Query("SELECT guid FROM guild_member WHERE guildid = %u", guild);
                    if (result2) {
                        QueryResult result15 = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
                        if (result15) {
                            Field* fields = result15->Fetch();
                            uint16 level = fields[0].Get<uint16>();
                            uint32 xp = fields[1].Get<uint32>();
                            if (xp >= cost) {
                                CharacterDatabase.Query("UPDATE guild_level SET xp = xp-%u WHERE guild = %u", cost, guild);

                                UpdateLevelCost(player);
                            }
                            else {
                                CloseGossipMenuFor(player);
                                player->GetSession()->SendNotification("Недостаточно опыта гильдии!");
                                return;
                            }

                        }
                        do {
                            Field* fields = result2->Fetch();
                            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint64>());
                            if (Player* onlinePlayer = ObjectAccessor::FindPlayer(guid)) {
                                onlinePlayer->learnSpell(spell);
                            }
                            else CharacterDatabase.Query("REPLACE INTO character_spell (guid, spell, active, disabled) VALUES (%u, %u, 1, 0)", guid, spell);

                            CharacterDatabase.Query("REPLACE INTO guild_learn_spell (guild, spell) VALUES (%u, %u)", guild, spell);


                        } while (result2->NextRow());

                    }

                    // learn spell
                    CloseGossipMenuFor(player);
                    player->GetSession()->SendAreaTriggerMessage("Гильдейское заклинание успешно куплено!");
                }

            } while (result->NextRow());
        }

    }

    void SelectSpell15(Player* player, Creature* creature, uint32 action) {
        uint32 spell;
        uint32 cost;
        uint32 number;
        uint32 guild = player->GetGuildId();
        
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, number FROM guild_level_spell WHERE level = 15");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                number = fields[2].Get<uint32>();

                if (number == action) {
                    // learn spell

                    QueryResult result2 = CharacterDatabase.Query("SELECT guid FROM guild_member WHERE guildid = %u", guild);
                    if (result2) {
                        QueryResult result15 = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
                        if (result15) {
                            Field* fields = result15->Fetch();
                            uint16 level = fields[0].Get<uint16>();
                            uint32 xp = fields[1].Get<uint32>();
                            if (xp >= cost) {
                                CharacterDatabase.Query("UPDATE guild_level SET xp = xp-%u WHERE guild = %u", cost, guild);

                                UpdateLevelCost(player);
                            }
                            else {
                                CloseGossipMenuFor(player);
                                player->GetSession()->SendNotification("Недостаточно опыта гильдии!");
                                return;
                            }

                        }
                        do {
                            Field* fields = result2->Fetch();
                            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint64>());
                            if (Player* onlinePlayer = ObjectAccessor::FindPlayer(guid)) {
                                onlinePlayer->learnSpell(spell);
                            }
                            else CharacterDatabase.Query("REPLACE INTO character_spell (guid, spell, active, disabled) VALUES (%u, %u, 1, 0)", guid, spell);

                            CharacterDatabase.Query("REPLACE INTO guild_learn_spell (guild, spell) VALUES (%u, %u)", guild, spell);


                        } while (result2->NextRow());

                    }

                    // learn spell
                    CloseGossipMenuFor(player);
                    player->GetSession()->SendAreaTriggerMessage("Гильдейское заклинание успешно куплено!");
                }

            } while (result->NextRow());
        }

    }

    void SelectSpell20(Player* player, Creature* creature, uint32 action) {
        uint32 spell;
        uint32 cost;
        uint32 number;
        uint32 guild = player->GetGuildId();
        
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, number FROM guild_level_spell WHERE level = 20");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                number = fields[2].Get<uint32>();

                if (number == action) {
                    // learn spell

                    QueryResult result2 = CharacterDatabase.Query("SELECT guid FROM guild_member WHERE guildid = %u", guild);
                    if (result2) {
                        QueryResult result15 = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
                        if (result15) {
                            Field* fields = result15->Fetch();
                            uint16 level = fields[0].Get<uint16>();
                            uint32 xp = fields[1].Get<uint32>();
                            if (xp >= cost) {
                                CharacterDatabase.Query("UPDATE guild_level SET xp = xp-%u WHERE guild = %u", cost, guild);

                                UpdateLevelCost(player);
                            }
                            else {
                                CloseGossipMenuFor(player);
                                player->GetSession()->SendNotification("Недостаточно опыта гильдии!");
                                return;
                            }

                        }
                        do {
                            Field* fields = result2->Fetch();
                            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint64>());
                            if (Player* onlinePlayer = ObjectAccessor::FindPlayer(guid)) {
                                onlinePlayer->learnSpell(spell);
                            }
                            else CharacterDatabase.Query("REPLACE INTO character_spell (guid, spell, active, disabled) VALUES (%u, %u, 1, 0)", guid, spell);

                            CharacterDatabase.Query("REPLACE INTO guild_learn_spell (guild, spell) VALUES (%u, %u)", guild, spell);


                        } while (result2->NextRow());

                    }

                    // learn spell
                    CloseGossipMenuFor(player);
                    player->GetSession()->SendAreaTriggerMessage("Гильдейское заклинание успешно куплено!");
                }

            } while (result->NextRow());
        }

    }

    void SelectSpell25(Player* player, Creature* creature, uint32 action) {
        uint32 spell;
        uint32 cost;
        uint32 number;
        uint32 guild = player->GetGuildId();
        
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, number FROM guild_level_spell WHERE level = 25");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                number = fields[2].Get<uint32>();

                if (number == action) {
                    // learn spell

                    QueryResult result2 = CharacterDatabase.Query("SELECT guid FROM guild_member WHERE guildid = %u", guild);
                    if (result2) {
                        QueryResult result15 = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
                        if (result15) {
                            Field* fields = result15->Fetch();
                            uint16 level = fields[0].Get<uint16>();
                            uint32 xp = fields[1].Get<uint32>();
                            if (xp >= cost) {
                                CharacterDatabase.Query("UPDATE guild_level SET xp = xp-%u WHERE guild = %u", cost, guild);

                                UpdateLevelCost(player);
                            }
                            else {
                                CloseGossipMenuFor(player);
                                player->GetSession()->SendNotification("Недостаточно опыта гильдии!");
                                return;
                            }

                        }
                        do {
                            Field* fields = result2->Fetch();
                            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint64>());
                            if (Player* onlinePlayer = ObjectAccessor::FindPlayer(guid)) {
                                onlinePlayer->learnSpell(spell);
                            }
                            else CharacterDatabase.Query("REPLACE INTO character_spell (guid, spell, active, disabled) VALUES (%u, %u, 1, 0)", guid, spell);

                            CharacterDatabase.Query("REPLACE INTO guild_learn_spell (guild, spell) VALUES (%u, %u)", guild, spell);


                        } while (result2->NextRow());

                    }

                    // learn spell
                    CloseGossipMenuFor(player);
                    player->GetSession()->SendAreaTriggerMessage("Гильдейское заклинание успешно куплено!");
                }

            } while (result->NextRow());
        }

    }

    void SelectSpell30(Player* player, Creature* creature, uint32 action) {
        uint32 spell;
        uint32 cost;
        uint32 number;
        uint32 guild = player->GetGuildId();
        
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, number FROM guild_level_spell WHERE level = 30");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                number = fields[2].Get<uint32>();

                if (number == action) {
                    // learn spell

                    QueryResult result2 = CharacterDatabase.Query("SELECT guid FROM guild_member WHERE guildid = %u", guild);
                    if (result2) {
                        QueryResult result15 = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
                        if (result15) {
                            Field* fields = result15->Fetch();
                            uint16 level = fields[0].Get<uint16>();
                            uint32 xp = fields[1].Get<uint32>();
                            if (xp >= cost) {
                                CharacterDatabase.Query("UPDATE guild_level SET xp = xp-%u WHERE guild = %u", cost, guild);

                                UpdateLevelCost(player);
                            }
                            else {
                                CloseGossipMenuFor(player);
                                player->GetSession()->SendNotification("Недостаточно опыта гильдии!");
                                return;
                            }

                        }
                        do {
                            Field* fields = result2->Fetch();
                            ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint64>());
                            if (Player* onlinePlayer = ObjectAccessor::FindPlayer(guid)) {
                                onlinePlayer->learnSpell(spell);
                            }
                            else CharacterDatabase.Query("REPLACE INTO character_spell (guid, spell, active, disabled) VALUES (%u, %u, 1, 0)", guid, spell);

                            CharacterDatabase.Query("REPLACE INTO guild_learn_spell (guild, spell) VALUES (%u, %u)", guild, spell);


                        } while (result2->NextRow());

                    }

                    // learn spell
                    CloseGossipMenuFor(player);
                    player->GetSession()->SendAreaTriggerMessage("Гильдейское заклинание успешно куплено!");
                }

            } while (result->NextRow());
        }

    }

    void ReplaceColorList(Player* player, Creature* creature)
    {
        player->PlayerTalkClass->ClearMenus();

        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "Изменить цвет на [Красный]", GOSSIP_SENDER_MAIN, 25);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "Изменить цвет на [Синий]", GOSSIP_SENDER_MAIN, 26);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "Изменить цвет на [Чёрный]", GOSSIP_SENDER_MAIN, 27);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "Изменить цвет на [Белый]", GOSSIP_SENDER_MAIN, 28);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "Изменить цвет на [Зелёный]", GOSSIP_SENDER_MAIN, 29);
        AddGossipItemFor(player,GOSSIP_ICON_TRAINER, "Изменить цвет на [Желтый]", GOSSIP_SENDER_MAIN, 30);

        SendGossipMenuFor(player, 2001714, creature->GetGUID());
    }

    void ReplaceColor(Player* player, Creature* creature, uint32 color)
    {
        switch (color)
        {
        case 1:
            CharacterDatabase.Execute("UPDATE guild_level SET color = '|cffFF0000' WHERE guild = %u", player->GetGuildId());
            break;
        case 2:
            CharacterDatabase.Execute("UPDATE guild_level SET color = '|cff0000FF' WHERE guild = %u", player->GetGuildId());
            break;
        case 3:
            CharacterDatabase.Execute("UPDATE guild_level SET color = '|cff000000' WHERE guild = %u", player->GetGuildId());
            break;
        case 4:
            CharacterDatabase.Execute("UPDATE guild_level SET color = '|cffFFFFFF' WHERE guild = %u", player->GetGuildId());
            break;
        case 5:
            CharacterDatabase.Execute("UPDATE guild_level SET color = '|cff00FF00' WHERE guild = %u", player->GetGuildId());
            break;
        case 6:
            CharacterDatabase.Execute("UPDATE guild_level SET color = '|cffFFFF00' WHERE guild = %u", player->GetGuildId());
            break;

        }
        sGuildMgr->LoadGuilds();
        player->GetSession()->SendAreaTriggerMessage("Вы успешно сменили цвет названия гильдии!");
        CloseGossipMenuFor(player);
    }

    void BuySpell10(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "Список доступных спеллов:", GOSSIP_SENDER_MAIN, 9900);
        uint32 spell;
        uint32 cost;
        uint16 level;
        uint32 number;
        uint32 faction;
        const char* name;
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, level, number, faction FROM guild_level_spell WHERE level = 10");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                level = fields[2].Get<uint16>();
                number = fields[3].Get<uint32>();
                faction = fields[4].Get<uint32>();

                if (player->HasSpell(spell)) continue;
                ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Система Гильдий]:|r Все доступные заклинания - изучены.|r");

                if (player->GetTeamId() == TEAM_ALLIANCE && faction == 2) continue;

                if (player->GetTeamId() == TEAM_HORDE && faction == 1) continue;
                const SpellEntry* spellEntry = sSpellStore.LookupEntry(spell);
                name = (spellEntry->SpellName[8]);

                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Стоимость: " << "|cFF0f4d8a" << cost << " опыта." << "|r";

                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, buffer.str(), GOSSIP_SENDER_MAIN, number);
            }

            while (result->NextRow());

            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }
    }

    void BuySpell15(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "Список доступных спеллов:", GOSSIP_SENDER_MAIN, 9901);
        uint32 spell;
        uint32 cost;
        uint16 level;
        uint32 number;
        uint32 faction;
        const char* name;
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, level, number, faction FROM guild_level_spell WHERE level = 15");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                level = fields[2].Get<uint16>();
                number = fields[3].Get<uint32>();
                faction = fields[4].Get<uint32>();

                if (player->HasSpell(spell)) continue;

                if (player->GetTeamId() == TEAM_ALLIANCE && faction == 2) continue;

                if (player->GetTeamId() == TEAM_HORDE && faction == 1) continue;
                const SpellEntry* spellEntry = sSpellStore.LookupEntry(spell);
                name = (spellEntry->SpellName[8]);

                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Стоимость: " << "|cFF0f4d8a" << cost << " опыта." << "|r";

                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, buffer.str(), GOSSIP_SENDER_MAIN, number);
            }

            while (result->NextRow());

            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }
    }

    void BuySpell20(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "Список доступных спеллов:", GOSSIP_SENDER_MAIN, 9902);
        uint32 spell;
        uint32 cost;
        uint16 level;
        uint32 number;
        uint32 faction;
        const char* name;
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, level, number, faction FROM guild_level_spell WHERE level = 20");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                level = fields[2].Get<uint16>();
                number = fields[3].Get<uint32>();
                faction = fields[4].Get<uint32>();

                if (player->HasSpell(spell)) continue;

                if (player->GetTeamId() == TEAM_ALLIANCE && faction == 2) continue;

                if (player->GetTeamId() == TEAM_HORDE && faction == 1) continue;
                const SpellEntry* spellEntry = sSpellStore.LookupEntry(spell);
                name = (spellEntry->SpellName[8]);

                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Стоимость: " << "|cFF0f4d8a" << cost << " опыта." << "|r";

                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, buffer.str(), GOSSIP_SENDER_MAIN, number);
            }

            while (result->NextRow());

            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }
    }
    void BuySpell25(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "Список доступных спеллов:", GOSSIP_SENDER_MAIN, 9903);
        uint32 spell;
        uint32 cost;
        uint16 level;
        uint32 number;
        uint32 faction;
        const char* name;
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, level, number, faction FROM guild_level_spell WHERE level = 25");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                level = fields[2].Get<uint16>();
                number = fields[3].Get<uint32>();
                faction = fields[4].Get<uint32>();

                if (player->HasSpell(spell)) continue;

                if (player->GetTeamId() == TEAM_ALLIANCE && faction == 2) continue;

                if (player->GetTeamId() == TEAM_HORDE && faction == 1) continue;
                const SpellEntry* spellEntry = sSpellStore.LookupEntry(spell);
                name = (spellEntry->SpellName[8]);

                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Стоимость: " << "|cFF0f4d8a" << cost << " опыта." << "|r";

                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, buffer.str(), GOSSIP_SENDER_MAIN, number);
            }

            while (result->NextRow());

            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }
    }

    void BuySpell30(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "Список доступных спеллов:", GOSSIP_SENDER_MAIN, 9904);
        uint32 spell;
        uint32 cost;
        uint16 level;
        uint32 number;
        uint32 faction;
        const char* name;
        QueryResult result = CharacterDatabase.Query("SELECT spell, cost, level, number, faction FROM guild_level_spell WHERE level = 30");
        if (result) {
            do {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                level = fields[2].Get<uint16>();
                number = fields[3].Get<uint32>();
                faction = fields[4].Get<uint32>();

                if (player->HasSpell(spell)) continue;

                if (player->GetTeamId() == TEAM_ALLIANCE && faction == 2) continue;

                if (player->GetTeamId() == TEAM_HORDE && faction == 1) continue;
                const SpellEntry* spellEntry = sSpellStore.LookupEntry(spell);
                name = (spellEntry->SpellName[8]);

                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Стоимость: " << "|cFF0f4d8a" << cost << " опыта." << "|r";

                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, buffer.str(), GOSSIP_SENDER_MAIN, number);
            }

            while (result->NextRow());

            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }
    }

    void CurrentSpellsMenu(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();

        AddGossipItemFor(player,GOSSIP_ICON_TALK, "Доступные уровни заклинаний:", GOSSIP_SENDER_MAIN, 9905);
        uint32 guild = player->GetGuildId();
        uint16 level;
        QueryResult result = CharacterDatabase.Query("SELECT level FROM guild_level WHERE guild = %u", guild);
        if (result) {
            Field* fields = result->Fetch();
            level = fields[0].Get<uint16>();
        }

        uint32 spell;
        if (level >= 5) {
            QueryResult result2 = CharacterDatabase.Query("SELECT spell FROM guild_level_spell WHERE level = 5");
            if (result2) {
                do {
                    Field* fields = result2->Fetch();
                    spell = fields[0].Get<uint32>();
                    if (!player->HasSpell(spell)) {
                        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Заклинания 5-го уровня", GOSSIP_SENDER_MAIN, 24);
                        break;
                    }
                } while (result2->NextRow());
            }
        }

        if (level >= 10) {
            QueryResult result2 = CharacterDatabase.Query("SELECT spell FROM guild_level_spell WHERE level = 10");
            if (result2) {
                do {
                    Field* fields = result2->Fetch();
                    spell = fields[0].Get<uint32>();
                    if (!player->HasSpell(spell)) {
                        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Заклинания 10-го уровня", GOSSIP_SENDER_MAIN, 25);
                        break;
                    }
                } while (result2->NextRow());
            }
        }

        if (level >= 15) {
            QueryResult result2 = CharacterDatabase.Query("SELECT spell FROM guild_level_spell WHERE level = 15");
            if (result2) {
                do {
                    Field* fields = result2->Fetch();
                    spell = fields[0].Get<uint32>();
                    if (!player->HasSpell(spell)) {
                        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Заклинания 15-го уровня", GOSSIP_SENDER_MAIN, 26);
                        break;
                    }
                } while (result2->NextRow());
            }
        }

        if (level >= 20) {
            QueryResult result2 = CharacterDatabase.Query("SELECT spell FROM guild_level_spell WHERE level = 20");
            if (result2) {
                do {
                    Field* fields = result2->Fetch();
                    spell = fields[0].Get<uint32>();
                    if (!player->HasSpell(spell)) {
                        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Заклинания 20-го уровня", GOSSIP_SENDER_MAIN, 27);
                        break;
                    }
                } while (result2->NextRow());
            }
        }

        if (level >= 25) {
            QueryResult result2 = CharacterDatabase.Query("SELECT spell FROM guild_level_spell WHERE level = 25");
            if (result2) {
                do {
                    Field* fields = result2->Fetch();
                    spell = fields[0].Get<uint32>();
                    if (!player->HasSpell(spell)) {
                        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Заклинания 25-го уровня", GOSSIP_SENDER_MAIN, 28);
                        break;
                    }
                } while (result2->NextRow());
            }
        }

        if (level >= 30) {
            QueryResult result2 = CharacterDatabase.Query("SELECT spell FROM guild_level_spell WHERE level = 30");
            if (result2) {
                do {
                    Field* fields = result2->Fetch();
                    spell = fields[0].Get<uint32>();
                    if (!player->HasSpell(spell)) {
                        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Заклинания 30-го уровня", GOSSIP_SENDER_MAIN, 29);
                        break;
                    }
                } while (result2->NextRow());
            }
        }



        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void AllGuilds1(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        uint32 count;
        QueryResult result3 = CharacterDatabase.Query("SELECT COUNT(guild) FROM guild_level WHERE level > 1");
        if (result3) {
            Field* fields = result3->Fetch();
            count = fields[0].Get<uint32>();
        }
        QueryResult result = CharacterDatabase.Query("SELECT guild, level FROM guild_level WHERE level > 1 ORDER BY level DESC");
        if (result) {
            std::string name;
            std::string gleader;
            uint32 guild;
            uint16 level;
            uint16 go = 0;
            uint64 leaderguid;
            do {
                Field* fields = result->Fetch();
                guild = fields[0].Get<uint32>();
                level = fields[1].Get<uint16>();
                QueryResult result3 = CharacterDatabase.Query("SELECT name, leaderguid FROM guild WHERE guildid = %u", guild);
                if (result3) {
                    Field* fields = result3->Fetch();
                    name = fields[0].Get<std::string>();
                    leaderguid = fields[1].Get<uint64>();
                }
                QueryResult result4 = CharacterDatabase.Query("SELECT name FROM characters WHERE guid = %u", leaderguid);
                if (result4) {
                    Field* fields = result4->Fetch();
                    gleader = fields[0].Get<std::string>();
                }
                if (go == 10) {
                    AddGossipItemFor(player,GOSSIP_ICON_TALK, "Дальше", GOSSIP_SENDER_MAIN, 14);
                    break;
                }
                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Уровень: " << "|cFF1E90FF" << level << "|r" << ". ГМ: " << "|cff790C06" << gleader << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, guild + 100);
                go++;

            } while (result->NextRow());


        }


        SendGossipMenuFor(player, 2001711, creature->GetGUID());
    }

    void AllGuilds2(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "<= Назад", GOSSIP_SENDER_MAIN, 19);
        QueryResult result = CharacterDatabase.Query("SELECT guild, level FROM guild_level WHERE level > 1 ORDER BY level DESC");
        if (result) {
            std::string name;
            std::string gleader;
            uint32 guild;
            uint16 level;
            uint16 go = 0;
            uint64 leaderguid;
            do {
                if (go < 10) {
                    go++;
                    continue;
                }
                Field* fields = result->Fetch();
                guild = fields[0].Get<uint32>();
                level = fields[1].Get<uint16>();
                QueryResult result3 = CharacterDatabase.Query("SELECT name, leaderguid FROM guild WHERE guildid = %u", guild);
                if (result3) {
                    Field* fields = result3->Fetch();
                    name = fields[0].Get<std::string>();
                    leaderguid = fields[1].Get<uint64>();
                }
                QueryResult result4 = CharacterDatabase.Query("SELECT name FROM characters WHERE guid = %u", leaderguid);
                if (result4) {
                    Field* fields = result4->Fetch();
                    gleader = fields[0].Get<std::string>();
                }
                if (go == 20) {
                    AddGossipItemFor(player,GOSSIP_ICON_TALK, "Дальше =>", GOSSIP_SENDER_MAIN, 15);
                    break;
                }
                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Уровень: " << "|cFF1E90FF" << level << "|r" << ". ГМ: " << "|cff790C06" << gleader << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, guild + 1000);

                go++;
            } while (result->NextRow());


        }


        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void AllGuilds3(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "<= Назад", GOSSIP_SENDER_MAIN, 20);
        QueryResult result = CharacterDatabase.Query("SELECT guild, level FROM guild_level WHERE level > 1 ORDER BY level DESC");
        if (result) {
            std::string name;
            std::string gleader;
            uint32 guild;
            uint16 level;
            uint16 go = 0;
            uint64 leaderguid;
            do {
                if (go < 20) {
                    go++;
                    continue;
                }
                Field* fields = result->Fetch();
                guild = fields[0].Get<uint32>();
                level = fields[1].Get<uint16>();
                QueryResult result3 = CharacterDatabase.Query("SELECT name, leaderguid FROM guild WHERE guildid = %u", guild);
                if (result3) {
                    Field* fields = result3->Fetch();
                    name = fields[0].Get<std::string>();
                    leaderguid = fields[1].Get<uint64>();
                }
                QueryResult result4 = CharacterDatabase.Query("SELECT name FROM characters WHERE guid = %u", leaderguid);
                if (result4) {
                    Field* fields = result4->Fetch();
                    gleader = fields[0].Get<std::string>();
                }
                if (go == 30) {
                    AddGossipItemFor(player,GOSSIP_ICON_TALK, "Дальше =>", GOSSIP_SENDER_MAIN, 16);
                    break;
                }
                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Уровень: " << "|cFF1E90FF" << level << "|r" << ". ГМ: " << "|cff790C06" << gleader << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, guild + 2000);
                go++;
            } while (result->NextRow());


        }


        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void AllGuilds4(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "<= Назад", GOSSIP_SENDER_MAIN, 21);
        QueryResult result = CharacterDatabase.Query("SELECT guild, level FROM guild_level WHERE level > 1 ORDER BY level DESC");
        if (result) {
            std::string name;
            std::string gleader;
            uint32 guild;
            uint16 level;
            uint16 go = 0;
            uint64 leaderguid;
            do {
                if (go < 30) {
                    go++;
                    continue;
                }
                Field* fields = result->Fetch();
                guild = fields[0].Get<uint32>();
                level = fields[1].Get<uint16>();
                QueryResult result3 = CharacterDatabase.Query("SELECT name, leaderguid FROM guild WHERE guildid = %u", guild);
                if (result3) {
                    Field* fields = result3->Fetch();
                    name = fields[0].Get<std::string>();
                    leaderguid = fields[1].Get<uint64>();
                }
                QueryResult result4 = CharacterDatabase.Query("SELECT name FROM characters WHERE guid = %u", leaderguid);
                if (result4) {
                    Field* fields = result4->Fetch();
                    gleader = fields[0].Get<std::string>();
                }
                if (go == 40) {
                    AddGossipItemFor(player,GOSSIP_ICON_TALK, "Дальше =>", GOSSIP_SENDER_MAIN, 17);
                    break;
                }
                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Уровень: " << "|cFF1E90FF" << level << "|r" << ". ГМ: " << "|cff790C06" << gleader << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, guild + 3000);
                go++;
            } while (result->NextRow());


        }


        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void AllGuilds5(Player* player, Creature* creature) {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "<= Назад", GOSSIP_SENDER_MAIN, 22);
        QueryResult result = CharacterDatabase.Query("SELECT guild, level FROM guild_level WHERE level > 1 ORDER BY level DESC");
        if (result) {
            std::string name;
            std::string gleader;
            uint32 guild;
            uint16 level;
            uint16 go = 0;
            uint64 leaderguid;
            do {
                if (go < 40) {
                    go++;
                    continue;
                }
                Field* fields = result->Fetch();
                guild = fields[0].Get<uint32>();
                level = fields[1].Get<uint16>();
                QueryResult result3 = CharacterDatabase.Query("SELECT name, leaderguid FROM guild WHERE guildid = %u", guild);
                if (result3) {
                    Field* fields = result3->Fetch();
                    name = fields[0].Get<std::string>();
                    leaderguid = fields[1].Get<uint64>();
                }
                QueryResult result4 = CharacterDatabase.Query("SELECT name FROM characters WHERE guid = %u", leaderguid);
                if (result4) {
                    Field* fields = result4->Fetch();
                    gleader = fields[0].Get<std::string>();
                }
                if (go == 50) {
                    AddGossipItemFor(player,GOSSIP_ICON_TALK, "Конец", GOSSIP_SENDER_MAIN, 18);
                    break;
                }
                std::stringstream buffer;
                buffer << "|cff084E13" << name << "|r" << ". Уровень: " << "|cFF1E90FF" << level << "|r" << ". ГМ: " << "|cff790C06" << gleader << "|r";
                AddGossipItemFor(player,4, buffer.str(), GOSSIP_SENDER_MAIN, guild + 4000);
                go++;
            } while (result->NextRow());


        }


        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    void TakeHonorButtons(Player* player, Creature* creature)
    {
        if (!player->GetGuildId()) {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        player->PlayerTalkClass->ClearMenus();

        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 2 000 чести [+10 опыта]", GOSSIP_SENDER_MAIN, 5);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 10 000 чести [+50 опыта]", GOSSIP_SENDER_MAIN, 6);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 20 000 чести [+100 опыта]", GOSSIP_SENDER_MAIN, 7);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 30 000 чести [+150 опыта]", GOSSIP_SENDER_MAIN, 8);

        SendGossipMenuFor(player, 2001712, creature->GetGUID());
    }

    void TakeEmblemButtons(Player* player, Creature* creature)
    {
        player->PlayerTalkClass->ClearMenus();

        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 5 Эмблем [+50 опыта]", GOSSIP_SENDER_MAIN, 36);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 10 Эмблем [+100 опыта]", GOSSIP_SENDER_MAIN, 3610);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 15 Эмблем [+150 опыта]", GOSSIP_SENDER_MAIN, 3620);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 20 Эмблем [+200 опыта]", GOSSIP_SENDER_MAIN, 3630);

        SendGossipMenuFor(player, 2001715, creature->GetGUID());
    }

    void TakeGold(Player* player, Creature* creature, char const* code)
    {
        uint32 gold = atoi(code);
        uint32 goldx = gold * 10000;
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 exp = gold / 100;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (gold < 100)
        {
            player->GetSession()->SendNotification("Минимальное количество вложения золота 100!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetMoney() >= goldx)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, 0, 10000, %u, 0, 0)", guild, name.c_str(), gold);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `gold`=`gold`+'%u' WHERE `guild`='%u' AND `name`='%s'", gold, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyMoney(-goldx);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u золота и полули %u опыта!", gold, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно золота!");
        CloseGossipMenuFor(player);
    }

    void TakeArena10000(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 1500;
        uint32 exp = count / 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetArenaPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, %u, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `arena`=`arena`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyArenaPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков арены и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков арены!");
        CloseGossipMenuFor(player);
    }

    void TakeArena7500(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 1000;
        uint32 exp = count / 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetArenaPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, %u, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `arena`=`arena`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyArenaPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков арены и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков арены!");
        CloseGossipMenuFor(player);
    }

    void TakeArena5000(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 500;
        uint32 exp = count / 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetArenaPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, %u, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `arena`=`arena`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyArenaPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков арены и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков арены!");
        CloseGossipMenuFor(player);
    }

    void TakeArena2500(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 100;
        uint32 exp = count / 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetArenaPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, %u, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `arena`=`arena`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyArenaPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков арены и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков арены!");
        CloseGossipMenuFor(player);
    }

    void TakeHonor200(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 30000;
        uint32 exp = count / 200;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetHonorPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', %u, 0, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `honor`=`honor`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyHonorPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков чести и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков чести!");
        CloseGossipMenuFor(player);
    }

    void TakeHonor150(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 20000;
        uint32 exp = count / 200;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetHonorPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', %u, 0, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `honor`=`honor`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyHonorPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков чести и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков чести!");
        CloseGossipMenuFor(player);
    }

    void TakeHonor100(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 10000;
        uint32 exp = count / 200;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetHonorPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', %u, 0, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `honor`=`honor`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyHonorPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков чести и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков чести!");
        CloseGossipMenuFor(player);
    }

    void TakeFrostEmblem(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 5;
        uint32 exp = count * 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->HasItemCount(90651, count))
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, 0, 10000, 0, 0, %u)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `token`=`token`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->DestroyItemCount(90651, count, true);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u эмблем и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно эмблем!");
        CloseGossipMenuFor(player);
    }

    void TakeFrostEmblem1(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 10;
        uint32 exp = count * 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->HasItemCount(90651, count))
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, 0, 10000, 0, 0, %u)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `token`=`token`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->DestroyItemCount(90651, count, true);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u эмблем и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно эмблем!");
        CloseGossipMenuFor(player);
    }

    void TakeFrostEmblem2(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 15;
        uint32 exp = count * 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->HasItemCount(90651, count))
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, 0, 10000, 0, 0, %u)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `token`=`token`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->DestroyItemCount(90651, count, true);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u эмблем и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно эмблем!");
        CloseGossipMenuFor(player);
    }

    void TakeFrostEmblem3(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 20;
        uint32 exp = count * 10;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->HasItemCount(90651, count))
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, 0, 10000, 0, 0, %u)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `token`=`token`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->DestroyItemCount(90651, count, true);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u эмблем и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно эмблем!");
        CloseGossipMenuFor(player);
    }

    void TakeTriumphEmblem(Player* player)
    {
        if (!player->GetGuildId()) {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (!player->HasItemCount(18228, 50, true)) {
            player->GetSession()->SendNotification("У вас недостаточно свитков!");
            CloseGossipMenuFor(player);
            return;
        }
        uint32 guild = player->GetGuildId();
        CharacterDatabase.Query("UPDATE guild_level SET xp = xp+10 WHERE guild = %u", guild);

        std::string name = player->GetName();
        QueryResult result4 = CharacterDatabase.Query("SELECT name FROM guild_level_invested");
        if (!result4) CharacterDatabase.Query("REPLACE INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, 0, 10000, 0, 0, 0)", guild, name.c_str());

        QueryResult result3 = CharacterDatabase.Query("SELECT name FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
        uint32 number;
        QueryResult result2 = CharacterDatabase.Query("SELECT MAX(number) FROM guild_level_invested");
        if (result2) {
            Field* fields = result2->Fetch();
            number = fields[0].Get<uint32>();
            if (!result3) CharacterDatabase.Query("REPLACE INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', 0, 0, %u, 0)", guild, name.c_str(), number + 1);
        }
        CharacterDatabase.Query("UPDATE guild_level_invested SET svitok = svitok+50 WHERE guild = %u AND name = '%s'", guild, name.c_str());
        player->DestroyItemCount(18228, 50, true);
        UpdateLevel(player);
        player->GetSession()->SendAreaTriggerMessage("Пожертвование прошло успешно!");
        CloseGossipMenuFor(player);
    }

    void TakeHonor50(Player* player)
    {
        uint32 guild = player->GetGuildId();
        std::string name = player->GetName();
        uint32 count = 2000;
        uint32 exp = count / 200;

        if (!guild)
        {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        if (player->GetHonorPoints() >= count)
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT * FROM guild_level_invested WHERE guild = %u AND name = '%s'", guild, name.c_str());
            if (!result4)
                CharacterDatabase.Query("INSERT INTO guild_level_invested (guild, name, honor, arena, number, gold, svitok, token) VALUES (%u, '%s', %u, 0, 10000, 0, 0, 0)", guild, name.c_str(), count);
            else
                CharacterDatabase.Execute("UPDATE `guild_level_invested` SET `honor`=`honor`+'%u' WHERE `guild`='%u' AND `name`='%s'", count, guild, name.c_str());

            CharacterDatabase.Query("UPDATE guild_level SET xp = xp+%u WHERE guild = %u", exp, guild);
            player->ModifyHonorPoints(-count);
            UpdateLevel(player);
            ChatHandler(player->GetSession()).PSendSysMessage("Пожертвование прошло успешно, вы отдали %u очков чести и полули %u опыта!", count, exp);
        }
        else
            player->GetSession()->SendNotification("У вас недостаточно очков чести!");
        CloseGossipMenuFor(player);
    }



    void TakeArenaButtons(Player* player, Creature* creature) {
        if (!player->GetGuildId()) {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }

        player->PlayerTalkClass->ClearMenus();

        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 100 арены [+10 опыта]", GOSSIP_SENDER_MAIN, 9);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 500 арены [+50 опыта]", GOSSIP_SENDER_MAIN, 10);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 1000 арены [+100 опыта]", GOSSIP_SENDER_MAIN, 11);
        AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 1500 арены [+150 опыта]", GOSSIP_SENDER_MAIN, 12);

        SendGossipMenuFor(player, 2001713, creature->GetGUID());
    }

    void GuildInfo(Player* player) {
        if (!player->GetGuildId()) {
            player->GetSession()->SendNotification("Вы не состоите в гильдии!");
            CloseGossipMenuFor(player);
            return;
        }
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
        if (result) {
            Field* fields = result->Fetch();
            uint16 level = fields[0].Get<uint16>();
            uint32 xp = fields[1].Get<uint32>();

            ChatHandler(player->GetSession()).PSendSysMessage("|cfff4b25e[Прогресс Гильдии]:|r");
            ChatHandler(player->GetSession()).PSendSysMessage("|cfff4b25eУровень вашей гильдии:|r |cfffcedbb%u|r", level);
            ChatHandler(player->GetSession()).PSendSysMessage("|cfff4b25eПрогресс уровня вашей гильдии:|r |cfffcedbb%u|r", xp);

            QueryResult result1 = CharacterDatabase.Query("SELECT xp FROM guild_xp_table WHERE level = %u", level);
            if (result1) {
                Field* fields = result1->Fetch();
                uint32 reqXp = fields[0].Get<uint32>();
                uint32 ReqXp = reqXp - xp;
                if (level < 5) ChatHandler(player->GetSession()).PSendSysMessage("|cfff4b25eДо %u-го уровня гильдии осталось накопить:|r |cfffcedbb%u опыта|r", level + 1, ReqXp);
                else ChatHandler(player->GetSession()).PSendSysMessage("|cfff4b25eВаша гильдия имеет максимальный уровень!|r");

            }

        }
        CloseGossipMenuFor(player);
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) {
        switch (action) {
        case 1:
            TakeHonorButtons(player, creature);
            break;
        case 2:
            TakeArenaButtons(player, creature);
            break;
        case 3:
            GuildInfo(player);
            break;
        case 4:
            CloseGossipMenuFor(player);
            break;
        case 5:
            TakeHonor50(player);
            break;
        case 6:
            TakeHonor100(player);
            break;
        case 7:
            TakeHonor150(player);
            break;
        case 8:
            TakeHonor200(player);
            break;
        case 9:
            TakeArena2500(player);
            break;
        case 10:
            TakeArena5000(player);
            break;
        case 11:
            TakeArena7500(player);
            break;
        case 12:
            TakeArena10000(player);
            break;
        case 13:
            AllGuilds1(player, creature);
            break;
        case 14:
            AllGuilds2(player, creature);
            break;
        case 15:
            AllGuilds3(player, creature);
            break;
        case 16:
            AllGuilds4(player, creature);
            break;
        case 17:
            AllGuilds5(player, creature);
            break;
        case 18:
            CloseGossipMenuFor(player);
            break;
        case 19:
            AllGuilds1(player, creature);
            break;
        case 20:
            AllGuilds2(player, creature);
            break;
        case 21:
            AllGuilds3(player, creature);
            break;
        case 22:
            AllGuilds4(player, creature);
            break;
        case 23:
            CurrentSpellsMenu(player, creature);
            break;
        case 24:
            ReplaceColorList(player, creature);
            break;
        case 25:
            ReplaceColor(player, creature, 1);
            break;
        case 26:
            ReplaceColor(player, creature, 2);
            break;
        case 27:
            ReplaceColor(player, creature, 3);
            break;
        case 28:
            ReplaceColor(player, creature, 4);
            break;
        case 29:
            ReplaceColor(player, creature, 5);
            break;
        case 30:
            ReplaceColor(player, creature, 6);
            break;
        case 35:
            TakeTriumphEmblem(player);
            break;
        case 36:
            TakeFrostEmblem(player);
            break;
        case 38:
            TakeFrostEmblem1(player);
            break;
        case 39:
            TakeFrostEmblem2(player);
            break;
        case 40:
            TakeFrostEmblem3(player);
            break;
        case 41:
            OnGossipHello(player, creature);
            break;
        case 37:
            player->PlayerTalkClass->ClearMenus();
            AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 5 Эмблем [+50 опыта]", GOSSIP_SENDER_MAIN, 36);
            AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 10 Эмблем [+100 опыта]", GOSSIP_SENDER_MAIN, 38);
            AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 15 Эмблем [+150 опыта]", GOSSIP_SENDER_MAIN, 39);
            AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "Пожертвовать 20 Эмблем [+200 опыта]", GOSSIP_SENDER_MAIN, 40);
            SendGossipMenuFor(player, 2001715, creature->GetGUID());
            break;

        case 9000:
            InvestedRosterGold1(player, creature);
            break;
        case 9910:
            InvestedRosterHonor2(player, creature);
            break;
        case 9911:
            InvestedRosterHonor1(player, creature);
            break;
        case 9912:
            InvestedRosterArena2(player, creature);
            break;
        case 9913:
            InvestedRosterArena1(player, creature);
            break;
        case 9914:
            InvestedRoster(player, creature);
            break;
        case 9918:
            InvestedToken(player, creature);
            break;
        case 9915:
            InvestedRosterHonor1(player, creature);
            break;
        case 9916:
            InvestedRosterArena1(player, creature);
            break;

        }

        if (action > 100 && action < 1000) AllGuilds1(player, creature);
        if (action > 1000 && action < 2000) AllGuilds2(player, creature);
        if (action > 2000 && action < 3000) AllGuilds3(player, creature);
        if (action > 3000 && action < 4000) AllGuilds4(player, creature);
        if (action > 4000 && action < 5000) AllGuilds5(player, creature);
        if (action >= 10000) InvestedRoster(player, creature);



        return true;
    }
    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, char const* code)
    {
        switch (action)
        {
        case 200:
            TakeGold(player, creature, code);
            break;
        }
        return true;
    }

};

class npc_guildspell : public CreatureScript
{
public:
    npc_guildspell() : CreatureScript("npc_guildspell") { }

    uint8 IsSpell;

    bool OnGossipHello(Player* player, Creature* creature)
    {
        player->PlayerTalkClass->ClearMenus();
        if (player->GetRankFromDB(player->GetGUID()) == 0 && player->GetGuildId())
        {
            AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "|TInterface/ICONS/Achievement_reputation_knightsoftheebonblade:25|tПриобрести [Заклинание-Гильдии]", GOSSIP_SENDER_MAIN, 99000);
            AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "|TInterface/ICONS/Inv_shield_66:25|tПриобрести [Вещи-Гильдии]", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
        }
        SendGossipMenuFor(player, 200172, creature->GetGUID());
        return true;

    }

    void BuySpellOrTitle(Player* player, Creature* creature, uint8 isSpell)
    {
        player->PlayerTalkClass->ClearMenus();
        AddGossipItemFor(player,GOSSIP_ICON_TALK, "Список доступных заклинаний:", GOSSIP_SENDER_MAIN, 99005);

        uint32 spell;
        uint32 cost;
        uint32 number;
        const char* name;

        QueryResult result = CharacterDatabase.Query("SELECT spellortitle, cost, number FROM guild_level_spell WHERE isSpell = %u", isSpell);
        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                spell = fields[0].Get<uint32>();
                cost = fields[1].Get<uint32>();
                number = fields[2].Get<uint32>();
                if (isSpell == 1)
                {
                    if (player->HasSpell(spell)) continue;

                    const SpellEntry* spellEntry = sSpellStore.LookupEntry(spell);
                    name = (spellEntry->SpellName[8]);
                }
                else
                {
                    const CharTitlesEntry* titleEntry = sCharTitlesStore.LookupEntry(spell);
                    if (player->HasTitle(titleEntry)) continue;

                    name = (const char*)titleEntry->nameMale[8];
                }
                std::stringstream buffer;

                buffer << "|cff084E13" << name << "|r" << ". Стоимость: " << "|cFF0f4d8a" << cost << " эмблем." << "|r";

                AddGossipItemFor(player,GOSSIP_ICON_TRAINER, buffer.str(), GOSSIP_SENDER_MAIN, number);
            }

            while (result->NextRow());

            IsSpell = isSpell;

            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        }
    }

    void SelectSpellOrTitle(Player* player, Creature* creature, uint32 action)
    {
        uint32 spell;
        uint32 cost;
        uint32 level;
        uint32 number;
        uint32 guild = player->GetGuildId();
        QueryResult result = CharacterDatabase.Query("SELECT spellortitle, cost, level, number FROM guild_level_spell WHERE isSpell = %u AND level = %u", IsSpell, action);
        if (result)
        {
            Field* fields = result->Fetch();
            spell = fields[0].Get<uint32>();
            cost = fields[1].Get<uint32>();
            level = fields[2].Get<uint32>();
            number = fields[3].Get<uint32>();

            if (number == action)
            {
                // learn spell
                QueryResult knowLevel = CharacterDatabase.Query("SELECT level, xp FROM guild_level WHERE guild = %u", guild);
                if (knowLevel)
                {
                    Field* fs = knowLevel->Fetch();
                    uint16 gLevel = fs[0].Get<uint16>();

                    if (gLevel < level) player->GetSession()->SendAreaTriggerMessage("Недостаточный уровень!");
                    else {

                        QueryResult result2 = CharacterDatabase.Query("SELECT guid FROM guild_member WHERE guildid = %u", guild);
                        if (result2)
                        {

                            if (!player->HasItemCount(90651, cost))
                            {
                                CloseGossipMenuFor(player);
                                player->GetSession()->SendNotification("Недостаточно эмблем!");
                                return;
                            }


                            do {
                                Field* fields = result2->Fetch();
                                ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(fields[0].Get<uint64>());
                                if (Player* onlinePlayer = ObjectAccessor::FindPlayer(guid)) {
                                    if (IsSpell == 1) onlinePlayer->learnSpell(spell);
                                    else onlinePlayer->SetTitle(sCharTitlesStore.LookupEntry(spell));
                                }

                                CharacterDatabase.Query("REPLACE INTO guild_learn_spell (guild, spellortitle, isSpell) VALUES (%u, %u, %u)", guild, spell, IsSpell);

                            } while (result2->NextRow());

                        }
                        player->DestroyItemCount(90651, cost, true);
                        // learn spell
                        CloseGossipMenuFor(player);
                        if (IsSpell == 1) player->GetSession()->SendAreaTriggerMessage("Гильдейское заклинание успешно куплено!");
                        else player->GetSession()->SendAreaTriggerMessage("Гильдейское звание успешно куплено!");
                    }
                }
            }
        }

    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        switch (action)
        {
        case GOSSIP_OPTION_VENDOR:
            player->GetSession()->SendListInventory(creature->GetGUID());
            break;
        case 99000:
            BuySpellOrTitle(player, creature, 1);
            break;
        case 99002:
            BuySpellOrTitle(player, creature, 0);
            break;
        case 99001:
            CloseGossipMenuFor(player);
            break;
        case 99005:
            OnGossipHello(player, creature);
            break;

        }
        if (action < 5000) SelectSpellOrTitle(player, creature, action);

        return true;
    }


};

class Login_spellguild : public PlayerScript
{
public:
    Login_spellguild() : PlayerScript("Login_spellguild") { }
    void OnLogin(Player* player/*, bool firstLogin)
    {
        uint32 guild = player->GetGuildId();

        if (!guild)
            return;

        QueryResult result = CharacterDatabase.Query("SELECT spellortitle FROM guild_learn_spell WHERE guild = %u And isSpell = 1", guild);
        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                uint32 spell = fields[0].Get<uint32>();

                if (!player->HasSpell(spell)) player->learnSpell(spell);
            } while (result->NextRow());
        }
        else
        {
            QueryResult result2 = CharacterDatabase.Query("SELECT spellortitle FROM guild_level_spell WHERE isSpell = 1");
            if (result2)
            {
                do {
                    Field* fields = result2->Fetch();
                    uint32 Spell = fields[0].Get<uint32>();

                    if (player->HasSpell(Spell)) player->removeSpell(Spell, SPEC_MASK_ALL, false);
                } while (result2->NextRow());
            }
        }

        QueryResult result3 = CharacterDatabase.Query("SELECT spellortitle FROM guild_learn_spell WHERE guild = %u And isSpell = 0", guild);
        if (result3)
        {
            do
            {
                Field* fields = result3->Fetch();
                uint32 title = fields[0].Get<uint32>();

                if (!player->HasTitle(sCharTitlesStore.LookupEntry(title))) player->SetTitle(sCharTitlesStore.LookupEntry(title));
            } while (result3->NextRow());
        }
        else
        {
            QueryResult result4 = CharacterDatabase.Query("SELECT spellortitle FROM guild_level_spell WHERE isSpell = 0");
            if (result4)
            {
                do {
                    Field* fields = result4->Fetch();
                    uint32 title = fields[0].Get<uint32>();

                    if (player->HasTitle(sCharTitlesStore.LookupEntry(title)))
                    {
                        player->SetTitle(sCharTitlesStore.LookupEntry(title), true);
                        if (!player->HasTitle(player->GetInt32Value(PLAYER_CHOSEN_TITLE))) player->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
                    }
                } while (result4->NextRow());
            }
        }
    }
};

class guildMasterChat : public PlayerScript
{
public:
    guildMasterChat() : PlayerScript("guildMasterChat") {}

    void OnChat(Player* player, uint32 /*type, uint32 lang, std::string& msg, Guild* guild)
    {
        if (player->GetRank() == 0) msg = "|cFFFFD700" + msg + "|r";
    }

}; */
//GuildLevel END// 

void AddSC_account_commandscript()
{
    new account_commandscript();
   // new npc_guild_level();
  //  new npc_guildspell();
  //  new Login_spellguild();
   // new guildMasterChat();
}
