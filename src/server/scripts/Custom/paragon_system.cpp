/*
 * Paragon System - Diablo 3 Style
 * Unlimited levels beyond max level with stat point allocation
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "DatabaseEnv.h"
#include "Chat.h"
#include "World.h"
#include "WorldSessionMgr.h"
#include "SpellAuras.h"
#include <sstream>
#include <map>
#include <cmath>

// ============================================================
// PARAGON STAT TYPES
// ============================================================
enum ParagonStatType
{
    PARAGON_CORE = 0,
    PARAGON_OFFENSE = 1,
    PARAGON_DEFENSE = 2,
    PARAGON_UTILITY = 3
};

// ============================================================
// PARAGON SYSTEM MANAGER
// ============================================================
class ParagonSystem
{
public:
    static ParagonSystem* instance()
    {
        static ParagonSystem instance;
        return &instance;
    }

    // Get paragon level
    uint32 GetParagonLevel(Player* player)
    {
        if (!player)
            return 0;

        uint32 guid = player->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT paragon_level FROM character_paragon WHERE guid = {}", guid);
        
        if (result)
            return result->Fetch()[0].Get<uint32>();
        
        return 0;
    }

    // Get available paragon points
    uint32 GetAvailablePoints(Player* player)
    {
        if (!player)
            return 0;

        uint32 guid = player->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT paragon_points_available FROM character_paragon WHERE guid = {}", guid);
        
        if (result)
            return result->Fetch()[0].Get<uint32>();
        
        return 0;
    }

    // Add paragon experience
    void AddParagonExperience(Player* player, uint64 experience)
    {
        if (!player || experience == 0)
            return;

        uint32 guid = player->GetGUID().GetCounter();
        
        // Get current paragon data
        QueryResult result = CharacterDatabase.Query(
            "SELECT paragon_level, paragon_experience, paragon_points_available, paragon_tier "
            "FROM character_paragon WHERE guid = {}", guid);
        
        uint32 currentLevel = 0;
        uint64 currentExp = 0;
        uint32 availablePoints = 0;
        uint8 tier = 0;
        
        if (result)
        {
            Field* fields = result->Fetch();
            currentLevel = fields[0].Get<uint32>();
            currentExp = fields[1].Get<uint64>();
            availablePoints = fields[2].Get<uint32>();
            tier = fields[3].Get<uint8>();
        }

        // Add experience
        uint64 newExp = currentExp + experience;
        uint64 expNeeded = GetExperienceForNextLevel(currentLevel);
        
        uint32 levelsGained = 0;
        uint32 newLevel = currentLevel;
        
        // Level up if enough experience
        while (newExp >= expNeeded)
        {
            newExp -= expNeeded;
            newLevel++;
            levelsGained++;
            availablePoints++; // One point per level
            expNeeded = GetExperienceForNextLevel(newLevel);
            
            // Check for tier milestone (every 100 levels)
            uint8 newTier = newLevel / 100;
            if (newTier > tier)
            {
                OnParagonTierReached(player, newTier);
            }
        }

        // Update database
        CharacterDatabase.Execute(
            "INSERT INTO character_paragon (guid, paragon_level, paragon_experience, paragon_points_available, "
            "total_paragon_experience, paragon_tier, highest_paragon_level) "
            "VALUES ({}, {}, {}, {}, {}, {}, {}) "
            "ON DUPLICATE KEY UPDATE "
            "paragon_level = {}, paragon_experience = {}, paragon_points_available = {}, "
            "total_paragon_experience = total_paragon_experience + {}, paragon_tier = {}, "
            "highest_paragon_level = GREATEST(highest_paragon_level, {})",
            guid, newLevel, newExp, availablePoints, experience, newLevel / 100, newLevel,
            newLevel, newExp, availablePoints, experience, newLevel / 100, newLevel);

        // Notify player
        if (levelsGained > 0)
        {
            ChatHandler(player->GetSession()).PSendSysMessage(
                "|cFF00FF00Paragon Level Up!|r You reached Paragon Level %u! (+%u points)", 
                newLevel, levelsGained);
            player->PlayDirectSound(888); // Level up sound
            
            // World announcement for milestones
            if (newLevel % 100 == 0)
            {
                std::ostringstream announce;
                announce << "|cFF00FF00" << player->GetName() << "|r has reached |cFFFF0000Paragon Tier " 
                         << (newLevel / 100) << "|r! (Level " << newLevel << ")";
                sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, announce.str());
            }
        }
    }

    // Allocate paragon point to stat
    bool AllocateParagonPoint(Player* player, ParagonStatType statType, uint8 statId)
    {
        if (!player)
            return false;

        uint32 guid = player->GetGUID().GetCounter();
        
        // Check available points
        uint32 available = GetAvailablePoints(player);
        if (available == 0)
        {
            ChatHandler(player->GetSession()).PSendSysMessage("|cFFFF0000You have no available paragon points!|r");
            return false;
        }

        // Get current allocation
        QueryResult result = CharacterDatabase.Query(
            "SELECT points_allocated FROM character_paragon_stats "
            "WHERE guid = {} AND stat_type = {} AND stat_id = {}", guid, statType, statId);
        
        uint32 currentPoints = 0;
        if (result)
            currentPoints = result->Fetch()[0].Get<uint32>();

        // Check max points (50 default)
        QueryResult maxResult = WorldDatabase.Query(
            "SELECT max_points FROM paragon_stat_definitions WHERE stat_id = {}", statId);
        
        uint32 maxPoints = 50;
        if (maxResult)
            maxPoints = maxResult->Fetch()[0].Get<uint32>();

        if (currentPoints >= maxPoints)
        {
            ChatHandler(player->GetSession()).PSendSysMessage("|cFFFF0000This stat is at maximum!|r");
            return false;
        }

        // Allocate point
        CharacterDatabase.Execute(
            "INSERT INTO character_paragon_stats (guid, stat_type, stat_id, points_allocated) "
            "VALUES ({}, {}, {}, {}) "
            "ON DUPLICATE KEY UPDATE points_allocated = points_allocated + 1",
            guid, statType, statId, currentPoints + 1);

        // Deduct available point
        CharacterDatabase.Execute(
            "UPDATE character_paragon SET paragon_points_available = paragon_points_available - 1 WHERE guid = {}",
            guid);

        // Apply stat bonus
        ApplyParagonStat(player, statType, statId, currentPoints + 1);

        ChatHandler(player->GetSession()).PSendSysMessage(
            "|cFF00FF00Paragon point allocated!|r (+1 to stat)");
        
        return true;
    }

    // Apply paragon stat bonus
    void ApplyParagonStat(Player* player, ParagonStatType statType, uint8 statId, uint32 points)
    {
        if (!player || points == 0)
            return;

        // Get stat definition
        QueryResult result = WorldDatabase.Query(
            "SELECT stat_name, points_per_level FROM paragon_stat_definitions WHERE stat_id = {}", statId);
        
        if (!result)
            return;

        Field* fields = result->Fetch();
        std::string statName = fields[0].Get<std::string>();
        float pointsPerLevel = fields[1].Get<float>();
        
        float statValue = points * pointsPerLevel;

        // Apply based on stat type and name
        if (statType == PARAGON_CORE)
        {
            if (statName == "Strength")
                player->HandleStatFlatModifier(UNIT_MOD_STAT_STRENGTH, BASE_VALUE, statValue, true);
            else if (statName == "Agility")
                player->HandleStatFlatModifier(UNIT_MOD_STAT_AGILITY, BASE_VALUE, statValue, true);
            else if (statName == "Intellect")
                player->HandleStatFlatModifier(UNIT_MOD_STAT_INTELLECT, BASE_VALUE, statValue, true);
            else if (statName == "Stamina")
                player->HandleStatFlatModifier(UNIT_MOD_STAT_STAMINA, BASE_VALUE, statValue, true);
            else if (statName == "Spirit")
                player->HandleStatFlatModifier(UNIT_MOD_STAT_SPIRIT, BASE_VALUE, statValue, true);
        }
        else if (statType == PARAGON_OFFENSE)
        {
            if (statName == "Spell Power")
                player->ApplySpellPowerBonus(int32(statValue), true);
            else if (statName == "Attack Power")
            {
                player->HandleStatFlatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, statValue, true);
                player->HandleStatFlatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, statValue, true);
            }
            else if (statName == "Critical Strike")
            {
                player->ApplyRatingMod(CR_CRIT_MELEE, int32(statValue * 10), true);
                player->ApplyRatingMod(CR_CRIT_RANGED, int32(statValue * 10), true);
                player->ApplyRatingMod(CR_CRIT_SPELL, int32(statValue * 10), true);
            }
        }
        else if (statType == PARAGON_DEFENSE)
        {
            if (statName == "Armor")
            {
                player->HandleStatFlatModifier(UNIT_MOD_ARMOR, TOTAL_VALUE, statValue, true);
                player->UpdateArmor();
            }
            else if (statName == "Health")
            {
                player->HandleStatFlatModifier(UNIT_MOD_HEALTH, TOTAL_VALUE, statValue, true);
                player->UpdateMaxHealth();
            }
        }

        player->UpdateAllStats();
    }

    // Apply all paragon stats on login
    void ApplyAllParagonStats(Player* player)
    {
        if (!player)
            return;

        uint32 guid = player->GetGUID().GetCounter();
        
        QueryResult result = CharacterDatabase.Query(
            "SELECT stat_type, stat_id, points_allocated FROM character_paragon_stats WHERE guid = {}", guid);
        
        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                ParagonStatType statType = ParagonStatType(fields[0].Get<uint8>());
                uint8 statId = fields[1].Get<uint8>();
                uint32 points = fields[2].Get<uint32>();
                
                ApplyParagonStat(player, statType, statId, points);
            } while (result->NextRow());
        }
    }

    // Get experience needed for next level
    uint64 GetExperienceForNextLevel(uint32 level)
    {
        // Exponential growth: base * (1.1 ^ level)
        // Base experience for level 1 = 1000
        return static_cast<uint64>(1000 * pow(1.1, level));
    }

    // On paragon tier reached
    void OnParagonTierReached(Player* player, uint8 tier)
    {
        if (!player)
            return;

        // Award milestone reward
        uint32 guid = player->GetGUID().GetCounter();
        uint32 milestoneLevel = tier * 100;
        
        CharacterDatabase.Execute(
            "INSERT INTO character_paragon_milestones (guid, milestone_id, reward_claimed) "
            "VALUES ({}, {}, 0) ON DUPLICATE KEY UPDATE milestone_id = milestone_id",
            guid, milestoneLevel);

        // Bonus points for tier milestone
        uint32 bonusPoints = tier; // 1 point per tier
        CharacterDatabase.Execute(
            "UPDATE character_paragon SET paragon_points_available = paragon_points_available + {} WHERE guid = {}",
            bonusPoints, guid);

        ChatHandler(player->GetSession()).PSendSysMessage(
            "|cFF00FF00Paragon Tier %u Reached!|r You earned %u bonus paragon points!", tier, bonusPoints);
    }

    // Get paragon info for display
    struct ParagonInfo
    {
        uint32 level;
        uint64 currentExp;
        uint64 expNeeded;
        uint32 availablePoints;
        uint8 tier;
    };

    ParagonInfo GetParagonInfo(Player* player)
    {
        ParagonInfo info = {0, 0, 0, 0, 0};
        
        if (!player)
            return info;

        uint32 guid = player->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT paragon_level, paragon_experience, paragon_points_available, paragon_tier "
            "FROM character_paragon WHERE guid = {}", guid);
        
        if (result)
        {
            Field* fields = result->Fetch();
            info.level = fields[0].Get<uint32>();
            info.currentExp = fields[1].Get<uint64>();
            info.availablePoints = fields[2].Get<uint32>();
            info.tier = fields[3].Get<uint8>();
            info.expNeeded = GetExperienceForNextLevel(info.level);
        }
        
        return info;
    }
};

#define sParagonSystem ParagonSystem::instance()

// ============================================================
// PLAYER SCRIPT - Apply paragon on login and gain experience
// ============================================================
class ParagonPlayerScript : public PlayerScript
{
public:
    ParagonPlayerScript() : PlayerScript("ParagonPlayerScript") { }

    void OnLogin(Player* player) override
    {
        // Apply all paragon stats
        sParagonSystem->ApplyAllParagonStats(player);
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* victim) override
    {
        // If player is max level, convert XP to paragon experience
        if (player->GetLevel() >= player->GetUInt32Value(PLAYER_FIELD_MAX_LEVEL))
        {
            // Convert 10% of XP to paragon experience
            uint64 paragonExp = static_cast<uint64>(amount * 0.1f);
            sParagonSystem->AddParagonExperience(player, paragonExp);
        }
    }

    void OnPlayerKilledByCreature(Creature* killer, Player* killed) override
    {
        // Award paragon experience on death (small amount)
        if (killed->GetLevel() >= killed->GetUInt32Value(PLAYER_FIELD_MAX_LEVEL))
        {
            uint64 paragonExp = 100; // Base paragon exp
            sParagonSystem->AddParagonExperience(killed, paragonExp);
        }
    }
};

// ============================================================
// PARAGON NPC
// ============================================================
class npc_paragon_master : public CreatureScript
{
public:
    npc_paragon_master() : CreatureScript("npc_paragon_master") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);
        
        ParagonSystem::ParagonInfo info = sParagonSystem->GetParagonInfo(player);
        
        std::ostringstream greeting;
        greeting << "|TInterface\\Icons\\Achievement_Level_80:30|t |cFF00FFFFParagon System|r\n\n";
        greeting << "|cFF00FF00Paragon Level:|r " << info.level << "\n";
        greeting << "|cFF00FF00Paragon Tier:|r " << (int)info.tier << "\n";
        greeting << "|cFF00FF00Available Points:|r " << info.availablePoints << "\n";
        greeting << "|cFFAAAAFFExperience:|r " << info.currentExp << " / " << info.expNeeded << "\n";
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, greeting.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Misc_QuestionMark:20|t Allocate Points", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Enchant_Disenchant:20|t View Stats", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Achievement_Leader_Horde:20|t Leaderboard", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            ShowAllocateMenu(player, creature, PARAGON_CORE);
        }
        else if (action == GOSSIP_ACTION_INFO_DEF + 2)
        {
            ShowStatsMenu(player, creature);
        }
        else if (action == GOSSIP_ACTION_INFO_DEF + 3)
        {
            ShowLeaderboard(player, creature);
        }
        else if (action >= GOSSIP_ACTION_INFO_DEF + 10 && action <= GOSSIP_ACTION_INFO_DEF + 13)
        {
            // Category selection
            ShowAllocateMenu(player, creature, ParagonStatType(action - GOSSIP_ACTION_INFO_DEF - 10));
        }
        else if (action >= GOSSIP_ACTION_INFO_DEF + 1000)
        {
            // Stat allocation: action = 1000 + (statType * 100) + statId
            uint32 baseAction = action - GOSSIP_ACTION_INFO_DEF - 1000;
            ParagonStatType statType = ParagonStatType(baseAction / 100);
            uint8 statId = baseAction % 100;
            
            if (sParagonSystem->AllocateParagonPoint(player, statType, statId))
            {
                // Refresh menu
                ShowAllocateMenu(player, creature, statType);
            }
            else
            {
                ShowAllocateMenu(player, creature, statType);
            }
        }
        else
        {
            OnGossipHello(player, creature);
        }
        
        return true;
    }

    void ShowAllocateMenu(Player* player, Creature* creature, ParagonStatType statType)
    {
        ClearGossipMenuFor(player);
        
        std::ostringstream menu;
        menu << "|TInterface\\Icons\\INV_Enchant_Disenchant:30|t |cFF00FFFFAllocate Paragon Points|r\n\n";
        
        const char* typeNames[] = {"Core", "Offense", "Defense", "Utility"};
        menu << "|cFF00FF00Category:|r " << typeNames[statType] << "\n\n";
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, menu.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        
        // Get stats for this category
        QueryResult result = WorldDatabase.Query(
            "SELECT stat_id, stat_name, max_points FROM paragon_stat_definitions "
            "WHERE stat_type = {} AND active = 1 ORDER BY sort_order", statType);
        
        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                uint8 statId = fields[0].Get<uint8>();
                std::string statName = fields[1].Get<std::string>();
                uint32 maxPoints = fields[2].Get<uint32>();
                
                // Get current allocation
                uint32 guid = player->GetGUID().GetCounter();
                QueryResult allocResult = CharacterDatabase.Query(
                    "SELECT points_allocated FROM character_paragon_stats "
                    "WHERE guid = {} AND stat_type = {} AND stat_id = {}", guid, statType, statId);
                
                uint32 currentPoints = 0;
                if (allocResult)
                    currentPoints = allocResult->Fetch()[0].Get<uint32>();
                
                std::ostringstream option;
                option << "|TInterface\\Icons\\INV_Enchant_Disenchant:20|t " << statName 
                       << " (" << currentPoints << "/" << maxPoints << ")";
                
                // Use unique action ID: 1000 + (statType * 100) + statId
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, option.str(), 
                    GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1000 + (statType * 100) + statId);
            } while (result->NextRow());
        }
        
        // Category selection
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Misc_QuestionMark:20|t Core Stats", 
            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Sword_04:20|t Offense Stats", 
            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Shield_05:20|t Defense Stats", 
            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Misc_Bag_08:20|t Utility Stats", 
            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Ability_Repair:20|t Back", 
            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
    }

    void ShowStatsMenu(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        
        std::ostringstream stats;
        stats << "|TInterface\\Icons\\INV_Misc_QuestionMark:30|t |cFF00FFFFYour Paragon Stats|r\n\n";
        
        uint32 guid = player->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT ps.stat_type, ps.stat_id, ps.points_allocated, pd.stat_name "
            "FROM character_paragon_stats ps "
            "JOIN paragon_stat_definitions pd ON ps.stat_id = pd.stat_id "
            "WHERE ps.guid = {} ORDER BY ps.stat_type, pd.sort_order", guid);
        
        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                uint8 statType = fields[0].Get<uint8>();
                uint32 points = fields[2].Get<uint32>();
                std::string statName = fields[3].Get<std::string>();
                
                stats << "|cFF00FF00" << statName << ":|r " << points << " points\n";
            } while (result->NextRow());
        }
        else
        {
            stats << "|cFFFF0000No stats allocated yet!|r\n";
        }
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, stats.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Ability_Repair:20|t Back", 
            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
    }

    void ShowLeaderboard(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        
        std::ostringstream leaderboard;
        leaderboard << "|TInterface\\Icons\\Achievement_Leader_Horde:30|t |cFF00FFFFParagon Leaderboard|r\n\n";
        leaderboard << "|cFF00FF00Top 10 Players:|r\n\n";
        
        QueryResult result = CharacterDatabase.Query(
            "SELECT c.name, p.paragon_level, p.paragon_tier "
            "FROM character_paragon p "
            "JOIN characters c ON p.guid = c.guid "
            "ORDER BY p.paragon_level DESC, p.total_paragon_experience DESC "
            "LIMIT 10");
        
        if (result)
        {
            uint8 rank = 1;
            do
            {
                Field* fields = result->Fetch();
                std::string name = fields[0].Get<std::string>();
                uint32 level = fields[1].Get<uint32>();
                uint8 tier = fields[2].Get<uint8>();
                
                leaderboard << "|cFFFFFF00#" << (int)rank << "|r " << name 
                           << " - Level " << level << " (Tier " << (int)tier << ")\n";
                rank++;
            } while (result->NextRow());
        }
        else
        {
            leaderboard << "|cFFFF0000No paragon players yet!|r\n";
        }
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, leaderboard.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Ability_Repair:20|t Back", 
            GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
    }
};

void AddSC_paragon_system()
{
    new ParagonPlayerScript();
    new npc_paragon_master();
}

