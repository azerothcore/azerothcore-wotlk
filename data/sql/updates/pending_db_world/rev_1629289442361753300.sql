INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629289442361753300');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 9237);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9237);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9237, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - On Aggro - Set Event Phase 1'),
(9237, 0, 1, 0, 2, 0, 100, 1, 40, 65, 300, 300, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - Between 40-65% Health - Set Event Phase 2 (No Repeat)'),
(9237, 0, 2, 0, 2, 0, 100, 1, 0, 40, 300, 300, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - Between 0-40% Health - Set Event Phase 3 (No Repeat)'),
(9237, 0, 3, 0, 0, 1, 100, 0, 1000, 1500, 8000, 8000, 0, 11, 16075, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - In Combat - Cast \'Throw Axe\' (Phase 1)'),
(9237, 0, 4, 0, 0, 0, 100, 1, 10000, 12000, 0, 0, 0, 11, 3391, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - In Combat - Cast \'Thrash\' (No Repeat)'),
(9237, 0, 5, 0, 0, 2, 100, 0, 5000, 6000, 10000, 12000, 0, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - In Combat - Cast \'Mortal Strike\' (Phase 2)'),
(9237, 0, 6, 0, 0, 2, 100, 0, 8000, 10000, 12000, 14000, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - In Combat - Cast \'Cleave\' (Phase 2)'),
(9237, 0, 7, 0, 0, 4, 100, 0, 6000, 8000, 8000, 8000, 0, 11, 15618, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - In Combat - Cast \'Snap Kick\' (Phase 3)'),
(9237, 0, 8, 0, 0, 4, 100, 0, 18000, 20000, 12000, 14000, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - In Combat - Cast \'Uppercut\' (Phase 3)'),
(9237, 0, 9, 0, 0, 4, 100, 0, 30000, 32000, 16000, 18000, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'War Master Voone - In Combat - Cast \'Pummel\' (Phase 3)');
