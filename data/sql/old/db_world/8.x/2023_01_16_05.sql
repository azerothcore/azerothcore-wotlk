-- DB update 2023_01_16_04 -> 2023_01_16_05
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=17395 AND `source_type`=0 AND `id`=3;
UPDATE `smart_scripts` SET `event_type`=0, `event_param1`=500, `event_param2`=500 WHERE `entryorguid`=17395 AND `source_type`=0 AND `id` IN (0,1);

UPDATE `smart_scripts` SET `action_param2`=0 WHERE `entryorguid`=17395 AND `source_type`=0 AND `id` IN (4,5);
UPDATE `smart_scripts` SET `event_flags`=0, `event_type`=4, `event_param1`=0, `event_param2`=0, `action_type`=87, `action_param1`=1739500, `action_param2`=1739501, `Comment`='Shadowmoon Summoner - In Combat - Call Random Actionlist' WHERE `entryorguid`=17395 AND `source_type`=0 AND `id`=2;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1739500,1739501) AND `source_type`=9;
INSERT INTO `smart_scripts` VALUES
(1739500,9,0,0,0,0,100,0,0,0,0,0,0,11,30853,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Summoner - Actionlist - Cast Summon Seductress'),
(1739501,9,0,0,0,0,100,0,0,0,0,0,0,11,30851,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowmoon Summoner - Actionlist - Cast Summon Felhound Manastalker');
