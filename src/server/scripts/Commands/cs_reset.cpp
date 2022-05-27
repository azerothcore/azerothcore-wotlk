/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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
#include "Language.h"
#include "ObjectAccessor.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class reset_commandscript : public CommandScript
{
public:
    reset_commandscript() : CommandScript("reset_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable resetCommandTable =
        {
            { "achievements",   SEC_CONSOLE,        true,  &HandleResetAchievementsCommand,     "" },
            { "honor",          SEC_ADMINISTRATOR,  true,  &HandleResetHonorCommand,            "" },
            { "level",          SEC_ADMINISTRATOR,  true,  &HandleResetLevelCommand,            "" },
            { "spells",         SEC_ADMINISTRATOR,  true,  &HandleResetSpellsCommand,           "" },
            { "stats",          SEC_ADMINISTRATOR,  true,  &HandleResetStatsCommand,            "" },
            { "talents",        SEC_ADMINISTRATOR,  true,  &HandleResetTalentsCommand,          "" },
            { "all",            SEC_CONSOLE,        true,  &HandleResetAllCommand,              "" }
        };
        static ChatCommandTable commandTable =
        {
            { "reset",          SEC_ADMINISTRATOR,  true, nullptr,                              "", resetCommandTable }
        };
        return commandTable;
    }

    static bool HandleResetAchievementsCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        ObjectGuid targetGuid;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid))
            return false;

        if (target)
            target->ResetAchievements();
        else
            AchievementMgr::DeleteFromDB(targetGuid.GetCounter());

        return true;
    }

    static bool HandleResetHonorCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

        target->SetHonorPoints(0);
        target->SetUInt32Value(PLAYER_FIELD_KILLS, 0);
        target->SetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 0);
        target->SetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, 0);
        target->SetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION, 0);
        target->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL);

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

    static bool HandleResetLevelCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

        if (!HandleResetStatsOrLevelHelper(target))
            return false;

        uint8 oldLevel = target->getLevel();

        // set starting level
        uint32 startLevel = target->getClass() != CLASS_DEATH_KNIGHT
                            ? sWorld->getIntConfig(CONFIG_START_PLAYER_LEVEL)
                            : sWorld->getIntConfig(CONFIG_START_HEROIC_PLAYER_LEVEL);

        target->_ApplyAllLevelScaleItemMods(false);
        target->SetLevel(startLevel);
        target->InitRunes();
        target->InitStatsForLevel(true);
        target->InitTaxiNodesForLevel();
        target->InitGlyphsForLevel();
        target->InitTalentForLevel();
        target->SetUInt32Value(PLAYER_XP, 0);

        target->_ApplyAllLevelScaleItemMods(true);

        // reset level for pet
        if (Pet* pet = target->GetPet())
            pet->SynchronizeLevelWithOwner();

        sScriptMgr->OnPlayerLevelChanged(target, oldLevel);

        return true;
    }

    static bool HandleResetSpellsCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        ObjectGuid targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        if (target)
        {
            target->resetSpells(/* bool myClassOnly */);

            ChatHandler(target->GetSession()).SendSysMessage(LANG_RESET_SPELLS);
            if (!handler->GetSession() || handler->GetSession()->GetPlayer() != target)
                handler->PSendSysMessage(LANG_RESET_SPELLS_ONLINE, handler->GetNameLink(target).c_str());
        }
        else
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_RESET_SPELLS));
            stmt->SetData(1, targetGuid.GetCounter());
            CharacterDatabase.Execute(stmt);

            handler->PSendSysMessage(LANG_RESET_SPELLS_OFFLINE, targetName.c_str());
        }

        return true;
    }

    static bool HandleResetStatsCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

        if (!HandleResetStatsOrLevelHelper(target))
            return false;

        target->InitRunes();
        target->InitStatsForLevel(true);
        target->InitTaxiNodesForLevel();
        target->InitGlyphsForLevel();
        target->InitTalentForLevel();

        return true;
    }

    static bool HandleResetTalentsCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        ObjectGuid targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
        {
            // Try reset talents as Hunter Pet
            Creature* creature = handler->getSelectedCreature();
            if (!*args && creature && creature->IsPet())
            {
                Unit* owner = creature->GetOwner();
                if (owner && owner->GetTypeId() == TYPEID_PLAYER && creature->ToPet()->IsPermanentPetFor(owner->ToPlayer()))
                {
                    creature->ToPet()->resetTalents();
                    owner->ToPlayer()->SendTalentsInfoData(true);

                    ChatHandler(owner->ToPlayer()->GetSession()).SendSysMessage(LANG_RESET_PET_TALENTS);
                    if (!handler->GetSession() || handler->GetSession()->GetPlayer() != owner->ToPlayer())
                        handler->PSendSysMessage(LANG_RESET_PET_TALENTS_ONLINE, handler->GetNameLink(owner->ToPlayer()).c_str());
                }
                return true;
            }

            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (target)
        {
            target->resetTalents(true);
            target->SendTalentsInfoData(false);
            ChatHandler(target->GetSession()).SendSysMessage(LANG_RESET_TALENTS);
            if (!handler->GetSession() || handler->GetSession()->GetPlayer() != target)
                handler->PSendSysMessage(LANG_RESET_TALENTS_ONLINE, handler->GetNameLink(target).c_str());

            Pet* pet = target->GetPet();
            Pet::resetTalentsForAllPetsOf(target, pet);
            if (pet)
                target->SendTalentsInfoData(true);
            return true;
        }
        else if (targetGuid)
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG);
            stmt->SetData(0, uint16(AT_LOGIN_NONE | AT_LOGIN_RESET_PET_TALENTS));
            stmt->SetData(1, targetGuid.GetCounter());
            CharacterDatabase.Execute(stmt);

            std::string nameLink = handler->playerLink(targetName);
            handler->PSendSysMessage(LANG_RESET_TALENTS_OFFLINE, nameLink.c_str());
            return true;
        }

        handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleResetAllCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        std::string caseName = args;

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
            handler->PSendSysMessage(LANG_RESETALL_UNKNOWN_CASE, args);
            handler->SetSentErrorMessage(true);
            return false;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ALL_AT_LOGIN_FLAGS);
        stmt->SetData(0, uint16(atLogin));
        CharacterDatabase.Execute(stmt);

        std::shared_lock<std::shared_mutex> lock(*HashMapHolder<Player>::GetLock());
        HashMapHolder<Player>::MapType const& plist = ObjectAccessor::GetPlayers();
        for (HashMapHolder<Player>::MapType::const_iterator itr = plist.begin(); itr != plist.end(); ++itr)
            itr->second->SetAtLoginFlag(atLogin);

        return true;
    }
};

void AddSC_reset_commandscript()
{
    new reset_commandscript();
}
