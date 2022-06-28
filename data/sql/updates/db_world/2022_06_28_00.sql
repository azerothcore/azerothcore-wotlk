-- DB update 2022_06_27_01 -> 2022_06_28_00
-- Hungering Plaguehound

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30952;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30952);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30952, 0, 0, 0, 38, 0, 100, 0, 31119, 0, 40000, 40000, 0, 69, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Data Set - Move To Point'),
(30952, 0, 1, 2, 34, 0, 100, 512, 8, 1, 0, 0, 0, 45, 30952, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Movement Inform - Set Data'),
(30952, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 75, 12098, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Movement Inform - Set Aura');

-- Bloody Meat

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31119;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31119);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31119, 0, 0, 1, 11, 0, 100, 512, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Respawn - Store Target'),
(31119, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 11, 30952, 20, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Respawn - Store Target'),
(31119, 0, 2, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 45, 31119, 0, 0, 0, 0, 0, 11, 30952, 10, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Respawn - Set Data'),
(31119, 0, 3, 4, 38, 0, 100, 1, 30952, 0, 0, 0, 0, 11, 58564, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Hungering Plaguehound - On Data Set - Kill Credit'),
(31119, 0, 4, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloody Meat - On Data Set - Force Despawn');
