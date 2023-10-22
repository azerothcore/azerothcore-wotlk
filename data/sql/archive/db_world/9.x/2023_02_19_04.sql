-- DB update 2023_02_19_03 -> 2023_02_19_04
--
UPDATE `creature_onkill_reputation` SET `MaxStanding1`=4 WHERE `creature_id` IN (18394,18429);
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN (20262,20252);
INSERT INTO `creature_onkill_reputation` VALUES
(20262,933,0,7,0,15,0,0,0,0),
(20252,933,0,7,0,15,0,0,0,0);
