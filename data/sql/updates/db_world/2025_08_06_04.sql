-- DB update 2025_08_06_03 -> 2025_08_06_04

-- Edit creature_text tables (Anok'ra, Sinrok, Tivax)
DELETE FROM `creature_text` WHERE (`CreatureID` IN (26769, 26770, 26771));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26769, 0, 0, 'I gladly die for the master...', 12, 0, 100, 0, 0, 0, 25937, 0, ''),
(26769, 0, 1, 'Your victory is meaningless.', 12, 0, 100, 0, 0, 0, 25938, 0, ''),
(26769, 0, 3, 'Anub\'et\'kan will... end you.', 12, 0, 100, 0, 0, 0, 25936, 0, ''),
(26769, 0, 4, 'I will rise again, more powerful... much... more...', 12, 0, 100, 0, 0, 0, 25939, 0, ''),
(26770, 0, 0, 'I gladly die for the master...', 12, 0, 100, 0, 0, 0, 25937, 0, ''),
(26770, 0, 1, 'Your victory is meaningless.', 12, 0, 100, 0, 0, 0, 25938, 0, ''),
(26770, 0, 3, 'Anub\'et\'kan will... end you.', 12, 0, 100, 0, 0, 0, 25936, 0, ''),
(26770, 0, 4, 'I will rise again, more powerful... much... more...', 12, 0, 100, 0, 0, 0, 25939, 0, ''),
(26771, 0, 0, 'I gladly die for the master...', 12, 0, 100, 0, 0, 0, 25937, 0, ''),
(26771, 0, 1, 'Your victory is meaningless.', 12, 0, 100, 0, 0, 0, 25938, 0, ''),
(26771, 0, 3, 'Anub\'et\'kan will... end you.', 12, 0, 100, 0, 0, 0, 25936, 0, ''),
(26771, 0, 4, 'I will rise again, more powerful... much... more...', 12, 0, 100, 0, 0, 0, 25939, 0, '');

-- Add dialogue lines on Death (Anok'ra, Sinrok, Tivax)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (26769, 26770, 26771));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26769) AND (`source_type` = 0) AND (`id` IN (12));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26770) AND (`source_type` = 0) AND (`id` IN (11));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26771) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26769, 0, 12, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anok\'ra the Manipulator - On Just Died - Say Line 0'),
(26770, 0, 11, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - On Just Died - Say Line 0'),
(26771, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sinok the Shadowrager - On Just Died - Say Line 0');
