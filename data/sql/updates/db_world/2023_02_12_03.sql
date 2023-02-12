-- DB update 2023_02_12_02 -> 2023_02_12_03
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=19671 AND `source_type`=0 AND `id`=19;
INSERT INTO `smart_scripts` VALUES
(19671,0,19,0,54,0,100,0,0,0,0,0,0,211,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Cryo-Engineer Sha\'heen - On Just Summoned - Disallow reset phase');
