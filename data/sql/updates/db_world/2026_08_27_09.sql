-- DB update 2026_08_27_08 -> 2026_08_27_09

-- Remove Row 13 in Brann SmartAI and Related Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 14 AND `SourceEntry` = 33579 AND `SourceId` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 33579 AND `source_type` = 0 AND `id` = 13;

-- Add new row (1). Set Instance Data 107 0.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3357900 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (3357900, 9, 0, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 136281, 33624, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Say Line 0'),
    (3357900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 107, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Instance Data 107 to 0'),
    (3357900, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136281, 33624, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
    (3357900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136524, 33662, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
    (3357900, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136537, 33672, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
    (3357900, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 10, 136271, 33622, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
    (3357900, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Say Line 1'),
    (3357900, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 15807, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Play Sound 15807'),
    (3357900, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Instance Data 801 to 0'),
    (3357900, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 11, 33686, 200, 1, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 0 1'),
    (3357900, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 136348, 33626, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Set Data 1 1'),
    (3357900, 9, 11, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 53, 1, 33579, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brann Bronzebeard - Actionlist - Start Waypoint');
