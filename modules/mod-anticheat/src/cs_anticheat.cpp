/*
 *MIT License
 *
 *Copyright (c) 2023 Azerothcore
 *
 *Permission is hereby granted, free of charge, to any person obtaining a copy
 *of this software and associated documentation files (the "Software"), to deal
 *in the Software without restriction, including without limitation the rights
 *to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *copies of the Software, and to permit persons to whom the Software is
 *furnished to do so, subject to the following conditions:
 *
 *The above copyright notice and this permission notice shall be included in all
 *copies or substantial portions of the Software.
 *
 *THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *SOFTWARE.
 */

#include "Language.h"
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "AnticheatMgr.h"
#include "Configuration/Config.h"
#include "Player.h"
#include "SpellAuras.h"
#include "DatabaseEnv.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

enum Spells
{
    SHACKLES = 38505,
    LFG_SPELL_DUNGEON_DESERTER = 71041,
    BG_SPELL_DESERTER = 26013,
    SILENCED = 23207
};

class anticheat_commandscript : public CommandScript
{
public:
    anticheat_commandscript() : CommandScript("anticheat_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> anticheatCommandTable =
        {
            { "global",  HandleAntiCheatGlobalCommand,  SEC_GAMEMASTER,     Console::Yes },
            { "player",  HandleAntiCheatPlayerCommand,  SEC_GAMEMASTER,     Console::Yes },
            { "delete",  HandleAntiCheatDeleteCommand,  SEC_ADMINISTRATOR,  Console::Yes },
            { "jail",    HandleAnticheatJailCommand,    SEC_GAMEMASTER,     Console::Yes },
            { "parole",  HandleAnticheatParoleCommand,  SEC_ADMINISTRATOR,  Console::Yes },
            { "purge",   HandleAntiCheatPurgeCommand,   SEC_ADMINISTRATOR,  Console::Yes },
            { "warn",    HandleAnticheatWarnCommand,    SEC_GAMEMASTER,     Console::Yes }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "anticheat",  anticheatCommandTable },
        };

