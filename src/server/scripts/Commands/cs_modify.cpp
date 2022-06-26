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

using namespace Acore::ChatCommands;

class modify_commandscript : public CommandScript
{
public:
    modify_commandscript() : CommandScript("modify_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable modifyspeedCommandTable =
        {
            { "fly",            HandleModifyFlyCommand,           SEC_GAMEMASTER,       Console::No },
            { "all",            HandleModifyASpeedCommand,        SEC_GAMEMASTER,       Console::No },
            { "walk",           HandleModifySpeedCommand,         SEC_GAMEMASTER,       Console::No },
            { "backwalk",       HandleModifyBWalkCommand,         SEC_GAMEMASTER,       Console::No },
            { "swim",           HandleModifySwimCommand,          SEC_GAMEMASTER,       Console::No },
            { "",               HandleModifyASpeedCommand,        SEC_GAMEMASTER,       Console::No }
        };

        static ChatCommandTable modifyCommandTable =
        {
            { "hp",             HandleModifyHPCommand,            SEC_GAMEMASTER,       Console::No },
            { "mana",           HandleModifyManaCommand,          SEC_GAMEMASTER,       Console::No },
            { "rage",           HandleModifyRageCommand,          SEC_GAMEMASTER,       Console::No },
            { "runicpower",     HandleModifyRunicPowerCommand,    SEC_GAMEMASTER,       Console::No },
            { "energy",         HandleModifyEnergyCommand,        SEC_GAMEMASTER,       Console::No },
            { "money",          HandleModifyMoneyCommand,         SEC_GAMEMASTER,       Console::No },
            { "scale",          HandleModifyScaleCommand,         SEC_GAMEMASTER,       Console::No },
            { "bit",            HandleModifyBitCommand,           SEC_GAMEMASTER,       Console::No },
            { "faction",        HandleModifyFactionCommand,       SEC_ADMINISTRATOR,    Console::No },
            { "spell",          HandleModifySpellCommand,         SEC_CONSOLE,          Console::No },
            { "talentpoints",   HandleModifyTalentCommand,        SEC_GAMEMASTER,       Console::No },
            { "mount",          HandleModifyMountCommand,         SEC_GAMEMASTER,       Console::No },
            { "honor",          HandleModifyHonorCommand,         SEC_GAMEMASTER,       Console::No },
            { "reputation",     HandleModifyRepCommand,           SEC_GAMEMASTER,       Console::No },
            { "arenapoints",    HandleModifyArenaCommand,         SEC_GAMEMASTER,       Console::No },
            { "drunk",          HandleModifyDrunkCommand,         SEC_GAMEMASTER,       Console::No },
            { "standstate",     HandleModifyStandStateCommand,    SEC_GAMEMASTER,       Console::No },
            { "phase",          HandleModifyPhaseCommand,         SEC_GAMEMASTER,       Console::No },
            { "gender",         HandleModifyGenderCommand,        SEC_GAMEMASTER,       Console::No },
            { "speed",          modifyspeedCommandTable }
        };

        static ChatCommandTable morphCommandTable =
        {
            { "reset",          HandleMorphResetCommand,          SEC_MODERATOR,        Console::No },
            { "target",         HandleMorphTargetCommand,         SEC_MODERATOR,        Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "morph",          morphCommandTable },
            { "modify",         modifyCommandTable }
        };

        return commandTable;
    }

    template<typename... Args>
    static void NotifyModification(ChatHandler* handler, Unit* target, AcoreStrings resourceMessage, AcoreStrings resourceReportMessage, Args&&... args)
    {
        if (Player* player = target->ToPlayer())
        {
            handler->PSendSysMessage(resourceMessage, std::forward<Args>(args)..., handler->GetNameLink(player).c_str());

            if (handler->needReportToTarget(player))
            {
                ChatHandler(player->GetSession()).PSendSysMessage(resourceReportMessage, handler->GetNameLink().c_str(), std::forward<Args>(args)...);
            }
        }
    }

    static bool CheckModifyInt32(ChatHandler* handler, Player* target, int32 modifyValue)
    {
        if (modifyValue < 1)
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

        if (handler->HasLowerSecurity(target))
        {
            return false;
        }

        return true;
    }

