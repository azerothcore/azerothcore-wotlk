-- DB update 2022_05_29_01 -> 2022_05_30_00
--
UPDATE `smart_scripts` SET `event_type`=60 WHERE `entryorguid`=14122 AND `source_type`=0 AND `id`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=14122 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` VALUES
(14122,0,1,0,54,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hydrospawn - on summon - set passive react');
