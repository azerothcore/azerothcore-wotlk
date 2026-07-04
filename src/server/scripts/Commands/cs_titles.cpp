/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Chat.h"
#include "CommandScript.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Player.h"
#include "RBAC.h"
#include "StringConvert.h"
#include "Tokenize.h"

#include <array>
#include <sstream>

using namespace Acore::ChatCommands;

class titles_commandscript : public CommandScript
{
public:
    titles_commandscript() : CommandScript("titles_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable titlesSetCommandTable =
        {
            { "mask", HandleTitlesSetMaskCommand, rbac::RBAC_PERM_COMMAND_TITLES_SET_MASK, Console::Yes },
        };
        static ChatCommandTable titlesCommandTable =
        {
            { "add",     HandleTitlesAddCommand,     rbac::RBAC_PERM_COMMAND_TITLES_ADD,     Console::Yes },
            { "current", HandleTitlesCurrentCommand, rbac::RBAC_PERM_COMMAND_TITLES_CURRENT, Console::Yes },
            { "remove",  HandleTitlesRemoveCommand,  rbac::RBAC_PERM_COMMAND_TITLES_REMOVE,  Console::Yes },
            { "set",     titlesSetCommandTable },
        };
        static ChatCommandTable commandTable =
        {
            { "titles", titlesCommandTable },
        };
        return commandTable;
    }

    static bool SetTitleBitInDB(ObjectGuid guid, CharTitlesEntry const* title, bool lost)
    {
        QueryResult result = CharacterDatabase.Query("SELECT knownTitles FROM characters WHERE guid = {}", guid.GetCounter());
        if (!result)
            return false;

        std::string knownTitlesStr = result->Fetch()[0].Get<std::string>();
        std::vector<std::string_view> tokens = Acore::Tokenize(knownTitlesStr, ' ', false);
        if (tokens.size() != KNOWN_TITLES_SIZE * 2)
            return false;

        std::array<uint32, KNOWN_TITLES_SIZE * 2> knownTitles{};
        for (uint32 i = 0; i < KNOWN_TITLES_SIZE * 2; ++i)
        {
            Optional<uint32> val = Acore::StringTo<uint32>(tokens[i]);
            if (!val)
                return false;
            knownTitles[i] = *val;
        }

        uint32 fieldIndexOffset = title->bit_index / 32;
        uint32 flag = 1 << (title->bit_index % 32);
        if (fieldIndexOffset >= KNOWN_TITLES_SIZE * 2)
            return false;

        if (lost)
            knownTitles[fieldIndexOffset] &= ~flag;
        else
            knownTitles[fieldIndexOffset] |= flag;

        std::ostringstream ss;
        for (uint32 val : knownTitles)
            ss << val << ' ';

        CharacterDatabase.Execute("UPDATE characters SET knownTitles = '{}' WHERE guid = {}", ss.str(), guid.GetCounter());
        return true;
    }

    static void SetChosenTitleInDB(ObjectGuid guid, uint32 titleBitIndex)
    {
        CharacterDatabase.Execute("UPDATE characters SET chosenTitle = {} WHERE guid = {}", titleBitIndex, guid.GetCounter());
    }

