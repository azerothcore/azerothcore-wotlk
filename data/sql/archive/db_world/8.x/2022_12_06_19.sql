-- DB update 2022_12_06_18 -> 2022_12_06_19
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18498,18499,18500,18501,18503) AND `source_type`=0 AND `event_type` IN (1, 7);

DELETE FROM `smart_scripts` WHERE `entryorguid`=18497 AND `source_type`=0 AND `id`=6;
INSERT INTO `smart_scripts` VALUES
(18497,0,6,0,7,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,204,0,0,0,0,0,0,0,0,'Auchenai Monk - On Evade - Despawn all summons');
