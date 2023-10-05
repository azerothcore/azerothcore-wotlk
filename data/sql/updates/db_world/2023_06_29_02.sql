-- DB update 2023_06_29_01 -> 2023_06_29_02
-- Fix SAI Yenniku --
DELETE FROM `creature_text` WHERE (`CreatureID` = 2530 AND `GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(2530, 0, 0, '%s is struck dumb by the Soul Gem!', 16, 0, 100, 0, 0, 0, 681, 0, 'Yenniku');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 2530);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 2530);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2530, 0, 0, 1, 8, 0, 100, 0, 3607, 0, 30000, 30000, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - On Spellhit \'Yenniku`s Release\' - Set Faction 35'),
(2530, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 253000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - On Spellhit \'Yenniku`s Release\' - Run Script'),
(2530, 0, 2, 0, 20, 0, 100, 0, 593, 0, 0, 0, 0, 80, 253001, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - On Quest \'Filling the Soul Gem\' Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (253000, 253001));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(253000, 9, 0, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 18, 6, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - Actionlist - Set Orientation Closest Player'),
(253000, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - Actionlist - Say Line 0'),
(253000, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 75, 18970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - Actionlist - Add Aura \'Self Stun - (Visual only)\''),
(253000, 9, 3, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 0, 28, 18970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - Actionlist - Remove Aura \'Self Stun - (Visual only)\''),
(253000, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 28, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - Actionlist - Set Faction 28'),
(253001, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 28, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - Actionlist - Set Faction 28'),
(253001, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 18970, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Yenniku - Actionlist - Remove Aura \'Self Stun - (Visual only)\'');
