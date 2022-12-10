-- DB update 2022_12_06_17 -> 2022_12_06_18
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=17517 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` VALUES
(17517,0,1,0,4,0,100,0,0,0,0,0,0,45,0,1,0,0,0,0,23,0,0,0,0,0,0,0,0,'Hellfire Sentry - On Aggro - Set Data 0-1 on summoner');
