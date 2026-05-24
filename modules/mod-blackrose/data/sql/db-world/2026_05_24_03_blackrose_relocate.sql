-- ============================================================================
-- Black Rose: relocate Faegrim to the actual Fire Scar Shrine center
--
-- The original spawn coords used in 2026_05_23_00_blackrose_putrid_boss.sql
-- (2204.98, 102.90, 111.55) were estimates - verified in-game they were
-- ~45 yards west and ~7 yards above the real shrine floor, so the boss
-- was either out of sight or clipping into terrain when the patrol path
-- nudged him off the safe footprint.
--
-- True Fire Scar Shrine center (verified .gps in Ashenvale):
--   X = 2250.36, Y = 97.07, Z = 104.92  (GroundZ 104.14)
--
-- This migration:
--   1. Moves the boss creature row to the verified center.
--   2. Re-plots the 4-point patrol as a tight ~10-yard square around the
--      new center, all at the shrine floor Z so the path stays on the
--      walkable footprint.
-- ============================================================================

SET @BR_BOSS := 900200;

-- Re-anchor the spawn at the verified shrine center.
UPDATE `creature`
   SET `position_x`  = 2250.36,
       `position_y`  =   97.07,
       `position_z`  =  104.92,
       `orientation` =    3.96
 WHERE `id1` = @BR_BOSS;

-- Replot the patrol around the new center.
DELETE FROM `waypoints` WHERE `entry` = @BR_BOSS;

INSERT INTO `waypoints`
    (`entry`, `pointid`, `position_x`, `position_y`, `position_z`,
     `orientation`, `delay`, `point_comment`)
VALUES
    (@BR_BOSS, 1, 2255.0, 102.0, 104.92, NULL, 3000,
     'Faegrim - patrol - NE corner'),
    (@BR_BOSS, 2, 2255.0,  92.0, 104.92, NULL, 3000,
     'Faegrim - patrol - SE corner'),
    (@BR_BOSS, 3, 2245.0,  92.0, 104.92, NULL, 3000,
     'Faegrim - patrol - SW corner'),
    (@BR_BOSS, 4, 2245.0, 102.0, 104.92, NULL, 3000,
     'Faegrim - patrol - NW corner');
