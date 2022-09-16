-- DB update 2022_06_21_02 -> 2022_06_22_00
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11353;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11353);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11353, 0, 0, 0, 9, 0, 100, 0, 0, 5, 2000, 4000, 0, 11, 24437, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Blood Drinker - Within 0-5 Range - Cast \'Blood Leech\''),
(11353, 0, 1, 0, 2, 0, 100, 0, 0, 30, 8000, 12000, 0, 11, 24435, 1, 0, 0, 0, 0, 26, 30, 0, 0, 0, 0, 0, 0, 0, 'Gurubashi Blood Drinker - Between 0-30% Health - Cast \'Drain Life\'');
