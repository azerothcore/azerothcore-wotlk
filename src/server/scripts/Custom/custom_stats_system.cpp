/*
 * Custom Stats System
 * New stats beyond standard 5 stats (STR, AGI, STA, INT, SPI)
 * Includes: Intelligence, Attack Speed, Cast Speed, Movement Speed, etc.
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Item.h"
#include "DatabaseEnv.h"
#include "Chat.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include <sstream>
#include <map>

// ============================================================
// CUSTOM STAT TYPES
// ============================================================
enum CustomStatType
{
    CUSTOM_STAT_INTELLIGENCE = 0,
    CUSTOM_STAT_ATTACK_SPEED = 1,
    CUSTOM_STAT_CAST_SPEED = 2,
    CUSTOM_STAT_MOVEMENT_SPEED = 3,
    CUSTOM_STAT_CRITICAL_STRIKE = 4,
    CUSTOM_STAT_HASTE = 5,
    CUSTOM_STAT_MASTERY = 6,
    CUSTOM_STAT_VERSATILITY = 7,
    CUSTOM_STAT_LIFESTEAL = 8,
    CUSTOM_STAT_MULTISTRIKE = 9,
    CUSTOM_STAT_SPELL_POWER = 10,
    CUSTOM_STAT_ATTACK_POWER = 11,
    CUSTOM_STAT_ARMOR = 12,
    CUSTOM_STAT_RESISTANCE = 13,
    CUSTOM_STAT_HEALTH_REGEN = 14,
    CUSTOM_STAT_MANA_REGEN = 15,
    CUSTOM_STAT_EXPERIENCE = 16,
    CUSTOM_STAT_GOLD = 17,
    CUSTOM_STAT_LOOT = 18,
    MAX_CUSTOM_STATS = 19
};

// ============================================================
// CUSTOM STATS MANAGER
// ============================================================
class CustomStatsManager
{
public:
    static CustomStatsManager* instance()
    {
        static CustomStatsManager instance;
        return &instance;
    }

    // Get custom stat value for player
    int32 GetCustomStat(Player* player, CustomStatType statType)
    {
        if (!player)
            return 0;

        uint32 guid = player->GetGUID().GetCounter();
        std::string statName = GetStatColumnName(statType);
        
        QueryResult result = CharacterDatabase.Query(
            "SELECT {} FROM character_custom_stats WHERE guid = {}", statName, guid);
        
        if (result)
            return result->Fetch()[0].Get<int32>();
        
        return 0;
    }

    // Set custom stat value for player
    void SetCustomStat(Player* player, CustomStatType statType, int32 value)
    {
        if (!player)
            return;

        uint32 guid = player->GetGUID().GetCounter();
        std::string statName = GetStatColumnName(statType);
        
        CharacterDatabase.Execute(
            "INSERT INTO character_custom_stats (guid, {}) VALUES ({}, {}) "
            "ON DUPLICATE KEY UPDATE {} = {}",
            statName, guid, value, statName, value);
        
        ApplyCustomStat(player, statType, value);
    }

    // Add custom stat value (additive)
    void AddCustomStat(Player* player, CustomStatType statType, int32 value)
    {
        int32 current = GetCustomStat(player, statType);
        SetCustomStat(player, statType, current + value);
    }

    // Apply custom stat to player
    void ApplyCustomStat(Player* player, CustomStatType statType, int32 value)
    {
        if (!player || value == 0)
            return;

        switch (statType)
        {
            case CUSTOM_STAT_INTELLIGENCE:
                // Apply as intellect bonus via aura
                ApplyIntelligenceBonus(player, value);
                break;
            case CUSTOM_STAT_ATTACK_SPEED:
                // Apply attack speed via aura
                ApplyAttackSpeedBonus(player, value);
                break;
            case CUSTOM_STAT_CAST_SPEED:
                // Apply cast speed via aura
                ApplyCastSpeedBonus(player, value);
                break;
            case CUSTOM_STAT_MOVEMENT_SPEED:
                // Apply movement speed via aura
                ApplyMovementSpeedBonus(player, value);
                break;
            case CUSTOM_STAT_CRITICAL_STRIKE:
                // Apply crit rating
                player->ApplyRatingMod(CR_CRIT_MELEE, value, true);
                player->ApplyRatingMod(CR_CRIT_RANGED, value, true);
                player->ApplyRatingMod(CR_CRIT_SPELL, value, true);
                break;
            case CUSTOM_STAT_HASTE:
                // Apply haste rating
                player->ApplyRatingMod(CR_HASTE_MELEE, value, true);
                player->ApplyRatingMod(CR_HASTE_RANGED, value, true);
                player->ApplyRatingMod(CR_HASTE_SPELL, value, true);
                break;
            case CUSTOM_STAT_SPELL_POWER:
                player->ApplySpellPowerBonus(value, true);
                break;
            case CUSTOM_STAT_ATTACK_POWER:
                player->HandleStatFlatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, float(value), true);
                player->HandleStatFlatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(value), true);
                break;
            case CUSTOM_STAT_ARMOR:
                player->HandleStatFlatModifier(UNIT_MOD_ARMOR, TOTAL_VALUE, float(value), true);
                player->UpdateArmor();
                break;
            case CUSTOM_STAT_RESISTANCE:
                // Apply to all resistances
                for (uint8 i = 0; i < MAX_SPELL_SCHOOL; ++i)
                {
                    player->HandleStatFlatModifier(UnitMods(UNIT_MOD_RESISTANCE_START + i), TOTAL_VALUE, float(value), true);
                    player->UpdateResistances(i);
                }
                break;
            case CUSTOM_STAT_HEALTH_REGEN:
                // Apply health regen via aura
                if (Aura* aura = player->AddAura(65116, player))
                {
                    if (AuraEffect* eff = aura->GetEffect(0))
                    {
                        eff->SetAmount(value); // Percentage bonus
                    }
                }
                break;
            case CUSTOM_STAT_MANA_REGEN:
                // Apply mana regen via aura
                if (Aura* aura = player->AddAura(65116, player))
                {
                    if (AuraEffect* eff = aura->GetEffect(0))
                    {
                        eff->SetAmount(value); // Percentage bonus
                    }
                }
                break;
        }
    }

    // Apply all custom stats from database
    void ApplyAllCustomStats(Player* player)
    {
        if (!player)
            return;

        for (uint8 i = 0; i < MAX_CUSTOM_STATS; ++i)
        {
            int32 value = GetCustomStat(player, CustomStatType(i));
            if (value != 0)
                ApplyCustomStat(player, CustomStatType(i), value);
        }
    }

    // Get stat column name
    std::string GetStatColumnName(CustomStatType statType)
    {
        switch (statType)
        {
            case CUSTOM_STAT_INTELLIGENCE: return "intelligence_bonus";
            case CUSTOM_STAT_ATTACK_SPEED: return "attack_speed_bonus";
            case CUSTOM_STAT_CAST_SPEED: return "cast_speed_bonus";
            case CUSTOM_STAT_MOVEMENT_SPEED: return "movement_speed_bonus";
            case CUSTOM_STAT_CRITICAL_STRIKE: return "critical_strike_bonus";
            case CUSTOM_STAT_HASTE: return "haste_bonus";
            case CUSTOM_STAT_MASTERY: return "mastery_bonus";
            case CUSTOM_STAT_VERSATILITY: return "versatility_bonus";
            case CUSTOM_STAT_LIFESTEAL: return "lifesteal_bonus";
            case CUSTOM_STAT_MULTISTRIKE: return "multistrike_bonus";
            case CUSTOM_STAT_SPELL_POWER: return "spell_power_bonus";
            case CUSTOM_STAT_ATTACK_POWER: return "attack_power_bonus";
            case CUSTOM_STAT_ARMOR: return "armor_bonus";
            case CUSTOM_STAT_RESISTANCE: return "resistance_bonus";
            case CUSTOM_STAT_HEALTH_REGEN: return "health_regen_bonus";
            case CUSTOM_STAT_MANA_REGEN: return "mana_regen_bonus";
            case CUSTOM_STAT_EXPERIENCE: return "experience_bonus";
            case CUSTOM_STAT_GOLD: return "gold_bonus";
            case CUSTOM_STAT_LOOT: return "loot_bonus";
            default: return "";
        }
    }

    // Get stat display name
    std::string GetStatDisplayName(CustomStatType statType)
    {
        switch (statType)
        {
            case CUSTOM_STAT_INTELLIGENCE: return "Intelligence";
            case CUSTOM_STAT_ATTACK_SPEED: return "Attack Speed";
            case CUSTOM_STAT_CAST_SPEED: return "Cast Speed";
            case CUSTOM_STAT_MOVEMENT_SPEED: return "Movement Speed";
            case CUSTOM_STAT_CRITICAL_STRIKE: return "Critical Strike";
            case CUSTOM_STAT_HASTE: return "Haste";
            case CUSTOM_STAT_MASTERY: return "Mastery";
            case CUSTOM_STAT_VERSATILITY: return "Versatility";
            case CUSTOM_STAT_LIFESTEAL: return "Lifesteal";
            case CUSTOM_STAT_MULTISTRIKE: return "Multistrike";
            case CUSTOM_STAT_SPELL_POWER: return "Spell Power";
            case CUSTOM_STAT_ATTACK_POWER: return "Attack Power";
            case CUSTOM_STAT_ARMOR: return "Armor";
            case CUSTOM_STAT_RESISTANCE: return "Resistance";
            case CUSTOM_STAT_HEALTH_REGEN: return "Health Regen";
            case CUSTOM_STAT_MANA_REGEN: return "Mana Regen";
            case CUSTOM_STAT_EXPERIENCE: return "Experience";
            case CUSTOM_STAT_GOLD: return "Gold";
            case CUSTOM_STAT_LOOT: return "Loot";
            default: return "Unknown";
        }
    }

private:
    void ApplyIntelligenceBonus(Player* player, int32 value)
    {
        // Apply as intellect stat bonus
        player->HandleStatFlatModifier(UNIT_MOD_STAT_INTELLECT, BASE_VALUE, float(value), true);
        player->UpdateStatBuffMod(STAT_INTELLECT);
        player->UpdateStats(STAT_INTELLECT);
    }

    void ApplyAttackSpeedBonus(Player* player, int32 value)
    {
        // Apply attack speed via aura (percentage)
        if (Aura* aura = player->AddAura(65116, player)) // Use existing aura or create new
        {
            if (AuraEffect* eff = aura->GetEffect(0))
            {
                eff->SetAmount(value); // Percentage bonus
            }
        }
    }

    void ApplyCastSpeedBonus(Player* player, int32 value)
    {
        // Apply cast speed via aura
        player->ApplyCastTimePercentMod(float(value), true);
    }

    void ApplyMovementSpeedBonus(Player* player, int32 value)
    {
        // Apply movement speed via aura
        if (Aura* aura = player->AddAura(65116, player))
        {
            if (AuraEffect* eff = aura->GetEffect(0))
            {
                eff->SetAmount(value); // Percentage bonus
            }
        }
    }
};

#define sCustomStats CustomStatsManager::instance()

// ============================================================
// PLAYER SCRIPT - Apply custom stats on login
// ============================================================
class CustomStatsPlayerScript : public PlayerScript
{
public:
    CustomStatsPlayerScript() : PlayerScript("CustomStatsPlayerScript") { }

    void OnPlayerLevelChanged(Player* player, uint8 /*oldlevel*/) override
    {
        // Apply all custom stats from database when level changes
        sCustomStats->ApplyAllCustomStats(player);
    }
};

