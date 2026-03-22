
-- Defias Tower Patroller smart ai
SET @ENTRY := 7052;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 3100, 4700, 8600, 10100, 0, 0, 11, 5679, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Every 8.6 - 10.1 seconds (3.1 - 4.7s initially) (IC) - Self: Cast spell  Torch Burn (5679) on Victim'),
(@ENTRY, 0, 1, 0, 8, 0, 100, 0, 53, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (53) hit - Self: Die'),
(@ENTRY, 0, 2, 0, 8, 0, 100, 0, 2589, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (2589) hit - Self: Die'),
(@ENTRY, 0, 3, 0, 8, 0, 100, 0, 2590, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (2590) hit - Self: Die'),
(@ENTRY, 0, 4, 0, 8, 0, 100, 0, 2591, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (2591) hit - Self: Die'),
(@ENTRY, 0, 5, 0, 8, 0, 100, 0, 8721, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (8721) hit - Self: Die'),
(@ENTRY, 0, 6, 0, 8, 0, 100, 0, 11279, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (11279) hit - Self: Die'),
(@ENTRY, 0, 7, 0, 8, 0, 100, 0, 11280, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (11280) hit - Self: Die'),
(@ENTRY, 0, 8, 0, 8, 0, 100, 0, 11281, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (11281) hit - Self: Die'),
(@ENTRY, 0, 9, 0, 8, 0, 100, 0, 25300, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (25300) hit - Self: Die'),
(@ENTRY, 0, 10, 0, 8, 0, 100, 0, 26863, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (26863) hit - Self: Die'),
(@ENTRY, 0, 11, 0, 8, 0, 100, 0, 48656, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (48656) hit - Self: Die'),
(@ENTRY, 0, 12, 0, 8, 0, 100, 0, 48657, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (48657) hit - Self: Die'),
(@ENTRY, 0, 13, 0, 8, 0, 100, 0, 8676, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (8676) hit - Self: Die'),
(@ENTRY, 0, 14, 0, 8, 0, 100, 0, 8724, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (8724) hit - Self: Die'),
(@ENTRY, 0, 15, 0, 8, 0, 100, 0, 8725, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (8725) hit - Self: Die'),
(@ENTRY, 0, 16, 0, 8, 0, 100, 0, 11267, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (11267) hit - Self: Die'),
(@ENTRY, 0, 17, 0, 8, 0, 100, 0, 11268, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (11268) hit - Self: Die'),
(@ENTRY, 0, 18, 0, 8, 0, 100, 0, 11269, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (11269) hit - Self: Die'),
(@ENTRY, 0, 19, 0, 8, 0, 100, 0, 27441, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (27441) hit - Self: Die'),
(@ENTRY, 0, 20, 0, 8, 0, 100, 0, 48689, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (48689) hit - Self: Die'),
(@ENTRY, 0, 21, 0, 8, 0, 100, 0, 48690, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (48690) hit - Self: Die'),
(@ENTRY, 0, 22, 0, 8, 0, 100, 0, 48691, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (48691) hit - Self: Die');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 7052 AND `SourceId` = 0;
 -- Defias Tower Sentry smart ai
SET @ENTRY := 7056;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 1, 0, 100, 1, 1000, 1500, 0, 0, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Time between 1 - 1.5 seconds (OOC) - Self: Cast spell  Sneak (22766) on Self'),
(@ENTRY, 0, 1, 0, 8, 0, 100, 0, 53, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (53) hit - Self: Die'),
(@ENTRY, 0, 2, 0, 8, 0, 100, 0, 2589, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (2589) hit - Self: Die'),
(@ENTRY, 0, 3, 0, 8, 0, 100, 0, 2590, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (2590) hit - Self: Die'),
(@ENTRY, 0, 4, 0, 8, 0, 100, 0, 2591, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (2591) hit - Self: Die'),
(@ENTRY, 0, 5, 0, 8, 0, 100, 0, 8721, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (8721) hit - Self: Die'),
(@ENTRY, 0, 6, 0, 8, 0, 100, 0, 11279, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (11279) hit - Self: Die'),
(@ENTRY, 0, 7, 0, 8, 0, 100, 0, 11280, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (11280) hit - Self: Die'),
(@ENTRY, 0, 8, 0, 8, 0, 100, 0, 11281, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (11281) hit - Self: Die'),
(@ENTRY, 0, 9, 0, 8, 0, 100, 0, 25300, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (25300) hit - Self: Die'),
(@ENTRY, 0, 10, 0, 8, 0, 100, 0, 26863, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (26863) hit - Self: Die'),
(@ENTRY, 0, 11, 0, 8, 0, 100, 0, 48656, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (48656) hit - Self: Die'),
(@ENTRY, 0, 12, 0, 8, 0, 100, 0, 48657, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Backstab (48657) hit - Self: Die'),
(@ENTRY, 0, 13, 0, 8, 0, 100, 0, 8676, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (8676) hit - Self: Die'),
(@ENTRY, 0, 14, 0, 8, 0, 100, 0, 8724, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (8724) hit - Self: Die'),
(@ENTRY, 0, 15, 0, 8, 0, 100, 0, 8725, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (8725) hit - Self: Die'),
(@ENTRY, 0, 16, 0, 8, 0, 100, 0, 11267, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (11267) hit - Self: Die'),
(@ENTRY, 0, 17, 0, 8, 0, 100, 0, 11268, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (11268) hit - Self: Die'),
(@ENTRY, 0, 18, 0, 8, 0, 100, 0, 11269, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (11269) hit - Self: Die'),
(@ENTRY, 0, 19, 0, 8, 0, 100, 0, 27441, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (27441) hit - Self: Die'),
(@ENTRY, 0, 20, 0, 8, 0, 100, 0, 48689, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (48689) hit - Self: Die'),
(@ENTRY, 0, 21, 0, 8, 0, 100, 0, 48690, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (48690) hit - Self: Die'),
(@ENTRY, 0, 22, 0, 8, 0, 100, 0, 48691, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On spell  Ambush (48691) hit - Self: Die');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 7056 AND `SourceId` = 0;
