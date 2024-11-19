-- DB update 2023_04_19_25 -> 2023_04_19_26
-- ID 21861 (Vision of the Raven God), also set to not specified
UPDATE `creature_template` SET `type` = 10 WHERE `entry` = 21861;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 21861;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21861, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 0, 11, 39426, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - On Data Set 1 - Cast credit'),
(21861, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - Link - Say 0'),
(21861, 0, 2, 3, 38, 0, 100, 0, 1, 2, 0, 0, 0, 11, 39428, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - On Data Set 2 - Cast credit'),
(21861, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - Link - Say 1'),
(21861, 0, 4, 5, 38, 0, 100, 0, 1, 3, 0, 0, 0, 11, 39430, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - On Data Set 3 - Cast credit'),
(21861, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - Link - Say 2'),
(21861, 0, 6, 7, 38, 0, 100, 0, 1, 4, 0, 0, 0, 11, 39431, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - On Data Set 4 - Cast credit'),
(21861, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Vision of Raven God - Link - Say 3');

-- The First Prophecy, also correct spawn position (previously falling from above)
UPDATE `smart_scripts` SET `target_z` = 170.498 WHERE `source_type` = 1 AND `entryorguid` = 184950 AND `id` = 0;

DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 184950 AND `id` IN (1,2,3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(184950, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'First Prophecy - Link - Store Targetlist'),
(184950, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'First Prophecy - Link - Send Target to Raven God'),
(184950, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'First Prophecy - Link - Set Data 1 to Raven God');

-- The Second Prophecy
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 184967 AND `id` IN (1,2,3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(184967, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Second Prophecy - Link - Store Targetlist'),
(184967, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'Second Prophecy - Link - Send Target to Raven God'),
(184967, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'Second Prophecy - Link - Set Data 2 to Raven God');

-- The Third Prophecy
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 184968 AND `id` IN (1,2,3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(184968, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Third Prophecy - Link - Store Targetlist'),
(184968, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'Third Prophecy - Link - Send Target to Raven God'),
(184968, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'Third Prophecy - Link - Set Data 3 to Raven God');

-- The Fourth Prophecy
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 184969 AND `id` IN (1,2,3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(184969, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fourth Prophecy - Link - Store Targetlist'),
(184969, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'Fourth Prophecy - Link - Send Target to Raven God'),
(184969, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 4, 0, 0, 0, 0, 19, 21861, 20, 0, 0, 0, 0, 0, 0, 'Fourth Prophecy - Link - Set Data 4 to Raven God');
