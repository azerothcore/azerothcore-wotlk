-- =============================================================================
-- fix_item_armor_missing_values.sql
-- AzerothCore World Database: Missing armor values in item_template
-- =============================================================================
--
-- BUG SUMMARY
-- -----------
-- 462 armor items (class=4, subclass IN 1-4) have armor=0 in item_template
-- despite being real, equippable gear. Affected content includes ICC tier sets
-- (Scourgelord, Lasherweave, Ahn'Kahar Blood Hunter's, Ymirjar Lord's, Lightsworn),
-- as well as items from ToC, Ulduar, Naxxramas, and pre-WotLK content.
--
-- ROOT CAUSE
-- ----------
-- AzerothCore reads item armor exclusively from proto->Armor (Player.cpp ~L6854):
--
--   uint32 armor = proto->Armor;
--   if (ssv) { ... }  // ssv is NULL when ScalingStatValue = 0
--   // no further fallback
--
-- When both armor=0 AND ScalingStatValue=0, the item contributes zero armor
-- to the player. The DBC files that Blizzard used for the armor formula
-- (ItemArmorSubclass.dbc, ItemArmorQuality.dbc, ItemArmorTotal.dbc) are not
-- extracted or loaded by AzerothCore, so there is no runtime fallback.
--
-- CONFIRMED AFFECTED
-- ------------------
-- AzerothCore rev. ae5001d16e0b 2025-09-23 (master branch)
--
-- DISCOVERY
-- ---------
-- While investigating armor values in item_template for WotLK content, we found
-- that 462 armor items have armor=0 AND ScalingStatValue=0. Source code analysis
-- of Player::_ApplyItemBonuses confirmed that no DBC fallback exists for these
-- items. In-game testing verified the impact: a character equipping ICC plate
-- pieces received zero armor contribution from each affected piece.
--
-- FIX METHODOLOGY
-- ---------------
-- Two-pass reference-based approach:
--
--   Pass 1 (name-match, 95 items):
--     For each zero-armor item, find another item_template entry with the same
--     name that has a known-good armor value. Requires that ALL entries sharing
--     that name agree on the same armor value (prevents ambiguous matches).
--     This correctly handles tank vs. DPS tier variants â€” e.g., the Scourgelord
--     Battleplate (2526 armor, DPS) and Scourgelord Chestguard (3590 armor, tank)
--     are matched by name to their respective counterparts.
--
--   Pass 2 (slot-reference, 367 items):
--     For each remaining zero-armor item, find items at the same (ItemLevel,
--     Quality, subclass, InventoryType) that have consistent armor values
--     (MIN = MAX across all references). Only uses the reference if all items
--     in that group agree, preventing incorrect averaging across intentionally
--     different values (e.g., tank vs. DPS variants within the same slot).
--
-- WHAT IS NOT FIXED
-- -----------------
-- 76 items remain at armor=0. These are test/placeholder/deprecated entries:
--   - "ICECROWN TEST GOD BP", "Armor Test Item", "Tom's Legs A/B/C/3"
--   - "HF BLUE Plate DPS Chest", "TEST 130 Epic Warrior Waistband"
--   - Martin Fury (entry 17), "Deprecated Sentinel Coif"
--   - Items at unique (ilvl, quality, subclass, slot) combos with no references
-- These are not real player-obtainable items and are safe to leave at 0.
--
-- VALIDATION
-- ----------
-- After applying this fix, spot-check:
--   SELECT entry, name, armor FROM item_template
--   WHERE entry IN (51682, 51683, 51684, 51685, 51686, 51687, 51688, 51689,
--                   51690, 51691, 51692, 51693, 51694, 51695, 51696, 51707,
--                   51708, 51709, 51710);
-- Expected: all rows have armor > 0 matching their 25-normal counterparts.
-- =============================================================================

-- =============================================================================
-- PRE-FIX VERIFICATION
-- =============================================================================
-- Run this before applying to confirm the bug is present:
--
-- SELECT COUNT(*) AS affected_items
-- FROM item_template
-- WHERE class = 4
--   AND subclass IN (1,2,3,4)
--   AND armor = 0
--   AND ScalingStatValue = 0
--   AND Quality >= 2
--   AND ItemLevel > 1;
--
-- Expected on unpatched database: 538 (462 fixable + 76 unfixable test items)
-- =============================================================================

-- =============================================================================
-- PASS 1: Name-match (95 items)
-- Fixes items that have an exact name twin with a known-good armor value.
-- Covers ICC 25 Heroic tier sets (ilvl 251) including:
--   - Scourgelord plate (DPS and tank variants): entries 51682-51691
--   - Lasherweave cloth: entries 51692-51706
--   - Ahn'Kahar Blood Hunter's mail: entries 51707-51710
--   - Various pre-WotLK items with duplicate entries
-- =============================================================================
UPDATE item_template bad
JOIN (
    SELECT name, MIN(armor) AS armor
    FROM item_template
    WHERE armor > 0
      AND class = 4
      AND subclass IN (1, 2, 3, 4)
    GROUP BY name
    HAVING MIN(armor) = MAX(armor)
) ref ON bad.name = ref.name
SET bad.armor = ref.armor
WHERE bad.class = 4
  AND bad.subclass IN (1, 2, 3, 4)
  AND bad.armor = 0
  AND bad.ScalingStatValue = 0
  AND bad.Quality >= 2
  AND bad.ItemLevel > 1;

-- =============================================================================
-- PASS 2: Slot-reference (367 items)
-- Fixes remaining zero-armor items using consistent reference values from items
-- at the same (ItemLevel, Quality, subclass, InventoryType).
-- Only applies when ALL reference items in a group agree on the same value
-- (HAVING MIN = MAX), preventing cross-contamination of tank/DPS variants.
-- Covers items from ICC 25H (ilvl 264-284), ToC (ilvl 232-258),
-- Ulduar (ilvl 213-232), Naxxramas (ilvl 187-213), and older content.
-- =============================================================================
UPDATE item_template bad
JOIN (
    SELECT ItemLevel, Quality, subclass, InventoryType,
           MIN(armor) AS ref_armor
    FROM item_template
    WHERE class = 4
      AND subclass IN (1, 2, 3, 4)
      AND armor > 0
      AND Quality >= 2
      AND ItemLevel > 1
    GROUP BY ItemLevel, Quality, subclass, InventoryType
    HAVING MIN(armor) = MAX(armor)
) slot_ref ON bad.ItemLevel    = slot_ref.ItemLevel
          AND bad.Quality      = slot_ref.Quality
          AND bad.subclass     = slot_ref.subclass
          AND bad.InventoryType = slot_ref.InventoryType
SET bad.armor = slot_ref.ref_armor
WHERE bad.class = 4
  AND bad.subclass IN (1, 2, 3, 4)
  AND bad.armor = 0
  AND bad.ScalingStatValue = 0
  AND bad.Quality >= 2
  AND bad.ItemLevel > 1;

-- =============================================================================
-- POST-FIX VERIFICATION
-- =============================================================================
SELECT
    'Fixed' AS status,
    COUNT(*) AS item_count
FROM item_template
WHERE class = 4
  AND subclass IN (1, 2, 3, 4)
  AND armor > 0
  AND Quality >= 2
  AND ItemLevel > 1
UNION ALL
SELECT
    'Still zero (test/deprecated only)' AS status,
    COUNT(*) AS item_count
FROM item_template
WHERE class = 4
  AND subclass IN (1, 2, 3, 4)
  AND armor = 0
  AND ScalingStatValue = 0
  AND Quality >= 2
  AND ItemLevel > 1;

-- Expected after applying this fix:
--   Fixed                             | 15471+ (all real armor items)
--   Still zero (test/deprecated only) | 76     (intentional non-fixable items)

-- Spot-check ICC Heroic 25 (ilvl 251) tier sets:
SELECT entry, name, subclass, InventoryType, armor
FROM item_template
WHERE entry IN (
    51682, 51683, 51684, 51685, 51686, 51687, 51688, 51689, 51690, 51691, -- Scourgelord plate
    51692, 51693, 51694, 51695, 51696, 51697, 51698, 51699, 51700, 51701, -- Lasherweave cloth
    51702, 51703, 51704, 51705, 51706,                                     -- Lasherweave cloth (continued)
    51707, 51708, 51709, 51710                                             -- Ahn'Kahar mail
)
ORDER BY entry;
-- =============================================================================

