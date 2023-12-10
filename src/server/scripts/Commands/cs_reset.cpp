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
Name: reset_commandscript
%Complete: 100
Comment: All reset related commands
Category: commandscripts
EndScriptData */

#include "AchievementMgr.h"
#include "Chat.h"
#include "CommandScript.h"
#include "Language.h"
#include "ObjectAccessor.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;

class reset_commandscript : public CommandScript
{
public:
    reset_commandscript() : CommandScript("reset_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable resetCommandTable =
        {
            { "achievements",   HandleResetAchievementsCommand, SEC_CONSOLE,       Console::Yes },
            { "honor",          HandleResetHonorCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "level",          HandleResetLevelCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "spells",         HandleResetSpellsCommand,       SEC_ADMINISTRATOR, Console::Yes },
            { "stats",          HandleResetStatsCommand,        SEC_ADMINISTRATOR, Console::Yes },
            { "talents",        HandleResetTalentsCommand,      SEC_ADMINISTRATOR, Console::Yes },
            { "all",            HandleResetAllCommand,          SEC_CONSOLE,       Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "reset", resetCommandTable }
        };
        return commandTable;
    }

    static bool HandleResetAchievementsCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (playerTarget)
            playerTarget->ResetAchievements();
        else
            AchievementMgr::DeleteFromDB(target->GetGUID().GetCounter());

