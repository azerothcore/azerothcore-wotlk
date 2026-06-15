-- =============================================================================
-- fix_weapon_damage_missing_values.sql
-- AzerothCore World Database: Missing damage values in item_template
-- =============================================================================
--
-- BUG SUMMARY
-- -----------
-- 61 weapons (class=2) have dmg_min1=0 AND dmg_max1=0 despite having valid
-- delay values, causing them to calculate as 0 DPS. Affected items include
-- Furious Gladiator's Waraxe (ilvl 232), Titansteel Defender/Deflector (ilvl 200),
-- Trade District Knife, Ice-Rimed Chopper, and various lower-level weapons
-- across all major weapon types.
--
-- ROOT CAUSE
-- ----------
-- The item_template entries have delay populated correctly but dmg_min1 and
-- dmg_max1 were never populated. These items fall through all damage calculation
-- paths in _ApplyItemBonuses since there is no DBC fallback for weapon damage
-- when the DB values are zero.
--
-- CONFIRMED AFFECTED
-- ------------------
-- AzerothCore rev. ae5001d16e0b 2025-09-23 (master branch)
--
-- DISCOVERY
-- ---------
-- While investigating damage values in item_template, we found 61 real combat
-- weapons with dmg_min1=dmg_max1=0 but valid delay values. Division by zero is
-- not a risk (delay > 0 for all affected items) but the weapons contribute no
-- DPS to any system that reads these fields.
--
-- FIX METHODOLOGY
-- ---------------
-- Reference DPS + per-subclass damage range ratios:
--
--   1. For each affected weapon, find the average DPS of other weapons at the
--      same (ItemLevel, Quality, subclass) that have correct damage values.
--      Requires at least 2 reference items for reliability.
--
--   2. Apply the per-subclass min/max ratio (derived from all weapons of that
--      type with correct values) to compute the damage range:
--        dmg_min1 = ROUND(ref_dps * (delay / 1000) * min_ratio)
--        dmg_max1 = ROUND(ref_dps * (delay / 1000) * max_ratio)
--
--      Per-subclass ratios observed:
--        Subclass  0  (1H Axe):       69.9% / 130.1%
--        Subclass  1  (2H Axe):       79.7% / 120.3%
--        Subclass  2  (Bow):          71.3% / 128.7%
--        Subclass  3  (Gun):          71.3% / 128.7%
--        Subclass  4  (1H Mace):      62.0% / 138.0%
--        Subclass  5  (2H Mace):      79.5% / 120.5%
--        Subclass  6  (Polearm):      79.9% / 120.1%
--        Subclass  7  (1H Sword):     67.9% / 132.1%
--        Subclass  8  (2H Sword):     79.8% / 120.2%
--        Subclass 10  (Staff):        76.8% / 123.2%
--        Subclass 13  (Fist Weapon):  71.0% / 129.0%
--        Subclass 15  (Dagger):       67.1% / 132.9%
--        Subclass 16  (Thrown):       75.1% / 124.9%
--        Subclass 18  (Crossbow):     76.8% / 123.2%
--
--      Validation: Furious Gladiator's Waraxe (entry 42238, subclass 0,
--      ilvl 232, delay 2600) computes to dmg_min1=325, dmg_max1=605, which
--      exactly matches Furious Gladiator's Cleaver (42209), Chopper (42233),
--      and all other Furious Gladiator's 1H axes with the same delay.
--
-- EXCLUDED ITEMS
-- --------------
-- The following categories are intentionally excluded from this fix:
--
--   subclass = 14 (Brewfest Steins): Cosmetic "weapons" with dmg_min1=0
--     intentionally. 12 entries (Filled Blue/Yellow/Green Brewfest Stein, etc.)
--
--   subclass = 19 (Wands): Wand damage mechanics differ from melee weapons
--     and may be handled separately. 14 entries excluded.
--
--   Cosmetic/art items: Frostmourne (art demo entries 33350, 36942), NPC-only
--     weapons not obtainable by players.
--
--   Test/placeholder items: Names containing 'Test', 'TEST', 'Art Demo',
--     or 'Deprecated'.
--
--   Items with no references: Weapons at a unique (ItemLevel, Quality, subclass)
--     combination where fewer than 2 other items with correct values exist.
--
-- VALIDATION
-- ----------
-- After applying, verify Furious Gladiator's Waraxe:
--   SELECT entry, name, dmg_min1, dmg_max1, delay,
--          ROUND((dmg_min1+dmg_max1)/2.0/(delay/1000.0), 1) AS dps
--   FROM item_template WHERE entry = 42238;
-- Expected: dmg_min1=325, dmg_max1=605, delay=2600, dps=178.8
-- =============================================================================

-- =============================================================================
-- PRE-FIX VERIFICATION
-- =============================================================================
-- Run this before applying to confirm the bug is present:
--
-- SELECT COUNT(*) AS affected_weapons
-- FROM item_template
-- WHERE class = 2
--   AND Quality >= 2
--   AND ItemLevel > 1
--   AND dmg_min1 = 0
--   AND delay > 0
--   AND subclass NOT IN (14, 19)
--   AND name NOT LIKE '%Test%'
--   AND name NOT LIKE '%TEST%'
--   AND name NOT LIKE '%Deprecated%'
--   AND name NOT LIKE '%Frostmourne%'
--   AND name NOT LIKE '%Art Demo%';
--
-- Expected on unpatched database: 61
-- =============================================================================