    static bool ApplyTitleChange(ChatHandler* handler, Variant<Hyperlink<title>, uint16> titleId, Optional<PlayerIdentifier> playerName, bool isAdd, bool isCurrent)
    {
        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        if (!titleInfo)
        {
            handler->SendErrorMessage(LANG_INVALID_TITLE_ID, uint32(titleId));
            return false;
        }

        if (playerName)
        {
            ObjectGuid targetGuid = playerName->GetGUID();
            std::string targetName = playerName->GetName();
            Player* target = playerName->IsConnected() ? playerName->GetConnectedPlayer() : nullptr;

            if (handler->HasLowerSecurity(target, targetGuid))
                return false;

            if (target)
            {
                if (isCurrent || isAdd)
                    target->SetTitle(titleInfo);
                else
                    target->SetTitle(titleInfo, true);

                if (isCurrent)
                    target->SetUInt32Value(PLAYER_CHOSEN_TITLE, titleInfo->bit_index);
                else if (!isAdd && !target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
                {
                    target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
                    handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, handler->playerLink(targetName));
                }
            }
            else
            {
                if (isCurrent || isAdd)
                {
                    if (!SetTitleBitInDB(targetGuid, titleInfo, false))
                    {
                        handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
                        return false;
                    }
                }
                else
                {
                    if (!SetTitleBitInDB(targetGuid, titleInfo, true))
                    {
                        handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
                        return false;
                    }

                    // Check if the removed title was the active title
                    QueryResult result = CharacterDatabase.Query("SELECT chosenTitle FROM characters WHERE guid = {}", targetGuid.GetCounter());
                    if (result)
                    {
                        uint32 chosenTitle = result->Fetch()[0].Get<uint32>();
                        if (chosenTitle == titleInfo->bit_index)
                        {
                            CharacterDatabase.Execute("UPDATE characters SET chosenTitle = 0 WHERE guid = {}", targetGuid.GetCounter());
                            handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, handler->playerLink(targetName));
                        }
                    }
                }

                if (isCurrent)
                    SetChosenTitleInDB(targetGuid, titleInfo->bit_index);
            }

            uint8 gender = GENDER_MALE;
            if (CharacterCacheEntry const* cacheEntry = sCharacterCache->GetCharacterCacheByGuid(targetGuid))
                gender = cacheEntry->Sex;

            std::string tNameLink = handler->playerLink(targetName);
            std::string titleNameStr = Acore::StringFormat(
                gender == GENDER_MALE ? titleInfo->nameMale[handler->GetSessionDbcLocale()] : titleInfo->nameFemale[handler->GetSessionDbcLocale()],
                targetName);

            if (isCurrent)
                handler->PSendSysMessage(LANG_TITLE_CURRENT_RES, uint32(titleId), titleNameStr, tNameLink);
            else if (isAdd)
                handler->PSendSysMessage(LANG_TITLE_ADD_RES, uint32(titleId), titleNameStr, tNameLink);
            else
                handler->PSendSysMessage(LANG_TITLE_REMOVE_RES, uint32(titleId), titleNameStr, tNameLink);

            return true;
        }

