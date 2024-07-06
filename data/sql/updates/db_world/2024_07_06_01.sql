-- DB update 2024_07_06_00 -> 2024_07_06_01
--
DELETE FROM `creature_text` WHERE (`CreatureID` = 6240);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(6240, 0, 0, '%s is demoralized and runs!', 16, 0, 100, 0, 0, 0, 2356, 0, 'Affray Challenger');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6240;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6240);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6240, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Emote'),
(6240, 0, 2, 1, 8, 0, 100, 0, 1160, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Flee For Assist'),
(6240, 0, 3, 1, 8, 0, 100, 0, 6190, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Flee For Assist'),
(6240, 0, 4, 1, 8, 0, 100, 0, 11554, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Flee For Assist'),
(6240, 0, 5, 1, 8, 0, 100, 0, 11555, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Flee For Assist'),
(6240, 0, 6, 1, 8, 0, 100, 0, 11556, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Flee For Assist'),
(6240, 0, 7, 1, 8, 0, 100, 0, 25202, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Flee For Assist'),
(6240, 0, 8, 1, 8, 0, 100, 0, 25203, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Affray Challenger - On Spellhit \'Demoralizing Shout\' - Flee For Assist');
