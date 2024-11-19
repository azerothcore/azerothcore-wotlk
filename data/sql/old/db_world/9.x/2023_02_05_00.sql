-- DB update 2023_02_04_03 -> 2023_02_05_00
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=17626 AND `source_type`=0 AND `id`=3;
INSERT INTO `smart_scripts` VALUES
(17626,0,3,0,0,0,100,0,5000,12000,25000,35000,0,11,18765,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Laughing Skull Legionnaire - In Combat - Cast Sweeping Strikes');
