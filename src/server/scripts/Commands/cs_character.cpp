/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: character_commandscript
%Complete: 100
Comment: All character related commands
Category: commandscripts
EndScriptData */

#include "AccountMgr.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "PlayerDump.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "Implementation/CharacterDatabase.h"

class character_commandscript : public CommandScript
{
public:
    character_commandscript() : CommandScript("character_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> pdumpCommandTable =
        {
            { "load",           SEC_ADMINISTRATOR,  true,  &HandlePDumpLoadCommand,                 "" },
            { "write",          SEC_ADMINISTRATOR,  true,  &HandlePDumpWriteCommand,                "" }
        };

        static std::vector<ChatCommand> characterDeletedCommandTable =
        {
            { "delete",        SEC_CONSOLE,         true,  &HandleCharacterDeletedDeleteCommand,  "" },
            { "list",          SEC_ADMINISTRATOR,   true,  &HandleCharacterDeletedListCommand,    "" },
            { "restore",       SEC_ADMINISTRATOR,   true,  &HandleCharacterDeletedRestoreCommand, "" },
            { "purge",         SEC_CONSOLE,         true,  &HandleCharacterDeletedPurgeCommand,   "" },
        };

        static std::vector<ChatCommand> characterCheckCommandTable =
        {
            { "bank",          SEC_GAMEMASTER,      false,  &HandleCharacterCheckBankCommand, "" },
            { "bag",           SEC_GAMEMASTER,      false,  &HandleCharacterCheckBagCommand,  "" },
            { "profession",    SEC_GAMEMASTER,      false,  &HandleCharacterCheckProfessionCommand, "" },
        };

        static std::vector<ChatCommand> characterCommandTable =
        {
            { "customize",      SEC_GAMEMASTER,     true,  &HandleCharacterCustomizeCommand,       "" },
            { "changefaction",  SEC_GAMEMASTER,     true,  &HandleCharacterChangeFactionCommand,   "" },
            { "changerace",     SEC_GAMEMASTER,     true,  &HandleCharacterChangeRaceCommand,      "" },
            { "check",          SEC_GAMEMASTER,     false,  nullptr,                               "", characterCheckCommandTable },
            { "erase",          SEC_CONSOLE,        true,  &HandleCharacterEraseCommand,           "" },
            { "deleted",        SEC_ADMINISTRATOR,  true,  nullptr,                                "", characterDeletedCommandTable },
            { "level",          SEC_GAMEMASTER,     true,  &HandleCharacterLevelCommand,           "" },
            { "rename",         SEC_GAMEMASTER,     true,  &HandleCharacterRenameCommand,          "" },
            { "reputation",     SEC_GAMEMASTER,     true,  &HandleCharacterReputationCommand,      "" },
            { "titles",         SEC_GAMEMASTER,     true,  &HandleCharacterTitlesCommand,          "" }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "character",      SEC_GAMEMASTER,     true,  nullptr,                                "", characterCommandTable },
            { "levelup",        SEC_GAMEMASTER,     false, &HandleLevelUpCommand,                  "" },
            { "pdump",          SEC_ADMINISTRATOR,  true,  nullptr,                                "", pdumpCommandTable }
        };
        return commandTable;
    }

    // Stores informations about a deleted character
    struct DeletedInfo
    {
        uint32      lowGuid;                            ///< the low GUID from the character
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
        PreparedStatement* stmt;
        if (!searchString.empty())
        {
            // search by GUID
            if (isNumeric(searchString.c_str()))
            {
                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_DEL_INFO_BY_GUID);
                stmt->setUInt32(0, uint32(atoi(searchString.c_str())));
                result = CharacterDatabase.Query(stmt);
            }
            // search by name
            else
            {
                if (!normalizePlayerName(searchString))
                    return false;

                stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_DEL_INFO_BY_NAME);
                stmt->setString(0, searchString);
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

                info.lowGuid    = fields[0].GetUInt32();
                info.name       = fields[1].GetString();
                info.accountId  = fields[2].GetUInt32();

                // account name will be empty for nonexisting account
                AccountMgr::GetName(info.accountId, info.accountName);
                info.deleteDate = time_t(fields[3].GetUInt32());
                foundList.push_back(info);
            }
            while (result->NextRow());
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
            std::string dateStr = TimeToTimestampStr(itr->deleteDate);

            if (!handler->GetSession())
                handler->PSendSysMessage(LANG_CHARACTER_DELETED_LIST_LINE_CONSOLE,
                    itr->lowGuid, itr->name.c_str(), itr->accountName.empty() ? "<Not existing>" : itr->accountName.c_str(),
                    itr->accountId, dateStr.c_str());
            else
                handler->PSendSysMessage(LANG_CHARACTER_DELETED_LIST_LINE_CHAT,
                    itr->lowGuid, itr->name.c_str(), itr->accountName.empty() ? "<Not existing>" : itr->accountName.c_str(),
                    itr->accountId, dateStr.c_str());
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
            handler->PSendSysMessage(LANG_CHARACTER_DELETED_SKIP_ACCOUNT, delInfo.name.c_str(), delInfo.lowGuid, delInfo.accountId);
            return;
        }

        // check character count
        uint32 charcount = AccountMgr::GetCharactersCount(delInfo.accountId);
        if (charcount >= 10)
        {
            handler->PSendSysMessage(LANG_CHARACTER_DELETED_SKIP_FULL, delInfo.name.c_str(), delInfo.lowGuid, delInfo.accountId);
            return;
        }

        if (sObjectMgr->GetPlayerGUIDByName(delInfo.name))
        {
            handler->PSendSysMessage(LANG_CHARACTER_DELETED_SKIP_NAME, delInfo.name.c_str(), delInfo.lowGuid, delInfo.accountId);
            return;
        }

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_RESTORE_DELETE_INFO);
        stmt->setString(0, delInfo.name);
        stmt->setUInt32(1, delInfo.accountId);
        stmt->setUInt32(2, delInfo.lowGuid);
        CharacterDatabase.Execute(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHARACTER_NAME_DATA);
        stmt->setUInt32(0, delInfo.lowGuid);
        if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
            sWorld->AddGlobalPlayerData(delInfo.lowGuid, delInfo.accountId, delInfo.name, (*result)[2].GetUInt8(), (*result)[0].GetUInt8(), (*result)[1].GetUInt8(), (*result)[3].GetUInt8(), 0, 0);

    }

    static void HandleCharacterLevel(Player* player, uint64 playerGuid, uint32 oldLevel, uint32 newLevel, ChatHandler* handler)
    {
        if (player)
        {
            player->GiveLevel(newLevel);
            player->InitTalentForLevel();
            player->SetUInt32Value(PLAYER_XP, 0);

            if (handler->needReportToTarget(player))
            {
                if (oldLevel == newLevel)
                    ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOURS_LEVEL_PROGRESS_RESET, handler->GetNameLink().c_str());
                else if (oldLevel < newLevel)
                    ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOURS_LEVEL_UP, handler->GetNameLink().c_str(), newLevel);
                else                                                // if (oldlevel > newlevel)
                    ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOURS_LEVEL_DOWN, handler->GetNameLink().c_str(), newLevel);
            }
        }
        else
        {
            // Update level and reset XP, everything else will be updated at login
            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_LEVEL);
            stmt->setUInt8(0, uint8(newLevel));
            stmt->setUInt32(1, GUID_LOPART(playerGuid));
            CharacterDatabase.Execute(stmt);

            // xinef: update global storage
            sWorld->UpdateGlobalPlayerData(GUID_LOPART(playerGuid), PLAYER_UPDATE_DATA_LEVEL, "", newLevel);
        }
    }

    static bool HandleCharacterTitlesCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

        if (!target)
            return false;

        LocaleConstant loc = handler->GetSessionDbcLocale();
        char const* targetName = target->GetName().c_str();
        char const* knownStr = handler->GetAcoreString(LANG_KNOWN);

        // Search in CharTitles.dbc
        for (uint32 id = 0; id < sCharTitlesStore.GetNumRows(); id++)
        {
            CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(id);

            if (titleInfo && target->HasTitle(titleInfo))
            {
                std::string name = target->getGender() == GENDER_MALE ? titleInfo->nameMale[loc] : titleInfo->nameFemale[loc];
                if (name.empty())
                    continue;

                char const* activeStr = target && target->GetUInt32Value(PLAYER_CHOSEN_TITLE) == titleInfo->bit_index
                ? handler->GetAcoreString(LANG_ACTIVE)
                : "";

                char titleNameStr[80];
                snprintf(titleNameStr, 80, name.c_str(), targetName);

                // send title in "id (idx:idx) - [namedlink locale]" format
                if (handler->GetSession())
                    handler->PSendSysMessage(LANG_TITLE_LIST_CHAT, id, titleInfo->bit_index, id, titleNameStr, localeNames[loc], knownStr, activeStr);
                else
                    handler->PSendSysMessage(LANG_TITLE_LIST_CONSOLE, id, titleInfo->bit_index, name.c_str(), localeNames[loc], knownStr, activeStr);
            }
        }

        return true;
    }

    //rename characters
    static bool HandleCharacterRenameCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        if (target)
        {
            // check online security
            if (handler->HasLowerSecurity(target, 0))
                return false;

            handler->PSendSysMessage(LANG_RENAME_PLAYER, handler->GetNameLink(target).c_str());
            target->SetAtLoginFlag(AT_LOGIN_RENAME);
        }
        else
        {
            // check offline security
            if (handler->HasLowerSecurity(nullptr, targetGuid))
                return false;

            std::string oldNameLink = handler->playerLink(targetName);
            handler->PSendSysMessage(LANG_RENAME_PLAYER_GUID, oldNameLink.c_str(), GUID_LOPART(targetGuid));

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->setUInt16(0, uint16(AT_LOGIN_RENAME));
            stmt->setUInt32(1, GUID_LOPART(targetGuid));
            CharacterDatabase.Execute(stmt);
        }

        return true;
    }

    static bool HandleCharacterLevelCommand(ChatHandler* handler, char const* args)
    {
        char* nameStr;
        char* levelStr;
        handler->extractOptFirstArg((char*)args, &nameStr, &levelStr);
        if (!levelStr)
            return false;

        // exception opt second arg: .character level $name
        if (isalpha(levelStr[0]))
        {
            nameStr = levelStr;
            levelStr = nullptr;                                    // current level will used
        }

        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget(nameStr, &target, &targetGuid, &targetName))
            return false;

        int32 oldlevel = target ? target->getLevel() : Player::GetLevelFromStorage(targetGuid);
        int32 newlevel = levelStr ? atoi(levelStr) : oldlevel;

        if (newlevel < 1)
            return false;                                       // invalid level

        if (newlevel > DEFAULT_MAX_LEVEL)                         // hardcoded maximum level
            newlevel = DEFAULT_MAX_LEVEL;

        HandleCharacterLevel(target, targetGuid, oldlevel, newlevel, handler);
        if (!handler->GetSession() || handler->GetSession()->GetPlayer() != target)      // including player == nullptr
        {
            std::string nameLink = handler->playerLink(targetName);
            handler->PSendSysMessage(LANG_YOU_CHANGE_LVL, nameLink.c_str(), newlevel);
        }

        return true;
    }

    // customize characters
    static bool HandleCharacterCustomizeCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
        stmt->setUInt16(0, uint16(AT_LOGIN_CUSTOMIZE));
        if (target)
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER, handler->GetNameLink(target).c_str());
            target->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
            stmt->setUInt32(1, target->GetGUIDLow());
        }
        else
        {
            std::string oldNameLink = handler->playerLink(targetName);
            stmt->setUInt32(1, GUID_LOPART(targetGuid));
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER_GUID, oldNameLink.c_str(), GUID_LOPART(targetGuid));
        }
        CharacterDatabase.Execute(stmt);

        return true;
    }

    static bool HandleCharacterChangeFactionCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;

        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
        stmt->setUInt16(0, uint16(AT_LOGIN_CHANGE_FACTION));
        if (target)
        {
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER, handler->GetNameLink(target).c_str());
            target->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
            stmt->setUInt32(1, target->GetGUIDLow());
        }
        else
        {
            std::string oldNameLink = handler->playerLink(targetName);
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER_GUID, oldNameLink.c_str(), GUID_LOPART(targetGuid));
            stmt->setUInt32(1, GUID_LOPART(targetGuid));
        }
        CharacterDatabase.Execute(stmt);

        return true;
    }

    static bool HandleCharacterChangeRaceCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
        stmt->setUInt16(0, uint16(AT_LOGIN_CHANGE_RACE));
        if (target)
        {
            // TODO : add text into database
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER, handler->GetNameLink(target).c_str());
            target->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
            stmt->setUInt32(1, target->GetGUIDLow());
        }
        else
        {
            std::string oldNameLink = handler->playerLink(targetName);
            // TODO : add text into database
            handler->PSendSysMessage(LANG_CUSTOMIZE_PLAYER_GUID, oldNameLink.c_str(), GUID_LOPART(targetGuid));
            stmt->setUInt32(1, GUID_LOPART(targetGuid));
        }
        CharacterDatabase.Execute(stmt);

        return true;
    }

    static bool HandleCharacterReputationCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

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

    static bool HandleCharacterDeletedListCommand(ChatHandler* handler, char const* args)
    {
        DeletedInfoList foundList;
        if (!GetDeletedCharacterInfoList(foundList, args))
            return false;

        // if no characters have been found, output a warning
        if (foundList.empty())
        {
            handler->SendSysMessage(LANG_CHARACTER_DELETED_LIST_EMPTY);
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
    static bool HandleCharacterDeletedRestoreCommand(ChatHandler* handler, char const* args)
    {
        // It is required to submit at least one argument
        if (!*args)
            return false;

        std::string searchString;
        std::string newCharName;
        uint32 newAccount = 0;

        // GCC by some strange reason fail build code without temporary variable
        std::istringstream params(args);
        params >> searchString >> newCharName >> newAccount;

        DeletedInfoList foundList;
        if (!GetDeletedCharacterInfoList(foundList, searchString))
            return false;

        if (foundList.empty())
        {
            handler->SendSysMessage(LANG_CHARACTER_DELETED_LIST_EMPTY);
            return false;
        }

        handler->SendSysMessage(LANG_CHARACTER_DELETED_RESTORE);
        HandleCharacterDeletedListHelper(foundList, handler);

        if (newCharName.empty())
        {
            // Drop nonexisting account cases
            for (DeletedInfoList::iterator itr = foundList.begin(); itr != foundList.end(); ++itr)
                HandleCharacterDeletedRestoreHelper(*itr, handler);
        }
        else if (foundList.size() == 1 && normalizePlayerName(newCharName))
        {
            DeletedInfo delInfo = foundList.front();

            // update name
            delInfo.name = newCharName;

            // if new account provided update deleted info
            if (newAccount && newAccount != delInfo.accountId)
            {
                delInfo.accountId = newAccount;
                AccountMgr::GetName(newAccount, delInfo.accountName);
            }

            HandleCharacterDeletedRestoreHelper(delInfo, handler);
        }
        else
            handler->SendSysMessage(LANG_CHARACTER_DELETED_ERR_RENAME);

        return true;
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
    static bool HandleCharacterDeletedDeleteCommand(ChatHandler* handler, char const* args)
    {
        // It is required to submit at least one argument
        if (!*args)
            return false;

        DeletedInfoList foundList;
        if (!GetDeletedCharacterInfoList(foundList, args))
            return false;

        if (foundList.empty())
        {
            handler->SendSysMessage(LANG_CHARACTER_DELETED_LIST_EMPTY);
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
    static bool HandleCharacterDeletedPurgeCommand(ChatHandler* /*handler*/, char const* args)
    {
        int32 keepDays = sWorld->getIntConfig(CONFIG_CHARDELETE_KEEP_DAYS);

        char* daysStr = strtok((char*)args, " ");
        if (daysStr)
        {
            if (!isNumeric(daysStr))
                return false;

            keepDays = atoi(daysStr);
            if (keepDays < 0)
                return false;
        }
        // config option value 0 -> disabled and can't be used
        else if (keepDays <= 0)
            return false;

        Player::DeleteOldCharacters(uint32(keepDays));

        return true;
    }

    /**
     * Handles the '.character erase' command which completly delete a character from the DB
     *
     * @see Player::DeleteFromDB
     *
     * @param args the search string which either contains a player GUID or a part of the character-name
     */
    static bool HandleCharacterEraseCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* characterName_str = strtok((char*)args, " ");
        if (!characterName_str)
            return false;

        std::string characterName = characterName_str;
        if (!normalizePlayerName(characterName))
            return false;

        uint32 characterGuid;
        uint32 accountId;

        Player* player = ObjectAccessor::FindPlayerByName(characterName);
        if (player)
        {
            characterGuid = player->GetGUID();
            accountId = player->GetSession()->GetAccountId();
            player->GetSession()->KickPlayer("HandleCharacterEraseCommand");
        }
        else
        {
            characterGuid = sObjectMgr->GetPlayerGUIDByName(characterName);
            if (!characterGuid)
            {
                handler->PSendSysMessage(LANG_NO_PLAYER, characterName.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
            accountId = sObjectMgr->GetPlayerAccountIdByGUID(characterGuid);
        }

        std::string accountName;
        AccountMgr::GetName(accountId, accountName);

        Player::DeleteFromDB(characterGuid, accountId, true, true);
        handler->PSendSysMessage(LANG_CHARACTER_DELETED, characterName.c_str(), characterGuid, accountName.c_str(), accountId);

        return true;
    }

    static bool HandleLevelUpCommand(ChatHandler* handler, char const* args)
    {
        char* nameStr;
        char* levelStr;
        handler->extractOptFirstArg((char*)args, &nameStr, &levelStr);

        // exception opt second arg: .character level $name
        if (levelStr && isalpha(levelStr[0]))
        {
            nameStr = levelStr;
            levelStr = nullptr;                                    // current level will used
        }

        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget(nameStr, &target, &targetGuid, &targetName))
            return false;

        int32 oldlevel = target ? target->getLevel() : Player::GetLevelFromStorage(targetGuid);
        int32 addlevel = levelStr ? atoi(levelStr) : 1;
        int32 newlevel = oldlevel + addlevel;

        if (newlevel < 1)
            newlevel = 1;

        if (newlevel > STRONG_MAX_LEVEL)                         // hardcoded maximum level
            newlevel = STRONG_MAX_LEVEL;

        HandleCharacterLevel(target, targetGuid, oldlevel, newlevel, handler);

        if (!handler->GetSession() || handler->GetSession()->GetPlayer() != target)      // including chr == nullptr
        {
            std::string nameLink = handler->playerLink(targetName);
            handler->PSendSysMessage(LANG_YOU_CHANGE_LVL, nameLink.c_str(), newlevel);
        }

        return true;
    }

    static bool HandlePDumpLoadCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* fileStr = strtok((char*)args, " ");
        if (!fileStr)
            return false;

        char* accountStr = strtok(nullptr, " ");
        if (!accountStr)
            return false;

        std::string accountName = accountStr;
        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 accountId = AccountMgr::GetId(accountName);
        if (!accountId)
        {
            accountId = atoi(accountStr);                             // use original string
            if (!accountId)
            {
                handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        if (!AccountMgr::GetName(accountId, accountName))
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        char* guidStr = nullptr;
        char* nameStr = strtok(nullptr, " ");

        std::string name;
        if (nameStr)
        {
            name = nameStr;
            // normalize the name if specified and check if it exists
            if (!normalizePlayerName(name))
            {
                handler->PSendSysMessage(LANG_INVALID_CHARACTER_NAME);
                handler->SetSentErrorMessage(true);
                return false;
            }

            if (ObjectMgr::CheckPlayerName(name, true) != CHAR_NAME_SUCCESS)
            {
                handler->PSendSysMessage(LANG_INVALID_CHARACTER_NAME);
                handler->SetSentErrorMessage(true);
                return false;
            }

            guidStr = strtok(nullptr, " ");
        }

        uint32 guid = 0;

        if (guidStr)
        {
            guid = uint32(atoi(guidStr));
            if (!guid)
            {
                handler->PSendSysMessage(LANG_INVALID_CHARACTER_GUID);
                handler->SetSentErrorMessage(true);
                return false;
            }

            if (sObjectMgr->GetPlayerAccountIdByGUID(guid))
            {
                handler->PSendSysMessage(LANG_CHARACTER_GUID_IN_USE, guid);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        switch (PlayerDumpReader().LoadDump(fileStr, accountId, name, guid))
        {
            case DUMP_SUCCESS:
                handler->PSendSysMessage(LANG_COMMAND_IMPORT_SUCCESS);
                break;
            case DUMP_FILE_OPEN_ERROR:
                handler->PSendSysMessage(LANG_FILE_OPEN_FAIL, fileStr);
                handler->SetSentErrorMessage(true);
                return false;
            case DUMP_FILE_BROKEN:
                handler->PSendSysMessage(LANG_DUMP_BROKEN, fileStr);
                handler->SetSentErrorMessage(true);
                return false;
            case DUMP_TOO_MANY_CHARS:
                handler->PSendSysMessage(LANG_ACCOUNT_CHARACTER_LIST_FULL, accountName.c_str(), accountId);
                handler->SetSentErrorMessage(true);
                return false;
            default:
                handler->PSendSysMessage(LANG_COMMAND_IMPORT_FAILED);
                handler->SetSentErrorMessage(true);
                return false;
        }

        return true;
    }

    static bool HandlePDumpWriteCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* fileStr = strtok((char*)args, " ");
        char* playerStr = strtok(nullptr, " ");

        if (!fileStr && !playerStr)
        {
            QueryResult result = CharacterDatabase.PQuery("SELECT guid FROM characters");
            if (!result)
                return true;
            do{
                uint64 _guid = result->Fetch()[0].GetUInt64();
                char buff[20];
                sprintf(buff,"%u", (uint32)_guid);
                switch(PlayerDumpWriter().WriteDump(buff, uint32(_guid)))
                {
                    case DUMP_SUCCESS:
                        handler->PSendSysMessage(LANG_COMMAND_EXPORT_SUCCESS);
                        break;
                    case DUMP_FILE_OPEN_ERROR:
                        handler->PSendSysMessage(LANG_FILE_OPEN_FAIL, buff);
                        handler->SetSentErrorMessage(true);
                        return false;
                    case DUMP_CHARACTER_DELETED:
                        handler->PSendSysMessage(LANG_COMMAND_EXPORT_DELETED_CHAR);
                        handler->SetSentErrorMessage(true);
                        return false;
                    default:
                        handler->PSendSysMessage(LANG_COMMAND_EXPORT_FAILED);
                        handler->SetSentErrorMessage(true);
                        return false;
                }
            }while(result->NextRow());
        }

        if (!fileStr || !playerStr)
            return false;

        uint64 guid;
        // character name can't start from number
        if (isNumeric(playerStr))
            guid = MAKE_NEW_GUID(atoi(playerStr), 0, HIGHGUID_PLAYER);
        else
        {
            std::string name = handler->extractPlayerNameFromLink(playerStr);
            if (name.empty())
            {
                handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
                handler->SetSentErrorMessage(true);
                return false;
            }

            guid = sObjectMgr->GetPlayerGUIDByName(name);
        }

        if (!sObjectMgr->GetPlayerAccountIdByGUID(guid))
        {
            handler->PSendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        switch (PlayerDumpWriter().WriteDump(fileStr, uint32(guid)))
        {
            case DUMP_SUCCESS:
                handler->PSendSysMessage(LANG_COMMAND_EXPORT_SUCCESS);
                break;
            case DUMP_FILE_OPEN_ERROR:
                handler->PSendSysMessage(LANG_FILE_OPEN_FAIL, fileStr);
                handler->SetSentErrorMessage(true);
                return false;
            case DUMP_CHARACTER_DELETED:
                handler->PSendSysMessage(LANG_COMMAND_EXPORT_DELETED_CHAR);
                handler->SetSentErrorMessage(true);
                return false;
            default:
                handler->PSendSysMessage(LANG_COMMAND_EXPORT_FAILED);
                handler->SetSentErrorMessage(true);
                return false;
        }

        return true;
    }

    static bool HandleCharacterCheckBankCommand(ChatHandler* handler, char const* /*args*/)
    {
        handler->GetSession()->SendShowBank(handler->GetSession()->GetPlayer()->GetGUID());
        return true;
    }

    static bool HandleCharacterCheckBagCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* Slot = strtok((char*)args, " ");

        if (!Slot)
            return false;

        Player* player = handler->getSelectedPlayerOrSelf();

        if (!player)
            return false;

        uint8 Counter = 0;
        uint8 BagSlot = atoi(Slot);

        switch (BagSlot)
        {
            case 2: BagSlot = 19; break;
            case 3: BagSlot = 20; break;
            case 4: BagSlot = 21; break;
            case 5: BagSlot = 22; break;
            default: BagSlot = 1; break;
        }

        handler->PSendSysMessage("--------------------------------------");

        if (BagSlot == 1)
        {
            for (uint32 i = 23; i < 39; i++)
            {
                if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                {
                    Counter++;
                    std::ostringstream ItemString;
                    ItemString << std::hex << ItemQualityColors[item->GetTemplate()->Quality];

                    handler->PSendSysMessage("%u - |c%s|Hitem:%u:0:0:0:0:0:0:0:0:0|h[%s]|h|r - %u", Counter, ItemString.str().c_str(), item->GetEntry(), item->GetTemplate()->Name1.c_str(), item->GetCount());
                }
            }
        }
        else
        {
            if (Bag* bag = player->GetBagByPos(BagSlot))
            {
                for (uint32 i = 0; i < bag->GetBagSize(); i++)
                {
                    if (Item* item = player->GetItemByPos(BagSlot, i))
                    {
                        Counter++;
                        std::ostringstream ItemString;
                        ItemString << std::hex << ItemQualityColors[item->GetTemplate()->Quality];

                        handler->PSendSysMessage("%u - |c%s|Hitem:%u:0:0:0:0:0:0:0:0:0|h[%s]|h|r - %u", Counter, ItemString.str().c_str(), item->GetEntry(), item->GetTemplate()->Name1.c_str(), item->GetCount());
                    }
                }
            }
        }

        handler->PSendSysMessage("--------------------------------------");
        return true;
    }

    static bool HandleCharacterCheckProfessionCommand(ChatHandler* handler, char const*)
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
                        handler->PSendSysMessage("%u - Alchemy - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_BLACKSMITHING:
                        handler->PSendSysMessage("%u - Blacksmithing - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_ENCHANTING:
                        handler->PSendSysMessage("%u - Enchanting - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_ENGINEERING:
                        handler->PSendSysMessage("%u - Engineering - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_INSCRIPTION:
                        handler->PSendSysMessage("%u - Inscription - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_JEWELCRAFTING:
                        handler->PSendSysMessage("%u - Jewelcrafting - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_LEATHERWORKING:
                        handler->PSendSysMessage("%u - Leatherworking - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_TAILORING:
                        handler->PSendSysMessage("%u - Tailoring - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_SKINNING:
                        handler->PSendSysMessage("%u - Skinning - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_HERBALISM:
                        handler->PSendSysMessage("%u - Herbalism - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_MINING:
                        handler->PSendSysMessage("%u - Mining - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_COOKING:
                        handler->PSendSysMessage("%u - Cooking - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    case SKILL_FIRST_AID:
                        handler->PSendSysMessage("%u - First Aid - %u", Counter, player->GetSkillValue(SkillID));
                        break;
                    default:
                        break;
                }
            }
        }

        handler->PSendSysMessage("--------------------------------------");
        return true;
    }
};

void AddSC_character_commandscript()
{
    new character_commandscript();
}
