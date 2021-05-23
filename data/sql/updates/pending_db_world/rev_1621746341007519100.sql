INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621746341007519100');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 36551;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 36551);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(36551, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 69105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Apparition - On Aggro - Cast \'Soul Horror Visual\' (No Repeat)'),
(36551, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 69136, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Apparition - On Aggro - Cast \'Spiteful Apparition Visual\' (No Repeat)'),
(36551, 0, 2, 4, 0, 0, 100, 2, 1000, 1000, 7000, 9000, 0, 11, 68895, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Apparition - In Combat - Cast \'Spite\' (Normal Dungeon)'),
(36551, 0, 3, 5, 0, 0, 100, 4, 1000, 1000, 7000, 9000, 0, 11, 70212, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Apparition - In Combat - Cast \'Spite\' (Heroic Dungeon)'),
(36551, 0, 4, 0, 61, 0, 100, 2, 1000, 1000, 7000, 9000, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Apparition - In Combat - Despawn In 4000 ms (Normal Dungeon)'),
(36551, 0, 5, 0, 61, 0, 100, 4, 1000, 1000, 7000, 9000, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spiteful Apparition - In Combat - Despawn In 4000 ms (Heroic Dungeon)');

-- Not optimal but right now no way around it
UPDATE `creature_template` SET `type_flags`=`type_flags`|1048576 WHERE `entry` = 36551;
