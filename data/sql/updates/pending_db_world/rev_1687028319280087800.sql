--
UPDATE `smart_scripts` SET `event_flags`=0, `action_param1`=22766, `comment`='Crag Stalker - Out of Combat - Cast \'Stealth\'' WHERE  `entryorguid`=4126 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_type`=4, `event_flags`=0, `event_param1`=0, `event_param2`=0, `comment`='Crag Stalker - On Aggro - Cast \'Surprise Attack\'' WHERE  `entryorguid`=4126 AND `source_type`=0 AND `id`=1 AND `link`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=4126 AND `source_type`=0 AND `id`=2 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `id`, `event_type`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES (4126, 2, 9, 8, 2000, 4000, 11, 8151, 7, 'Crag Stalker - Within 0-8 Range - Cast \'Surprise Attack\'');

