# Progressive Systems & Server-Side Improvements Guide
## For WoW 3.3.5a / AzerothCore (No Client Modifications Required)

This guide outlines **server-side only** improvements that work with the vanilla 3.3.5a client. All changes are implemented via C++, SQL, and Lua scripts.

---

## 🎯 Core Concept: Infinite Progression System

The goal is to create a **never-ending progression system** where players continuously get stronger through:
- **Difficulty Scaling**: Higher difficulty = Better rewards
- **Progressive Power**: Character power increases beyond level 80
- **Dynamic Loot**: Loot quality scales with difficulty/completion
- **Prestige Systems**: Multiple layers of progression

---

## 📊 **1. INFINITE DIFFICULTY SCALING SYSTEM**

### Concept
Add unlimited difficulty tiers beyond Heroic (Normal → Heroic → Mythic+1 → Mythic+2 → ... → Mythic+∞)

### Implementation

#### A. Database Schema
```sql
-- New table for difficulty scaling
CREATE TABLE `custom_difficulty_scaling` (
  `map_id` INT UNSIGNED NOT NULL,
  `difficulty_tier` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `health_multiplier` FLOAT NOT NULL DEFAULT 1.0,
  `damage_multiplier` FLOAT NOT NULL DEFAULT 1.0,
  `loot_quality_bonus` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `experience_multiplier` FLOAT NOT NULL DEFAULT 1.0,
  `required_item_level` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `reward_points` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`map_id`, `difficulty_tier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Player progression tracking
