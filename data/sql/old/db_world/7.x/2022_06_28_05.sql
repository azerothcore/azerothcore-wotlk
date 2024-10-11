-- DB update 2022_06_28_04 -> 2022_06_28_05
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 756) AND (`source_type` = 0);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 669) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(669, 0, 0, 0, 25, 0, 100, 1, 0, 0, 0, 0, 0, 11, 3621, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skullsplitter Hunter - On Reset - Cast \'3621\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 756;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 669;

DELETE FROM `creature` WHERE (`id1` = 756) AND (`guid` IN (1158, 1162, 1215, 1317, 1345, 1361, 1369, 1374, 1377, 1382, 1383, 1392, 1395));
