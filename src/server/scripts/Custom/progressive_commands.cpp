/*
 * Progressive Commands
 * GM commands for progressive systems
 */

#include "ScriptMgr.h"
#include "Chat.h"
#include "Player.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "CommandScript.h"
#include "ChatCommands/ChatCommand.h"
#include "Optional.h"
#include <sstream>
#include <cmath>

using namespace Acore::ChatCommands;

class progressive_commands : public CommandScript
{
public:
    progressive_commands() : CommandScript("progressive_commands") { }

    std::vector<Acore::ChatCommands::ChatCommandBuilder> GetCommands() const override
    {
        static ChatCommandTable progressiveCommandTable =
        {
            { "tier",      HandleProgressiveTierCommand,      SEC_ADMINISTRATOR,     Console::No },
            { "points",    HandleProgressivePointsCommand,    SEC_ADMINISTRATOR,     Console::No },
            { "prestige",  HandleProgressivePrestigeCommand,  SEC_ADMINISTRATOR,     Console::No },
            { "power",     HandleProgressivePowerCommand,     SEC_PLAYER,            Console::No },
            { "stats",     HandleProgressiveStatsCommand,     SEC_PLAYER,            Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "progressive", progressiveCommandTable },
        };

        return commandTable;
    }

    static bool HandleProgressiveTierCommand(ChatHandler* handler, Optional<uint8> tier)
    {
        if (!tier || *tier < 1 || *tier > 100)
        {
            handler->PSendSysMessage("Tier must be between 1 and 100.");
            handler->PSendSysMessage("Usage: .progressive tier <tier>");
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->PSendSysMessage("No player selected.");
            return false;
        }

        uint32 guid = target->GetGUID().GetCounter();
        CharacterDatabase.Execute(
            "INSERT INTO character_progression_unified (guid, current_tier) VALUES ({}, {}) "
            "ON DUPLICATE KEY UPDATE current_tier = {}",
            guid, *tier, *tier);

        handler->PSendSysMessage("Set %s's progression tier to %u.", target->GetName().c_str(), *tier);
        return true;
    }

    static bool HandleProgressivePointsCommand(ChatHandler* handler, uint32 points)
    {
        if (points == 0 || points > 1000000)
        {
            handler->PSendSysMessage("Points must be between 1 and 1,000,000.");
            handler->PSendSysMessage("Usage: .progressive points <amount>");
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->PSendSysMessage("No player selected.");
            return false;
        }

        uint32 guid = target->GetGUID().GetCounter();
        CharacterDatabase.Execute(
            "INSERT INTO character_progression_unified (guid, progression_points) VALUES ({}, {}) "
            "ON DUPLICATE KEY UPDATE progression_points = progression_points + {}",
            guid, points, points);

        handler->PSendSysMessage("Added %u progression points to %s.", points, target->GetName().c_str());
        return true;
    }

