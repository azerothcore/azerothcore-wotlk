-- DB update 2026_01_09_00 -> 2026_01_09_01
--
DELETE FROM `spell_area` WHERE `spell` = 58139 AND `area` = 4588 AND `quest_start` = 13144;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(58139, 4588, 13144, 13220, 0, 0, 2, 1, 64, 9);

UPDATE `creature` SET `phaseMask` = `phaseMask`|64 WHERE `id1` = 30631 AND `guid` = 123657;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30631;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30631);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30631, 0, 0, 0, 20, 0, 100, 0, 13144, 30000, 30000, 0, 0, 0, 80, 3063100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkrider Arly - On Quest \'Killing Two Scourge With One Skeleton\' Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3063100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3063100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 31428, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6648.76, 3217.7263, 810.50073, 1.6057028770446777, 'Darkrider Arly - Actionlist - Summon Creature \'Crusader Olakin Sainrith\''),
(3063100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 31432, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6588.4272, 3278.2026, 818.2033, 5.044001579284668, 'Darkrider Arly - Actionlist - Summon Creature \'Ghostwing\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 31428) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 23) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 4530) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 31428, 0, 0, 23, 1, 4530, 0, 0, 0, 0, 0, '', 'Only run script if summon occurs in Sanctum of Reanimation (4530)');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 6) AND (`SourceEntry` = 31428) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 23) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 4588) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 6, 31428, 0, 0, 23, 1, 4588, 0, 0, 0, 0, 0, '', 'Only run script if summon occurs in Blackwatch (4588)');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 59091) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 31432) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 59091, 0, 0, 31, 0, 3, 31432, 0, 0, 0, 0, '', 'Ride Ghostwing (59091) Only Targets Ghostwing (31432)');

UPDATE `creature_template_addon` SET `mount` = 0 WHERE (`entry` = 31428);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31428);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31428, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Just Summoned, Condition: Only in Sanctum of Reanimation - Set Faction 1770'),
(31428, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3142800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Just Summoned - Run Script'),
(31428, 0, 2, 3, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Data Set 1 1 - Set Event Phase 1'),
(31428, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 74956, 30698, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Data Set 1 1 - Start Attacking'),
(31428, 0, 4, 0, 7, 1, 100, 0, 0, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Evade - Despawn In 8000 ms (Phase 1)'),
(31428, 0, 5, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3142801, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Just Summoned, Condition: Only in Blackwatch - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3142801);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3142801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 44, 64, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - Actionlist - Set PhaseMask 64'),
(3142801, 9, 1, 0, 0, 0, 100, 0, 1300, 1300, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - Actionlist - Say Line 1');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags` = 768 WHERE `entry` = 31432;
UPDATE `creature_template_movement` SET `Flight` = 2 WHERE (`CreatureId` = 31432);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31432);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31432, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3143200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - On Just Summoned - Run Script'),
(31432, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 3143201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - On Reached Point Blackwatch - Run Script'),
(31432, 0, 2, 3, 34, 0, 100, 0, 8, 2, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 31428, 40, 0, 0, 0, 0, 0, 0, 'Ghostwing - On Reached Despawn Point - Despawn Olakin'),
(31432, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - On Reached Despawn Point - Despawn Self');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3143200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3143200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 44, 64, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Set PhaseMask 64'),
(3143200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 239, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Set AnimTier Flying'),
(3143200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6644.4297, 3222.9124, 823.0705, 0, 'Ghostwing - Actionlist - Move To Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3143201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3143201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 460, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Play Emote 460 (OneShotFlyDragonSpit)'),
(3143201, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Say Line 0'),
(3143201, 9, 2, 0, 0, 0, 100, 0, 6470, 6470, 0, 0, 0, 0, 5, 452, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Play Emote 452 (OneShotFlyGrab)'),
(3143201, 9, 3, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 86, 59091, 2, 19, 31428, 40, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Cross Cast \'Ride Ghostwing\''),
(3143201, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 30631, 40, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Store Arly as Target'),
(3143201, 9, 5, 0, 0, 0, 100, 0, 2840, 2840, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6690.6504, 3177.2793, 860.5705, 0, 'Ghostwing - Actionlist - Move To Position'),
(3143201, 9, 6, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ghostwing - Actionlist - Arly Say Line 0');
