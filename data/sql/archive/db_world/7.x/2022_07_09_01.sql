-- DB update 2022_07_09_00 -> 2022_07_09_01
--
UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry`=15047;

DELETE FROM `smart_scripts` WHERE `entryorguid`=15047 AND `source_type`=0;
INSERT INTO `smart_scripts` VALUES
(15047,0,0,0,1,0,100,1,500,500,0,0,0,11,24178,0,0,0,0,0,23,0,0,0,0,0,0,0,0,'Gurubashi - OOC - Cast Will of Hakkar');
