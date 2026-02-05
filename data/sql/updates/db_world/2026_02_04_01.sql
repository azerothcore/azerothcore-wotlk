-- DB update 2026_02_04_00 -> 2026_02_04_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19734);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19734, 0, 0, 1, 0, 0, 100, 1, 8000, 12000, 0, 0, 0, 0, 11, 35256, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fungal Giant - In Combat - Cast \'Serverside - Summon Unstable Mushroom\' (No Repeat)'),
(19734, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Fungal Giant - In Combat - Say Line 0 (No Repeat)');

DELETE FROM `creature_text` WHERE (`CreatureID` = 19734);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19734, 0, 0, '%s throws a mushroom spore at $n.', 16, 0, 100, 0, 0, 0, 18913, 0, 'Fungal Giant Unstable Shroom');

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 20479);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(20479, 0, 0, 0, 1, 0, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20479);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20479, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2047900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - On Just Summoned - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2047900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2047900, 9, 0 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Set Reactstate Passive'),
(2047900, 9, 1 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 31690, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Putrid Mushroom\''),
(2047900, 9, 2 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 31691, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Shrink\''),
(2047900, 9, 3 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 4 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 5 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 6 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 7 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 8 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 9 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 10, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 11, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Grow\''),
(2047900, 9, 12, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 35362, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Unstable Mushroom Visual\''),
(2047900, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 35252, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Cast \'Unstable Cloud\''),
(2047900, 9, 14, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 28, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Remove Aura \'Grow\''),
(2047900, 9, 15, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Shroom - Actionlist - Despawn Instant');
