-- DB update 2022_12_06_29 -> 2022_12_06_30
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18131);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18131, 0, 0, 0, 0, 0, 75, 0, 3000, 3000, 9000, 9000, 0, 11, 35333, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Slicer - In Combat - Cast \'Tail Swipe\''),
(18131, 0, 1, 0, 0, 0, 75, 0, 1000, 1000, 10000, 10000, 0, 11, 17008, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Slicer - In Combat - Cast \'Drain Mana\''),
(18131, 0, 2, 0, 3, 0, 100, 0, 25, 100, 3600, 3600, 0, 11, 35334, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Slicer - Between 25-100% Mana - Cast \'Nether Shock\''),
(18131, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 108, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshfang Slicer - On Reset - Set Mana To 0');

UPDATE `creature_template` SET `unit_flags2`=`unit_flags2`&~2048 WHERE (`entry` = 18131);
