-- DB update 2026_02_06_07 -> 2026_02_06_08
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|64|32768 WHERE (`entry` = 21838);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21838);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21838, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 15000, 0, 0, 11, 40721, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - In Combat - Cast \'Shadow Bolt Volley\''),
(21838, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 7000, 9000, 0, 0, 11, 15284, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - In Combat - Cast \'Cleave\''),
(21838, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2183800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - On Just Summoned - Run Script'),
(21838, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 112, 97, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - On Aggro - Start Skyguard Ace Event'),
(21838, 0, 4, 0, 0, 0, 100, 0, 18000, 30000, 16000, 32000, 0, 0, 80, 2183801, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - In Combat and Outside \'Divine Shield\' Phase - Run Chosen One Script'), -- Only Outside Divine Shield
(21838, 0, 5, 6, 0, 0, 100, 0, 45000, 60000, 45000, 75000, 0, 0, 11, 40733, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - In Combat - Cast \'Divine Shield\''),
(21838, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - On \'Divine Shield\' Cast - Say Line 1'),
(21838, 0, 7, 8, 32, 0, 100, 0, 0, 1000000, 0, 0, 0, 0, 28, 40733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - On Damaged by \'Ancient Flames\' - Remove Aura \'Divine Shield\' (Phase 1)'), -- Only with Divine Shield
(21838, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - On Spellhit \'Ancient Flames\' - Say Line 2'),
(21838, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 28747, 34, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - On Spellhit \'Ancient Flames\' - Cast \'Frenzy\''),
(21838, 0, 10, 11, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 12478, 23377, 0, 0, 0, 0, 0, 0, 'Terokk - On Evade - Do Action on Skyguard Ace Retreat'),
(21838, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - On Evade - Despawn Instant'),
(21838, 0, 12, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 12478, 23377, 0, 0, 0, 0, 0, 0, 'Terokk - On Just Died - Do Action Terokk Dead');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2183800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2183800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2183800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Cast \'Spawn - Red Lightning\''),
(2183800, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 39579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Cast \'Shadowform\''),
(2183800, 9, 3, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Say Line 3'),
(2183800, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2183800, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2183801);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2183801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Store Targetlist'),
(2183801, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Say Line 4'),
(2183801, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40726, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Cast \'Chosen One\''),
(2183801, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 40722, 128, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokk - Actionlist - Cast \'Will of the Arakkoa God\'');

DELETE FROM `game_event` WHERE `eventEntry` = 97;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(97, NULL, NULL, 5184000, 2592000, 0, 0, 'Terokk Boss Event', 0, 2);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -12478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-12478, 0, 1000, 0, 60, 0, 100, 0, 10000, 10000, 20000, 30000, 0, 0, 11, 40655, 0, 0, 0, 0, 0, 19, 21838, 60, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Update - Cast \'Skyguard Flare\''),
(-12478, 0, 1001, 0, 17, 0, 100, 0, 23277, 0, 0, 0, 0, 0, 11, 40657, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Summoning Skyguard Target - Cast \'Ancient Flames\''),
(-12478, 0, 1002, 0, 17, 0, 100, 0, 23277, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Summoning Skyguard Target - Despawn Summon in 30s'),
(-12478, 0, 1003, 0, 17, 0, 100, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Summoning Skyguard Target - Say Line 1'),
(-12478, 0, 1004, 0, 109, 0, 100, 0, 0, 124781, 0, 0, 0, 0, 80, 2337700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Path Arrive Finished - Run Script'),
(-12478, 0, 1005, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 124781, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Respawn - Start Path Arrive'),
(-12478, 0, 1006, 1008, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Success - Say Line 3'),
(-12478, 0, 1007, 1008, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Quest Fail - Say Line 4'),
(-12478, 0, 1008, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 124783, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Quest Success or Fail - Start Path Leave'),
(-12478, 0, 1009, 0, 109, 0, 100, 0, 0, 124783, 0, 0, 0, 0, 111, 97, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Path Leave Finished - End Terokk Boss Event');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2337700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2337700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - Actionlist - Say Line 2'),
(2337700, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 232, 124782, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - Actionlist - Start Path Circle');

UPDATE `creature_template` SET `unit_flags` = 2, `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 23377);
UPDATE `creature_template` SET `speed_run` = 1.71428 WHERE (`entry` = 23377);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23377);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23377, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Initialize - Set Active On'),
(23377, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Respawn - Set Run On'),
(23377, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skyguard Ace - On Respawn - Set Reactstate Passive');

UPDATE `creature_template_addon` SET `auras` = '40656' WHERE (`entry` = 23277);
UPDATE `creature_template` SET `AIName` = 'NullCreatureAI' WHERE `entry` = 23277;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23277);

DELETE FROM `creature_text` WHERE (`CreatureID` = 21838) AND (`GroupID` IN (4));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21838, 4, 0, 'Show me what you\'re made of, $n!', 14, 0, 100, 0, 0, 0, 21327, 0, 'Terokk Chosen One');

DELETE FROM `creature_text` WHERE (`CreatureID` = 23377) AND (`GroupID` IN (4));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23377, 4, 0, 'Abort mission!  Our ground forces have been defeated.', 14, 0, 100, 0, 0, 0, 21438, 0, 'Skyguard Ace Defeat');

DELETE FROM `waypoint_data` WHERE `id` IN (124781, 124782, 124783);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`move_type`) VALUES
-- Skyguard Enter
(124781, 1, -3335.223, 3431.9473, 426.38644, NULL, 2),
(124781, 2, -3548.365, 3463.0986, 365.91205, NULL, 2),
(124781, 3, -3548.365, 3463.0986, 365.91205, NULL, 2),
(124781, 4, -3548.365, 3463.0986, 365.91205, NULL, 2),
-- Skyguard Circle
(124782, 1, -3761.507, 3494.25, 305.43765   , NULL, 2),
(124782, 2, -3746.0168, 3524.3342, 304.60434, NULL, 2),
(124782, 3, -3779.0083, 3555.692, 304.3266  , NULL, 2),
(124782, 4, -3821.4905, 3536.9502, 304.38208, NULL, 2),
(124782, 5, -3830.6106, 3503.1016, 303.99332, NULL, 2),
(124782, 6, -3805.376, 3480.2854, 302.40988 , NULL, 2),
(124782, 7, -3774.9329, 3484.5464, 305.43765, NULL, 2),
-- Skyguard Leave
(124783, 1, -3697.9067, 3470.4912, 315.2088 , NULL, 2),
(124783, 2, -3668.2097, 3478.07, 330.95886  , NULL, 2),
(124783, 3, -3632.0579, 3477.3137, 339.87555, NULL, 2),
(124783, 4, -3586.6597, 3462.7095, 351.9589 , NULL, 2);

DELETE FROM `creature` WHERE `guid` IN (12478, 12479, 12480) AND `id1` = 23377;
INSERT INTO `creature` (`guid`, `id1`, `map`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12478, 23377, 530, 1, -3335.223, 3431.9473, 426.38644, 0, 300, 52237, 1, 'Skyguard Ace from Terokk Boss Event'),
(12479, 23377, 530, 1, -3335.223, 3431.9473, 426.38644, 0, 300, 52237, 1, 'Skyguard Ace from Terokk Boss Event'),
(12480, 23377, 530, 1, -3335.223, 3431.9473, 426.38644, 0, 300, 52237, 1, 'Skyguard Ace from Terokk Boss Event');

DELETE FROM `creature_formations` WHERE (`leaderGUID` = 12478);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(12478, 12478, 0, 0, 512, 0, 0),
(12478, 12479, 6, 120, 512, 0, 0),
(12478, 12480, 6, 240, 512, 0, 0);

DELETE FROM `game_event_creature` WHERE `eventEntry` = 97;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(97, 12478),
(97, 12479),
(97, 12480);

UPDATE `event_scripts` SET `x`=-3788.8564, `y`=3507.526, `z`=286.88455, `o`=3.159045934677124023 WHERE `id`=15014;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 5) AND (`SourceEntry` = 21838) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 1) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 40733) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 5, 21838, 0, 0, 1, 1, 40733, 0, 0, 1, 0, 0, '', 'Only use Chosen One script when outside Divine Shield phase');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 8) AND (`SourceEntry` = 21838) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 1) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 40733) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 8, 21838, 0, 0, 1, 1, 40733, 0, 0, 0, 0, 0, '', 'Only remove Divine Shield during the Divine Shield phase');
