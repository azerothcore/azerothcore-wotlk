/*
 * Progressive Systems Debug Commands Implementation
 */

#include "ProgressiveSystemsCommands.h"
#include "ProgressiveSystems.h"
#include "ProgressiveSystemsCache.h"
#include "Chat.h"
#include "Player.h"
#include "Config.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "ChatCommands/ChatCommand.h"
#include "DatabaseEnv.h"
#include "Optional.h"

bool ProgressiveSystemsCommands::HandleProgressiveSystemsInfoCommand(ChatHandler* handler)
{
    if (!handler->GetSession() || !handler->GetSession()->GetPlayer())
    {
        handler->PSendSysMessage("This command can only be used by a player.");
        return false;
    }
    
    Player* player = handler->GetSession()->GetPlayer();
    uint32 guid = player->GetGUID().GetCounter();
    
    // Get progression data
    uint64 points = sProgressiveSystems->GetProgressionPoints(player);
    uint32 kills = sProgressiveSystems->GetTotalKills(player);
    uint8 tier = sProgressiveSystems->GetCurrentProgressionTier(player);
    uint8 difficultyTier = sProgressiveSystems->GetDifficultyTier(player, player->GetMap());
    uint32 prestige = sProgressiveSystems->GetPrestigeLevel(player);
    uint32 powerLevel = sProgressiveSystems->CalculatePowerLevel(player);
    
    handler->PSendSysMessage("=== Progressive Systems Info ===");
    handler->PSendSysMessage("Progression Points: %llu", points);
    handler->PSendSysMessage("Total Kills: %u", kills);
    handler->PSendSysMessage("Current Tier: %u", tier);
    handler->PSendSysMessage("Difficulty Tier: %u", difficultyTier);
    handler->PSendSysMessage("Prestige Level: %u", prestige);
    handler->PSendSysMessage("Power Level: %u", powerLevel);
    
    // Configuration info
    bool debug = sConfigMgr->GetOption<bool>("ProgressiveSystems.Debug", false);
    bool enabled = sConfigMgr->GetOption<bool>("ProgressiveSystems.Enable", true);
    handler->PSendSysMessage("Module Enabled: %s", enabled ? "Yes" : "No");
    handler->PSendSysMessage("Debug Mode: %s", debug ? "Yes" : "No");
    
    return true;
}

bool ProgressiveSystemsCommands::HandleProgressiveSystemsPointsCommand(ChatHandler* handler, Optional<uint32> points)
{
    if (!handler->GetSession() || !handler->GetSession()->GetPlayer())
    {
        handler->PSendSysMessage("This command can only be used by a player.");
        return false;
    }
    
    if (!points || *points == 0 || *points > 1000000)
    {
        handler->PSendSysMessage("Invalid point amount. Must be between 1 and 1,000,000.");
        handler->PSendSysMessage("Usage: .ps points <amount>");
        return false;
    }
    
    Player* player = handler->GetSession()->GetPlayer();
    sProgressiveSystems->AddProgressionPoints(player, *points);
    handler->PSendSysMessage("Added %u progression points to %s.", *points, player->GetName().c_str());
    
    return true;
}

bool ProgressiveSystemsCommands::HandleProgressiveSystemsTierCommand(ChatHandler* handler, Optional<uint8> tier)
{
    if (!handler->GetSession() || !handler->GetSession()->GetPlayer())
    {
        handler->PSendSysMessage("This command can only be used by a player.");
        return false;
    }
    
    if (!tier || *tier == 0 || *tier > 100)
    {
        handler->PSendSysMessage("Invalid tier. Must be between 1 and 100.");
        handler->PSendSysMessage("Usage: .ps tier <tier>");
        return false;
    }
    
    Player* player = handler->GetSession()->GetPlayer();
    Map* map = player->GetMap();
    
    if (map && (map->IsDungeon() || map->IsRaid()))
    {
        sProgressiveSystems->SetDifficultyTier(player, map, *tier);
        handler->PSendSysMessage("Set difficulty tier to %u for current instance.", *tier);
    }
    else
    {
        handler->PSendSysMessage("You must be in a dungeon or raid to set difficulty tier.");
        return false;
    }
    
    return true;
}

bool ProgressiveSystemsCommands::HandleProgressiveSystemsResetCommand(ChatHandler* handler)
{
    if (!handler->GetSession() || !handler->GetSession()->GetPlayer())
    {
        handler->PSendSysMessage("This command can only be used by a player.");
        return false;
    }
    
    Player* player = handler->GetSession()->GetPlayer();
    uint32 guid = player->GetGUID().GetCounter();
    
    // Reset progression data (keep prestige)
    CharacterDatabase.Execute(
        "UPDATE character_progression_unified SET "
        "total_kills = 0, "
        "claimed_milestone = 0, "
        "difficulty_tier = 1, "
        "current_tier = 1, "
        "total_power_level = 0, "
        "progression_points = 0 "
        "WHERE guid = {}", guid);
    
    // Invalidate cache
    sProgressiveSystemsCache->InvalidateCache(guid);
    
    handler->PSendSysMessage("Reset progression data for %s (prestige level preserved).", player->GetName().c_str());
    
    return true;
}

bool ProgressiveSystemsCommands::HandleProgressiveSystemsDebugCommand(ChatHandler* handler, Optional<bool> enable)
{
    // This would require a runtime config change, which is complex
    // For now, just inform the user
    bool currentDebug = sConfigMgr->GetOption<bool>("ProgressiveSystems.Debug", false);
    handler->PSendSysMessage("Current debug mode: %s", currentDebug ? "ENABLED" : "DISABLED");
    handler->PSendSysMessage("Debug mode can be changed in mod-progressive-systems.conf");
    if (enable)
    {
        handler->PSendSysMessage("Set ProgressiveSystems.Debug = %d and reload config.", *enable ? 1 : 0);
    }
    
    return true;
}

bool ProgressiveSystemsCommands::HandleProgressiveSystemsCacheCommand(ChatHandler* handler)
{
    // Show cache statistics (if we had them)
    handler->PSendSysMessage("Cache cleared. (Statistics not yet implemented)");
    sProgressiveSystemsCache->ClearCache();
    
    return true;
}

// Command script registration
class ProgressiveSystemsCommandScript : public CommandScript
{
public:
    ProgressiveSystemsCommandScript() : CommandScript("ProgressiveSystemsCommandScript") { }

    std::vector<Acore::ChatCommands::ChatCommandBuilder> GetCommands() const override
    {
        using namespace Acore::ChatCommands;
        
        static ChatCommandTable progressiveSystemsCommandTable =
        {
            { "info",     HandleProgressiveSystemsInfoCommand,     SEC_PLAYER,     Console::No },
            { "points",   HandleProgressiveSystemsPointsCommand,   SEC_ADMINISTRATOR, Console::No },
            { "tier",     HandleProgressiveSystemsTierCommand,     SEC_ADMINISTRATOR, Console::No },
            { "reset",    HandleProgressiveSystemsResetCommand,    SEC_ADMINISTRATOR, Console::No },
            { "debug",    HandleProgressiveSystemsDebugCommand,    SEC_PLAYER,     Console::No },
            { "cache",    HandleProgressiveSystemsCacheCommand,    SEC_ADMINISTRATOR, Console::No },
        };
        
        static ChatCommandTable commandTable =
        {
            { "ps",       progressiveSystemsCommandTable },
            { "progressive", progressiveSystemsCommandTable },
        };
        
        return commandTable;
    }
};

void AddSC_ProgressiveSystemsCommands()
{
    new ProgressiveSystemsCommandScript();
}