    //Edit Player HP
    static bool HandleModifyHPCommand(ChatHandler* handler, int32 healthPoints)
    {
        Player* target = handler->getSelectedPlayer();

        if (!CheckModifyInt32(handler, target, healthPoints))
        {
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_HP, handler->GetNameLink(target).c_str(), healthPoints, healthPoints);

        if (handler->needReportToTarget(target))
        {
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_HP_CHANGED, handler->GetNameLink().c_str(), healthPoints, healthPoints);
        }

        target->SetMaxHealth(healthPoints);
        target->SetHealth(healthPoints);

        return true;
    }

    //Edit Player Mana
    static bool HandleModifyManaCommand(ChatHandler* handler, int32 manaPoints)
    {
        Player* target = handler->getSelectedPlayer();

        if (!CheckModifyInt32(handler, target, manaPoints))
        {
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_MANA, handler->GetNameLink(target).c_str(), manaPoints, manaPoints);

        if (handler->needReportToTarget(target))
        {
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_MANA_CHANGED, handler->GetNameLink().c_str(), manaPoints, manaPoints);
        }

        target->SetMaxPower(POWER_MANA, manaPoints);
        target->SetPower(POWER_MANA, manaPoints);

        return true;
    }

    //Edit Player Energy
    static bool HandleModifyEnergyCommand(ChatHandler* handler, int32 energyPoints)
    {
        Player* target = handler->getSelectedPlayer();

        if (!CheckModifyInt32(handler, target, energyPoints))
        {
            return false;
        }

        energyPoints *= 10;

        handler->PSendSysMessage(LANG_YOU_CHANGE_ENERGY, handler->GetNameLink(target).c_str(), energyPoints / 10, energyPoints / 10);

        if (handler->needReportToTarget(target))
        {
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_ENERGY_CHANGED, handler->GetNameLink().c_str(), energyPoints / 10, energyPoints / 10);
        }

        target->SetMaxPower(POWER_ENERGY, energyPoints);
        target->SetPower(POWER_ENERGY, energyPoints);

        LOG_DEBUG("misc", handler->GetAcoreString(LANG_CURRENT_ENERGY), target->GetMaxPower(POWER_ENERGY));

        return true;
    }

    //Edit Player Rage
    static bool HandleModifyRageCommand(ChatHandler* handler, int32 ragePoints)
    {
        Player* target = handler->getSelectedPlayer();

        if (!CheckModifyInt32(handler, target, ragePoints))
        {
            return false;
        }

        ragePoints *= 10;

        handler->PSendSysMessage(LANG_YOU_CHANGE_RAGE, handler->GetNameLink(target).c_str(), ragePoints / 10, ragePoints / 10);

        if (handler->needReportToTarget(target))
        {
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_RAGE_CHANGED, handler->GetNameLink().c_str(), ragePoints / 10, ragePoints / 10);
        }

        target->SetMaxPower(POWER_RAGE, ragePoints);
        target->SetPower(POWER_RAGE, ragePoints);

        return true;
    }

    // Edit Player Runic Power
    static bool HandleModifyRunicPowerCommand(ChatHandler* handler, int32 runePoints)
    {
        Player* target = handler->getSelectedPlayer();

        if (!CheckModifyInt32(handler, target, runePoints))
        {
            return false;
        }

        runePoints *= 10;

        handler->PSendSysMessage(LANG_YOU_CHANGE_RUNIC_POWER, handler->GetNameLink(target).c_str(), runePoints / 10, runePoints / 10);

        if (handler->needReportToTarget(target))
        {
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_RUNIC_POWER_CHANGED, handler->GetNameLink().c_str(), runePoints / 10, runePoints / 10);
        }

        target->SetMaxPower(POWER_RUNIC_POWER, runePoints);
        target->SetPower(POWER_RUNIC_POWER, runePoints);

        return true;
    }

    //Edit Player Faction
    static bool HandleModifyFactionCommand(ChatHandler* handler, Optional<uint32> factionID, Optional<uint32> flagID, Optional<uint32> npcFlagID, Optional<uint32> dynamicFlagID)
    {
        Creature* target = handler->getSelectedCreature();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!factionID)
        {
            uint32 factionid = target->GetFaction();
            uint32 flag      = target->GetUnitFlags();
            uint32 npcflag   = target->GetNpcFlags();
            uint32 dyflag    = target->GetDynamicFlags();
            handler->PSendSysMessage(LANG_CURRENT_FACTION, target->GetGUID().GetCounter(), factionid, flag, npcflag, dyflag);
            return true;
        }

        uint32 factionid = factionID.value();
        UnitFlags flag;
        NPCFlags npcflag;
        uint32 dyflag;

        auto pflag = flagID;
        if (!pflag)
            flag = target->GetUnitFlags();
        else
            flag = UnitFlags(*pflag);

        auto pnpcflag = npcFlagID;
        if (!pnpcflag)
            npcflag = target->GetNpcFlags();
        else
            npcflag = NPCFlags(*npcFlagID);

        auto pdyflag = dynamicFlagID;
        if (!pdyflag)
            dyflag = target->GetDynamicFlags();
        else
            dyflag = *dynamicFlagID;

        if (!sFactionTemplateStore.LookupEntry(factionid))
        {
            handler->PSendSysMessage(LANG_WRONG_FACTION, factionid);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_FACTION, target->GetGUID().GetCounter(), factionid, flag, npcflag, dyflag);

        target->SetFaction(factionid);
        target->ReplaceAllUnitFlags(flag);
        target->ReplaceAllNpcFlags(npcflag);
        target->ReplaceAllDynamicFlags(dyflag);

        return true;
    }

    //Edit Player Spell
    static bool HandleModifySpellCommand(ChatHandler* handler, uint8 spellFlatID, uint8 op, uint16 val, Optional<uint16> mark)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
        {
            return false;
        }

        handler->PSendSysMessage(LANG_YOU_CHANGE_SPELLFLATID, spellFlatID, val, mark ? *mark : 65535, handler->GetNameLink(target).c_str());
        if (handler->needReportToTarget(target))
        {
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_SPELLFLATID_CHANGED, handler->GetNameLink().c_str(), spellFlatID, val, mark ? *mark : 65535);
        }

        WorldPacket data(SMSG_SET_FLAT_SPELL_MODIFIER, (1 + 1 + 2 + 2));
        data << uint8(spellFlatID);
        data << uint8(op);
        data << uint16(val);
        data << uint16(mark ? *mark : 65535);
        target->GetSession()->SendPacket(&data);

        return true;
    }

    //Edit Player TP
    static bool HandleModifyTalentCommand(ChatHandler* handler, uint32 talentPoints)
    {
        if (!talentPoints)
        {
            return false;
        }

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
            {
                return false;
            }

            target->ToPlayer()->SetFreeTalentPoints(talentPoints);
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
                ((Pet*)target)->SetFreeTalentPoints(talentPoints);
                owner->ToPlayer()->SendTalentsInfoData(true);
                return true;
            }
        }

        handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool CheckModifySpeed(ChatHandler* handler, Unit* target, float speed, float minimumBound, float maximumBound, bool checkInFlight = true)
    {
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
            if (handler->HasLowerSecurity(player))
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
    static bool HandleModifyASpeedCommand(ChatHandler* handler, float allSpeed)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (CheckModifySpeed(handler, target, allSpeed, 0.1f, 50.0f))
        {
            NotifyModification(handler, target, LANG_YOU_CHANGE_ASPEED, LANG_YOURS_ASPEED_CHANGED, allSpeed);
            target->SetSpeed(MOVE_WALK, allSpeed);
            target->SetSpeed(MOVE_RUN, allSpeed);
            target->SetSpeed(MOVE_SWIM, allSpeed);
            target->SetSpeed(MOVE_FLIGHT, allSpeed);
            return true;
        }

        return false;
    }

    //Edit Player Speed
    static bool HandleModifySpeedCommand(ChatHandler* handler, float speed)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (CheckModifySpeed(handler, target, speed, 0.1f, 50.0f))
        {
            NotifyModification(handler, target, LANG_YOU_CHANGE_SPEED, LANG_YOURS_SPEED_CHANGED, speed);
            target->SetSpeedRate(MOVE_RUN, speed);
            return true;
        }

        return false;
    }

    //Edit Player Swim Speed
    static bool HandleModifySwimCommand(ChatHandler* handler, float swimSpeed)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (CheckModifySpeed(handler, target, swimSpeed, 0.1f, 50.0f))
        {
            NotifyModification(handler, target, LANG_YOU_CHANGE_SWIM_SPEED, LANG_YOURS_SWIM_SPEED_CHANGED, swimSpeed);
            target->SetSpeedRate(MOVE_SWIM, swimSpeed);
            return true;
        }

        return false;
    }

    //Edit Player Walk Speed
    static bool HandleModifyBWalkCommand(ChatHandler* handler, float backSpeed)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (CheckModifySpeed(handler, target, backSpeed, 0.1f, 50.0f))
        {
            NotifyModification(handler, target, LANG_YOU_CHANGE_BACK_SPEED, LANG_YOURS_BACK_SPEED_CHANGED, backSpeed);
            target->SetSpeedRate(MOVE_RUN_BACK, backSpeed);
            return true;
        }

        return false;
    }

    //Edit Player Fly
    static bool HandleModifyFlyCommand(ChatHandler* handler, float flySpeed)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (CheckModifySpeed(handler, target, flySpeed, 0.1f, 50.0f, false))
        {
            NotifyModification(handler, target, LANG_YOU_CHANGE_FLY_SPEED, LANG_YOURS_FLY_SPEED_CHANGED, flySpeed);
            target->SetSpeedRate(MOVE_FLIGHT, flySpeed);
            return true;
        }

        return false;
    }

    //Edit Player or Creature Scale
    static bool HandleModifyScaleCommand(ChatHandler* handler, float scale)
    {
        if (scale > 10.0f || scale < 0.1f)
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

            handler->PSendSysMessage(LANG_YOU_CHANGE_SIZE, scale, handler->GetNameLink(player).c_str());
            if (handler->needReportToTarget(player))
                ChatHandler(player->GetSession()).PSendSysMessage(LANG_YOURS_SIZE_CHANGED, handler->GetNameLink().c_str(), scale);
        }

        target->SetObjectScale(scale);

        return true;
    }

    //Enable Player mount
    static bool HandleModifyMountCommand(ChatHandler* handler, uint32 creatureDisplayID, Optional<float> speed)
    {
        if (!sCreatureDisplayInfoStore.LookupEntry(creatureDisplayID))
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

        float _speed = speed ? *speed : 1.0f;

        if (!CheckModifySpeed(handler, target, _speed, 0.1f, 50.0f))
        {
            return false;
        }

        NotifyModification(handler, target, LANG_YOU_GIVE_MOUNT, LANG_MOUNT_GIVED);

        target->Mount(creatureDisplayID);
        target->SetSpeed(MOVE_RUN, _speed, true);
        target->SetSpeed(MOVE_FLIGHT, _speed, true);
        return true;
    }

    //Edit Player money
    static bool HandleModifyMoneyCommand(ChatHandler* handler, Tail money)
    {
        if (money.empty())
        {
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
        {
            return false;
        }

        auto IsExistWord = [](std::string_view line, std::initializer_list<std::string_view> words)
        {
            for (auto const& word : words)
            {
                if (line.find(word) != std::string_view::npos)
                {
                    return true;
                }
            }

            return false;
        };

        Optional<int32> moneyToAddO = 0;
        if (IsExistWord(money, { "g", "s", "c" }))
        {
            moneyToAddO = MoneyStringToMoney(money);
        }
        else
        {
            moneyToAddO = Acore::StringTo<int32>(money);
        }

        if (!moneyToAddO)
        {
            return false;
        }

        int32 moneyToAdd = *moneyToAddO;
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

                handler->PSendSysMessage(LANG_YOU_TAKE_MONEY, std::abs(moneyToAdd), handler->GetNameLink(target).c_str());
                if (handler->needReportToTarget(target))
                    ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOURS_MONEY_TAKEN, handler->GetNameLink().c_str(), std::abs(moneyToAdd));
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
    static bool HandleModifyBitCommand(ChatHandler* handler, uint16 field, uint32 bit)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer()))
        {
            return false;
        }

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

    static bool HandleModifyHonorCommand(ChatHandler* handler, int32 amount)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
        {
            return false;
        }

        target->ModifyHonorPoints(amount);

        handler->PSendSysMessage(LANG_COMMAND_MODIFY_HONOR, handler->GetNameLink(target).c_str(), target->GetHonorPoints());

        return true;
    }

    static bool HandleModifyDrunkCommand(ChatHandler* handler, uint8 drunklevel)
    {
        if (drunklevel > 100)
        {
            drunklevel = 100;
        }

        if (Player* target = handler->getSelectedPlayer())
        {
            target->SetDrunkValue(drunklevel);
        }

        return true;
    }

    static bool HandleModifyRepCommand(ChatHandler* handler, uint32 factionId, Variant<int32, std::string> rank, Optional<int32> delta)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target))
        {
            return false;
        }

        int32 amount = 0;

        if (rank.holds_alternative<std::string>())
        {
            std::string rankStr = rank.get<std::string>();
            std::wstring wrankStr;

            if (!Utf8toWStr(rankStr, wrankStr))
            {
                return false;
            }

            wstrToLower(wrankStr);

            int32 r = 0;
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
                    if (delta)
                    {
                        if (*delta < 0 || (*delta > ReputationMgr::PointsInRank[r] - 1))
                        {
                            handler->PSendSysMessage(LANG_COMMAND_FACTION_DELTA, ReputationMgr::PointsInRank[r] - 1);
                            handler->SetSentErrorMessage(true);
                            return false;
                        }

                        amount += *delta;
                    }

                    break;
                }

                amount += ReputationMgr::PointsInRank[r];
            }

            if (r >= MAX_REPUTATION_RANK)
            {
                handler->PSendSysMessage(LANG_COMMAND_FACTION_INVPARAM, rankStr.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        else
        {
            amount = rank.get<int32>();
        }

        if (!amount)
        {
            return false;
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

        target->GetReputationMgr().SetOneFactionReputation(factionEntry, float(amount), false);
        target->GetReputationMgr().SendState(target->GetReputationMgr().GetState(factionEntry));

        handler->PSendSysMessage(LANG_COMMAND_MODIFY_REP, factionEntry->name[handler->GetSessionDbcLocale()], factionId,
                                 handler->GetNameLink(target).c_str(), target->GetReputationMgr().GetReputation(factionEntry));
        return true;
    }

    static bool HandleMorphTargetCommand(ChatHandler* handler, uint32 displayID)
    {
        Unit* target = handler->getSelectedUnit();

        if (!target)
        {
            target = handler->GetSession()->GetPlayer();
        }
        else if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer())) // check online security
        {
            return false;
        }

        target->SetDisplayId(displayID);
        return true;
    }

    //morph creature or player
    static bool HandleMorphResetCommand(ChatHandler* handler)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            target = handler->GetSession()->GetPlayer();
        }
        else if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer())) // check online security
        {
            return false;
        }

        target->DeMorph();
        return true;
    }

    //set temporary phase mask for player
    static bool HandleModifyPhaseCommand(ChatHandler* handler, uint32 phaseMask)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            target = handler->GetSession()->GetPlayer();
        }
        else if (target->GetTypeId() == TYPEID_PLAYER && handler->HasLowerSecurity(target->ToPlayer())) // check online security
        {
            return false;
        }

        target->SetPhaseMask(phaseMask, true);
        return true;
    }

    //change standstate
    static bool HandleModifyStandStateCommand(ChatHandler* handler, uint32 anim)
    {
        handler->GetSession()->GetPlayer()->SetUInt32Value(UNIT_NPC_EMOTESTATE, anim);
        return true;
    }

    static bool HandleModifyArenaCommand(ChatHandler* handler, int32 amount)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        target->ModifyArenaPoints(amount);

        handler->PSendSysMessage(LANG_COMMAND_MODIFY_ARENA, handler->GetNameLink(target).c_str(), target->GetArenaPoints());

        return true;
    }

    static bool HandleModifyGenderCommand(ChatHandler* handler, Tail genderString)
    {
        if (genderString.empty())
        {
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->PSendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        PlayerInfo const* info = sObjectMgr->GetPlayerInfo(target->getRace(), target->getClass());
        if (!info)
        {
            return false;
        }

        Gender gender;

        if (StringEqualI(genderString, "male")) // MALE
        {
            if (target->getGender() == GENDER_MALE)
                return true;

            gender = GENDER_MALE;
        }
        else if (StringEqualI(genderString, "female"))    // FEMALE
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
        {
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOUR_GENDER_CHANGED, gender_full, handler->GetNameLink().c_str());
        }

        return true;
    }
};

void AddSC_modify_commandscript()
{
    new modify_commandscript();
}
