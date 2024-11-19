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
Name: character_commandscript
%Complete: 100
Comment: All character related commands
Category: commandscripts
EndScriptData */

#include "AccountMgr.h"
#include "AchievementMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PlayerDump.h"
#include "ReputationMgr.h"
#include "Timer.h"
#include "World.h"
#include "WorldSession.h"

using namespace Acore::ChatCommands;

class character_commandscript : public CommandScript
{
public:
    character_commandscript() : CommandScript("character_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable pdumpCommandTable =
        {
            { "load",           HandlePDumpLoadCommand,  SEC_ADMINISTRATOR, Console::Yes },
            { "write",          HandlePDumpWriteCommand, SEC_ADMINISTRATOR, Console::Yes }
        };

        static ChatCommandTable characterDeletedCommandTable =
        {
            { "delete",         HandleCharacterDeletedDeleteCommand,   SEC_CONSOLE,       Console::Yes },
            { "list",           HandleCharacterDeletedListCommand,     SEC_ADMINISTRATOR, Console::Yes },
            { "restore",        HandleCharacterDeletedRestoreCommand,  SEC_ADMINISTRATOR, Console::Yes },
            { "purge",          HandleCharacterDeletedPurgeCommand,    SEC_CONSOLE,       Console::Yes }
        };

        static ChatCommandTable characterCheckCommandTable =
        {
            { "bank",          HandleCharacterCheckBankCommand,          SEC_GAMEMASTER, Console::Yes },
            { "bag",           HandleCharacterCheckBagCommand,           SEC_GAMEMASTER, Console::Yes },
            { "profession",    HandleCharacterCheckProfessionCommand,    SEC_GAMEMASTER, Console::Yes }
        };

        static ChatCommandTable characterCommandTable =
        {
            { "customize",      HandleCharacterCustomizeCommand,        SEC_GAMEMASTER, Console::Yes },
            { "changefaction",  HandleCharacterChangeFactionCommand,    SEC_GAMEMASTER, Console::Yes },
            { "changerace",     HandleCharacterChangeRaceCommand,       SEC_GAMEMASTER, Console::Yes },
            { "changeaccount",  HandleCharacterChangeAccountCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "check",          characterCheckCommandTable },
            { "erase",          HandleCharacterEraseCommand,            SEC_CONSOLE,    Console::Yes },
            { "deleted",        characterDeletedCommandTable },
            { "level",          HandleCharacterLevelCommand,            SEC_GAMEMASTER, Console::Yes },
            { "rename",         HandleCharacterRenameCommand,           SEC_GAMEMASTER, Console::Yes },
            { "reputation",     HandleCharacterReputationCommand,       SEC_GAMEMASTER, Console::Yes },
            { "titles",         HandleCharacterTitlesCommand,           SEC_GAMEMASTER, Console::Yes }
        };

        static ChatCommandTable commandTable =
        {
            { "character",      characterCommandTable },
            { "levelup",        HandleLevelUpCommand, SEC_GAMEMASTER, Console::No },
            { "pdump",          pdumpCommandTable }
        };

        return commandTable;
    }

    // Stores informations about a deleted character
    struct DeletedInfo
    {
        ObjectGuid::LowType lowGuid;                    ///< the low GUID from the character
        std::string name;                               ///< the character name
        uint32      accountId;                          ///< the account id
        std::string accountName;                        ///< the account name
        time_t      deleteDate;                         ///< the date at which the character has been deleted
    };

    typedef std::list<DeletedInfo> DeletedInfoList;

