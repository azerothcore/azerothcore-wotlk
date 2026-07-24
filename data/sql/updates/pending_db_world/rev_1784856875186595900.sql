-- --------------------------------------------------------------------------------------------
-- Icecrown (Northrend, map 571)
-- Vaelen the Flayed (Entry 30056, GUID 122535)
-- Prevent NPC from attacking other NPCs while chained up
-- -------------------------------------------
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|512 WHERE (`entry` = 30056);
