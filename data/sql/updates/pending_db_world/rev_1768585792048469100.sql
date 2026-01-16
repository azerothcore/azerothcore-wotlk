--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26261);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26261, 0, 0, 0, 8, 0, 100, 512, 47394, 0, 0, 0, 0, 0, 80, 2626100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grizzly Hills Giant - On Spellhit \'Kurun\'s Blessing\' - Run Script'),
(26261, 0, 1, 0, 1, 0, 100, 0, 2000, 5000, 4000, 6000, 0, 0, 11, 46815, 0, 0, 0, 0, 0, 19, 26264, 85, 0, 0, 0, 0, 0, 0, 'Grizzly Hills Giant - Out of Combat - Cast \'Toss Boulder\''),
(26261, 0, 2, 0, 1, 0, 100, 0, 3000, 9000, 7000, 13000, 0, 0, 11, 46815, 0, 0, 0, 0, 0, 19, 26417, 100, 0, 0, 0, 0, 0, 0, 'Grizzly Hills Giant - Out of Combat - Cast \'Toss Boulder\'');
