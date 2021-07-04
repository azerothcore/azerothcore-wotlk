INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620337536404777343');

-- Timers update for NPC "Flamewaker Protector"
UPDATE `smart_scripts` SET `event_param1`=5000, `event_param2`=5000, `event_param3`=6500, `event_param4`=6500 WHERE `entryorguid`=12119 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=5000, `event_param2`=10000, `event_param3`=7000, `event_param4`=7000 WHERE `entryorguid`=12119 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- Timers update for NPC "Flamewaker"
UPDATE `smart_scripts` SET `event_param1`=3000, `event_param2`=6000, `event_param3`=10000, `event_param4`=13000 WHERE `entryorguid`=11661 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=3000, `event_param3`=4000, `event_param4`=6000 WHERE  `entryorguid`=11661 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=4000, `event_param2`=9000, `event_param3`=5000, `event_param4`=8000 WHERE `entryorguid`=11661 AND `source_type`=0 AND `id`=2 AND `link`=0;

