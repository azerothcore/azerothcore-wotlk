-- DB update 2025_08_27_00 -> 2025_08_27_01
SET @SAY_APPROACH = 0,
@SAY_AGGRO = 1,
@SAY_SUMMON = 2,
@GUID = 12748;

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5014, 5015);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5014, 'at_karazhan_mirkblood_approach'),
(5015, 'at_karazhan_mirkblood_entrance');

UPDATE `creature_template` SET `minlevel` = 73, `maxlevel` = 73, `speed_run` = 1.85714285714, `ScriptName` = 'boss_tenris_mirkblood' WHERE `entry` = 28194;
UPDATE `creature_template` SET `speed_walk` = 0.4, `speed_run` = 0.14285714285, `ScriptName` = 'npc_sanguine_spirit' WHERE `entry` = 28232;
UPDATE `creature_template` SET `unit_flags` = 33554432, `AIName` = 'SmartAI' WHERE `entry` = 28485;
UPDATE `creature_template` SET `unit_flags` = 33555200 WHERE `entry` = 28493;

UPDATE `creature_model_info` SET `BoundingRadius` = 0.200000002980232238, `CombatReach` = 0.400000005960464477 WHERE `DisplayID` = 25296;
UPDATE `creature_model_info` SET `BoundingRadius` = 0.465000003576278686, `CombatReach` = 1.5 WHERE `DisplayID` = 25541;

DELETE FROM `creature_text` WHERE `CreatureID` = 28194;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28194, @SAY_APPROACH, 0, 'I smell... $r.  Delicious!',                          14, 0, 100, 0, 0, 0, 27780, 0, 'Prince Tenris Mirkblood - SAY_APPROACH'),
(28194, @SAY_AGGRO,    0, 'I shall consume you!',                                14, 0, 100, 0, 0, 0, 27781, 0, 'Prince Tenris Mirkblood - SAY_AGGRO'),
(28194, @SAY_SUMMON,   0, 'Drink, mortals!  Taste my blood!  Taste your death!', 12, 0, 100, 0, 0, 0, 27712, 0, 'Prince Tenris Mirkblood - SAY_SUMMON');

UPDATE `gameobject_template` SET `ScriptName` = 'go_blood_drenched_door' WHERE `entry` = 181032;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (50883, 50925, 51013);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(50883, 'spell_mirkblood_blood_mirror_target_picker'),
(50925, 'spell_mirkblood_dash_gash_return_to_tank_pre_spell'),
(51013, 'spell_mirkblood_exsanguinate');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -50845 AND `spell_effect` = -50844;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-50845, -50844, 0, 'Tenris Mirkblood Blood Mirror');

DELETE FROM `creature_template_addon` WHERE `entry` IN (28232, 28485, 28493);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(28232, 0, 0, 0, 0, 0,   0, '51282'),
(28485, 0, 0, 0, 0, 0,   0, '30987'),
(28493, 0, 0, 0, 0, 383, 0, '');

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (28485, 28493);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(28485, 0, 0, 1, 0, 0, 0, NULL),
(28493, 0, 0, 1, 0, 0, 0, NULL);

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+9 AND `id1` IN (28485, 28493);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@GUID+0, 28485, 0, 0, 532, 0, 0, 1, 1, 0, -11087.619, -1996.4193, 82.59072,  0.453785598278045654, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+1, 28485, 0, 0, 532, 0, 0, 1, 1, 0, -11104.703, -1973.5052, 82.73294,  0.05235987901687622,  300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+2, 28485, 0, 0, 532, 0, 0, 1, 1, 0, -11084.556, -1981.4388, 82.4658,   0.575958669185638427, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+3, 28485, 0, 0, 532, 0, 0, 1, 1, 0, -11091.643, -1961.8134, 82.77006,  0.104719758033752441, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+4, 28485, 0, 0, 532, 0, 0, 1, 1, 0, -11097.971, -1982.734,  82.39082,  0.418879032135009765, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+5, 28493, 0, 0, 532, 0, 0, 1, 1, 0, -11097.721, -1982.62,   77.43985,  5.113814830780029296, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+6, 28493, 0, 0, 532, 0, 0, 1, 1, 0, -11104.523, -1973.4592, 78.07421,  1.396263360977172851, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+7, 28493, 0, 0, 532, 0, 0, 1, 1, 0, -11084.696, -1981.4202, 77.87848,  4.904375076293945312, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+8, 28493, 0, 0, 532, 0, 0, 1, 1, 0, -11091.594, -1962.1276, 78.054115, 2.146754980087280273, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL),
(@GUID+9, 28493, 0, 0, 532, 0, 0, 1, 1, 0, -11087.617, -1996.2291, 77.72322,  0.436332315206527709, 300, 0, 0, 4050, 0, 0, 0, 0, 0, '', 49345, 2, NULL);

DELETE FROM `game_event_creature` WHERE `eventEntry` = 120 AND `guid` BETWEEN @GUID+0 AND @GUID+9;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(120, @GUID+0),
(120, @GUID+1),
(120, @GUID+2),
(120, @GUID+3),
(120, @GUID+4),
(120, @GUID+5),
(120, @GUID+6),
(120, @GUID+7),
(120, @GUID+8),
(120, @GUID+9);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28485) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28485, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 11, 51773, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blood Vat Bunny - On Initialize - Cast \'Scourge Invasion Blood Vat Bunny\'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 51773 AND `ConditionTypeOrReference` = 31 AND `ConditionValue2` = 28485;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 51773, 0, 0, 31, 0, 3, 28485, 0, 0, 0, 0, '', 'Target must be unit Blood Vat Bunny');

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValue_1` = 28232, `EffectMiscValueB_1` = 64 WHERE `ID` = 50996;
