-- DB update 2023_01_01_02 -> 2023_01_01_03
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=17826 AND `source_type`=0 AND `id`=15;
INSERT INTO `smart_scripts` VALUES
(17826,0,15,0,0,0,100,0,0,0,2000,2500,0,11,22907,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Swamplord Musel\'ek - In Combat - Cast Shoot');