    static bool HandleProgressivePrestigeCommand(ChatHandler* handler, Optional<uint32> prestige)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->PSendSysMessage("No player selected.");
            return false;
        }

        uint32 guid = target->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT prestige_level FROM character_progression_unified WHERE guid = {}", guid);
        
        uint32 prestigeLevel = 0;
        if (result)
            prestigeLevel = result->Fetch()[0].Get<uint32>();

        if (prestige)
        {
            CharacterDatabase.Execute(
                "INSERT INTO character_progression_unified (guid, prestige_level) VALUES ({}, {}) "
                "ON DUPLICATE KEY UPDATE prestige_level = {}",
                guid, *prestige, *prestige);
            
            handler->PSendSysMessage("Set %s's prestige level to %u.", target->GetName().c_str(), *prestige);
        }
        else
        {
            handler->PSendSysMessage("%s's prestige level: %u", target->GetName().c_str(), prestigeLevel);
        }

        return true;
    }

    static bool HandleProgressivePowerCommand(ChatHandler* handler)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (!target)
            return false;

        uint32 guid = target->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT total_power_level, current_tier, prestige_level, progression_points "
            "FROM character_progression_unified WHERE guid = {}", guid);

        if (!result)
        {
            handler->PSendSysMessage("No progression data found.");
            return true;
        }

        Field* fields = result->Fetch();
        uint32 powerLevel = fields[0].Get<uint32>();
        uint8 tier = fields[1].Get<uint8>();
        uint32 prestige = fields[2].Get<uint32>();
        uint64 points = fields[3].Get<uint64>();

        handler->PSendSysMessage("|cFF00FFFF=== Progressive Power Level ===|r");
        handler->PSendSysMessage("Power Level: |cFF00FF00%u|r", powerLevel);
        handler->PSendSysMessage("Current Tier: |cFFFFFF00%u|r", tier);
        handler->PSendSysMessage("Prestige Level: |cFFFF0000%u|r", prestige);
        handler->PSendSysMessage("Progression Points: |cFF00FF00%llu|r", points);

        return true;
    }

    static bool HandleProgressiveStatsCommand(ChatHandler* handler)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (!target)
            return false;

        uint32 guid = target->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT total_kills, claimed_milestone, highest_floor "
            "FROM character_progression_unified WHERE guid = {}", guid);

        if (!result)
        {
            handler->PSendSysMessage("No progression stats found.");
            return true;
        }

        Field* fields = result->Fetch();
        uint32 kills = fields[0].Get<uint32>();
        uint32 milestone = fields[1].Get<uint32>();
        uint32 floor = 0;
        if (!fields[2].IsNull())
            floor = fields[2].Get<uint32>();

        handler->PSendSysMessage("|cFF00FFFF=== Progressive Statistics ===|r");
        handler->PSendSysMessage("Total Kills: |cFF00FF00%u|r", kills);
        handler->PSendSysMessage("Last Milestone: |cFFFFFF00%u|r", milestone);
        if (floor > 0)
            handler->PSendSysMessage("Highest Floor: |cFFFF0000%u|r", floor);

        return true;
    }

    static bool HandleParagonCommand(ChatHandler* handler)
    {
        Player* target = handler->getSelectedPlayerOrSelf();
        if (!target)
            return false;

        uint32 guid = target->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT paragon_level, paragon_experience, paragon_points_available, paragon_tier, total_paragon_experience "
            "FROM character_paragon WHERE guid = {}", guid);

        if (!result)
        {
            handler->PSendSysMessage("|cFFFF0000No paragon data found. Reach level 80 to start earning paragon experience!|r");
            return true;
        }

        Field* fields = result->Fetch();
        uint32 level = fields[0].Get<uint32>();
        uint64 currentExp = fields[1].Get<uint64>();
        uint32 availablePoints = fields[2].Get<uint32>();
        uint8 tier = fields[3].Get<uint8>();
        uint64 totalExp = fields[4].Get<uint64>();

        // Calculate exp needed
        uint64 expNeeded = static_cast<uint64>(1000 * pow(1.1, level));
        float expPercent = expNeeded > 0 ? (float(currentExp) / float(expNeeded)) * 100.0f : 0.0f;

        handler->PSendSysMessage("|cFF00FFFF=== Paragon System ===|r");
        handler->PSendSysMessage("Paragon Level: |cFF00FF00%u|r", level);
        handler->PSendSysMessage("Paragon Tier: |cFFFF0000%u|r", tier);
        handler->PSendSysMessage("Available Points: |cFFFFFF00%u|r", availablePoints);
        handler->PSendSysMessage("Experience: |cFFAAAAFF%llu / %llu (%.1f%%)|r", currentExp, expNeeded, expPercent);
        handler->PSendSysMessage("Total Experience: |cFF00FF00%llu|r", totalExp);
        handler->PSendSysMessage("|cFFAAAAFFTalk to Paragon Master NPC to allocate points!|r");

        return true;
    }
};

void AddSC_progressive_commands()
{
    new progressive_commands();
}

