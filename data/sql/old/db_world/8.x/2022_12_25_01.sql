-- DB update 2022_12_25_00 -> 2022_12_25_01
--
DELETE FROM `creature_template_movement` WHERE `CreatureID` IN (3460602,3460603);
INSERT INTO `creature_template_movement` VALUES
(3460602,0,1,1,0,0,0,NULL),
(3460603,0,1,1,0,0,0,NULL);
