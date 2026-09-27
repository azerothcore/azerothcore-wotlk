-- --------------------------------------------------------------------------------------------
-- Durotar (Kalimdor, map 1) and Azuremyst Isle (Outland, map 530)
-- Magga (Entry 11943, GUID 3416) and Jaeleil (Entry 16476, GUID 57174)
-- Make NPCs sit
-- -------------------------------------------
-- Magga (Entry 11943, GUID 3416)
UPDATE `creature_addon` SET `bytes1` = 1 WHERE (`guid` = 3416);
-- Jaeleil (Entry 16476, GUID 57174)
UPDATE `creature_template_addon` SET `bytes1` = 1 WHERE (`entry` = 16476);
