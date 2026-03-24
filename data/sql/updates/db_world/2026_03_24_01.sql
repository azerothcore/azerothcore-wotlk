-- DB update 2026_03_24_00 -> 2026_03_24_01
-- Defias Tower Patroller smart ai
SET @ENTRY := 7052;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 3100, 4700, 8600, 10100, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - In Combat - Cast \'Torch Burn\''),
(@ENTRY, 0, 1, 0, 8, 0, 100, 0, 53, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (53)\' - Kill Self'),
(@ENTRY, 0, 2, 0, 8, 0, 100, 0, 2589, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (2589)\' - Kill Self'),
(@ENTRY, 0, 3, 0, 8, 0, 100, 0, 2590, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (2590)\' - Kill Self'),
(@ENTRY, 0, 4, 0, 8, 0, 100, 0, 2591, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (2591)\' - Kill Self'),
(@ENTRY, 0, 5, 0, 8, 0, 100, 0, 8721, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (8721)\' - Kill Self'),
(@ENTRY, 0, 6, 0, 8, 0, 100, 0, 11279, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (11279)\' - Kill Self'),
(@ENTRY, 0, 7, 0, 8, 0, 100, 0, 11280, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (11280)\' - Kill Self'),
(@ENTRY, 0, 8, 0, 8, 0, 100, 0, 11281, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (11281)\' - Kill Self'),
(@ENTRY, 0, 9, 0, 8, 0, 100, 0, 25300, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (25300)\' - Kill Self'),
(@ENTRY, 0, 10, 0, 8, 0, 100, 0, 26863, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (26863)\' - Kill Self'),
(@ENTRY, 0, 11, 0, 8, 0, 100, 0, 48656, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (48656)\' - Kill Self'),
(@ENTRY, 0, 12, 0, 8, 0, 100, 0, 48657, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Backstab (48657)\' - Kill Self'),
(@ENTRY, 0, 13, 0, 8, 0, 100, 0, 8676, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (8676)\' - Kill Self'),
(@ENTRY, 0, 14, 0, 8, 0, 100, 0, 8724, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (8724)\' - Kill Self'),
(@ENTRY, 0, 15, 0, 8, 0, 100, 0, 8725, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (8725)\' - Kill Self'),
(@ENTRY, 0, 16, 0, 8, 0, 100, 0, 11267, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (11267)\' - Kill Self'),
(@ENTRY, 0, 17, 0, 8, 0, 100, 0, 11268, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (11268)\' - Kill Self'),
(@ENTRY, 0, 18, 0, 8, 0, 100, 0, 11269, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (11269)\' - Kill Self'),
(@ENTRY, 0, 19, 0, 8, 0, 100, 0, 27441, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (27441)\' - Kill Self'),
(@ENTRY, 0, 20, 0, 8, 0, 100, 0, 48689, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Patroller - On Spellhit \'Ambush (48689)\' - Kill Self');

-- Defias Tower Sentry smart ai
SET @ENTRY := 7056;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - Out of Combat - Cast \'Sneak\' (No Repeat)'),
(@ENTRY, 0, 1, 0, 8, 0, 100, 0, 53, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (53)\' - Kill Self'),
(@ENTRY, 0, 2, 0, 8, 0, 100, 0, 2589, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (2589)\' - Kill Self'),
(@ENTRY, 0, 3, 0, 8, 0, 100, 0, 2590, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (2590)\' - Kill Self'),
(@ENTRY, 0, 4, 0, 8, 0, 100, 0, 2591, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (2591)\' - Kill Self'),
(@ENTRY, 0, 5, 0, 8, 0, 100, 0, 8721, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (8721)\' - Kill Self'),
(@ENTRY, 0, 6, 0, 8, 0, 100, 0, 11279, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (11279)\' - Kill Self'),
(@ENTRY, 0, 7, 0, 8, 0, 100, 0, 11280, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (11280)\' - Kill Self'),
(@ENTRY, 0, 8, 0, 8, 0, 100, 0, 11281, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (11281)\' - Kill Self'),
(@ENTRY, 0, 9, 0, 8, 0, 100, 0, 25300, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (25300)\' - Kill Self'),
(@ENTRY, 0, 10, 0, 8, 0, 100, 0, 26863, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (26863)\' - Kill Self'),
(@ENTRY, 0, 11, 0, 8, 0, 100, 0, 48656, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (48656)\' - Kill Self'),
(@ENTRY, 0, 12, 0, 8, 0, 100, 0, 48657, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Backstab (48657)\' - Kill Self'),
(@ENTRY, 0, 13, 0, 8, 0, 100, 0, 8676, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (8676)\' - Kill Self'),
(@ENTRY, 0, 14, 0, 8, 0, 100, 0, 8724, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (8724)\' - Kill Self'),
(@ENTRY, 0, 15, 0, 8, 0, 100, 0, 8725, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (8725)\' - Kill Self'),
(@ENTRY, 0, 16, 0, 8, 0, 100, 0, 11267, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (11267)\' - Kill Self'),
(@ENTRY, 0, 17, 0, 8, 0, 100, 0, 11268, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (11268)\' - Kill Self'),
(@ENTRY, 0, 18, 0, 8, 0, 100, 0, 11269, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (11269)\' - Kill Self'),
(@ENTRY, 0, 19, 0, 8, 0, 100, 0, 27441, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (27441)\' - Kill Self'),
(@ENTRY, 0, 20, 0, 8, 0, 100, 0, 48689, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defias Tower Sentry - On Spellhit \'Ambush (48689)\' - Kill Self');

-- Remove Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND (`SourceEntry` IN (7052, 7056)) AND `SourceId` = 0;
