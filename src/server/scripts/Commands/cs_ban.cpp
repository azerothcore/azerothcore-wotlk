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
Name: ban_commandscript
%Complete: 100
Comment: All ban related commands
Category: commandscripts
EndScriptData */

#include "AccountMgr.h"
#include "BanMgr.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "CommandScript.h"
#include "GameTime.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"

/// Ban function modes
enum BanMode
{
    BAN_ACCOUNT,
    BAN_CHARACTER,
    BAN_IP
};

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class ban_commandscript : public CommandScript
{
public:
    ban_commandscript() : CommandScript("ban_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable unbanCommandTable =
        {
            { "account",       HandleUnBanAccountCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "character",     HandleUnBanCharacterCommand,     SEC_ADMINISTRATOR, Console::Yes },
            { "playeraccount", HandleUnBanAccountByCharCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "ip",            HandleUnBanIPCommand,            SEC_ADMINISTRATOR, Console::Yes }
        };

        static ChatCommandTable banlistCommandTable =
        {
            { "account",      HandleBanListAccountCommand,   SEC_GAMEMASTER, Console::Yes },
            { "character",    HandleBanListCharacterCommand, SEC_GAMEMASTER, Console::Yes },
            { "ip",           HandleBanListIPCommand,        SEC_GAMEMASTER, Console::Yes }
        };

        static ChatCommandTable baninfoCommandTable =
        {
            { "account",      HandleBanInfoAccountCommand,   SEC_GAMEMASTER, Console::Yes },
            { "character",    HandleBanInfoCharacterCommand, SEC_GAMEMASTER, Console::Yes },
            { "ip",           HandleBanInfoIPCommand,        SEC_GAMEMASTER, Console::Yes }
        };

        static ChatCommandTable banCommandTable =
        {
            { "account",      HandleBanAccountCommand,       SEC_GAMEMASTER, Console::Yes },
            { "character",    HandleBanCharacterCommand,     SEC_GAMEMASTER, Console::Yes },
            { "playeraccount",HandleBanAccountByCharCommand, SEC_GAMEMASTER, Console::Yes },
            { "ip",           HandleBanIPCommand,            SEC_GAMEMASTER, Console::Yes }
        };

        static ChatCommandTable commandTable =
        {
            { "ban",     banCommandTable },
            { "baninfo", baninfoCommandTable },
            { "banlist", banlistCommandTable },
            { "unban",   unbanCommandTable }
        };

        return commandTable;
    }

    static bool HandleBanAccountCommand(ChatHandler* handler, char const* args)
    {
        return HandleBanHelper(BAN_ACCOUNT, args, handler);
    }

    static bool HandleBanCharacterCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* nameStr = strtok((char*)args, " ");
        if (!nameStr)
            return false;

        std::string name = nameStr;

        char* durationStr = strtok(nullptr, " ");
        if (!durationStr || !atoi(durationStr))
            return false;

        char* reasonStr = strtok(nullptr, "");
        if (!reasonStr)
            return false;

        if (!normalizePlayerName(name))
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        switch (sBan->BanCharacter(name, durationStr, reasonStr, handler->GetSession() ? handler->GetSession()->GetPlayerName() : ""))
        {
            case BAN_SUCCESS:
                if (atoi(durationStr) > 0)
                {
                    if (!sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
                        handler->PSendSysMessage(LANG_BAN_YOUBANNED, name.c_str(), secsToTimeString(TimeStringToSecs(durationStr), true).c_str(), reasonStr);
                }
                else
                {
                    if (!sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
                        handler->PSendSysMessage(LANG_BAN_YOUPERMBANNED, name.c_str(), reasonStr);
                }
                break;
            case BAN_NOTFOUND:
                {
                    handler->SendErrorMessage(LANG_BAN_NOTFOUND, "character", name.c_str());
                    return false;
                }
            default:
                break;
        }

        return true;
    }

    static bool HandleBanAccountByCharCommand(ChatHandler* handler, char const* args)
    {
        return HandleBanHelper(BAN_CHARACTER, args, handler);
    }

    static bool HandleBanIPCommand(ChatHandler* handler, char const* args)
    {
        return HandleBanHelper(BAN_IP, args, handler);
    }

    static bool HandleBanHelper(BanMode mode, char const* args, ChatHandler* handler)
    {
        if (!*args)
            return false;

        char* cnameOrIP = strtok((char*)args, " ");
        if (!cnameOrIP)
            return false;

        std::string nameOrIP = cnameOrIP;

        char* durationStr = strtok(nullptr, " ");
        if (!durationStr || !atoi(durationStr))
            return false;

        char* reasonStr = strtok(nullptr, "");
        if (!reasonStr)
            return false;

        switch (mode)
        {
            case BAN_ACCOUNT:
                if (!Utf8ToUpperOnlyLatin(nameOrIP))
                {
                    handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, nameOrIP.c_str());
                    return false;
                }
                break;
            case BAN_CHARACTER:
                if (!normalizePlayerName(nameOrIP))
                {
                    handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
                    return false;
                }
                break;
            case BAN_IP:
                if (!IsIPAddress(nameOrIP.c_str()))
                    return false;
                break;
        }

        BanReturn banReturn;

        switch (mode)
        {
            case BAN_ACCOUNT:
                banReturn = sBan->BanAccount(nameOrIP, durationStr, reasonStr, handler->GetSession() ? handler->GetSession()->GetPlayerName() : "");
                break;
            case BAN_CHARACTER:
                banReturn = sBan->BanAccountByPlayerName(nameOrIP, durationStr, reasonStr, handler->GetSession() ? handler->GetSession()->GetPlayerName() : "");
                break;
            case BAN_IP:
            default:
                banReturn = sBan->BanIP(nameOrIP, durationStr, reasonStr, handler->GetSession() ? handler->GetSession()->GetPlayerName() : "");
                break;
        }

        switch (banReturn)
        {
            case BAN_SUCCESS:
                if (atoi(durationStr) > 0)
                {
                    if (!sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
                        handler->PSendSysMessage(LANG_BAN_YOUBANNED, nameOrIP.c_str(), secsToTimeString(TimeStringToSecs(durationStr), true).c_str(), reasonStr);
                }
                else
                {
                    if (!sWorld->getBoolConfig(CONFIG_SHOW_BAN_IN_WORLD))
                        handler->PSendSysMessage(LANG_BAN_YOUPERMBANNED, nameOrIP.c_str(), reasonStr);
                }
                break;
            case BAN_SYNTAX_ERROR:
                return false;
            case BAN_NOTFOUND:
                switch (mode)
                {
                    default:
                        handler->SendErrorMessage(LANG_BAN_NOTFOUND, "account", nameOrIP.c_str());
                        break;
                    case BAN_CHARACTER:
                        handler->SendErrorMessage(LANG_BAN_NOTFOUND, "character", nameOrIP.c_str());
                        break;
                    case BAN_IP:
                        handler->SendErrorMessage(LANG_BAN_NOTFOUND, "ip", nameOrIP.c_str());
                        break;
                }
                return false;
            case BAN_LONGER_EXISTS:
                handler->PSendSysMessage("Unsuccessful! A longer ban is already present on this account!");
                break;
            default:
                break;
        }

        return true;
    }

    static bool HandleBanInfoAccountCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* nameStr = strtok((char*)args, "");
        if (!nameStr)
            return false;

        std::string accountName = nameStr;
        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            return false;
        }

        uint32 accountId = AccountMgr::GetId(accountName);
        if (!accountId)
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            return true;
        }

        return HandleBanInfoHelper(accountId, accountName.c_str(), handler);
    }

    static bool HandleBanInfoHelper(uint32 accountId, char const* accountName, ChatHandler* handler)
    {
        QueryResult result = LoginDatabase.Query("SELECT FROM_UNIXTIME(bandate, '%Y-%m-%d..%H:%i:%s') as bandate, unbandate-bandate, active, unbandate, banreason, bannedby FROM account_banned WHERE id = '{}' ORDER BY bandate ASC", accountId);
        if (!result)
        {
            handler->PSendSysMessage(LANG_BANINFO_NOACCOUNTBAN, accountName);
            return true;
        }

        handler->PSendSysMessage(LANG_BANINFO_BANHISTORY, accountName);
        do
        {
            Field* fields = result->Fetch();

            time_t unbanDate = time_t(fields[3].Get<uint32>());
            bool active = false;
            if (fields[2].Get<bool>() && (fields[1].Get<uint64>() == uint64(0) || unbanDate >= GameTime::GetGameTime().count()))
                active = true;
            bool permanent = (fields[1].Get<uint64>() == uint64(0));
            std::string banTime = permanent ? handler->GetAcoreString(LANG_BANINFO_INFINITE) : secsToTimeString(fields[1].Get<uint64>(), true);
            handler->PSendSysMessage(LANG_BANINFO_HISTORYENTRY,
                fields[0].Get<std::string>().c_str(), banTime.c_str(), active ? handler->GetAcoreString(LANG_YES) : handler->GetAcoreString(LANG_NO), fields[4].Get<std::string>().c_str(), fields[5].Get<std::string>().c_str());
        } while (result->NextRow());

        return true;
    }

    static bool HandleBanInfoCharacterCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* target = ObjectAccessor::FindPlayerByName(args, false);
        ObjectGuid targetGuid;
        std::string name(args);

        if (!target)
        {
            targetGuid = sCharacterCache->GetCharacterGuidByName(name);
            if (!targetGuid)
            {
                handler->PSendSysMessage(LANG_BANINFO_NOCHARACTER);
                return false;
            }
        }
        else
            targetGuid = target->GetGUID();

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_BANINFO);
        stmt->SetData(0, targetGuid.GetCounter());

        PreparedQueryResult result = CharacterDatabase.Query(stmt);
        if (!result)
        {
            handler->PSendSysMessage(LANG_CHAR_NOT_BANNED, name.c_str());
            return true;
        }

        handler->PSendSysMessage(LANG_BANINFO_BANHISTORY, name.c_str());
        do
        {
            Field* fields = result->Fetch();
            time_t unbanDate = time_t(fields[3].Get<uint32>());
            bool active = false;
            if (fields[2].Get<uint8>() && (!fields[1].Get<uint32>() || unbanDate >= GameTime::GetGameTime().count()))
                active = true;
            bool permanent = (fields[1].Get<uint32>() == uint32(0));
            std::string banTime = permanent ? handler->GetAcoreString(LANG_BANINFO_INFINITE) : secsToTimeString(fields[1].Get<uint64>(), true);
            handler->PSendSysMessage(LANG_BANINFO_HISTORYENTRY,
                fields[0].Get<std::string>().c_str(), banTime.c_str(), active ? handler->GetAcoreString(LANG_YES) : handler->GetAcoreString(LANG_NO), fields[4].Get<std::string>().c_str(), fields[5].Get<std::string>().c_str());
        } while (result->NextRow());

        return true;
    }

    static bool HandleBanInfoIPCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* ipStr = strtok((char*)args, "");
        if (!ipStr)
            return false;

        if (!IsIPAddress(ipStr))
            return false;

        std::string IP = ipStr;

        LoginDatabase.EscapeString(IP);
        QueryResult result = LoginDatabase.Query("\
            SELECT \
                ip, FROM_UNIXTIME(bandate, '%Y-%m-%d %H:%i:%s'), FROM_UNIXTIME(unbandate, '%Y-%m-%d %H:%i:%s'), \
                IF (unbandate > UNIX_TIMESTAMP(), unbandate - UNIX_TIMESTAMP(), 0) AS timeRemaining, \
                banreason, bannedby, unbandate - bandate = 0 AS permanent \
            FROM ip_banned \
            WHERE ip = '{}' \
        ", IP);
        if (!result)
        {
            handler->PSendSysMessage(LANG_BANINFO_NOIP);
            return true;
        }

        Field* fields = result->Fetch();
        bool permanent = fields[6].Get<uint64>() == 1;
        handler->PSendSysMessage(LANG_BANINFO_IPENTRY,
            fields[0].Get<std::string>().c_str(), fields[1].Get<std::string>().c_str(), permanent ? handler->GetAcoreString(LANG_BANINFO_NEVER) : fields[2].Get<std::string>().c_str(),
            permanent ? handler->GetAcoreString(LANG_BANINFO_INFINITE) : secsToTimeString(fields[3].Get<uint64>(), true).c_str(), fields[4].Get<std::string>().c_str(), fields[5].Get<std::string>().c_str());

        return true;
    }

    static bool HandleBanListAccountCommand(ChatHandler* handler, char const* args)
    {
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_EXPIRED_IP_BANS);
        LoginDatabase.Execute(stmt);

        char* filterStr = strtok((char*)args, " ");
        std::string filter = filterStr ? filterStr : "";

        PreparedQueryResult result;

        if (filter.empty())
        {
            LoginDatabasePreparedStatement* stmt2 = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED_ALL);
            result = LoginDatabase.Query(stmt2);
        }
        else
        {
            LoginDatabasePreparedStatement* stmt2 = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_BANNED_BY_USERNAME);
            stmt2->SetData(0, filter);
            result = LoginDatabase.Query(stmt2);
        }

        if (!result)
        {
            handler->PSendSysMessage(LANG_BANLIST_NOACCOUNT);
            return true;
        }

        return HandleBanListHelper(result, handler);
    }

    static bool HandleBanListHelper(PreparedQueryResult result, ChatHandler* handler)
    {
        handler->PSendSysMessage(LANG_BANLIST_MATCHINGACCOUNT);

        // Chat short output
        if (handler->GetSession())
        {
            do
            {
                Field* fields = result->Fetch();
                uint32 accountid = fields[0].Get<uint32>();

                QueryResult banResult = LoginDatabase.Query("SELECT account.username FROM account, account_banned WHERE account_banned.id='{}' AND account_banned.id=account.id", accountid);
                if (banResult)
                {
                    Field* fields2 = banResult->Fetch();
                    handler->PSendSysMessage("%s", fields2[0].Get<std::string>().c_str());
                }
            } while (result->NextRow());
        }
        // Console wide output
        else
        {
            handler->SendSysMessage(LANG_BANLIST_ACCOUNTS);
            handler->SendSysMessage(" ===============================================================================");
            handler->SendSysMessage(LANG_BANLIST_ACCOUNTS_HEADER);
            do
            {
                handler->SendSysMessage("-------------------------------------------------------------------------------");
                Field* fields = result->Fetch();
                uint32 accountId = fields[0].Get<uint32>();

                std::string accountName;

                // "account" case, name can be get in same query
                if (result->GetFieldCount() > 1)
                    accountName = fields[1].Get<std::string>();
                // "character" case, name need extract from another DB
                else
                    AccountMgr::GetName(accountId, accountName);

                // No SQL injection. id is uint32.
                QueryResult banInfo = LoginDatabase.Query("SELECT bandate, unbandate, bannedby, banreason FROM account_banned WHERE id = {} ORDER BY unbandate", accountId);
                if (banInfo)
                {
                    Field* fields2 = banInfo->Fetch();
                    do
                    {
                        tm tmBan = Acore::Time::TimeBreakdown(fields2[0].Get<uint32>());

                        if (fields2[0].Get<uint32>() == fields2[1].Get<uint32>())
                        {
                            handler->PSendSysMessage("|%-15.15s|%02d-%02d-%02d %02d:%02d|   permanent  |%-15.15s|%-15.15s|",
                                                     accountName.c_str(), tmBan.tm_year % 100, tmBan.tm_mon + 1, tmBan.tm_mday, tmBan.tm_hour, tmBan.tm_min,
                                                     fields2[2].Get<std::string>().c_str(), fields2[3].Get<std::string>().c_str());
                        }
                        else
                        {
                            tm tmUnban = Acore::Time::TimeBreakdown(fields2[1].Get<uint32>());
                            handler->PSendSysMessage("|%-15.15s|%02d-%02d-%02d %02d:%02d|%02d-%02d-%02d %02d:%02d|%-15.15s|%-15.15s|",
                                                     accountName.c_str(), tmBan.tm_year % 100, tmBan.tm_mon + 1, tmBan.tm_mday, tmBan.tm_hour, tmBan.tm_min,
                                                     tmUnban.tm_year % 100, tmUnban.tm_mon + 1, tmUnban.tm_mday, tmUnban.tm_hour, tmUnban.tm_min,
                                                     fields2[2].Get<std::string>().c_str(), fields2[3].Get<std::string>().c_str());
                        }
                    } while (banInfo->NextRow());
                }
            } while (result->NextRow());

            handler->SendSysMessage(" ===============================================================================");
        }

        return true;
    }

    static bool HandleBanListCharacterCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* filterStr = strtok((char*)args, " ");
        if (!filterStr)
            return false;

        std::string filter(filterStr);
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GUID_BY_NAME_FILTER);
        stmt->SetData(0, filter);
        PreparedQueryResult result = CharacterDatabase.Query(stmt);
        if (!result)
        {
            handler->PSendSysMessage(LANG_BANLIST_NOCHARACTER);
            return true;
        }

        handler->PSendSysMessage(LANG_BANLIST_MATCHINGCHARACTER);

        // Chat short output
        if (handler->GetSession())
        {
            do
            {
                Field* fields = result->Fetch();
                CharacterDatabasePreparedStatement* stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_SEL_BANNED_NAME);
                stmt2->SetData(0, fields[0].Get<uint32>());

                PreparedQueryResult banResult = CharacterDatabase.Query(stmt2);
                if (banResult)
                    handler->PSendSysMessage("%s", (*banResult)[0].Get<std::string>().c_str());
            } while (result->NextRow());
        }
        // Console wide output
        else
        {
            handler->SendSysMessage(LANG_BANLIST_CHARACTERS);
            handler->SendSysMessage(" =============================================================================== ");
            handler->SendSysMessage(LANG_BANLIST_CHARACTERS_HEADER);
            do
            {
                handler->SendSysMessage("-------------------------------------------------------------------------------");

                Field* fields = result->Fetch();

                std::string char_name = fields[1].Get<std::string>();

                CharacterDatabasePreparedStatement* stmt2 = CharacterDatabase.GetPreparedStatement(CHAR_SEL_BANINFO_LIST);
                stmt2->SetData(0, fields[0].Get<uint32>());

                PreparedQueryResult banInfo = CharacterDatabase.Query(stmt2);
                if (banInfo)
                {
                    Field* banFields = banInfo->Fetch();
                    do
                    {
                        tm tmBan = Acore::Time::TimeBreakdown(banFields[0].Get<uint32>());

                        if (banFields[0].Get<uint32>() == banFields[1].Get<uint32>())
                        {
                            handler->PSendSysMessage("|%-15.15s|%02d-%02d-%02d %02d:%02d|   permanent  |%-15.15s|%-15.15s|",
                                                     char_name.c_str(), tmBan.tm_year % 100, tmBan.tm_mon + 1, tmBan.tm_mday, tmBan.tm_hour, tmBan.tm_min,
                                                     banFields[2].Get<std::string>().c_str(), banFields[3].Get<std::string>().c_str());
                        }
                        else
                        {
                            tm tmUnban = Acore::Time::TimeBreakdown(banFields[1].Get<uint32>());
                            handler->PSendSysMessage("|%-15.15s|%02d-%02d-%02d %02d:%02d|%02d-%02d-%02d %02d:%02d|%-15.15s|%-15.15s|",
                                                     char_name.c_str(), tmBan.tm_year % 100, tmBan.tm_mon + 1, tmBan.tm_mday, tmBan.tm_hour, tmBan.tm_min,
                                                     tmUnban.tm_year % 100, tmUnban.tm_mon + 1, tmUnban.tm_mday, tmUnban.tm_hour, tmUnban.tm_min,
                                                     banFields[2].Get<std::string>().c_str(), banFields[3].Get<std::string>().c_str());
                        }
                    } while (banInfo->NextRow());
                }
            } while (result->NextRow());
            handler->SendSysMessage(" =============================================================================== ");
        }

        return true;
    }

    static bool HandleBanListIPCommand(ChatHandler* handler, char const* args)
    {
        LoginDatabasePreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_EXPIRED_IP_BANS);
        LoginDatabase.Execute(stmt);

        char* filterStr = strtok((char*)args, " ");
        std::string filter = filterStr ? filterStr : "";
        LoginDatabase.EscapeString(filter);

        PreparedQueryResult result;

        if (filter.empty())
        {
            LoginDatabasePreparedStatement* stmt2 = LoginDatabase.GetPreparedStatement(LOGIN_SEL_IP_BANNED_ALL);
            result = LoginDatabase.Query(stmt2);
        }
        else
        {
            LoginDatabasePreparedStatement* stmt2 = LoginDatabase.GetPreparedStatement(LOGIN_SEL_IP_BANNED_BY_IP);
            stmt2->SetData(0, filter);
            result = LoginDatabase.Query(stmt2);
        }

        if (!result)
        {
            handler->PSendSysMessage(LANG_BANLIST_NOIP);
            return true;
        }

        handler->PSendSysMessage(LANG_BANLIST_MATCHINGIP);
        // Chat short output
        if (handler->GetSession())
        {
            do
            {
                Field* fields = result->Fetch();
                handler->PSendSysMessage("%s", fields[0].Get<std::string>().c_str());
            } while (result->NextRow());
        }
        // Console wide output
        else
        {
            handler->SendSysMessage(LANG_BANLIST_IPS);
            handler->SendSysMessage(" ===============================================================================");
            handler->SendSysMessage(LANG_BANLIST_IPS_HEADER);
            do
            {
                handler->SendSysMessage("-------------------------------------------------------------------------------");
                Field* fields = result->Fetch();
                tm tmBan = Acore::Time::TimeBreakdown(fields[1].Get<uint32>());
                if (fields[1].Get<uint32>() == fields[2].Get<uint32>())
                {
                    handler->PSendSysMessage("|%-15.15s|%02d-%02d-%02d %02d:%02d|   permanent  |%-15.15s|%-15.15s|",
                                             fields[0].Get<std::string>().c_str(), tmBan.tm_year % 100, tmBan.tm_mon + 1, tmBan.tm_mday, tmBan.tm_hour, tmBan.tm_min,
                                             fields[3].Get<std::string>().c_str(), fields[4].Get<std::string>().c_str());
                }
                else
                {
                    tm tmUnban = Acore::Time::TimeBreakdown(fields[2].Get<uint32>());
                    handler->PSendSysMessage("|%-15.15s|%02d-%02d-%02d %02d:%02d|%02d-%02d-%02d %02d:%02d|%-15.15s|%-15.15s|",
                                             fields[0].Get<std::string>().c_str(), tmBan.tm_year % 100, tmBan.tm_mon + 1, tmBan.tm_mday, tmBan.tm_hour, tmBan.tm_min,
                                             tmUnban.tm_year % 100, tmUnban.tm_mon + 1, tmUnban.tm_mday, tmUnban.tm_hour, tmUnban.tm_min,
                                             fields[3].Get<std::string>().c_str(), fields[4].Get<std::string>().c_str());
                }
            } while (result->NextRow());

            handler->SendSysMessage(" ===============================================================================");
        }

        return true;
    }

    static bool HandleUnBanAccountCommand(ChatHandler* handler, char const* args)
    {
        return HandleUnBanHelper(BAN_ACCOUNT, args, handler);
    }

    static bool HandleUnBanCharacterCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* nameStr = strtok((char*)args, " ");
        if (!nameStr)
            return false;

        std::string CharacterName = nameStr;

        if (!normalizePlayerName(CharacterName))
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        if (!sBan->RemoveBanCharacter(CharacterName))
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        return true;
    }

    static bool HandleUnBanAccountByCharCommand(ChatHandler* handler, char const* args)
    {
        return HandleUnBanHelper(BAN_CHARACTER, args, handler);
    }

    static bool HandleUnBanIPCommand(ChatHandler* handler, char const* args)
    {
        return HandleUnBanHelper(BAN_IP, args, handler);
    }

    static bool HandleUnBanHelper(BanMode mode, char const* args, ChatHandler* handler)
    {
        if (!*args)
            return false;

        char* nameOrIPStr = strtok((char*)args, " ");
        if (!nameOrIPStr)
            return false;

        std::string nameOrIP = nameOrIPStr;

        switch (mode)
        {
            case BAN_ACCOUNT:
                if (!Utf8ToUpperOnlyLatin(nameOrIP))
                {
                    handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, nameOrIP.c_str());
                    return false;
                }
                break;
            case BAN_CHARACTER:
                if (!normalizePlayerName(nameOrIP))
                {
                    handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
                    return false;
                }
                break;
            case BAN_IP:
                if (!IsIPAddress(nameOrIP.c_str()))
                    return false;
                break;
        }

        switch (mode)
        {
            case BAN_ACCOUNT:
                if (sBan->RemoveBanAccount(nameOrIP))
                    handler->PSendSysMessage(LANG_UNBAN_UNBANNED, nameOrIP.c_str());
                else
                    handler->PSendSysMessage(LANG_UNBAN_ERROR, nameOrIP.c_str());
                break;
            case BAN_CHARACTER:
                if (sBan->RemoveBanAccountByPlayerName(nameOrIP))
                    handler->PSendSysMessage(LANG_UNBAN_UNBANNED, nameOrIP.c_str());
                else
                    handler->PSendSysMessage(LANG_UNBAN_ERROR, nameOrIP.c_str());
                break;
            case BAN_IP:
                if (sBan->RemoveBanIP(nameOrIP))
                    handler->PSendSysMessage(LANG_UNBAN_UNBANNED, nameOrIP.c_str());
                else
                    handler->PSendSysMessage(LANG_UNBAN_ERROR, nameOrIP.c_str());
                break;
            default:
                break;
        }

        return true;
    }
};

void AddSC_ban_commandscript()
{
    new ban_commandscript();
}