        return commandTable;
    }

    static Optional<PlayerIdentifier> TrySolvePlayer(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!player)
            player = PlayerIdentifier::FromTarget(handler);

        if (!player || !player->IsConnected())
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return std::nullopt;
        }

        return player;
    }

    static bool HandleAnticheatWarnCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!sConfigMgr->GetOption<bool>("Anticheat.Enabled", 0))
            return false;

        player = TrySolvePlayer(handler, player);
        if (!player)
            return false;

        ChatHandler(player->GetConnectedPlayer()->GetSession()).SendSysMessage("The anticheat system has reported several times that you may be cheating. You will be monitored to confirm if this is accurate.");
        return true;
    }

    static bool HandleAnticheatJailCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!sConfigMgr->GetOption<bool>("Anticheat.Enabled", 0))
            return false;

        player = TrySolvePlayer(handler, player);
        if (!player)
            return false;

        Player* pTarget = player->GetConnectedPlayer();

        // teleport both to jail.
        if (!handler->IsConsole())
        {
            handler->GetSession()->GetPlayer()->TeleportTo(1, 16226.5f, 16403.6f, -64.5f, 3.2f);
        }

        // GM Jail Location is uncommit and used as default for the jailing. Feel free to commit it out with double forward slashes (//) and uncommit,
        // removing the double forward slashes (//) if you wish to use the other locations.
        WorldLocation loc = WorldLocation(1, 16226.5f, 16403.6f, -64.5f, 3.2f);// GM Jail Location
        //WorldLocation loc = WorldLocation(35, -98.0155, 149.8360,-40.3827, 3.2f);// Alliance Jail Stormwind Stockade Location
        //WorldLocation loc = WorldLocation(0, -11139.1845, -1742.4421, -29.7365, 3.2f);// Horde Jail The Pit of Criminals Location

        pTarget->TeleportTo(loc);
        pTarget->SetHomebind(loc, 876);// GM Jail Homebind location
        pTarget->CastSpell(pTarget, SHACKLES);// shackle him in place to ensure no exploit happens for jail break attempt
        if (Aura* dungdesert = pTarget->AddAura(LFG_SPELL_DUNGEON_DESERTER, pTarget))
        {
            dungdesert->SetDuration(-1);
        }
        if (Aura* bgdesert = pTarget->AddAura(BG_SPELL_DESERTER, pTarget))
        {
            bgdesert->SetDuration(-1);
        }
        if (Aura* silent = pTarget->AddAura(SILENCED, pTarget))
        {
            silent->SetDuration(-1);
        }

        return true;
    }

    static bool HandleAnticheatParoleCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!sConfigMgr->GetOption<bool>("Anticheat.Enabled", 0))
            return false;

        player = TrySolvePlayer(handler, player);
        if (!player)
            return false;

        Player* pTarget = player->GetConnectedPlayer();

        if (pTarget->GetTeamId() == TEAM_ALLIANCE)
        {
            WorldLocation Aloc = WorldLocation(0, -8833.37f, 628.62f, 94.00f, 1.06f);// Stormwind
            pTarget->TeleportTo(0, -8833.37f, 628.62f, 94.00f, 1.06f);//Stormwind
            pTarget->SetHomebind(Aloc, 1519);// Stormwind Homebind location
        }
        else
        {
            WorldLocation Hloc = WorldLocation(1, 1569.59f, -4397.63f, 7.7f, 0.54f);// Orgrimmar
            pTarget->TeleportTo(1, 1569.59f, -4397.63f, 7.7f, 0.54f);//Orgrimmar
            pTarget->SetHomebind(Hloc, 1653);// Orgrimmar Homebind location
        }
        pTarget->RemoveAura(SHACKLES);
        pTarget->RemoveAura(LFG_SPELL_DUNGEON_DESERTER);
        pTarget->RemoveAura(BG_SPELL_DESERTER);
        pTarget->RemoveAura(SILENCED);
        sAnticheatMgr->AnticheatDeleteCommand(pTarget->GetGUID());// deletes auto reports on player
        return true;
    }

    static bool HandleAntiCheatDeleteCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!sConfigMgr->GetOption<bool>("Anticheat.Enabled", 0))
            return false;

        player = TrySolvePlayer(handler, player);
        if (!player)
            return false;

        sAnticheatMgr->AnticheatDeleteCommand(player->GetGUID());
        handler->PSendSysMessage("Anticheat players_reports_status deleted for player %s", player->GetName());
        return true;
    }

    static bool HandleAntiCheatPlayerCommand(ChatHandler* handler, Optional<PlayerIdentifier> player)
    {
        if (!sConfigMgr->GetOption<bool>("Anticheat.Enabled", 0))
            return false;

        player = TrySolvePlayer(handler, player);
        if (!player)
            return false;

        if (Player* playerTarget = player->GetConnectedPlayer())
        {
            ObjectGuid guid = player->GetGUID();
            uint32 latency = playerTarget->GetSession()->GetLatency();

            const char* counterMeasureTemplate;
            const char* lineTemplate_u;
            const char* lineTemplate_s;
            const char* lineSeparator;
            const char* playerInformationTemplate;
            const char* ipAndLatencyTemplate;
            const char* banAndReasonTemplate;
            const char* averageTotalTemplate;
            if (handler->IsConsole())
            {
                counterMeasureTemplate = "Counter Measures Deployed: %u";
                lineTemplate_u = "%s Reports: %u";
                lineTemplate_s = "%s: %s";
                lineSeparator = "-----------------------------------------------------------------";
                playerInformationTemplate = "Information about player %s";
                ipAndLatencyTemplate = "IP Address: %s || Latency %u ms";
                banAndReasonTemplate = "Ban by: %s || Ban Reason: %s";
                averageTotalTemplate = "Average: %f || Total Reports: %u";
            }
            else
            {
                counterMeasureTemplate = "|cffff0000Counter Measures Deployed:|cffffff00 %u";
                lineTemplate_u = "|cffff0000%s Reports:|cffffff00 %u";
                lineTemplate_s = "|cffff0000%s:|cffffff00 %s";
                lineSeparator = "|cFFFFA500-----------------------------------------------------------------";
                playerInformationTemplate = "|cFF20B2AAInformation about player:|cffffff00 %s";
                ipAndLatencyTemplate = "|cffff0000IP Address: |cffffff00%s |cffff0000Latency |cffffff00%u ms";
                banAndReasonTemplate = "|cffff0000Ban by:|cffffff00 %s |cffff0000Ban Reason:|cffffff00 %s";
                averageTotalTemplate = "|cffff0000Average: |cffffff00%f |cffff0000Total Reports:|cffffff00 %u";
            }

            handler->PSendSysMessage(lineSeparator);
            handler->PSendSysMessage(playerInformationTemplate, player->GetName());
            handler->PSendSysMessage(ipAndLatencyTemplate, playerTarget->GetSession()->GetRemoteAddress(), latency);

            //                                                       0            1           2
            QueryResult resultADB = LoginDatabase.Query("SELECT `unbandate`, `banreason`, `bannedby` FROM `account_banned` WHERE `id` = {} ORDER BY `bandate` ASC", playerTarget->GetSession()->GetAccountId());
            if (resultADB)
            {
                do
                {
                    Field* fields = resultADB->Fetch();
                    std::string startbanEnd = Acore::Time::TimeToTimestampStr(Seconds(fields[0].Get<uint64>()));
                    std::string bannedReason = fields[1].Get<std::string>();
                    std::string bannedBy = fields[2].Get<std::string>();
                    handler->PSendSysMessage(lineTemplate_s, "Account Previously Banned", "Yes");
                    handler->PSendSysMessage(lineTemplate_s, "Ban Ended", startbanEnd);
                    handler->PSendSysMessage(banAndReasonTemplate, bannedBy, bannedReason);
                } while (resultADB->NextRow());
            }
            else
            {
                handler->PSendSysMessage(lineTemplate_s, "Account Previously Banned", "No");
            }

            //                                                           0            1           2
            QueryResult resultCDB = CharacterDatabase.Query("SELECT `unbandate`, `banreason`, `bannedby` FROM `character_banned` WHERE `guid` = {} ORDER BY `bandate` ASC;", playerTarget->GetGUID().GetCounter());
            if (resultCDB)
            {
                do
                {
                    Field* fields = resultCDB->Fetch();
                    std::string startbanEnd = Acore::Time::TimeToTimestampStr(Seconds(fields[0].Get<uint64>()));
                    std::string bannedReason = fields[1].Get<std::string>();
                    std::string bannedBy = fields[2].Get<std::string>();
                    handler->PSendSysMessage(lineTemplate_s, "Character Previously Banned", "Yes");
                    handler->PSendSysMessage(lineTemplate_s, "Ban Ended", startbanEnd);
                    handler->PSendSysMessage(banAndReasonTemplate, bannedBy, bannedReason);
                } while (resultCDB->NextRow());
            }
            else
            {
                handler->PSendSysMessage(lineTemplate_s, "Character Previously Banned", "No");
            }

            // If any row exists, then we consider "detected".
            if (CharacterDatabase.Query("SELECT TRUE FROM `account_data` WHERE `data` LIKE '%CastSpellByName%' AND `accountId` = {};", playerTarget->GetSession()->GetAccountId()))
            {
                handler->PSendSysMessage(lineTemplate_s, "Macro Requiring Lua Unlock Detected", "Yes");
            }
            else
            {
                handler->PSendSysMessage(lineTemplate_s, "Macro Requiring Lua Unlock Detected", "No");
            }

            float average = sAnticheatMgr->GetAverage(guid);
            uint32 total_reports = sAnticheatMgr->GetTotalReports(guid);
            uint32 counter_measures_reports = sAnticheatMgr->GetTypeReports(guid, COUNTER_MEASURES_REPORT);

            handler->PSendSysMessage(counterMeasureTemplate, counter_measures_reports);
            handler->PSendSysMessage(averageTotalTemplate, average, total_reports);

            if (uint32 speed_reports = sAnticheatMgr->GetTypeReports(guid, SPEED_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(SPEED_HACK_REPORT), speed_reports);

            if (uint32 fly_reports = sAnticheatMgr->GetTypeReports(guid, FLY_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(FLY_HACK_REPORT), fly_reports);

            if (uint32 jump_reports = sAnticheatMgr->GetTypeReports(guid, JUMP_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(JUMP_HACK_REPORT), jump_reports);

            if (uint32 waterwalk_reports = sAnticheatMgr->GetTypeReports(guid, WALK_WATER_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(WALK_WATER_HACK_REPORT), waterwalk_reports);

            if (uint32 teleportplane_reports = sAnticheatMgr->GetTypeReports(guid, TELEPORT_PLANE_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(TELEPORT_PLANE_HACK_REPORT), teleportplane_reports);

            if (uint32 teleport_reports = sAnticheatMgr->GetTypeReports(guid, TELEPORT_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(TELEPORT_HACK_REPORT), teleport_reports);

            if (uint32 climb_reports = sAnticheatMgr->GetTypeReports(guid, CLIMB_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(CLIMB_HACK_REPORT), climb_reports);

            if (uint32 ignorecontrol_reports = sAnticheatMgr->GetTypeReports(guid, IGNORE_CONTROL_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(IGNORE_CONTROL_REPORT), ignorecontrol_reports);

            if (uint32 zaxis_reports = sAnticheatMgr->GetTypeReports(guid, ZAXIS_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(ZAXIS_HACK_REPORT), zaxis_reports);

            if (uint32 antiswim_reports = sAnticheatMgr->GetTypeReports(guid, ANTISWIM_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(ANTISWIM_HACK_REPORT), antiswim_reports);

            if (uint32 gravity_reports = sAnticheatMgr->GetTypeReports(guid, GRAVITY_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(GRAVITY_HACK_REPORT), gravity_reports);

            if (uint32 antiknockback_reports = sAnticheatMgr->GetTypeReports(guid, ANTIKNOCK_BACK_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(ANTIKNOCK_BACK_HACK_REPORT), antiknockback_reports);

            if (uint32 no_fall_damage_reports = sAnticheatMgr->GetTypeReports(guid, NO_FALL_DAMAGE_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(NO_FALL_DAMAGE_HACK_REPORT), no_fall_damage_reports);

            if (uint32 op_ack_reports = sAnticheatMgr->GetTypeReports(guid, OP_ACK_HACK_REPORT))
                handler->PSendSysMessage(lineTemplate_u, sAnticheatMgr->GetReportNameFromReportType(OP_ACK_HACK_REPORT), op_ack_reports);

            return true;
        }

        return false;
    }

    static bool HandleAntiCheatGlobalCommand(ChatHandler* handler)
    {
        if (!sConfigMgr->GetOption<bool>("Anticheat.Enabled", 0))
        {
            handler->PSendSysMessage("The Anticheat System is disabled.");
            return true;
        }

        sAnticheatMgr->AnticheatGlobalCommand(handler);

        return true;
    }

    static bool HandleAntiCheatPurgeCommand(ChatHandler* handler)
    {
        sAnticheatMgr->AnticheatPurgeCommand(handler);
        handler->PSendSysMessage("The Anticheat daily_players_reports has been purged.");
        return true;
    }
};

void AddSC_anticheat_commandscript()
{
    new anticheat_commandscript();
}
