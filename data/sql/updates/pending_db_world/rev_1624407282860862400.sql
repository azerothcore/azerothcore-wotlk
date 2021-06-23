INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624407282860862400');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5240;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5240);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5240, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Warlock - On Aggro - Say Line 0'),
(5240, 0, 1, 0, 0, 0, 100, 0, 0, 1, 9000, 10000, 0, 11, 20298, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Warlock - In Combat - Cast \'Shadow Bolt\''),
(5240, 0, 2, 0, 0, 0, 100, 0, 9000, 15000, 30000, 35000, 0, 11, 7289, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordunni Warlock - In Combat - Cast \'Shrink\'');