        return true;
    }

    static bool HandleResetHonorCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        playerTarget->SetHonorPoints(0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_KILLS, 0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
        playerTarget->SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);
        playerTarget->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL);

        return true;
    }

    static bool HandleResetStatsOrLevelHelper(Player* player)
    {
        ChrClassesEntry const* classEntry = sChrClassesStore.LookupEntry(player->getClass());
        if (!classEntry)
        {
            LOG_ERROR("dbc", "Class {} not found in DBC (Wrong DBC files?)", player->getClass());
            return false;
        }

        uint8 powerType = classEntry->powerType;

        // reset m_form if no aura
        if (!player->HasAuraType(SPELL_AURA_MOD_SHAPESHIFT))
            player->SetShapeshiftForm(FORM_NONE);

        player->SetFactionForRace(player->getRace());

        player->SetUInt32Value(UNIT_FIELD_BYTES_0, ((player->getRace()) | (player->getClass() << 8) | (player->getGender() << 16) | (powerType << 24)));

        // reset only if player not in some form;
        if (player->GetShapeshiftForm() == FORM_NONE)
            player->InitDisplayIds();

        player->SetByteValue(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_PVP);

        player->ReplaceAllUnitFlags(UNIT_FLAG_PLAYER_CONTROLLED);

        //-1 is default value
        player->SetUInt32Value(PLAYER_FIELD_WATCHED_FACTION_INDEX, uint32(-1));
        return true;
    }

    static bool HandleResetLevelCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (!HandleResetStatsOrLevelHelper(playerTarget))
            return false;

        uint8 oldLevel = playerTarget->GetLevel();

        // set starting level
        uint32 startLevel = playerTarget->getClass() != CLASS_DEATH_KNIGHT
                            ? sWorld->getIntConfig(CONFIG_START_PLAYER_LEVEL)
                            : sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL);

        playerTarget->_ApplyAllLevelScaleItemMods(false);
        playerTarget->SetLevel(startLevel);
        playerTarget->InitRunes();
        playerTarget->InitStatsForLevel(true);
        playerTarget->InitTaxiNodesForLevel();
        playerTarget->InitGlyphsForLevel();
        playerTarget->InitTalentForLevel();
        playerTarget->SetUInt32Value(PLAYER_XP, 0);

        playerTarget->_ApplyAllLevelScaleItemMods(true);

        // reset level for pet
        if (Pet* pet = playerTarget->GetPet())
            pet->SynchronizeLevelWithOwner();

        sScriptMgr->OnPlayerLevelChanged(playerTarget, oldLevel);

        return true;
    }

    static bool HandleResetSpellsCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (target)
        {
            playerTarget->resetSpells(/* bool myClassOnly */);

            ChatHandler(playerTarget->GetSession()).SendSysMessage(LANG_RESET_SPELLS);
            if (!handler->GetSession() || handler->GetSession()->GetPlayer() != playerTarget)
                handler->PSendSysMessage(LANG_RESET_SPELLS_ONLINE, handler->GetNameLink(playerTarget).c_str());
        }
        else
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_RESET_SPELLS));
            stmt->SetData(1, playerTarget->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);

            handler->PSendSysMessage(LANG_RESET_SPELLS_OFFLINE, target->GetName());
        }

        return true;
    }

    static bool HandleResetStatsCommand(ChatHandler*, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            return false;
        }

        Player* playerTarget = target->GetConnectedPlayer();

        if (!HandleResetStatsOrLevelHelper(playerTarget))
            return false;

        playerTarget->InitRunes();
        playerTarget->InitStatsForLevel(true);
        playerTarget->InitTaxiNodesForLevel();
        playerTarget->InitGlyphsForLevel();
        playerTarget->InitTalentForLevel();

        return true;
    }

    static bool HandleResetTalentsCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        Player* targetPlayer = nullptr;

        if (target)
        {
            targetPlayer = target->GetConnectedPlayer();
        }
        else
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        if (targetPlayer)
        {
            targetPlayer->resetTalents(true);
            targetPlayer->SendTalentsInfoData(false);
            ChatHandler(targetPlayer->GetSession()).SendSysMessage(LANG_RESET_TALENTS);
            if (!handler->GetSession() || handler->GetSession()->GetPlayer() != targetPlayer)
                handler->PSendSysMessage(LANG_RESET_TALENTS_ONLINE, handler->GetNameLink(targetPlayer).c_str());

            Pet* pet = targetPlayer->GetPet();
            Pet::resetTalentsForAllPetsOf(targetPlayer, pet);
            if (pet)
                targetPlayer->SendTalentsInfoData(true);
            return true;
        }
        else
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_RESET_TALENTS | AT_LOGIN_RESET_PET_TALENTS));
            stmt->SetData(1, target->GetGUID().GetCounter());
            CharacterDatabase.Execute(stmt);

            std::string nameLink = handler->playerLink(target->GetName());
            handler->PSendSysMessage(LANG_RESET_TALENTS_OFFLINE, nameLink.c_str());
            return true;
        }
    }

    static bool HandleResetAllCommand(ChatHandler* handler, std::string_view caseName)
    {
        AtLoginFlags atLogin;

        // Command specially created as single command to prevent using short case names
        if (caseName == "spells")
        {
            atLogin = AT_LOGIN_RESET_SPELLS;
            sWorld->SendWorldText(LANG_RESETALL_SPELLS);
            if (!handler->GetSession())
                handler->SendSysMessage(LANG_RESETALL_SPELLS);
        }
        else if (caseName == "talents")
        {
            atLogin = AtLoginFlags(AT_LOGIN_RESET_TALENTS | AT_LOGIN_RESET_PET_TALENTS);
            sWorld->SendWorldText(LANG_RESETALL_TALENTS);
            if (!handler->GetSession())
                handler->SendSysMessage(LANG_RESETALL_TALENTS);
        }
        else
        {
            handler->SendErrorMessage(LANG_RESETALL_UNKNOWN_CASE, caseName);
            return false;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ALL_AT_LOGIN_FLAGS);
        stmt->SetData(0, uint16(atLogin));
        CharacterDatabase.Execute(stmt);

        std::shared_lock<std::shared_mutex> lock(*HashMapHolder<Player>::GetLock());
        HashMapHolder<Player>::MapType const& plist = ObjectAccessor::GetPlayers();
        for (auto itr = plist.begin(); itr != plist.end(); ++itr)
            itr->second->SetAtLoginFlag(atLogin);

        return true;
    }
};

void AddSC_reset_commandscript()
{
    new reset_commandscript();
}