-- =============================================================================
-- FIX: Compute dmg_min1/dmg_max1 from reference DPS + per-subclass ratios
-- Covers all major weapon types except wands (19) and Brewfest steins (14).
-- Each item uses its own delay value - weapons with different swing speeds at
-- the same ilvl/quality get the correct absolute damage values for their speed.
-- =============================================================================
UPDATE item_template bad
JOIN (
    -- Average DPS from working weapons at same (ItemLevel, Quality, subclass)
    SELECT
        ItemLevel,
        Quality,
        subclass,
        AVG((dmg_min1 + dmg_max1) / 2.0 / (delay / 1000.0)) AS ref_dps
    FROM item_template
    WHERE class = 2
      AND dmg_min1 > 0
      AND delay > 0
      AND Quality >= 2
      AND ItemLevel > 1
    GROUP BY ItemLevel, Quality, subclass
    HAVING COUNT(*) >= 2
) ref ON bad.ItemLevel = ref.ItemLevel
     AND bad.Quality   = ref.Quality
     AND bad.subclass  = ref.subclass
JOIN (
    -- Per-subclass min/max ratios (e.g., 1H axes are ~70/130, 2H swords ~80/120)
    SELECT
        subclass,
        AVG(dmg_min1 / ((dmg_min1 + dmg_max1) / 2.0)) AS min_ratio,
        AVG(dmg_max1 / ((dmg_min1 + dmg_max1) / 2.0)) AS max_ratio
    FROM item_template
    WHERE class = 2
      AND dmg_min1 > 0
      AND Quality >= 2
      AND ItemLevel > 1
    GROUP BY subclass
) ratios ON bad.subclass = ratios.subclass
SET
    bad.dmg_min1 = GREATEST(1, ROUND(
        ref.ref_dps * (bad.delay / 1000.0) * ratios.min_ratio)),
    bad.dmg_max1 = GREATEST(2, ROUND(
        ref.ref_dps * (bad.delay / 1000.0) * ratios.max_ratio))
WHERE bad.class = 2
  AND bad.Quality >= 2
  AND bad.ItemLevel > 1
  AND bad.dmg_min1 = 0
  AND bad.delay > 0
  AND bad.subclass NOT IN (14, 19)              -- exclude Brewfest steins and wands
  AND bad.name NOT LIKE '%Test%'
  AND bad.name NOT LIKE '%TEST%'
  AND bad.name NOT LIKE '%Deprecated%'
  AND bad.name NOT LIKE '%Frostmourne%'         -- art/NPC-only Frostmourne entries
  AND bad.name NOT LIKE '%Art Demo%';

-- =============================================================================
-- POST-FIX VERIFICATION
-- =============================================================================

-- Overall counts:
SELECT
    'Has damage values' AS status,
    COUNT(*) AS weapon_count
FROM item_template
WHERE class = 2
  AND Quality >= 2
  AND ItemLevel > 1
  AND dmg_min1 > 0
  AND delay > 0
  AND subclass NOT IN (14, 19)
UNION ALL
SELECT
    'Still missing damage (cosmetic/test/no-reference)' AS status,
    COUNT(*) AS weapon_count
FROM item_template
WHERE class = 2
  AND Quality >= 2
  AND ItemLevel > 1
  AND dmg_min1 = 0
  AND delay > 0
  AND subclass NOT IN (14, 19);

-- Spot-check notable fixed weapons:
SELECT
    entry,
    name,
    subclass,
    Quality,
    ItemLevel,
    dmg_min1,
    dmg_max1,
    delay,
    ROUND((dmg_min1 + dmg_max1) / 2.0 / (delay / 1000.0), 1) AS dps
FROM item_template
WHERE entry IN (
    42238,  -- Furious Gladiator’s Waraxe   (1H Axe, ilvl 232) -> expected ~178.8 DPS
    44948,  -- Titansteel Defender           (2H Axe, ilvl 200) -> expected ~186.5 DPS
    44926,  -- Titansteel Deflector          (2H Sword, ilvl 200) -> expected ~186.5 DPS
    44191,  -- Ice-Rimed Chopper             (2H Axe, ilvl 200) -> expected ~169.2 DPS
    37697   -- Trade District Knife          (Dagger, ilvl 200) -> expected ~113.5 DPS
)
ORDER BY ItemLevel DESC;

-- Cross-reference Furious Gladiator's Waraxe against known-good axes:
SELECT entry, name, dmg_min1, dmg_max1, delay,
       ROUND((dmg_min1 + dmg_max1) / 2.0 / (delay / 1000.0), 1) AS dps
FROM item_template
WHERE subclass = 0 AND Quality = 4 AND ItemLevel = 232 AND delay = 2600
ORDER BY entry;
-- All entries with delay=2600 should show dmg_min1=325, dmg_max1=605, dps=178.8
-- =============================================================================

