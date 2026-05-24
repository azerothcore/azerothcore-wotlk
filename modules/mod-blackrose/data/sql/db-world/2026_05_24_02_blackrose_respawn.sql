-- ============================================================================
-- Black Rose: Faegrim respawn timer -> 5 minutes
--
-- Original spawn (2026_05_23_00_blackrose_putrid_boss.sql) used a 1800s
-- (30 min) timer because the encounter was tuned around long groups
-- travelling in. Bumping it down to 300s (5 min) so groups that wipe or
-- finish quickly don't sit around waiting for a re-pull, and so the
-- world feels populated on a smaller server.
-- ============================================================================

UPDATE `creature`
   SET `spawntimesecs` = 300
 WHERE `id1` = 900200;
