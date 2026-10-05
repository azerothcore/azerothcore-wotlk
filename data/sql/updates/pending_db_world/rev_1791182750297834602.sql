--
SET @NATASHA := 22465;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @NATASHA;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @NATASHA AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@NATASHA, 0, 0, 0, 1, 0, 100, 0, 60000, 120000, 60000, 120000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Natasha - Out of Combat - Say Line 0');

DELETE FROM `creature_text` WHERE `CreatureID` = @NATASHA;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NATASHA, 0, 0, 'I''m only 4 years old.', 12, 0, 100, 0, 0, 0, 20353, 0, 'Natasha'),
(@NATASHA, 0, 1, 'Have you seen my mommy and daddy?', 12, 0, 100, 0, 0, 0, 20355, 0, 'Natasha'),
(@NATASHA, 0, 2, 'Antelarion, is it safe to play in the forest yet?', 12, 0, 100, 6, 0, 0, 20357, 0, 'Natasha'),
(@NATASHA, 0, 3, 'I think I came from Eng-land, do you know where that is?', 12, 0, 100, 5, 0, 0, 20358, 0, 'Natasha'),
(@NATASHA, 0, 4, 'Antelarion says I fell off a big bird, as I fell he caught me... He is so pretty!', 12, 0, 100, 0, 0, 0, 20360, 0, 'Natasha');
