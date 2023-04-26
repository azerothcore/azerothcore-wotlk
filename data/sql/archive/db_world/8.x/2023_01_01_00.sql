-- DB update 2022_12_31_02 -> 2023_01_01_00
--
UPDATE `smart_scripts` SET `link`=9 WHERE `entryorguid`=17827 AND `source_type`=0 AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17827 AND `source_type`=0 AND `id`=9;
INSERT INTO `smart_scripts` VALUES
(17827,0,9,0,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,19,17826,100,0,0,0,0,0,0,'Claw - Combat - Swamplord Musel\'ek Say 0');
