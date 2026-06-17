-- fix armor=0 on equippable armor items (class=4, subclass 1-4)

-- pass 1: name-match (95 items)
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

-- pass 2: slot-reference (367 items)
-- HAVING MIN=MAX prevents tank/DPS cross-contamination
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
) slot_ref ON bad.ItemLevel     = slot_ref.ItemLevel
          AND bad.Quality       = slot_ref.Quality
          AND bad.subclass      = slot_ref.subclass
          AND bad.InventoryType = slot_ref.InventoryType
SET bad.armor = slot_ref.ref_armor
WHERE bad.class = 4
  AND bad.subclass IN (1, 2, 3, 4)
  AND bad.armor = 0
  AND bad.ScalingStatValue = 0
  AND bad.Quality >= 2
  AND bad.ItemLevel > 1;

-- fix dmg_min1=dmg_max1=0 on real weapons (class=2)
-- with valid delay (61 items)
UPDATE item_template bad
JOIN (
    SELECT ItemLevel, Quality, subclass,
           AVG((dmg_min1 + dmg_max1) / 2.0 / (delay / 1000.0)) AS ref_dps
    FROM item_template
    WHERE class = 2
      AND dmg_min1 > 0
      AND dmg_max1 > 0
      AND delay > 0
      AND Quality >= 2
      AND ItemLevel > 1
      AND subclass NOT IN (14, 19)
      AND name NOT LIKE '%Test%'
      AND name NOT LIKE '%TEST%'
      AND name NOT LIKE '%Deprecated%'
      AND name NOT LIKE '%Frostmourne%'
      AND name NOT LIKE '%Art Demo%'
    GROUP BY ItemLevel, Quality, subclass
    HAVING COUNT(*) >= 2
) ref ON bad.ItemLevel = ref.ItemLevel
     AND bad.Quality   = ref.Quality
     AND bad.subclass  = ref.subclass
JOIN (
    SELECT subclass,
           AVG(dmg_min1 / ((dmg_min1 + dmg_max1) / 2.0)) AS min_ratio,
           AVG(dmg_max1 / ((dmg_min1 + dmg_max1) / 2.0)) AS max_ratio
    FROM item_template
    WHERE class = 2
      AND dmg_min1 > 0
      AND dmg_max1 > 0
      AND delay > 0
      AND Quality >= 2
      AND ItemLevel > 1
      AND subclass NOT IN (14, 19)
      AND name NOT LIKE '%Test%'
      AND name NOT LIKE '%TEST%'
      AND name NOT LIKE '%Deprecated%'
      AND name NOT LIKE '%Frostmourne%'
      AND name NOT LIKE '%Art Demo%'
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
  AND bad.dmg_max1 = 0
  AND bad.delay > 0
  -- Brewfest steins (cosmetic) and wands (handled separately)
  AND bad.subclass NOT IN (14, 19)
  AND bad.name NOT LIKE '%Test%'
  AND bad.name NOT LIKE '%TEST%'
  AND bad.name NOT LIKE '%Deprecated%'
  AND bad.name NOT LIKE '%Frostmourne%'  -- art/NPC-only entries
  AND bad.name NOT LIKE '%Art Demo%';