// ============================================================
// CUSTOM STATS NPC
// ============================================================
class npc_custom_stats : public CreatureScript
{
public:
    npc_custom_stats() : CreatureScript("npc_custom_stats") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);
        
        std::ostringstream greeting;
        greeting << "|TInterface\\Icons\\Spell_ChargePositive:30|t |cFF00FFFFCustom Stats Manager|r\n\n";
        greeting << "|cFFAAAAFFView and enhance your custom stats!|r\n";
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, greeting.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Misc_QuestionMark:20|t View My Stats", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Enchant_Disenchant:20|t Enhance Stats", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            ShowStatsMenu(player, creature);
        }
        else if (action == GOSSIP_ACTION_INFO_DEF + 2)
        {
            ShowEnhanceMenu(player, creature);
        }
        else
        {
            OnGossipHello(player, creature);
        }
        
        return true;
    }

    void ShowStatsMenu(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        
        std::ostringstream stats;
        stats << "|TInterface\\Icons\\Spell_ChargePositive:30|t |cFF00FFFFYour Custom Stats|r\n\n";
        
        // Show top stats
        for (uint8 i = 0; i < 10; ++i)
        {
            int32 value = sCustomStats->GetCustomStat(player, CustomStatType(i));
            if (value != 0)
            {
                stats << "|cFF00FF00" << sCustomStats->GetStatDisplayName(CustomStatType(i)) << ":|r " << value << "\n";
            }
        }
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, stats.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Ability_Repair:20|t Back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
    }

    void ShowEnhanceMenu(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        
        std::ostringstream enhance;
        enhance << "|TInterface\\Icons\\INV_Enchant_Disenchant:30|t |cFF00FFFFEnhance Stats|r\n\n";
        enhance << "|cFFAAAAFFSelect a stat to enhance!|r\n";
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, enhance.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        
        // Add stat enhancement options
        for (uint8 i = 0; i < 10; ++i)
        {
            std::ostringstream option;
            option << "|TInterface\\Icons\\INV_Enchant_Disenchant:20|t Enhance " << sCustomStats->GetStatDisplayName(CustomStatType(i));
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, option.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10 + i);
        }
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Ability_Repair:20|t Back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
    }
};

void AddSC_custom_stats_system()
{
    new CustomStatsPlayerScript();
    new npc_custom_stats();
}