CREATE TABLE `character_progression` (
  `guid` INT UNSIGNED NOT NULL,
  `prestige_level` INT UNSIGNED NOT NULL DEFAULT 0,
  `total_power_level` INT UNSIGNED NOT NULL DEFAULT 0,
  `highest_difficulty_cleared` INT UNSIGNED NOT NULL DEFAULT 0,
  `total_mythic_plus_completed` INT UNSIGNED NOT NULL DEFAULT 0,
  `progression_points` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `last_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### B. C++ Implementation Hooks
Use existing script hooks:
- `OnPlayerCustomScalingStatValue` - Modify item stats dynamically
- `OnCreatureKill` - Track difficulty completions
- `OnItemRoll` - Modify loot quality based on difficulty
- `OnPlayerLogin` - Apply progression bonuses

#### C. Difficulty Selection System
```cpp
// Add new difficulty selection via NPC or command
// Players can select difficulty tier when entering instance
// Store in instance save data
```

### Features
- **Unlimited Tiers**: Mythic+1, +2, +3... up to +1000+
- **Exponential Scaling**: Each tier increases health/damage by 10-15%
- **Item Level Requirements**: Higher tiers require higher average item level
- **Progression Points**: Earn points for completing higher difficulties

---

## 💎 **2. DYNAMIC ITEM UPGRADE SYSTEM**

### Concept
Items can be upgraded infinitely using materials/currency earned from higher difficulties.

### Implementation

#### A. Database Schema
```sql
CREATE TABLE `item_upgrades` (
  `item_guid` BIGINT UNSIGNED NOT NULL,
  `upgrade_level` INT UNSIGNED NOT NULL DEFAULT 0,
  `stat_bonus_percent` FLOAT NOT NULL DEFAULT 0.0,
  `upgrade_cost_progression_points` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `upgrade_materials` (
  `item_entry` INT UNSIGNED NOT NULL,
  `upgrade_tier` TINYINT UNSIGNED NOT NULL,
  `required_quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`item_entry`, `upgrade_tier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### B. Stat Scaling Hook
```cpp
// Use OnPlayerCustomScalingStatValue hook
void OnPlayerCustomScalingStatValue(Player* player, ItemTemplate const* proto, 
    uint32& statType, int32& val, uint8 itemProtoStatNumber, 
    uint32 ScalingStatValue, ScalingStatValuesEntry const* ssv)
{
    // Check item upgrade level from database
    // Apply percentage bonus: val = val * (1.0 + upgrade_level * 0.05)
    // Each upgrade = +5% stats (configurable)
}
```

### Features
- **Infinite Upgrades**: Items can be upgraded 100+ times
- **Progressive Cost**: Each upgrade costs more materials/points
- **Stat Scaling**: +5-10% stats per upgrade level
- **Visual Feedback**: Use item enchant visual effects to show upgrade level

---

## 🏆 **3. PRESTIGE SYSTEM**

### Concept
After reaching level 80, players can "prestige" to gain permanent bonuses while resetting some progress.

### Implementation

#### A. Database Schema
```sql
CREATE TABLE `character_prestige` (
  `guid` INT UNSIGNED NOT NULL,
  `prestige_level` INT UNSIGNED NOT NULL DEFAULT 0,
  `total_prestige_points` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `permanent_stat_bonus` FLOAT NOT NULL DEFAULT 0.0,
  `prestige_rewards_unlocked` TEXT,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### B. Prestige Bonuses
- **Permanent Stat Bonus**: +1% all stats per prestige level
- **Loot Quality Bonus**: Higher chance for better loot
- **Experience Bonus**: Faster leveling (if level reset)
- **Special Titles**: Prestige-specific titles
- **Cosmetic Rewards**: Mounts, pets, tabards

#### C. Implementation
```cpp
// On player stat calculation
void OnPlayerCalculateStat(Player* player, uint32 statType, float& value)
{
    // Add prestige bonus: value *= (1.0 + prestige_level * 0.01)
}
```

---

## 🎲 **4. ADAPTIVE LOOT SYSTEM**

### Concept
Loot quality and quantity scale with difficulty, completion time, and player progression.

### Implementation

#### A. Loot Modification Hook
```cpp
bool OnItemRoll(Player const* player, LootStoreItem const* lootStoreItem, 
    float& chance, Loot& loot, LootStore const& store)
{
    // Get current difficulty tier
    uint8 difficultyTier = GetCurrentDifficultyTier(player);
    
    // Increase drop chance based on difficulty
    chance *= (1.0 + difficultyTier * 0.1); // +10% per tier
    
    // Add chance for upgraded items
    if (roll_chance_f(difficultyTier * 0.5))
    {
        // Spawn item with upgrade level = difficultyTier / 5
    }
    
    return true;
}
```

#### B. Dynamic Item Generation
- **Base Item**: Normal quality item
- **Upgraded Variant**: Same item with +X item level
- **Perfect Roll**: Maximum random properties
- **Legendary Variants**: Ultra-rare versions of items

### Features
- **Quality Scaling**: Higher difficulty = better base quality
- **Upgrade Drops**: Items can drop pre-upgraded
- **Perfect Stats**: Chance for perfect stat rolls
- **Set Bonuses**: Enhanced set bonuses at higher difficulties

---

## ⚔️ **5. COMBAT POWER SYSTEM**

### Concept
Track and display a "Power Level" that increases with gear, upgrades, and prestige.

### Implementation

#### A. Power Calculation
```cpp
uint32 CalculatePlayerPowerLevel(Player* player)
{
    uint32 power = 0;
    
    // Base stats
    power += player->GetTotalStatValue(STAT_STRENGTH);
    power += player->GetTotalStatValue(STAT_AGILITY);
    power += player->GetTotalStatValue(STAT_STAMINA);
    power += player->GetTotalStatValue(STAT_INTELLECT);
    power += player->GetTotalStatValue(STAT_SPIRIT);
    
    // Item level contribution
    power += GetAverageItemLevel(player) * 10;
    
    // Upgrade bonuses
    power += GetTotalUpgradeLevels(player) * 50;
    
    // Prestige bonus
    power += GetPrestigeLevel(player) * 1000;
    
    return power;
}
```

#### B. Display System
- **Character Info Command**: `.powerlevel` shows current power
- **Leaderboards**: Top power level players
- **Requirements**: Content requires minimum power level

---

## 🎮 **6. INFINITE DUNGEON MODE**

### Concept
Procedurally generated dungeon floors with increasing difficulty and rewards.

### Implementation

#### A. Database Schema
```sql
CREATE TABLE `infinite_dungeon_progress` (
  `guid` INT UNSIGNED NOT NULL,
  `current_floor` INT UNSIGNED NOT NULL DEFAULT 1,
  `highest_floor` INT UNSIGNED NOT NULL DEFAULT 1,
  `total_floors_cleared` INT UNSIGNED NOT NULL DEFAULT 0,
  `dungeon_type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### B. Procedural Generation
- **Floor Scaling**: Each floor = +1 difficulty tier
- **Random Encounters**: Mix of existing creatures with scaled stats
- **Boss Every 5 Floors**: Special boss encounters
- **Reward Scaling**: Better loot every 10 floors

---

## 📈 **7. STAT ENHANCEMENT SYSTEM**

### Concept
Players can permanently enhance base stats using progression currency.

### Implementation

#### A. Database Schema
```sql
CREATE TABLE `character_stat_enhancements` (
  `guid` INT UNSIGNED NOT NULL,
  `stat_type` TINYINT UNSIGNED NOT NULL,
  `enhancement_level` INT UNSIGNED NOT NULL DEFAULT 0,
  `total_invested_points` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`guid`, `stat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### B. Stat Application
```cpp
void OnPlayerCalculateStat(Player* player, uint32 statType, float& value)
{
    // Get enhancement level from database
    uint32 enhancementLevel = GetStatEnhancementLevel(player, statType);
    
    // Apply flat bonus: +1 stat per level
    value += enhancementLevel;
    
    // Apply percentage bonus at milestones (every 100 levels)
    value *= (1.0 + (enhancementLevel / 100) * 0.01);
}
```

---

## 🎁 **8. REWARD POINTS SYSTEM**

### Concept
Universal currency earned from all activities, spent on upgrades and enhancements.

### Implementation

#### A. Points Sources
- **Dungeon Completion**: Base points + difficulty multiplier
- **Boss Kills**: Points based on boss difficulty
- **Daily Quests**: Bonus points
- **Achievements**: One-time point rewards
- **PvP**: Points for battleground wins

#### B. Points Spending
- **Item Upgrades**: Primary use
- **Stat Enhancements**: Permanent stat increases
- **Cosmetic Items**: Mounts, pets, titles
- **Quality of Life**: Bank space, bag space

---

## 🔄 **9. SEASONAL RESET SYSTEM**

### Concept
Periodic resets (every 3-6 months) with seasonal rewards and fresh progression.

### Implementation

#### A. Seasonal Tracking
```sql
CREATE TABLE `seasonal_progress` (
  `guid` INT UNSIGNED NOT NULL,
  `season_id` INT UNSIGNED NOT NULL,
  `seasonal_level` INT UNSIGNED NOT NULL DEFAULT 0,
  `seasonal_points` BIGINT UNSIGNED NOT NULL DEFAULT 0,
  `rewards_claimed` TEXT,
  PRIMARY KEY (`guid`, `season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

#### B. Reset Mechanics
- **Soft Reset**: Keep prestige, reset some progression
- **Seasonal Rewards**: Unique items/achievements per season
- **Leaderboards**: Seasonal rankings
- **Permanent Bonuses**: Some progress carries over

---

## 🛠️ **10. IMPLEMENTATION PRIORITY**

### Phase 1: Foundation (Week 1-2)
1. ✅ Database schema creation
2. ✅ Basic difficulty scaling system
3. ✅ Progression points tracking
4. ✅ Power level calculation

### Phase 2: Core Systems (Week 3-4)
1. ✅ Item upgrade system
2. ✅ Dynamic loot modification
3. ✅ Stat enhancement system
4. ✅ Prestige system basics

### Phase 3: Advanced Features (Week 5-6)
1. ✅ Infinite dungeon mode
2. ✅ Seasonal system
3. ✅ Leaderboards
4. ✅ Reward point economy

### Phase 4: Polish (Week 7-8)
1. ✅ UI improvements (via NPCs/commands)
2. ✅ Balance tuning
3. ✅ Documentation
4. ✅ Testing

---

## 📝 **11. SERVER-SIDE ONLY TECHNIQUES**

### What Works Without Client Mods:
✅ **Stat Modifications**: Via auras, item bonuses, script hooks
✅ **Loot Quality**: Modify drop chances, item stats
✅ **Difficulty Scaling**: Creature health/damage multipliers
✅ **Currency Systems**: Custom items as currency
✅ **Progression Tracking**: Database storage
✅ **NPC Interactions**: Gossip menus, quests
✅ **Commands**: GM commands for all features
✅ **Visual Effects**: Existing spell visual effects
✅ **Item Enchants**: Use enchant visuals for upgrade levels

### What Requires Client Mods (Avoid):
❌ New UI elements
❌ Custom graphics/models
❌ New spell animations
❌ Modified client packets

---

## 🎯 **12. EXAMPLE IMPLEMENTATION: MYTHIC+ SYSTEM**

### Step-by-Step:

1. **Create Difficulty Tiers Table**
```sql
INSERT INTO `custom_difficulty_scaling` VALUES
(533, 3, 2.5, 2.0, 1, 2.0, 200, 1000),  -- Naxxramas Mythic+3
(533, 5, 4.0, 3.5, 2, 3.0, 220, 2500),  -- Naxxramas Mythic+5
(533, 10, 10.0, 8.0, 3, 5.0, 250, 10000); -- Naxxramas Mythic+10
```

2. **Modify Creature Stats on Spawn**
```cpp
void OnCreatureAddToMap(Creature* creature, Map* map)
{
    uint8 difficultyTier = GetInstanceDifficultyTier(map);
    if (difficultyTier > 1)
    {
        float healthMult = GetDifficultyHealthMultiplier(map->GetId(), difficultyTier);
        float damageMult = GetDifficultyDamageMultiplier(map->GetId(), difficultyTier);
        
        creature->SetMaxHealth(creature->GetMaxHealth() * healthMult);
        creature->SetHealth(creature->GetMaxHealth());
        // Apply damage multiplier via aura
    }
}
```

3. **Modify Loot on Kill**
```cpp
bool OnItemRoll(Player const* player, LootStoreItem const* item, 
    float& chance, Loot& loot, LootStore const& store)
{
    uint8 tier = GetCurrentDifficultyTier(player);
    chance *= (1.0 + tier * 0.15); // +15% per tier
    
    // 10% chance per tier for upgraded item
    if (roll_chance_f(tier * 10.0))
    {
        // Create upgraded version of item
    }
    
    return true;
}
```

4. **Award Progression Points**
```cpp
void OnCreatureKill(Player* killer, Creature* killed)
{
    uint8 tier = GetCurrentDifficultyTier(killer);
    uint32 points = GetBasePoints(killed) * (1 + tier);
    
    AddProgressionPoints(killer, points);
    UpdatePowerLevel(killer);
}
```

---

## 🚀 **13. ADVANCED IDEAS**

### A. **Paragon System**
After prestige 10, unlock "Paragon" levels with even greater bonuses.

### B. **Ascension System**
Ultimate progression: Convert progression points into permanent account-wide bonuses.

### C. **Challenge Modes**
Time-based challenges with leaderboards and exclusive rewards.

### D. **Guild Progression**
Guild-wide progression that benefits all members.

### E. **World Scaling**
Open world content scales with player power level.

### F. **Elite Modes**
Special difficulty modes with unique mechanics (no deaths, time limits, etc.)

---

## 📚 **14. RESOURCES & REFERENCES**

### AzerothCore Hooks to Use:
- `OnPlayerCustomScalingStatValue` - Item stat modification
- `OnItemRoll` - Loot chance modification
- `OnCreatureKill` - Kill tracking
- `OnPlayerLogin` - Apply bonuses on login
- `OnPlayerCalculateStat` - Stat calculation modification
- `OnBeforeRollMeleeOutcomeAgainst` - Combat modification

### Database Tables to Extend:
- `characters` - Add progression columns
- `item_instance` - Track item upgrades
- `character_stats` - Store enhanced stats
- `instance` - Track difficulty tiers

### Useful Modules:
- **mod-autobalance**: Difficulty scaling reference
- **mod-cfbg**: Cross-faction features
- **mod-arena-spectator**: Advanced features example

---

## ✅ **15. QUICK START CHECKLIST**

- [ ] Create database schema
- [ ] Implement difficulty tier selection
- [ ] Add creature stat scaling
- [ ] Modify loot system
- [ ] Create progression point system
- [ ] Add item upgrade functionality
- [ ] Implement prestige system
- [ ] Create NPCs for interactions
- [ ] Add GM commands
- [ ] Test and balance

---

## 🎉 **CONCLUSION**

All these systems work **100% server-side** with the vanilla 3.3.5a client. The key is using:
- **Script Hooks** for game logic
- **Database** for persistence
- **Auras/Spells** for visual effects
- **NPCs/Commands** for player interaction
- **Item Templates** for custom items

The possibilities are endless! Start with one system, test it thoroughly, then expand. Good luck! 🚀

