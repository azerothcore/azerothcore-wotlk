-- DB update 2022_07_03_00 -> 2022_07_03_01
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=3177300 AND `source_type`=9 AND `id`=46;
INSERT INTO `smart_scripts` VALUES
(3177300,9,46,0,0,0,100,0,0,0,0,0,0,28,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Remove all auras');
