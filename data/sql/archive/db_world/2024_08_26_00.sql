-- DB update 2024_08_25_00 -> 2024_08_26_00
-- Fix the target_type for Chain lightning and Psychic Scream spells with Twilight Prophet
SET @ENTRY := 15308;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 4000, 4500, 12000, 15000, 0, 0, 11, 15305, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Prophet - In Combat - Cast Chain Lightning'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 8000, 9000, 25000, 28000, 0, 0, 11, 22884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Prophet - In Combat - Cast Psychic Scream'),
(@ENTRY, 0, 2, 0, 106, 0, 100, 0, 16000, 19000, 16000, 19000, 0, 8, 11, 17366, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Prophet - Within 0-8 Range - Cast Fire Nova'),
(@ENTRY, 0, 3, 0, 106, 0, 100, 0, 16000, 19000, 16000, 19000, 0, 8, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Prophet - Within 0-8 Range - Cast Frost Nova');
