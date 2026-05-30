-- DB update 2026_04_03_03 -> 2026_04_04_00
-- Fix Scarlet Monastery Cathedral Mograine/Whitemane encounter resetting during scripted phase
-- Disable evade during the scripted "fake death" / "Deep Sleep" / "resurrection" phase
-- to prevent JustExitedCombat auto-evade from triggering SMART_EVENT_EVADE and setting FAIL

-- Mograine: Disable evade when fake-dying (actionlist 397600)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 397600 AND `source_type` = 9 AND `id` = 10;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(397600, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - Actionlist - Disable Evade');

-- Mograine: Re-enable evade when reaching Whitemane after resurrection (On Reached Point 1 chain)
-- Update id 24 to link to new id 29
UPDATE `smart_scripts` SET `link` = 29 WHERE `entryorguid` = 3976 AND `source_type` = 0 AND `id` = 24;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3976 AND `source_type` = 0 AND `id` = 29;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(3976, 0, 29, 0, 61, 0, 100, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Enable Evade');

-- Whitemane: Disable evade when casting Deep Sleep (actionlist 397700)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 397700 AND `source_type` = 9 AND `id` = 5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(397700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Disable Evade');

-- Whitemane: Re-enable evade when re-engaging after resurrection (actionlist 397701)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 397701 AND `source_type` = 9 AND `id` = 8;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(397701, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'High Inquisitor Whitemane - Actionlist - Enable Evade');
