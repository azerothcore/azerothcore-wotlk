-- DB update 2022_05_16_00 -> 2022_05_16_01
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=30331 AND `source_type`=0 AND `id`=5;
INSERT INTO `smart_scripts` VALUES
(30331,0,5,0,54,0,100,0,0,0,0,0,0,85,56606,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Jokkum - on just summoned - Cast Riding Jokkum');
