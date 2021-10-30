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
Name: modify_commandscript
%Complete: 100
Comment: All modify related commands
Category: commandscripts
EndScriptData */

#include "AccountMgr.h"
#include "Chat.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "StringConvert.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class modify_commandscript : public CommandScript
{
public:
    modify_commandscript() : CommandScript("modify_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable modifyspeedCommandTable =
        {
            { "fly",            SEC_GAMEMASTER,      false, &HandleModifyFlyCommand,           "" },
            { "all",            SEC_GAMEMASTER,      false, &HandleModifyASpeedCommand,        "" },
            { "walk",           SEC_GAMEMASTER,      false, &HandleModifySpeedCommand,         "" },
            { "backwalk",       SEC_GAMEMASTER,      false, &HandleModifyBWalkCommand,         "" },
            { "swim",           SEC_GAMEMASTER,      false, &HandleModifySwimCommand,          "" },
            { "",               SEC_GAMEMASTER,      false, &HandleModifyASpeedCommand,        "" }
        };

        static ChatCommandTable modifyCommandTable =
        {
            { "hp",             SEC_GAMEMASTER,      false, &HandleModifyHPCommand,            "" },
            { "mana",           SEC_GAMEMASTER,      false, &HandleModifyManaCommand,          "" },
            { "rage",           SEC_GAMEMASTER,      false, &HandleModifyRageCommand,          "" },
            { "runicpower",     SEC_GAMEMASTER,      false, &HandleModifyRunicPowerCommand,    "" },
            { "energy",         SEC_GAMEMASTER,      false, &HandleModifyEnergyCommand,        "" },
            { "money",          SEC_GAMEMASTER,      false, &HandleModifyMoneyCommand,         "" },
            { "scale",          SEC_GAMEMASTER,      false, &HandleModifyScaleCommand,         "" },
            { "bit",            SEC_GAMEMASTER,      false, &HandleModifyBitCommand,           "" },
            { "faction",        SEC_ADMINISTRATOR,   false, &HandleModifyFactionCommand,       "" },
            { "spell",          SEC_CONSOLE,         false, &HandleModifySpellCommand,         "" },
            { "talentpoints",   SEC_GAMEMASTER,      false, &HandleModifyTalentCommand,        "" },
            { "mount",          SEC_GAMEMASTER,      false, &HandleModifyMountCommand,         "" },
            { "honor",          SEC_GAMEMASTER,      false, &HandleModifyHonorCommand,         "" },
            { "reputation",     SEC_GAMEMASTER,      false, &HandleModifyRepCommand,           "" },
            { "arenapoints",    SEC_GAMEMASTER,      false, &HandleModifyArenaCommand,         "" },
            { "drunk",          SEC_GAMEMASTER,      false, &HandleModifyDrunkCommand,         "" },
            { "standstate",     SEC_GAMEMASTER,      false, &HandleModifyStandStateCommand,    "" },
            { "phase",          SEC_GAMEMASTER,      false, &HandleModifyPhaseCommand,         "" },
            { "gender",         SEC_GAMEMASTER,      false, &HandleModifyGenderCommand,        "" },
            { "speed",          SEC_GAMEMASTER,      false, nullptr,                           "", modifyspeedCommandTable }
        };

        static ChatCommandTable morphCommandTable =
        {
            { "reset",      SEC_MODERATOR,     false, &HandleMorphResetCommand, "" },
            { "target",     SEC_MODERATOR,     false, &HandleMorphTargetCommand, "" }
        };

        static ChatCommandTable commandTable =
        {
            { "morph",          SEC_MODERATOR,      false, nullptr,     "", morphCommandTable },
            { "modify",         SEC_GAMEMASTER,     false, nullptr,     "", modifyCommandTable }
        };
        return commandTable;
    }

    template<typename... Args>
    static void NotifyModification(ChatHandler* handler, Unit* target, AcoreStrings resourceMessage, AcoreStrings resourceReportMessage, Args&&... args)
    {
        if (Player* player = target->ToPlayer())
        {
            handler->PSendSysMessage(resourceMessage, handler->GetNameLink(player).c_str(), args...);
            if (handler->needReportToTarget(player))
            {
                ChatHandler(player->GetSession()).PSendSysMessage(resourceReportMessage, handler->GetNameLink().c_str(), std::forward<Args>(args)...);
            }
        }
    }

    //Edit Player HP
    static bool HandleModifyHPCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        int32 hp = atoi((char*)args);
        int32 hpm = atoi((char*)args);

        if (hp < 1 || hpm < 1 || hpm < hp)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (handler->HasLowerSecurity(target))
            return false;

        handler->PSendSysMessage(LANG_YOU_CHANGE_HP, handler->GetNameLink(target).c_str(), hp, hpm);
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_HP_CHANGED, handler->GetNameLink().c_str(), hp, hpm);

        target->SetMaxHealth(hpm);
        target->SetHealth(hp);

        return true;
    }

    //Edit Player Mana
    static bool HandleModifyManaCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        int32 mana = atoi((char*)args);
        int32 manam = atoi((char*)args);

        if (mana <= 0 || manam <= 0 || manam < mana)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        handler->PSendSysMessage(LANG_YOU_CHANGE_MANA, handler->GetNameLink(target).c_str(), mana, manam);
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_MANA_CHANGED, handler->GetNameLink().c_str(), mana, manam);

        target->SetMaxPower(POWER_MANA, manam);
        target->SetPower(POWER_MANA, mana);

        return true;
    }

    //Edit Player Energy
    static bool HandleModifyEnergyCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        // char* pmana = strtok((char*)args, " ");
        // if (!pmana)
        //     return false;

        // char* pmanaMax = strtok(nullptr, " ");
        // if (!pmanaMax)
        //     return false;

        // int32 manam = atoi(pmanaMax);
        // int32 mana = atoi(pmana);

        int32 energy = atoi((char*)args) * 10;
        int32 energym = atoi((char*)args) * 10;

        if (energy <= 0 || energym <= 0 || energym < energy)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        handler->PSendSysMessage(LANG_YOU_CHANGE_ENERGY, handler->GetNameLink(target).c_str(), energy / 10, energym / 10);
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_ENERGY_CHANGED, handler->GetNameLink().c_str(), energy / 10, energym / 10);

        target->SetMaxPower(POWER_ENERGY, energym);
        target->SetPower(POWER_ENERGY, energy);

        LOG_DEBUG("misc", handler->GetAcoreString(LANG_CURRENT_ENERGY), target->GetMaxPower(POWER_ENERGY));

        return true;
    }

    //Edit Player Rage
    static bool HandleModifyRageCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        // char* pmana = strtok((char*)args, " ");
        // if (!pmana)
        //     return false;

        // char* pmanaMax = strtok(nullptr, " ");
        // if (!pmanaMax)
        //     return false;

        // int32 manam = atoi(pmanaMax);
        // int32 mana = atoi(pmana);

        int32 rage = atoi((char*)args) * 10;
        int32 ragem = atoi((char*)args) * 10;

        if (rage <= 0 || ragem <= 0 || ragem < rage)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        handler->PSendSysMessage(LANG_YOU_CHANGE_RAGE, handler->GetNameLink(target).c_str(), rage / 10, ragem / 10);
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_RAGE_CHANGED, handler->GetNameLink().c_str(), rage / 10, ragem / 10);

        target->SetMaxPower(POWER_RAGE, ragem);
        target->SetPower(POWER_RAGE, rage);

        return true;
    }

    // Edit Player Runic Power
    static bool HandleModifyRunicPowerCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        int32 rune = atoi((char*)args) * 10;
        int32 runem = atoi((char*)args) * 10;

        if (rune <= 0 || runem <= 0 || runem < rune)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_RUNIC_POWER, handler->GetNameLink(target).c_str(), rune / 10, runem / 10);
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_RUNIC_POWER_CHANGED, handler->GetNameLink().c_str(), rune / 10, runem / 10);

        target->SetMaxPower(POWER_RUNIC_POWER, runem);
        target->SetPower(POWER_RUNIC_POWER, rune);

        return true;
    }

    //Edit Player Faction
    static bool HandleModifyFactionCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        char* pfactionid = handler->extractKeyFromLink((char*)args, "Hfaction");

        Creature* target = handler->getSelectedCreature();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!pfactionid)
        {
            uint32 factionid = target->getFaction();
            uint32 flag      = target->GetUInt32Value(UNIT_FIELD_FLAGS);
            uint32 npcflag   = target->GetUInt32Value(UNIT_NPC_FLAGS);
            uint32 dyflag    = target->GetUInt32Value(UNIT_DYNAMIC_FLAGS);
            handler->PSendSysMessage(LANG_CURRENT_FACTION, target->GetGUID().GetCounter(), factionid, flag, npcflag, dyflag);
            return true;
        }

        uint32 factionid = atoi(pfactionid);
        uint32 flag;

        char* pflag = strtok(nullptr, " ");
        if (!pflag)
            flag = target->GetUInt32Value(UNIT_FIELD_FLAGS);
        else
            flag = atoi(pflag);

        char* pnpcflag = strtok(nullptr, " ");

        uint32 npcflag;
        if (!pnpcflag)
            npcflag   = target->GetUInt32Value(UNIT_NPC_FLAGS);
        else
            npcflag = atoi(pnpcflag);

        char* pdyflag = strtok(nullptr, " ");

        uint32  dyflag;
        if (!pdyflag)
            dyflag   = target->GetUInt32Value(UNIT_DYNAMIC_FLAGS);
        else
            dyflag = atoi(pdyflag);

        if (!sFactionTemplateStore.LookupEntry(factionid))
        {
            handler->PSendSysMessage(LANG_WRONG_FACTION, factionid);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_FACTION, target->GetGUID().GetCounter(), factionid, flag, npcflag, dyflag);

        target->setFaction(factionid);
        target->SetUInt32Value(UNIT_FIELD_FLAGS, flag);
        target->SetUInt32Value(UNIT_NPC_FLAGS, npcflag);
        target->SetUInt32Value(UNIT_DYNAMIC_FLAGS, dyflag);

        return true;
    }

    //Edit Player Spell
    static bool HandleModifySpellCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        char* pspellflatid = strtok((char*)args, " ");
        if (!pspellflatid)
            return false;

        char* pop = strtok(nullptr, " ");
        if (!pop)
            return false;

        char* pval = strtok(nullptr, " ");
        if (!pval)
            return false;

        uint16 mark;

        char* pmark = strtok(nullptr, " ");

        uint8 spellflatid = atoi(pspellflatid);
        uint8 op   = atoi(pop);
        uint16 val = atoi(pval);
        if (!pmark)
            mark = 65535;
        else
            mark = atoi(pmark);

        Player* target = handler->getSelectedPlayer();
        if (target == nullptr)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        handler->PSendSysMessage(LANG_YOU_CHANGE_SPELLFLATID, spellflatid, val, mark, handler->GetNameLink(target).c_str());
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_SPELLFLATID_CHANGED, handler->GetNameLink().c_str(), spellflatid, val, mark);

        WorldPacket data(SMSG_SET_FLAT_SPELL_MODIFIER, (1 + 1 + 2 + 2));
        data << uint8(spellflatid);
        data << uint8(op);
        data << uint16(val);
        data << uint16(mark);
        target->GetSession()->SendPacket(&data);

        return true;
    }

    //Edit Player TP
    static bool HandleModifyTalentCommand (ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        int tp = atoi((char*)args);
        if (tp < 0)
            return false;

        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (target->GetTypeId() == TYPEID_PLAYER)
        {
            // check online security
            if (handler->HasLowerSecurity(target->ToPlayer()))
                return false;
            target->ToPlayer()->SetFreeTalentPoints(tp);
            target->ToPlayer()->SendTalentsInfoData(false);
            return true;
        }
        else if (target->IsPet())
        {
            Unit* owner = target->GetOwner();
            if (owner && owner->GetTypeId() == TYPEID_PLAYER && ((Pet*)target)->IsPermanentPetFor(owner->ToPlayer()))
            {
                // check online security
                if (handler->HasLowerSecurity(owner->ToPlayer()))
                    return false;
                ((Pet*)target)->SetFreeTalentPoints(tp);
                owner->ToPlayer()->SendTalentsInfoData(true);
                return true;
            }
        }

        handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool CheckModifySpeed(ChatHandler* handler, char const* args, Unit* target, float& speed, float minimumBound, float maximumBound, bool checkInFlight = true)
    {
        if (!*args)
        {
            return false;
        }

        speed = Acore::StringTo<float>(args).value();

        if (speed > maximumBound || speed < minimumBound)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (Player* player = target->ToPlayer())
        {
            // check online security
            if (handler->HasLowerSecurity(player, ObjectGuid::Empty))
            {
                return false;
            }

            if (player->IsInFlight() && checkInFlight)
            {
                handler->PSendSysMessage(LANG_CHAR_IN_FLIGHT, handler->GetNameLink(player).c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        return true;
    }

    //Edit Player Aspeed
    static bool HandleModifyASpeedCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        float ASpeed = (float)atof((char*)args);

        if (ASpeed > 50.0f || ASpeed < 0.1f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayerOrSelf();
        if (AccountMgr::IsGMAccount(handler->GetSession()->GetSecurity()))
            target = handler->GetSession()->GetPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        std::string targetNameLink = handler->GetNameLink(target);

        if (target->IsInFlight())
        {
            handler->PSendSysMessage(LANG_CHAR_IN_FLIGHT, targetNameLink.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_ASPEED, ASpeed, targetNameLink.c_str());
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_ASPEED_CHANGED, handler->GetNameLink().c_str(), ASpeed);

        target->SetSpeed(MOVE_WALK,    ASpeed, true);
        target->SetSpeed(MOVE_RUN,     ASpeed, true);
        target->SetSpeed(MOVE_SWIM,    ASpeed, true);
        //target->SetSpeed(MOVE_TURN,    ASpeed, true);
        target->SetSpeed(MOVE_FLIGHT,     ASpeed, true);
        return true;
    }

    //Edit Player Speed
    static bool HandleModifySpeedCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        float Speed = (float)atof((char*)args);

        if (Speed > 50.0f || Speed < 0.1f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayerOrSelf();
        if (AccountMgr::IsGMAccount(handler->GetSession()->GetSecurity()))
            target = handler->GetSession()->GetPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        std::string targetNameLink = handler->GetNameLink(target);

        if (target->IsInFlight())
        {
            handler->PSendSysMessage(LANG_CHAR_IN_FLIGHT, targetNameLink.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_SPEED, Speed, targetNameLink.c_str());
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_SPEED_CHANGED, handler->GetNameLink().c_str(), Speed);

        target->SetSpeed(MOVE_RUN, Speed, true);

        return true;
    }

    //Edit Player Swim Speed
    static bool HandleModifySwimCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        float Swim = (float)atof((char*)args);

        if (Swim > 50.0f || Swim < 0.1f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayerOrSelf();
        if (AccountMgr::IsGMAccount(handler->GetSession()->GetSecurity()))
            target = handler->GetSession()->GetPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        std::string targetNameLink = handler->GetNameLink(target);

        if (target->IsInFlight())
        {
            handler->PSendSysMessage(LANG_CHAR_IN_FLIGHT, targetNameLink.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_SWIM_SPEED, Swim, targetNameLink.c_str());
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_SWIM_SPEED_CHANGED, handler->GetNameLink().c_str(), Swim);

        target->SetSpeed(MOVE_SWIM, Swim, true);

        return true;
    }

    //Edit Player Walk Speed
    static bool HandleModifyBWalkCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        float BSpeed = (float)atof((char*)args);

        if (BSpeed > 50.0f || BSpeed < 0.1f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayerOrSelf();
        if (AccountMgr::IsGMAccount(handler->GetSession()->GetSecurity()))
            target = handler->GetSession()->GetPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        std::string targetNameLink = handler->GetNameLink(target);

        if (target->IsInFlight())
        {
            handler->PSendSysMessage(LANG_CHAR_IN_FLIGHT, targetNameLink.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_BACK_SPEED, BSpeed, targetNameLink.c_str());
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_BACK_SPEED_CHANGED, handler->GetNameLink().c_str(), BSpeed);

        target->SetSpeed(MOVE_RUN_BACK, BSpeed, true);

        return true;
    }

    //Edit Player Fly
    static bool HandleModifyFlyCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        float FSpeed = (float)atof((char*)args);

        if (FSpeed > 50.0f || FSpeed < 0.1f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayerOrSelf();
        if (AccountMgr::IsGMAccount(handler->GetSession()->GetSecurity()))
            target = handler->GetSession()->GetPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        handler->PSendSysMessage(LANG_YOU_CHANGE_FLY_SPEED, FSpeed, handler->GetNameLink(target).c_str());
        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOURS_FLY_SPEED_CHANGED, handler->GetNameLink().c_str(), FSpeed);

        target->SetSpeed(MOVE_FLIGHT, FSpeed, true);

        return true;
    }

    //Edit Player or Creature Scale
    static bool HandleModifyScaleCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        float Scale = (float)atof((char*)args);
        if (Scale > 10.0f || Scale < 0.1f)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (Player* player = target->ToPlayer())
        {
            // check online security
            if (handler->HasLowerSecurity(player))
                return false;

            handler->PSendSysMessage(LANG_YOU_CHANGE_SIZE, Scale, handler->GetNameLink(player).c_str());
            if (handler->needReportToTarget(player))
                (ChatHandler(player->GetSession())).PSendSysMessage(LANG_YOURS_SIZE_CHANGED, handler->GetNameLink().c_str(), Scale);
        }

        target->SetObjectScale(Scale);

        return true;
    }

    //Enable Player mount
    static bool HandleModifyMountCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
        {
            return false;
        }

        char const* mount_cstr = strtok(const_cast<char*>(args), " ");
        char const* speed_cstr = strtok(nullptr, " ");

        if (!mount_cstr)
        {
            return false;
        }

        if (!speed_cstr)
        {
            speed_cstr = "1";
        }

        uint32 mount = Acore::StringTo<uint32>(mount_cstr).value();
        if (!sCreatureDisplayInfoStore.LookupEntry(mount))
        {
            handler->SendSysMessage(LANG_NO_MOUNT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* target = handler->getSelectedPlayerOrSelf();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
        {
            return false;
        }

        float speed = 0.f;
        if (!CheckModifySpeed(handler, speed_cstr, target, speed, 0.1f, 50.0f))
        {
            return false;
        }

        NotifyModification(handler, target, LANG_YOU_GIVE_MOUNT, LANG_MOUNT_GIVED);

        target->Mount(mount);
        target->SetSpeed(MOVE_RUN, speed, true);
        target->SetSpeed(MOVE_FLIGHT, speed, true);
        return true;
    }

    //Edit Player money
    static bool HandleModifyMoneyCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        int32 moneyToAdd = 0;
        if (strchr(args, 'g') || strchr(args, 's') || strchr(args, 'c'))
            moneyToAdd = MoneyStringToMoney(std::string(args));
        else
            moneyToAdd = atoi(args);

        uint32 targetMoney = target->GetMoney();

        if (moneyToAdd < 0)
        {
            int32 newmoney = int32(targetMoney) + moneyToAdd;

            LOG_DEBUG("chat.system", handler->GetAcoreString(LANG_CURRENT_MONEY), targetMoney, moneyToAdd, newmoney);
            if (newmoney <= 0)
            {
                handler->PSendSysMessage(LANG_YOU_TAKE_ALL_MONEY, handler->GetNameLink(target).c_str());
                if (handler->needReportToTarget(target))
                    ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_ALL_MONEY_GONE, handler->GetNameLink().c_str());

                target->SetMoney(0);
            }
            else
            {
                if (newmoney > MAX_MONEY_AMOUNT)
                    newmoney = MAX_MONEY_AMOUNT;

                handler->PSendSysMessage(LANG_YOU_TAKE_MONEY, abs(moneyToAdd), handler->GetNameLink(target).c_str());
                if (handler->needReportToTarget(target))
                    ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_MONEY_TAKEN, handler->GetNameLink().c_str(), abs(moneyToAdd));
                target->SetMoney(newmoney);
            }
        }
        else
        {
            handler->PSendSysMessage(LANG_YOU_GIVE_MONEY, moneyToAdd, handler->GetNameLink(target).c_str());
            if (handler->needReportToTarget(target))
                ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_MONEY_GIVEN, handler->GetNameLink().c_str(), moneyToAdd);

            if (moneyToAdd >= MAX_MONEY_AMOUNT)
                moneyToAdd = MAX_MONEY_AMOUNT;

            if (targetMoney >= uint32(MAX_MONEY_AMOUNT) - moneyToAdd)
                moneyToAdd -= targetMoney;

            target->ModifyMoney(moneyToAdd);
        }

        LOG_DEBUG("chat.system", handler->GetAcoreString(LANG_NEW_MONEY), targetMoney, moneyToAdd, target->GetMoney());

        return true;
    }

    //Edit Unit field
    static bool HandleModifyBitCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer()))
            return false;

        char* pField = strtok((char*)args, " ");
        if (!pField)
            return false;

        char* pBit = strtok(nullptr, " ");
        if (!pBit)
            return false;

        uint16 field = atoi(pField);
        uint32 bit   = atoi(pBit);

        if (field < OBJECT_END || field >= target->GetValuesCount())
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (bit < 1 || bit > 32)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (target->HasFlag(field, (1 << (bit - 1))))
        {
            target->RemoveFlag(field, (1 << (bit - 1)));
            handler->PSendSysMessage(LANG_REMOVE_BIT, bit, field);
        }
        else
        {
            target->SetFlag(field, (1 << (bit - 1)));
            handler->PSendSysMessage(LANG_SET_BIT, bit, field);
        }
        return true;
    }

    static bool HandleModifyHonorCommand (ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        int32 amount = (uint32)atoi(args);

        target->ModifyHonorPoints(amount);

        handler->PSendSysMessage(LANG_COMMAND_MODIFY_HONOR, handler->GetNameLink(target).c_str(), target->GetHonorPoints());

        return true;
    }

    static bool HandleModifyDrunkCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint8 drunklevel = (uint8)atoi(args);
        if (drunklevel > 100)
            drunklevel = 100;

        if (Player* target = handler->getSelectedPlayer())
            target->SetDrunkValue(drunklevel);

        return true;
    }

    static bool HandleModifyRepCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
            return false;

        char* factionTxt = handler->extractKeyFromLink((char*)args, "Hfaction");
        if (!factionTxt)
            return false;

        uint32 factionId = atoi(factionTxt);

        int32 amount = 0;
        char* rankTxt = strtok(nullptr, " ");
        if (!factionTxt || !rankTxt)
            return false;

        amount = atoi(rankTxt);
        if ((amount == 0) && (rankTxt[0] != '-') && !isdigit(rankTxt[0]))
        {
            std::string rankStr = rankTxt;
            std::wstring wrankStr;
            if (!Utf8toWStr(rankStr, wrankStr))
                return false;
            wstrToLower(wrankStr);

            int r = 0;
            amount = -42000;
            for (; r < MAX_REPUTATION_RANK; ++r)
            {
                std::string rank = handler->GetAcoreString(ReputationRankStrIndex[r]);
                if (rank.empty())
                    continue;

                std::wstring wrank;
                if (!Utf8toWStr(rank, wrank))
                    continue;

                wstrToLower(wrank);

                if (wrank.substr(0, wrankStr.size()) == wrankStr)
                {
                    char* deltaTxt = strtok(nullptr, " ");
                    if (deltaTxt)
                    {
                        int32 delta = atoi(deltaTxt);
                        if ((delta < 0) || (delta > ReputationMgr::PointsInRank[r] - 1))
                        {
                            handler->PSendSysMessage(LANG_COMMAND_FACTION_DELTA, (ReputationMgr::PointsInRank[r] - 1));
                            handler->SetSentErrorMessage(true);
                            return false;
                        }
                        amount += delta;
                    }
                    break;
                }
                amount += ReputationMgr::PointsInRank[r];
            }
            if (r >= MAX_REPUTATION_RANK)
            {
                handler->PSendSysMessage(LANG_COMMAND_FACTION_INVPARAM, rankTxt);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionId);

        if (!factionEntry)
        {
            handler->PSendSysMessage(LANG_COMMAND_FACTION_UNKNOWN, factionId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (factionEntry->reputationListID < 0)
        {
            handler->PSendSysMessage(LANG_COMMAND_FACTION_NOREP_ERROR, factionEntry->name[handler->GetSessionDbcLocale()], factionId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        target->GetReputationMgr().SetOneFactionReputation(factionEntry, amount, false);
        target->GetReputationMgr().SendState(target->GetReputationMgr().GetState(factionEntry));
        handler->PSendSysMessage(LANG_COMMAND_MODIFY_REP, factionEntry->name[handler->GetSessionDbcLocale()], factionId,
                                 handler->GetNameLink(target).c_str(), target->GetReputationMgr().GetReputation(factionEntry));
        return true;
    }
    static bool HandleMorphTargetCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 display_id = (uint32)atoi((char*)args);
        Unit* target = handler->getSelectedUnit();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        // check online security
        else if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer()))
            return false;

        target->SetDisplayId(display_id);

        return true;
    }

    //morph creature or player
    static bool HandleMorphResetCommand(ChatHandler* handler, const char* /*args*/)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        // check online security
        else if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer()))
            return false;

        target->DeMorph();
        return true;
    }

    //set temporary phase mask for player
    static bool HandleModifyPhaseCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 phasemask = (uint32)atoi((char*)args);

        Unit* target = handler->getSelectedUnit();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        // check online security
        else if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer()))
            return false;

        target->SetPhaseMask(phasemask, true);

        return true;
    }

    //change standstate
    static bool HandleModifyStandStateCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        uint32 anim_id = atoi((char*)args);
        handler->GetSession()->GetPlayer()->SetUInt32Value(UNIT_NPC_EMOTESTATE, anim_id);

        return true;
    }

    static bool HandleModifyArenaCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        int32 amount = (uint32)atoi(args);

        target->ModifyArenaPoints(amount);

        handler->PSendSysMessage(LANG_COMMAND_MODIFY_ARENA, handler->GetNameLink(target).c_str(), target->GetArenaPoints());

        return true;
    }

    static bool HandleModifyGenderCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Player* target = handler->getSelectedPlayer();

        if (!target)
        {
            handler->PSendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        PlayerInfo const* info = sObjectMgr->GetPlayerInfo(target->getRace(), target->getClass());
        if (!info)
            return false;

        char const* gender_str = (char*)args;
        int gender_len = strlen(gender_str);

        Gender gender;

        if (!strncmp(gender_str, "male", gender_len))            // MALE
        {
            if (target->getGender() == GENDER_MALE)
                return true;

            gender = GENDER_MALE;
        }
        else if (!strncmp(gender_str, "female", gender_len))    // FEMALE
        {
            if (target->getGender() == GENDER_FEMALE)
                return true;

            gender = GENDER_FEMALE;
        }
        else
        {
            handler->SendSysMessage(LANG_MUST_MALE_OR_FEMALE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Set gender
        target->SetByteValue(UNIT_FIELD_BYTES_0, 2, gender);
        target->SetByteValue(PLAYER_BYTES_3, 0, gender);

        // Change display ID
        target->InitDisplayIds();

        char const* gender_full = gender ? "female" : "male";

        handler->PSendSysMessage(LANG_YOU_CHANGE_GENDER, handler->GetNameLink(target).c_str(), gender_full);

        if (handler->needReportToTarget(target))
            (ChatHandler(target->GetSession())).PSendSysMessage(LANG_YOUR_GENDER_CHANGED, gender_full, handler->GetNameLink().c_str());

        return true;
    }
};

void AddSC_modify_commandscript()
{
    new modify_commandscript();
}
