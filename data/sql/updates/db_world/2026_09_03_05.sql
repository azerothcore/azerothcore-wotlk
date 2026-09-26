-- DB update 2026_09_03_04 -> 2026_09_03_05

-- Resolve missing talk from Brann Bronzebeard (target was set on 0).
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3357901) AND (`source_type` = 9) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3357901, 9, 1, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Say Line 3');

-- Remove area trigger SmartAI
DELETE FROM `areatrigger_scripts` WHERE (`entry` IN (5414, 5415, 5416, 5417, 5442, 5443));
DELETE FROM `smart_scripts` WHERE (`source_type` = 2) AND (`entryorguid` IN (5414, 5415, 5416, 5417, 5442, 5443));

-- Update Bronzebeard Radio Personal GUID SAI.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-1975198, -1975199, -1975200, -1975201, -1975202, -1975203));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-1975198, 0, 0, 0, 101, 0, 100, 257, 1, 80, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On 1 or More Players in Range - Say Line 3 (No Repeat)'),
(-1975199, 0, 0, 0, 101, 0, 100, 257, 1, 60, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On 1 or More Players in Range - Say Line 8 (No Repeat)'),
(-1975200, 0, 0, 0, 101, 0, 100, 257, 1, 60, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On 1 or More Players in Range - Say Line 7 (No Repeat)'),
(-1975201, 0, 0, 0, 101, 0, 100, 257, 1, 40, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On 1 or More Players in Range - Say Line 4 (No Repeat)'),
(-1975202, 0, 0, 0, 101, 0, 100, 257, 1, 40, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On 1 or More Players in Range - Say Line 6 (No Repeat)'),
(-1975203, 0, 0, 0, 101, 0, 100, 257, 1, 60, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bronzebeard Radio - On 1 or More Players in Range - Say Line 5 (No Repeat)');
