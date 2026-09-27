-- DB update 2026_09_27_03 -> 2026_09_27_04
-- --------------------------------------------------------------------------------------------
-- Capital Cities (Eastern Kingdoms, map 0 / Kalimdor, map 1)
-- Named guard elite patrols
-- Patrol with weapons drawn
-- -------------------------------------------
-- Officer Jaxon (Entry 14423, GUID 79818)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 79818);
-- Officer Pomeroy (Entry 14438, GUID 90484)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 90484);
-- Officer Brady (Entry 14439, GUID 79768)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 79768);
-- Thief Catcher Shadowdelve (Entry 14363, GUID 109)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 109);
-- Thief Catcher Thunderbrew (Entry 14367, GUID 1814)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 1814);
-- Thief Catcher Farmountain (Entry 14365, GUID 91)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 91);
-- Scout Tharr (Entry 14377, GUID 6494)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 6494);
-- Scout Manslayer (Entry 14376, GUID 6495)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 6495);
-- Scout Stronghand (Entry 14375, GUID 6496)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 6496);
-- Hunter Sagewind (Entry 14440, GUID 24782)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 24782);
-- Hunter Ragetotem (Entry 14441, GUID 24785)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 24785);
-- Hunter Thunderhorn (Entry 14442, GUID 24786)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 24786);
-- Dark Ranger Cyndia (Entry 36226, GUID 203395)
UPDATE `creature_addon` SET `bytes2` = 1 WHERE (`guid` = 203395);
-- Dark Ranger Anya (Entry 36225, GUID 203420)
UPDATE `creature_addon` SET `bytes2` = 2 WHERE (`guid` = 203420);
