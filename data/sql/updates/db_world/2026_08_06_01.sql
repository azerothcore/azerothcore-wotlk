-- DB update 2026_08_06_00 -> 2026_08_06_01
--
UPDATE `creature_template` SET `faction` = 634, `AIName` = 'SmartAI' WHERE (`entry` = 25431);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 25431);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(25431, 0, 0, 1, 0, 0, 0, 0);

UPDATE `creature` SET
`MovementType` = 0, `wander_distance` = 0,
`VerifiedBuild` = 68887, `CreateObject` = 1, `Comment` = 'Quest Trigger: Leading the Ancestors Home',
`position_x`  = 3595.879,
`position_y`  = 5537.7905,
`position_z`  = 34.70591,
`orientation` = 3.59537816047668457
WHERE `id` = 25431 AND `guid` = 103715;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -103715);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-103715, 0, 0, 1, 8, 0, 100, 0, 45536, 0, 0, 0, 0, 0, 33, 25398, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaskala Ancestor - On Spellhit \'Complete Ancestor Ritual\' - Quest Credit'),
(-103715, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 25398, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3573.9446, 5513.4355, 27.129955, 0.9913623332977295, 'Kaskala Ancestor - On Spellhit \'Complete Ancestor Ritual\' - Summon Creature \'Elder Sagani\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = -103715) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 25398) AND (`ConditionValue2` = 40) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, -103715, 0, 0, 29, 0, 25398, 40, 0, 1, 0, 0, '', 'Don\'t spam summon Elders in quest Leading the Ancestors Home');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25398;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25398);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25398, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Sagani - On Just Summoned - Set Run Off'),
(25398, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3584.4246, 5529.451, 27.119078, 0.6293056011199951, 'Elder Sagani - On Just Summoned - Move To Position'),
(25398, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2539800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Sagani - On Reached Point 1 - Run Script'),
(25398, 0, 3, 0, 34, 0, 100, 0, 8, 2, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Sagani - On Reached Point 2 - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2539800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2539800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33345, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Sagani - Actionlist - Cast \'Yellow Banish State\''),
(2539800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 28320, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Sagani - Actionlist - Morph To Model 28320'),
(2539800, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Sagani - Actionlist - Set Fly On'),
(2539800, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3588.5952, 5532.733, 37.24327, 0, 'Elder Sagani - Actionlist - Move To Position');

UPDATE `creature` SET
`MovementType` = 0, `wander_distance` = 0,
`VerifiedBuild` = 68887, `CreateObject` = 1, `Comment` = 'Quest Trigger: Leading the Ancestors Home',
`position_x`  = 3643.4314,
`position_y`  = 5641.761,
`position_z`  = 34.668648,
`orientation` = 4.817108631134033203
WHERE `id` = 25431 AND `guid` = 103739;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -103739);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-103739, 0, 0, 1, 8, 0, 100, 0, 45536, 0, 0, 0, 0, 0, 33, 25397, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaskala Ancestor - On Spellhit \'Complete Ancestor Ritual\' - Quest Credit'),
(-103739, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 25397, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3640.4463, 5619.086, 33.224483, 1.358270764350891113, 'Kaskala Ancestor - On Spellhit \'Complete Ancestor Ritual\' - Summon Creature \'Elder Kesuk\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = -103739) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 25397) AND (`ConditionValue2` = 40) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, -103739, 0, 0, 29, 0, 25397, 40, 0, 1, 0, 0, '', 'Don\'t spam summon Elders in quest Leading the Ancestors Home');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25397;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25397);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25397, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Kesuk - On Just Summoned - Set Run Off'),
(25397, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3643.3994, 5632.7715, 34.295002, 1.567238688468933105, 'Elder Kesuk - On Just Summoned - Move To Position'),
(25397, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2539700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Kesuk - On Reached Point 1 - Run Script'),
(25397, 0, 3, 0, 34, 0, 100, 0, 8, 2, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Kesuk - On Reached Point 2 - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2539700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2539700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33345, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Kesuk - Actionlist - Cast \'Yellow Banish State\''),
(2539700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 28320, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Kesuk - Actionlist - Morph To Model 28320'),
(2539700, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Kesuk - Actionlist - Set Fly On'),
(2539700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3644.0684, 5645.0557, 51.326363, 0, 'Elder Kesuk - Actionlist - Move To Position');

UPDATE `creature` SET
`MovementType` = 0, `wander_distance` = 0,
`VerifiedBuild` = 68887, `CreateObject` = 1, `Comment` = 'Quest Trigger: Leading the Ancestors Home',
`position_x`  = 3711.4558,
`position_y`  = 5548.209,
`position_z`  = 44.690983,
`orientation` = 1.884955525398254394
WHERE `id` = 25431 AND `guid` = 103714;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -103714);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-103714, 0, 0, 1, 8, 0, 100, 0, 45536, 0, 0, 0, 0, 0, 33, 25399, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaskala Ancestor - On Spellhit \'Complete Ancestor Ritual\' - Quest Credit'),
(-103714, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 25399, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3696.6863, 5580.9136, 32.97882, 5.375614166259765625, 'Kaskala Ancestor - On Spellhit \'Complete Ancestor Ritual\' - Summon Creature \'Elder Takret\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = -103714) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 25399) AND (`ConditionValue2` = 40) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, -103714, 0, 0, 29, 0, 25399, 40, 0, 1, 0, 0, '', 'Don\'t spam summon Elders in quest Leading the Ancestors Home');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25399;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25399);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25399, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Takret - On Just Summoned - Set Run Off'),
(25399, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3707.2053, 5561.145, 34.735077, 5.029853343963623046, 'Elder Takret - On Just Summoned - Move To Position'),
(25399, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2539900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Takret - On Reached Point 1 - Run Script'),
(25399, 0, 3, 0, 34, 0, 100, 0, 8, 2, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Takret - On Reached Point 2 - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2539900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2539900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 33345, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Takret - Actionlist - Cast \'Yellow Banish State\''),
(2539900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 28320, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Takret - Actionlist - Morph To Model 28320'),
(2539900, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Elder Takret - Actionlist - Set Fly On'),
(2539900, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3709.6587, 5552.6787, 52.914448, 0, 'Elder Takret - Actionlist - Move To Position');

-- Delete old ancestors
DELETE FROM `creature` WHERE `id` IN (25397, 25398, 25399) AND `guid` IN (100832, 88238, 88239);
DELETE FROM `creature_addon` WHERE `guid` IN (100832, 88238, 88239);

-- Spell Implicit Target
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 45536) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 25397) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 45536) AND (`SourceId` = 0) AND (`ElseGroup` = 1) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 25398) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 45536) AND (`SourceId` = 0) AND (`ElseGroup` = 2) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 25399) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 45536) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 25431) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 45536, 0, 0, 31, 0, 3, 25431, 0, 0, 0, 0, '', 'Spell Complete Ancestor Ritual (45536) from Quest Leading the Ancestors Home (11610) only targets Kaskala Ancestor (25431)');

-- Ancestor Movement (they don't disable gravity until they turn into a spirit)
UPDATE `creature_template_movement` SET `Swim` = 0, `Flight` = 0 WHERE (`CreatureId` IN (25397, 25398, 25399));