    /**
    * Collects all GUIDs (and related info) from deleted characters which are still in the database.
    *
    * @param foundList    a reference to an std::list which will be filled with info data
    * @param searchString the search string which either contains a player GUID or a part fo the character-name
    * @return             returns false if there was a problem while selecting the characters (e.g. player name not normalizeable)
    */
    static bool GetDeletedCharacterInfoList(DeletedInfoList& foundList, std::string searchString)
    {
        PreparedQueryResult result;
        CharacterDatabasePreparedStatement* stmt = nullptr;
        if (!searchString.empty())
        {
            // search by GUID
            if (isNumeric(searchString.c_str()))
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_DEL_INFO_BY_GUID);
                stmt->SetData(0, *Acore::StringTo<uint32>(searchString));
                result = CharacterDatabase.Query(stmt);
            }
            // search by name
            else
            {
                if (!normalizePlayerName(searchString))
                    return false;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_DEL_INFO_BY_NAME);
                stmt->SetData(0, searchString);
                result = CharacterDatabase.Query(stmt);
            }
        }
        else
        {
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_DEL_INFO);
            result = CharacterDatabase.Query(stmt);
        }

        if (result)
        {
            do
            {
                Field* fields = result->Fetch();

                DeletedInfo info;

                info.lowGuid    = fields[0].Get<uint32>();
                info.name       = fields[1].Get<std::string>();
                info.accountId  = fields[2].Get<uint32>();

                // account name will be empty for nonexisting account
                AccountMgr::GetName(info.accountId, info.accountName);
                info.deleteDate = time_t(fields[3].Get<uint32>());
                foundList.push_back(info);
            } while (result->NextRow());
        }

        return true;
    }

    /**
    * Shows all deleted characters which matches the given search string, expected non empty list
    *
    * @see HandleCharacterDeletedListCommand
    * @see HandleCharacterDeletedRestoreCommand
    * @see HandleCharacterDeletedDeleteCommand
    * @see DeletedInfoList
    *
    * @param foundList contains a list with all found deleted characters
    */
    static void HandleCharacterDeletedListHelper(DeletedInfoList const& foundList, ChatHandler* handler)
    {
        if (!handler->GetSession())
        {
            handler->SendSysMessage(LANG_CHARACTER_DELETED_LIST_BAR);
            handler->SendSysMessage(LANG_CHARACTER_DELETED_LIST_HEADER);
            handler->SendSysMessage(LANG_CHARACTER_DELETED_LIST_BAR);
        }

        for (DeletedInfoList::const_iterator itr = foundList.begin(); itr != foundList.end(); ++itr)
        {
            std::string dateStr = Acore::Time::TimeToTimestampStr(Seconds(itr->deleteDate));

            if (!handler->GetSession())
                handler->PSendSysMessage(LANG_CHARACTER_DELETED_LIST_LINE_CONSOLE,
                                         itr->lowGuid, itr->name, itr->accountName.empty() ? "<Not existing>" : itr->accountName,
                                         itr->accountId, dateStr);
            else
                handler->PSendSysMessage(LANG_CHARACTER_DELETED_LIST_LINE_CHAT,
                                         itr->lowGuid, itr->name, itr->accountName.empty() ? "<Not existing>" : itr->accountName,
                                         itr->accountId, dateStr);
        }

        if (!handler->GetSession())
            handler->SendSysMessage(LANG_CHARACTER_DELETED_LIST_BAR);
    }

    /**
    * Restore a previously deleted character
    *
    * @see HandleCharacterDeletedListHelper
    * @see HandleCharacterDeletedRestoreCommand
    * @see HandleCharacterDeletedDeleteCommand
    * @see DeletedInfoList
    *
    * @param delInfo the informations about the character which will be restored
    */
    static void HandleCharacterDeletedRestoreHelper(DeletedInfo const& delInfo, ChatHandler* handler)
    {
        if (delInfo.accountName.empty())                    // account does not exist
        {
            handler->PSendSysMessage(LANG_CHARACTER_DELETED_SKIP_ACCOUNT, delInfo.name, delInfo.lowGuid, delInfo.accountId);
            return;
        }

        // check character count
        uint32 charcount = AccountMgr::GetCharactersCount(delInfo.accountId);
        if (charcount >= 10)
        {
            handler->PSendSysMessage(LANG_CHARACTER_DELETED_SKIP_FULL, delInfo.name, delInfo.lowGuid, delInfo.accountId);
            return;
        }

        if (sCharacterCache->GetCharacterGuidByName(delInfo.name))
        {
            handler->PSendSysMessage(LANG_CHARACTER_DELETED_SKIP_NAME, delInfo.name, delInfo.lowGuid, delInfo.accountId);
            return;
        }

        auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_RESTORE_DELETE_INFO);
        stmt->SetData(0, delInfo.name);
        stmt->SetData(1, delInfo.accountId);
        stmt->SetData(2, delInfo.lowGuid);
        CharacterDatabase.Execute(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_NAME_DATA);
        stmt->SetData(0, delInfo.lowGuid);
        if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
        {
            sCharacterCache->AddCharacterCacheEntry(ObjectGuid(HighGuid::Player, delInfo.lowGuid), delInfo.accountId, delInfo.name, (*result)[2].Get<uint8>(), (*result)[0].Get<uint8>(), (*result)[1].Get<uint8>(), (*result)[3].Get<uint8>());
        }
    }

    static void HandleCharacterLevel(Player* player, ObjectGuid playerGuid, uint32 oldLevel, uint32 newLevel, ChatHandler* handler)
    {
        if (player)
        {
            player->GiveLevel(newLevel);
            player->InitTalentForLevel();
            player->SetUInt32Value(PLAYER_XP, 0);

            if (handler->needReportToTarget(player))
            {
                if (oldLevel == newLevel)
                    ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOURS_LEVEL_PROGRESS_RESET, handler->GetNameLink());
                else if (oldLevel < newLevel)
                    ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOURS_LEVEL_UP, handler->GetNameLink(), newLevel);
                else                                                // if (oldlevel > newlevel)
                    ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOURS_LEVEL_DOWN, handler->GetNameLink(), newLevel);
            }
        }
        else
        {
            // Update level and reset XP, everything else will be updated at login
            auto* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_LEVEL);
            stmt->SetData(0, uint8(newLevel));
            stmt->SetData(1, playerGuid.GetCounter());
            CharacterDatabase.Execute(stmt);

            sAchievementMgr->UpdateAchievementCriteriaForOfflinePlayer(playerGuid.GetCounter(), ACHIEVEMENT_CRITERIA_TYPE_REACH_LEVEL);

            sCharacterCache->UpdateCharacterLevel(playerGuid, newLevel);
        }
    }

    static bool HandleCharacterTitlesCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!player || !player->IsConnected())
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        Player const* target = player->GetConnectedPlayer();

        LocaleConstant loc = handler->GetSessionDbcLocale();
        char const* knownStr = handler->GetAcoreString(LANG_KNOWN);

        // Search in CharTitles.dbc
        for (uint32 id = 0; id < sCharTitlesStore.GetNumRows(); id++)
        {
            CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(id);

            if (titleInfo && target->HasTitle(titleInfo))
            {
                char const* name = target->getGender() == GENDER_MALE ? titleInfo->nameMale[loc] : titleInfo->nameFemale[loc];
                if (!*name)
                    name = (target->getGender() == GENDER_MALE ? titleInfo->nameMale[sWorld->GetDefaultDbcLocale()] : titleInfo->nameFemale[sWorld->GetDefaultDbcLocale()]);

                if (!*name)
                    continue;

                char const* activeStr = "";
                if (target->GetUInt32Value(PLAYER_CHOSEN_TITLE) == titleInfo->bit_index)
                    activeStr = handler->GetAcoreString(LANG_ACTIVE);

                std::string titleName = Acore::StringFormat(name, player->GetName());

                // send title in "id (idx:idx) - [namedlink locale]" format
                if (handler->GetSession())
                    handler->PSendSysMessage(LANG_TITLE_LIST_CHAT, id, titleInfo->bit_index, id, titleName, localeNames[loc], knownStr, activeStr);
                else
                    handler->PSendSysMessage(LANG_TITLE_LIST_CONSOLE, id, titleInfo->bit_index, name, localeNames[loc], knownStr, activeStr);
            }
        }

        return true;
    }

    //rename characters
    static bool HandleCharacterRenameCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, Optional<bool> reserveName, Optional<std::string_view> newNameV)
    {
        if (!player && newNameV)
            return false;

        if (!player)
            player = PlayerIdentifier::FromTarget(handler);

        if (!player)
            return false;

        if (handler->HasLowerSecurity(nullptr, player->GetGUID()))
            return false;

        if (newNameV)
        {
            std::string newName{ *newNameV };
            if (!normalizePlayerName(newName))
            {
                handler->SendErrorMessage(LANG_BAD_VALUE);
                return false;
            }

            ResponseCodes res = ResponseCodes(ObjectMgr::CheckPlayerName(newName, true));
            if (res != CHAR_NAME_SUCCESS)
            {
                switch (res)
                {
                    case CHAR_NAME_RESERVED:
                        handler->SendErrorMessage(LANG_RESERVED_NAME);
                        break;
                    case CHAR_NAME_PROFANE:
                        handler->SendErrorMessage(LANG_PROFANITY_NAME);
                        break;
                    default:
                        handler->SendErrorMessage(LANG_BAD_VALUE);
                        break;
                }

                return false;
            }

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHECK_NAME);
            stmt->SetData(0, newName);
            PreparedQueryResult result = CharacterDatabase.Query(stmt);
            if (result)
            {
                handler->SendErrorMessage(LANG_RENAME_PLAYER_ALREADY_EXISTS, newName);
                return false;
            }

            // Remove declined name from db
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_DECLINED_NAME);
            stmt->SetData(0, player->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);

            if (Player* target = player->GetConnectedPlayer())
            {
                target->SetName(newName);

                ObjectAccessor::UpdatePlayerNameMapReference(player->GetName(), target);

                if (WorldSession* session = target->GetSession())
                    session->KickPlayer("HandleCharacterRenameCommand GM Command renaming character");
            }
            else
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_NAME_BY_GUID);
                stmt->SetData(0, newName);
                stmt->SetData(1, player->GetGUID().GetCounter());
                CharacterDatabase.Execute(stmt);
            }

            sCharacterCache->UpdateCharacterData(player->GetGUID(), newName);

            handler->PSendSysMessage(LANG_RENAME_PLAYER_WITH_NEW_NAME, player->GetName(), newName);
        }
        else
        {
            if (Player* target = player->GetConnectedPlayer())
            {
                handler->PSendSysMessage(LANG_RENAME_PLAYER, handler->GetNameLink(target));
                target->SetAtLoginFlag(AT_LOGIN_RENAME);
            }
            else
            {
                // check offline security
                if (handler->HasLowerSecurity(nullptr, player->GetGUID()))
                    return false;

                handler->PSendSysMessage(LANG_RENAME_PLAYER_GUID, handler->playerLink(*player), player->GetGUID().ToString());

                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
                stmt->SetData(0, uint16(AT_LOGIN_RENAME));
                stmt->SetData(1, player->GetGUID().GetCounter());
                CharacterDatabase.Execute(stmt);
            }
        }

        if (reserveName)
        {
            sObjectMgr->AddReservedPlayerName(player->GetName());
        }

        return true;
    }

    static bool HandleCharacterLevelCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, int16 newlevel)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!player)
            return false;

        uint8 oldlevel = player->IsConnected() ? player->GetConnectedPlayer()->GetLevel() : sCharacterCache->GetCharacterLevelByGuid(player->GetGUID());

        if (newlevel < 1)
            return false;                                       // invalid level

        if (newlevel > DEFAULT_MAX_LEVEL)                         // hardcoded maximum level
            newlevel = DEFAULT_MAX_LEVEL;

        HandleCharacterLevel(player->GetConnectedPlayer(), player->GetGUID(), oldlevel, newlevel, handler);

        if (!handler->GetSession() || (handler->GetSession()->GetPlayer() != player->GetConnectedPlayer()))      // including chr == NULL
            handler->PSendSysMessage(LANG_YOU_CHANGE_LVL, handler->playerLink(*player), newlevel);

        return true;
    }

    // customize characters
    static bool HandleCharacterCustomizeCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTarget(handler);
        if (!player)
            return false;

        if (Player* target = player->GetConnectedPlayer())
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER, handler->GetNameLink(target));
            target->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
        }
        else
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER_GUID, handler->playerLink(*player), player->GetGUID().ToString());
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, static_cast<uint16>(AT_LOGIN_CUSTOMIZE));
            stmt->SetData(1, player->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);
        }

        return true;
    }

    static bool HandleCharacterChangeFactionCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTarget(handler);
        if (!player)
            return false;

        if (Player* target = player->GetConnectedPlayer())
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER, handler->GetNameLink(target));
            target->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
        }
        else
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER_GUID, handler->playerLink(*player), player->GetGUID().ToString());
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_CHANGE_FACTION));
            stmt->SetData(1, player->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);
        }

        return true;
    }

    static bool HandleCharacterChangeRaceCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTarget(handler);
        if (!player)
            return false;

        if (Player* target = player->GetConnectedPlayer())
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER, handler->GetNameLink(target));
            target->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
        }
        else
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER_GUID, handler->playerLink(*player), player->GetGUID().ToString());
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_CHANGE_RACE));
            stmt->SetData(1, player->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);
        }

        return true;
    }

    static bool HandleCharacterReputationCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        if (!player || !player->IsConnected())
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        Player const* target = player->GetConnectedPlayer();
        LocaleConstant loc = handler->GetSessionDbcLocale();

        FactionStateList const& targetFSL = target->GetReputationMgr().GetStateList();
        for (FactionStateList::const_iterator itr = targetFSL.begin(); itr != targetFSL.end(); ++itr)
        {
            FactionState const& faction = itr->second;
            FactionEntry const* factionEntry = sFactionStore.LookupEntry(faction.ID);
            char const* factionName = factionEntry ? factionEntry->name[loc] : "#Not found#";
            ReputationRank rank = target->GetReputationMgr().GetRank(factionEntry);
            std::string rankName = handler->GetAcoreString(ReputationRankStrIndex[rank]);
            std::ostringstream ss;
            if (handler->GetSession())
                ss << faction.ID << " - |cffffffff|Hfaction:" << faction.ID << "|h[" << factionName << ' ' << localeNames[loc] << "]|h|r";
            else
                ss << faction.ID << " - " << factionName << ' ' << localeNames[loc];

            ss << ' ' << rankName << " (" << target->GetReputationMgr().GetReputation(factionEntry) << ')';

            if (faction.Flags & FACTION_FLAG_VISIBLE)
                ss << handler->GetAcoreString(LANG_FACTION_VISIBLE);
            if (faction.Flags & FACTION_FLAG_AT_WAR)
                ss << handler->GetAcoreString(LANG_FACTION_ATWAR);
            if (faction.Flags & FACTION_FLAG_PEACE_FORCED)
                ss << handler->GetAcoreString(LANG_FACTION_PEACE_FORCED);
            if (faction.Flags & FACTION_FLAG_HIDDEN)
                ss << handler->GetAcoreString(LANG_FACTION_HIDDEN);
            if (faction.Flags & FACTION_FLAG_INVISIBLE_FORCED)
                ss << handler->GetAcoreString(LANG_FACTION_INVISIBLE_FORCED);
            if (faction.Flags & FACTION_FLAG_INACTIVE)
                ss << handler->GetAcoreString(LANG_FACTION_INACTIVE);

            handler->SendSysMessage(ss.str().c_str());
        }

        return true;
    }

    /**
    * Handles the '.character deleted list' command, which shows all deleted characters which matches the given search string
    *
    * @see HandleCharacterDeletedListHelper
    * @see HandleCharacterDeletedRestoreCommand
    * @see HandleCharacterDeletedDeleteCommand
    * @see DeletedInfoList
    *
    * @param args the search string which either contains a player GUID or a part fo the character-name
    */

    static bool HandleCharacterDeletedListCommand(ChatHandler* handler, Optional<std::string_view> needleStr)
    {
        std::string needle;
        if (needleStr)
            needle.assign(*needleStr);
        DeletedInfoList foundList;
        if (!GetDeletedCharacterInfoList(foundList, needle))
            return false;

        // if no characters have been found, output a warning
        if (foundList.empty())
        {
            handler->SendErrorMessage(LANG_CHARACTER_DELETED_LIST_EMPTY);
            return false;
        }

        HandleCharacterDeletedListHelper(foundList, handler);

        return true;
    }

    /**
     * Handles the '.character deleted restore' command, which restores all deleted characters which matches the given search string
     *
     * The command automatically calls '.character deleted list' command with the search string to show all restored characters.
     *
     * @see HandleCharacterDeletedRestoreHelper
     * @see HandleCharacterDeletedListCommand
     * @see HandleCharacterDeletedDeleteCommand
     *
     * @param args the search string which either contains a player GUID or a part of the character-name
     */
    static bool HandleCharacterDeletedRestoreCommand(ChatHandler* handler, std::string needle, Optional<std::string_view> newCharName, Optional<AccountIdentifier> newAccount)
    {
        DeletedInfoList foundList;
        if (!GetDeletedCharacterInfoList(foundList, needle))
            return false;

        if (foundList.empty())
        {
            handler->SendErrorMessage(LANG_CHARACTER_DELETED_LIST_EMPTY);
            return false;
        }

        handler->SendSysMessage(LANG_CHARACTER_DELETED_RESTORE);
        HandleCharacterDeletedListHelper(foundList, handler);

        if (!newCharName)
        {
            // Drop nonexisting account cases
            for (DeletedInfoList::iterator itr = foundList.begin(); itr != foundList.end(); ++itr)
                HandleCharacterDeletedRestoreHelper(*itr, handler);
            return true;
        }

        if (foundList.size() == 1)
        {
            std::string newName{ *newCharName };
            DeletedInfo delInfo = foundList.front();

            // update name
            delInfo.name = newName;

            // if new account provided update deleted info
            if (newAccount)
            {
                delInfo.accountId = newAccount->GetID();
                delInfo.accountName = newAccount->GetName();
            }

            HandleCharacterDeletedRestoreHelper(delInfo, handler);
            return true;
        }

        handler->SendErrorMessage(LANG_CHARACTER_DELETED_ERR_RENAME);
        return false;
    }

    /**
     * Handles the '.character deleted delete' command, which completely deletes all deleted characters which matches the given search string
     *
     * @see Player::GetDeletedCharacterGUIDs
     * @see Player::DeleteFromDB
     * @see HandleCharacterDeletedListCommand
     * @see HandleCharacterDeletedRestoreCommand
     *
     * @param args the search string which either contains a player GUID or a part fo the character-name
     */
    static bool HandleCharacterDeletedDeleteCommand(ChatHandler* handler, std::string needle)
    {
        DeletedInfoList foundList;
        if (!GetDeletedCharacterInfoList(foundList, needle))
            return false;

        if (foundList.empty())
        {
            handler->SendErrorMessage(LANG_CHARACTER_DELETED_LIST_EMPTY);
            return false;
        }

        handler->SendSysMessage(LANG_CHARACTER_DELETED_DELETE);
        HandleCharacterDeletedListHelper(foundList, handler);

        // Call the appropriate function to delete them (current account for deleted characters is 0)
        for (DeletedInfoList::const_iterator itr = foundList.begin(); itr != foundList.end(); ++itr)
            Player::DeleteFromDB(itr->lowGuid, 0, false, true);

        return true;
    }

    /**
     * Handles the '.character deleted old' command, which completely deletes all deleted characters deleted with some days ago
     *
     * @see Player::DeleteOldCharacters
     * @see Player::DeleteFromDB
     * @see HandleCharacterDeletedDeleteCommand
     * @see HandleCharacterDeletedListCommand
     * @see HandleCharacterDeletedRestoreCommand
     *
     * @param args the search string which either contains a player GUID or a part of the character-name
     */
    static bool HandleCharacterDeletedPurgeCommand(ChatHandler* /*handler*/, Optional<uint16> days)
    {
        int32 keepDays = static_cast<int32>(sWorld->getIntConfig(CONFIG_CHARDELETE_KEEP_DAYS));

        if (days)
            keepDays = static_cast<int32>(*days);
        else if (keepDays <= 0) // config option value 0 -> disabled and can't be used
            return false;

        Player::DeleteOldCharacters(static_cast<uint32>(keepDays));

        return true;
    }

    /**
     * Handles the '.character erase' command which completly delete a character from the DB
     *
     * @see Player::DeleteFromDB
     *
     * @param args the search string which either contains a player GUID or a part of the character-name
     */
    static bool HandleCharacterEraseCommand(ChatHandler* handler, PlayerIdentifier player)
    {
        uint32 accountId;
        if (Player* target = player.GetConnectedPlayer())
        {
            accountId = target->GetSession()->GetAccountId();
            target->GetSession()->KickPlayer("HandleCharacterEraseCommand GM Command deleting character");
        }
        else
        {
            accountId = sCharacterCache->GetCharacterAccountIdByGuid(player.GetGUID());
        }

        std::string accountName;
        AccountMgr::GetName(accountId, accountName);

        Player::DeleteFromDB(player.GetGUID().GetCounter(), accountId, true, true);
        handler->PSendSysMessage(LANG_CHARACTER_DELETED, player.GetName(), player.GetGUID().ToString(), accountName, accountId);

        return true;
    }

    static bool HandleLevelUpCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, int16 level)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);

        if (!player)
            return false;

        uint8 oldlevel = player->IsConnected() ? player->GetConnectedPlayer()->GetLevel() : sCharacterCache->GetCharacterLevelByGuid(player->GetGUID());
        int16 newlevel = static_cast<int16>(oldlevel) + level;

        if (newlevel < 1)
            newlevel = 1;

        if (newlevel > STRONG_MAX_LEVEL)                         // hardcoded maximum level
            newlevel = STRONG_MAX_LEVEL;

        HandleCharacterLevel(player->GetConnectedPlayer(), player->GetGUID(), oldlevel, newlevel, handler);

        if (!handler->GetSession() || (handler->GetSession()->GetPlayer() != player->GetConnectedPlayer()))      // including chr == NULL
            handler->PSendSysMessage(LANG_YOU_CHANGE_LVL, handler->playerLink(*player), newlevel);

        return true;
    }

    static bool ValidatePDumpTarget(ChatHandler* handler, std::string& name, Optional<std::string_view> characterName, Optional<ObjectGuid::LowType> characterGUID)
    {
        if (characterName)
        {
            name.assign(*characterName);
            // normalize the name if specified and check if it exists
            if (!normalizePlayerName(name))
            {
                handler->SendErrorMessage(LANG_INVALID_CHARACTER_NAME);
                return false;
            }

            if (ObjectMgr::CheckPlayerName(name, true) != CHAR_NAME_SUCCESS)
            {
                handler->SendErrorMessage(LANG_INVALID_CHARACTER_NAME);
                return false;
            }
        }

        if (characterGUID)
        {
            if (sCharacterCache->GetCharacterAccountIdByGuid(ObjectGuid(HighGuid::Player, *characterGUID)))
            {
                handler->SendErrorMessage(LANG_CHARACTER_GUID_IN_USE, *characterGUID);
                return false;
            }
        }

        return true;
    }

    static bool HandlePDumpLoadCommand(ChatHandler* handler, std::string fileName, AccountIdentifier account, Optional<std::string_view> characterName, Optional<ObjectGuid::LowType> characterGUID)
    {
        std::string name;
        if (!ValidatePDumpTarget(handler, name, characterName, characterGUID))
            return false;

        switch (PlayerDumpReader().LoadDumpFromFile(fileName, account, name, characterGUID.value_or(0)))
        {
        case DUMP_SUCCESS:
            handler->PSendSysMessage(LANG_COMMAND_IMPORT_SUCCESS);
            break;
        case DUMP_FILE_OPEN_ERROR:
            handler->SendErrorMessage(LANG_FILE_OPEN_FAIL, fileName);
            return false;
        case DUMP_FILE_BROKEN:
            handler->SendErrorMessage(LANG_DUMP_BROKEN, fileName);
            return false;
        case DUMP_TOO_MANY_CHARS:
            handler->SendErrorMessage(LANG_ACCOUNT_CHARACTER_LIST_FULL, account.GetName(), account.GetID());
            return false;
        default:
            handler->SendErrorMessage(LANG_COMMAND_IMPORT_FAILED);
            return false;
        }

        return true;
    }

    static bool HandlePDumpCopyCommand(ChatHandler* handler, PlayerIdentifier player, AccountIdentifier account, Optional<std::string_view> characterName, Optional<ObjectGuid::LowType> characterGUID)
    {
        std::string name;
        if (!ValidatePDumpTarget(handler, name, characterName, characterGUID))
            return false;

        std::string dump;
        switch (PlayerDumpWriter().WriteDumpToString(dump, player.GetGUID().GetCounter()))
        {
        case DUMP_SUCCESS:
            break;
        case DUMP_CHARACTER_DELETED:
            handler->SendErrorMessage(LANG_COMMAND_EXPORT_DELETED_CHAR);
            return false;
        case DUMP_FILE_OPEN_ERROR: // this error code should not happen
        default:
            handler->SendErrorMessage(LANG_COMMAND_EXPORT_FAILED);
            return false;
        }

        switch (PlayerDumpReader().LoadDumpFromString(dump, account, name, characterGUID.value_or(0)))
        {
        case DUMP_SUCCESS:
            break;
        case DUMP_TOO_MANY_CHARS:
            handler->SendErrorMessage(LANG_ACCOUNT_CHARACTER_LIST_FULL, account.GetName(), account.GetID());
            return false;
        case DUMP_FILE_OPEN_ERROR: // this error code should not happen
        case DUMP_FILE_BROKEN: // this error code should not happen
        default:
            handler->SendErrorMessage(LANG_COMMAND_IMPORT_FAILED);
            return false;
        }

        // Original TC Notes from Refactor vvv
        //ToDo: use a new acore_string for this commands
        handler->PSendSysMessage(LANG_COMMAND_IMPORT_SUCCESS);

        return true;
    }

    static bool HandlePDumpWriteCommand(ChatHandler* handler, std::string fileName, PlayerIdentifier player)
    {
        switch (PlayerDumpWriter().WriteDumpToFile(fileName, player.GetGUID().GetCounter()))
        {
        case DUMP_SUCCESS:
            handler->PSendSysMessage(LANG_COMMAND_EXPORT_SUCCESS);
            break;
        case DUMP_FILE_OPEN_ERROR:
            handler->SendErrorMessage(LANG_FILE_OPEN_FAIL, fileName);
            return false;
        case DUMP_CHARACTER_DELETED:
            handler->SendErrorMessage(LANG_COMMAND_EXPORT_DELETED_CHAR);
            return false;
        default:
            handler->SendErrorMessage(LANG_COMMAND_EXPORT_FAILED);
            return false;
        }

        return true;
    }

    static bool HandleCharacterCheckBankCommand(ChatHandler* handler)
    {
        handler->GetSession()->SendShowBank(handler->GetSession()->GetPlayer()->GetGUID());
        return true;
    }

    static bool HandleCharacterCheckBagCommand(ChatHandler* handler, uint8 BagSlot)
    {
        Player* target = handler->getSelectedPlayerOrSelf();

        if (!target)
            return false;

        uint8 Counter = 0;
        switch (BagSlot)
        {
            case 2:
                BagSlot = 19;
                break;
            case 3:
                BagSlot = 20;
                break;
            case 4:
                BagSlot = 21;
                break;
            case 5:
                BagSlot = 22;
                break;
            default:
                BagSlot = 1;
                break;
        }

        handler->PSendSysMessage("--------------------------------------");

        if (BagSlot == 1)
        {
            for (uint32 i = 23; i < 39; i++)
            {
                if (Item* item = target->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                {
                    Counter++;
                    std::ostringstream ItemString;
                    ItemString << std::hex << ItemQualityColors[item->GetTemplate()->Quality];

                    handler->PSendSysMessage("{} - |c{}|Hitem:{}:0:0:0:0:0:0:0:0:0|h[{}]|h|r - {}", Counter, ItemString.str(), item->GetEntry(), item->GetTemplate()->Name1, item->GetCount());
                }
            }
        }
        else
        {
            if (Bag* bag = target->GetBagByPos(BagSlot))
            {
                for (uint32 i = 0; i < bag->GetBagSize(); i++)
                {
                    if (Item* item = target->GetItemByPos(BagSlot, i))
                    {
                        Counter++;
                        std::ostringstream ItemString;
                        ItemString << std::hex << ItemQualityColors[item->GetTemplate()->Quality];

                        handler->PSendSysMessage("{} - |c{}|Hitem:{}:0:0:0:0:0:0:0:0:0|h[{}]|h|r - {}", Counter, ItemString.str(), item->GetEntry(), item->GetTemplate()->Name1, item->GetCount());
                    }
                }
            }
        }

        handler->PSendSysMessage("--------------------------------------");
        return true;
    }

    static bool HandleCharacterCheckProfessionCommand(ChatHandler* handler)
    {
        Player* player = handler->getSelectedPlayerOrSelf();

        if (!player)
            return false;

        uint8 Counter = 0;

        handler->PSendSysMessage("--------------------------------------");

        for (uint32 i = 1; i < sSkillLineStore.GetNumRows(); ++i)
        {
            SkillLineEntry const* SkillInfo = sSkillLineStore.LookupEntry(i);

            if (!SkillInfo)
                continue;

            if ((SkillInfo->categoryId != SKILL_CATEGORY_PROFESSION) && !SkillInfo->canLink)
                continue;

            uint32 SkillID = SkillInfo->id;

            if (player->HasSkill(SkillID))
            {
                Counter++;

                switch (SkillID)
                {
                    case SKILL_ALCHEMY:
                        handler->PSendSysMessage("{} - Alchemy - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_BLACKSMITHING:
                        handler->PSendSysMessage("{} - Blacksmithing - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_ENCHANTING:
                        handler->PSendSysMessage("{} - Enchanting - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_ENGINEERING:
                        handler->PSendSysMessage("{} - Engineering - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_INSCRIPTION:
                        handler->PSendSysMessage("{} - Inscription - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_JEWELCRAFTING:
                        handler->PSendSysMessage("{} - Jewelcrafting - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_LEATHERWORKING:
                        handler->PSendSysMessage("{} - Leatherworking - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_TAILORING:
                        handler->PSendSysMessage("{} - Tailoring - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_SKINNING:
                        handler->PSendSysMessage("{} - Skinning - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_HERBALISM:
                        handler->PSendSysMessage("{} - Herbalism - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_MINING:
                        handler->PSendSysMessage("{} - Mining - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_COOKING:
                        handler->PSendSysMessage("{} - Cooking - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_FIRST_AID:
                        handler->PSendSysMessage("{} - First Aid - {}", Counter, player->GetSkillValue(SkillID));
                        break;
                    default:
                        break;
                }
            }
        }

        handler->PSendSysMessage("--------------------------------------");
        return true;
    }

    static bool HandleCharacterChangeAccountCommand(ChatHandler* handler, std::string accountName, Optional<PlayerIdentifier> player)
    {
        if (!player)
        {
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!player)
        {
            handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
            return false;
        }

        if (uint32 accountId = AccountMgr::GetId(accountName))
        {
            if (AccountMgr::GetCharactersCount(accountId) >= 10)
            {
                handler->SendErrorMessage(LANG_ACCOUNT_CHARACTER_LIST_FULL, accountName, accountId);
                return true;
            }

            if (CharacterCacheEntry const* cache = sCharacterCache->GetCharacterCacheByName(player->GetName()))
            {
                std::string accName;
                AccountMgr::GetName(cache->AccountId, accName);
                handler->PSendSysMessage(LANG_CMD_CHAR_CHANGE_ACC_SUCCESS, player->GetName(), player->GetGUID().ToString(), accName, cache->AccountId, accountName, accountId);
            }

            if (player->IsConnected())
            {
                player->GetConnectedPlayer()->GetSession()->KickPlayer("CMD char changeaccount");
            }

            CharacterDatabase.Query("UPDATE characters SET account = {} WHERE guid = {}", accountId, player->GetGUID().GetCounter());
            sCharacterCache->UpdateCharacterAccountId(player->GetGUID(), accountId);

        }
        else
        {
            handler->SendErrorMessage(LANG_ACCOUNT_NOT_EXIST, accountName);
            return true;
        }

        return true;
    }
};

void AddSC_character_commandscript()
{
    new character_commandscript();
}
