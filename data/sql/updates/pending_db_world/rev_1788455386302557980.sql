--
-- Wailing Caverns - Serpentbloom Snake
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 3680;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3680 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3680, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentbloom Snake - On Just Summoned - Set Run On (No Repeat)'),
(3680, 0, 1, 2, 1, 0, 100, 0, 0, 0, 1600, 1600, 0, 0, 66, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentbloom Snake - Out of Combat - Set Random Orientation'),
(3680, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 46, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentbloom Snake - On Link - Move Forward 30 Yards');