        return false;
    }

    static bool HandleTitlesCurrentCommand(ChatHandler* handler, Variant<Hyperlink<title>, uint16> titleId, Optional<PlayerIdentifier> playerName)
    {
        if (playerName)
        {
            return ApplyTitleChange(handler, titleId, playerName, true, true);
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        if (!titleInfo)
        {
            handler->SendErrorMessage(LANG_INVALID_TITLE_ID, uint32(titleId));
            return false;
        }

        std::string tNameLink = handler->GetNameLink(target);
        std::string titleNameStr = Acore::StringFormat(target->getGender() == GENDER_MALE ? titleInfo->nameMale[handler->GetSessionDbcLocale()] : titleInfo->nameFemale[handler->GetSessionDbcLocale()], target->GetName());

        target->SetTitle(titleInfo);
        target->SetUInt32Value(PLAYER_CHOSEN_TITLE, titleInfo->bit_index);

        handler->PSendSysMessage(LANG_TITLE_CURRENT_RES, uint32(titleId), titleNameStr, tNameLink);

        return true;
    }

    static bool HandleTitlesAddCommand(ChatHandler* handler, Variant<Hyperlink<title>, uint16> titleId, Optional<PlayerIdentifier> playerName)
    {
        if (playerName)
        {
            return ApplyTitleChange(handler, titleId, playerName, true, false);
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        if (!titleInfo)
        {
            handler->SendErrorMessage(LANG_INVALID_TITLE_ID, uint32(titleId));
            return false;
        }

        std::string tNameLink = handler->GetNameLink(target);
        std::string titleNameStr = Acore::StringFormat(target->getGender() == GENDER_MALE ? titleInfo->nameMale[handler->GetSessionDbcLocale()] : titleInfo->nameFemale[handler->GetSessionDbcLocale()], target->GetName());

        target->SetTitle(titleInfo);
        handler->PSendSysMessage(LANG_TITLE_ADD_RES, uint32(titleId), titleNameStr, tNameLink);

        return true;
    }

    static bool HandleTitlesRemoveCommand(ChatHandler* handler, Variant<Hyperlink<title>, uint16> titleId, Optional<PlayerIdentifier> playerName)
    {
        if (playerName)
        {
            return ApplyTitleChange(handler, titleId, playerName, false, false);
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        if (!titleInfo)
        {
            handler->SendErrorMessage(LANG_INVALID_TITLE_ID, uint32(titleId));
            return false;
        }

        target->SetTitle(titleInfo, true);

        std::string tNameLink = handler->GetNameLink(target);
        std::string titleNameStr = Acore::StringFormat(target->getGender() == GENDER_MALE ? titleInfo->nameMale[handler->GetSessionDbcLocale()] : titleInfo->nameFemale[handler->GetSessionDbcLocale()], target->GetName());

        handler->PSendSysMessage(LANG_TITLE_REMOVE_RES, uint32(titleId), titleNameStr, tNameLink);

        if (!target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
        {
            target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, tNameLink);
        }

        return true;
    }

    //Edit Player KnownTitles
    static bool HandleTitlesSetMaskCommand(ChatHandler* handler, uint64 mask, Optional<PlayerIdentifier> playerName)
    {
        // Filter out non-existing titles
        uint64 titles2 = mask;
        for (uint32 i = 1; i < sCharTitlesStore.GetNumRows(); ++i)
            if (CharTitlesEntry const* tEntry = sCharTitlesStore.LookupEntry(i))
                titles2 &= ~(uint64(1) << tEntry->bit_index);
        mask &= ~titles2;                                     // remove non-existing titles

        if (playerName)
        {
            ObjectGuid targetGuid = playerName->GetGUID();
            std::string targetName = playerName->GetName();
            Player* target = playerName->IsConnected() ? playerName->GetConnectedPlayer() : nullptr;

            if (handler->HasLowerSecurity(target, targetGuid))
                return false;

            if (target)
            {
                target->SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, mask);
                handler->SendSysMessage(LANG_DONE);

                if (!target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
                {
                    target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
                    handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, handler->playerLink(targetName));
                }
            }
            else
            {
                // Read current knownTitles and chosenTitle to preserve bits 64-191
                QueryResult result = CharacterDatabase.Query("SELECT knownTitles, chosenTitle FROM characters WHERE guid = {}", targetGuid.GetCounter());
                if (!result)
                {
                    handler->SendErrorMessage(LANG_PLAYER_NOT_FOUND);
                    return false;
                }

                Field* fields = result->Fetch();
                std::string knownTitlesStr = fields[0].Get<std::string>();
                uint32 chosenTitle = fields[1].Get<uint32>();
                std::vector<std::string_view> tokens = Acore::Tokenize(knownTitlesStr, ' ', false);
                std::array<uint32, KNOWN_TITLES_SIZE * 2> knownTitles{};
                for (uint32 i = 0; i < tokens.size() && i < KNOWN_TITLES_SIZE * 2; ++i)
                {
                    if (Optional<uint32> val = Acore::StringTo<uint32>(tokens[i]))
                        knownTitles[i] = *val;
                }

                // Update only the first 64 bits (PLAYER__FIELD_KNOWN_TITLES)
                knownTitles[0] = static_cast<uint32>(mask);
                knownTitles[1] = static_cast<uint32>(mask >> 32);

                std::ostringstream ss;
                for (uint32 val : knownTitles)
                    ss << val << ' ';

                CharacterDatabase.Execute("UPDATE characters SET knownTitles = '{}' WHERE guid = {}", ss.str(), targetGuid.GetCounter());

                handler->SendSysMessage(LANG_DONE);

                if (!(mask & (uint64(1) << chosenTitle)))
                {
                    CharacterDatabase.Execute("UPDATE characters SET chosenTitle = 0 WHERE guid = {}", targetGuid.GetCounter());
                    handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, handler->playerLink(targetName));
                }
            }

            return true;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        target->SetUInt64Value(PLAYER__FIELD_KNOWN_TITLES, mask);
        handler->SendSysMessage(LANG_DONE);

        if (!target->HasTitle(target->GetInt32Value(PLAYER_CHOSEN_TITLE)))
        {
            target->SetUInt32Value(PLAYER_CHOSEN_TITLE, 0);
            handler->PSendSysMessage(LANG_CURRENT_TITLE_RESET, handler->GetNameLink(target));
        }

        return true;
    }
};

void AddSC_titles_commandscript()
{
    new titles_commandscript();
}
